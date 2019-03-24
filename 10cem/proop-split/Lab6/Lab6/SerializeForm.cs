using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Shapes.Infrastructure;

namespace Lab1
{
    public partial class SerializeForm : Form
    {
        public static TextBox labelx;
        public static TextBox labely;
        
        public static List<Type> savePlugins;


        private string savePluginsFolderName = "saveplugin";
        public SerializeForm()
        {
            InitializeComponent();
            UpdateListView();
            //this.KeyDown += DrawOnKeyDown;
            UpdateShapeTypes();
        }

        
        private static void UpdateShapeTypes()
        {
            savePlugins = new List<Type>();
            foreach (var ass in AppDomain.CurrentDomain.GetAssemblies())
            {
                savePlugins.AddRange(ass.GetTypes()
                    .Where(type => type.GetInterfaces()
                                       .Contains(typeof(IPostDecorator))));
            }
        }

        
        private void DrawOnKeyDown(object sender, KeyEventArgs e)
        {
            
        }

        private void UpdateListView()
        {
            listOfShapesView.Items.Clear();
            foreach (var shape in Program._shapes)
            {
                listOfShapesView.Items.Add($"{shape.Type}({shape.X}, {shape.Y})");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (saveFileDialog1.ShowDialog() == DialogResult.Cancel)
                return;
            string filename = saveFileDialog1.FileName;
            var json = JsonConvert.SerializeObject(Program._shapes);
            System.IO.File.WriteAllText(filename, json);

            foreach (var pluginType in savePlugins)
            {
                var pluginObject = (IPostDecorator) Activator.CreateInstance(pluginType);
                pluginObject.Apply(filename);
            }
            
            MessageBox.Show("Файл сохранен");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.Cancel)
                return;
            string filename = openFileDialog1.FileName;
            string fileText = System.IO.File.ReadAllText(filename);
            var restored = JsonConvert.DeserializeObject<List<Shapes.Infrastructure.Shape>>(fileText);
            Program.RestoreShapes(restored);
            Hide();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Program._shapes = new List<Shapes.Infrastructure.Shape>();
            Program.ClearForm();
            Hide();
        }

        private static Form _addShapeForm;

        private void listOfShapesView_SelectedIndexChanged(object sender, EventArgs e)
        {
            var shapeToEdit = Program._shapes[listOfShapesView.SelectedIndex];


            _addShapeForm = new Form
            {
                Size = new Size(200, 200)
            };
            labelx = new TextBox
            {
                Text = shapeToEdit.X.ToString(),
                Location = new Point(0, 20)
            };

            labely = new TextBox
            {
                Text = shapeToEdit.Y.ToString()
            };

            var shapesListView = new ListView
            {
                Size = new Size(200, 100),
                Location = new Point(0, 50)
            };
            Program._shapes.RemoveAt(listOfShapesView.SelectedIndex);
            shapesListView.ItemActivate += ShapesListViewOnItemActivate;

            foreach (var shape in Program.shapeTypes.Select(t => t.Name)) shapesListView.Items.Add(shape);
            _addShapeForm.Controls.Add(labelx);
            _addShapeForm.Controls.Add(labely);
            _addShapeForm.Controls.Add(shapesListView);
            _addShapeForm.Show();
        }

        private void ShapesListViewOnItemActivate(object sender, EventArgs e)
        {
            var shapeTypeToDraw = Program.shapeTypes.FirstOrDefault(sh => sh.Name == ((ListView)sender).SelectedItems[0].Text);

            Program.AddShapeToForm(shapeTypeToDraw, Convert.ToInt32(labelx.Text), Convert.ToInt32(labely.Text));

            _addShapeForm.Hide();

            Program.UpdateForm();
            UpdateListView();
        }

        private void UpdatePluginsEvent(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
               
            }

        }

        private void button3_Click(object sender, EventArgs e)
        {
            var plugins = Directory.GetFiles($"{Program.AssemblyDirectory}/{savePluginsFolderName}");
            foreach (var plugin in plugins)
            {
                Assembly.LoadFrom(plugin);
                MessageBox.Show($"Loaded {Path.GetFileName(plugin)}");
            }
            UpdateShapeTypes();
        }
    }
}
