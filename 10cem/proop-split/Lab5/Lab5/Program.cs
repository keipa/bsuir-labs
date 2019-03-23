using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using Shapes;
using Shapes.Infrastructure;

namespace Lab1
{
    internal class Program
    {
        private static readonly string pluginsFolder = "plugins";
        private static Form _mainForm;
        private static Label _introLabel;
        private static Form _addShapeForm;
        private static int X;
        private static int Y;
        private static ActualDrawer drawer;
        public static List<Shape> _shapes = new List<Shape>();

        public static List<Type> shapeTypes;

        public static string AssemblyDirectory
        {
            get
            {
                var codeBase = Assembly.GetExecutingAssembly().CodeBase;
                var uri = new UriBuilder(codeBase);
                var path = Uri.UnescapeDataString(uri.Path);
                return Path.GetDirectoryName(path);
            }
        }


        private static void UpdateShapeTypes()
        {
            shapeTypes = new List<Type>();
            foreach (var ass in AppDomain.CurrentDomain.GetAssemblies())
                shapeTypes.AddRange(ass.GetTypes().Where(type => type.GetInterfaces().Contains(typeof(IShape)) &&
                                                                    type != typeof(Aggregation)));
        }

        [STAThread]
        private static void Main(string[] args)
        {
            Application.Run(CreateMainForm());
        }

        private static Form CreateMainForm()
        {
            Directory.CreateDirectory($"{AssemblyDirectory}\\{pluginsFolder}");
            UpdateShapeTypes();

            _mainForm = new Form
            {
                Size = new Size(400, 400)
            };
            _introLabel = new Label
            {
                Text = "Please, click somewhere on form",
                Location = new Point(_mainForm.Size.Width / 2, _mainForm.Size.Height / 2),
                Size = new Size(100, 100)
            };
            _mainForm.Controls.Add(_introLabel);

            _mainForm.MouseClick += Form_MouseClick;
            _mainForm.KeyDown += MainFormOnKeyDown;
            _introLabel.MouseClick += Form_MouseClick;
            return _mainForm;
        }

        private static void MainFormOnKeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
                var plugins = Directory.GetFiles($"{AssemblyDirectory}/{pluginsFolder}");
                foreach (var plugin in plugins)
                {
                    Assembly.LoadFrom(plugin);
                    MessageBox.Show($"Loaded {Path.GetFileName(plugin)}");
                }

                UpdateShapeTypes();

//                MessageBox.Show();
            }
        }

        private static void Form_MouseClick(object sender, MouseEventArgs e)
        {
            _introLabel.Hide();
            switch (e.Button)
            {
                case MouseButtons.Left:
                    AddShapeDialog(e);
                    break;

                case MouseButtons.Right:
                    var serializeForm = new SerializeForm();
                    serializeForm.Show();
                    break;
            }
        }

        private static void AddShapeDialog(MouseEventArgs e)
        {
            _addShapeForm = new Form
            {
                Size = new Size(200, 200)
            };
            var label = new Label
            {
                Text = $"Coordinates for shape x :{e.X} y: {e.Y}"
            };
            X = e.X;
            Y = e.Y;

            var shapesListView = new ListView
            {
                Size = new Size(200, 100),
                Location = new Point(0, 50)
            };

            shapesListView.ItemActivate += ShapesListViewOnItemActivate;

            foreach (var shape in shapeTypes.Select(t => t.Name)) shapesListView.Items.Add(shape);
            _addShapeForm.Controls.Add(label);
            _addShapeForm.Controls.Add(shapesListView);
            _addShapeForm.Show();
        }


        private static void ShapesListViewOnItemActivate(object sender, EventArgs e)
        {
            var shapeTypeToDraw = shapeTypes.FirstOrDefault(sh => sh.Name == ((ListView) sender).SelectedItems[0].Text);

            AddShapeToForm(shapeTypeToDraw, X, Y);

            _addShapeForm.Hide();
        }

        public static void AddShapeToForm(Type type, int x, int y)
        {
            _shapes.Add(new Shape
            {
                Type = type,
                X = x,
                Y = y
            });

            AddShapeToFormUpdate(type, x, y);
        }

        public static void AddShapeToFormUpdate(Type type, int x, int y)
        {
            var context = new DrawingContext();
            var drawer = new ActualDrawer(x, y, context);
            var shape = (IShape) Activator.CreateInstance(type, drawer);
            _mainForm.Paint += (o, ee) => { shape.Draw(ee.Graphics); };

            _mainForm.Invalidate(); // update form magic 
        }

        public static void ClearForm()
        {
            _mainForm.Paint += (o, ee) => { ee.Graphics.Clear(Color.WhiteSmoke); };
            _mainForm.Invalidate();
            _introLabel.Show();
        }

        public static void UpdateForm()
        {
            _mainForm.Paint += (o, ee) => { ee.Graphics.Clear(Color.WhiteSmoke); };
            _mainForm.Invalidate();
            foreach (var shape in _shapes) AddShapeToFormUpdate(shape.Type, shape.X, shape.Y);
        }


        public static void RestoreShapes(IEnumerable<Shape> restoredShapes)
        {
            foreach (var restoredShape in restoredShapes)
                AddShapeToForm(restoredShape.Type, restoredShape.X, restoredShape.Y);
        }
    }
}