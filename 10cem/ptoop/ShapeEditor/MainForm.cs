using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Shapes;
using Shapes.Interpretation;
using Shapes.Serialization;

namespace ShapeEditor
{
    public partial class MainForm : Form
    {
        private readonly IShapeInterpreter interpreter_;
        private readonly IShapeLoaderFactory shapeLoaderFactory_;
        private readonly List<IShape> shapes_ = new List<IShape>();

        public MainForm(IShapeInterpreter interpreter, IShapeLoaderFactory shapeLoaderFactory)
        {
            InitializeComponent();

            interpreter_ = interpreter;
            shapeLoaderFactory_ = shapeLoaderFactory;
        }

        #region Logic

        private ICollection<IShape> InterpretShapes(string text)
        {
            try
            {
                var context = new DrawingContext();
                // TODO: display available keywords
                return interpreter_.Interpret(text, context).ToList();
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
                return null;
            }
        }

        private ICollection<IShape> LoadShapesFromStream(IShapeLoader shapeLoader, Stream stream)
        {
            try
            {
                return shapeLoader.Load(stream).ToList();
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
                return null;
            }
        }

        private void Redraw(ICollection<IShape> shapes)
        {
            if (shapes != null)
            {
                shapes_.Clear();
                shapes_.AddRange(shapes);
                shapePictureBox.Invalidate();
                errorLabel.Text = "";
            }
        }

        private void SaveShapesToStream(IShapeLoader shapeLoader, Stream stream)
        {
            try
            {
                shapeLoader.Save(stream, shapes_);
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }
        }

        #endregion

        private void shapePictureBox_Paint(object sender, PaintEventArgs e)
        {
            foreach (IShape shape in shapes_)
            {
                shape.Draw(e.Graphics);
            }
        }

        private void interpretButton_Click(object sender, EventArgs e)
        {
            var shapes = InterpretShapes(interpretTextArea.Text);
            Redraw(shapes);
        }

        private void interpretTextArea_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && e.KeyCode == Keys.Enter)
            {
                e.SuppressKeyPress = true;
                var shapes = InterpretShapes(interpretTextArea.Text);
                Redraw(shapes);
            }
        }

        private void openFileButton_Click(object sender, EventArgs e)
        {
            IShapeLoader shapeLoader = shapeLoaderFactory_.Create();
            openFileDialog1.DefaultExt = shapeLoader.FileExtension;
            DialogResult dialogResult = openFileDialog1.ShowDialog();
            if (dialogResult == DialogResult.OK)
            {
                using (Stream stream = openFileDialog1.OpenFile())
                {
                    var shapes = LoadShapesFromStream(shapeLoader, stream);
                    Redraw(shapes);
                }
            }
        }

        private void saveToFileButton_Click(object sender, EventArgs e)
        {
            IShapeLoader shapeLoader = shapeLoaderFactory_.Create();
            saveFileDialog1.DefaultExt = shapeLoader.FileExtension;
            DialogResult dialogResult = saveFileDialog1.ShowDialog();
            if (dialogResult == DialogResult.OK)
            {
                using (Stream stream = saveFileDialog1.OpenFile())
                {
                    SaveShapesToStream(shapeLoader, stream);
                }
            }
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            interpretTextArea.Select();
        }
    }
}
