using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Windows.Forms;
using Shapes;
using Shapes.Infrastructure;
using Rectangle = System.Drawing.Rectangle;

namespace Lab1
{
    internal class Program
    {
        private static Form _mainForm;
        private static Label _introLabel;
        private static Form _addShapeForm;
        private static int X;
        private static int Y;
        private static ActualDrawer drawer;

        private static readonly IEnumerable<Type> shapeTypes = Assembly.Load(typeof(Aggregation).Assembly.FullName)
            .GetTypes()
            .Where(type => type.GetInterfaces().Contains(typeof(IShape)) &&
                           type != typeof(Aggregation));

        [STAThread]
        private static void Main(string[] args)
        {
            Application.Run(CreateMainForm());
        }

        private static Form CreateMainForm()
        {
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
            _introLabel.MouseClick += Form_MouseClick;
            return _mainForm;
        }

        private static void Form_MouseClick(object sender, MouseEventArgs e)
        {
            _introLabel.Hide();
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
                Location = new Point(0, 50),
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
            
            var context = new DrawingContext();
            
//            var line = new Line(new Point(X, Y), context.CreatePen());           
//            _mainForm.Paint += (o, ee) => { line.Draw(ee.Graphics); };

            var drawer = new ActualDrawer(X,Y, context);
            var shape = (IShape) Activator.CreateInstance(shapeTypeToDraw, drawer);
            _mainForm.Paint += (o, ee) =>
            {
                shape.Draw(ee.Graphics);
            };
//            
            _mainForm.Invalidate(); // update form magic method
            _addShapeForm.Hide();
        }


//        private static IShape GetShape()
//        {
//            var context = new DrawingContext();
//            return new Aggregation(new List<IShape>
//            {
//                new Line(new Point(10, 10), new Point(250, 10), context.CreatePen()),
//                new Ellipse(new Point(300, 40), new Point(150, 80), context.CreatePen()),
//                new Arc(new Rectangle(100, 100, 250, 250), 90, 90, context.CreatePen()),
//                new Shapes.Rectangle(new Point(200, 160), new Point(350, 260), context.CreatePen()),
//                new Text("Rovdo Nikolay", new Point(10, 60), context.CreateBrush(), context.CreateFont()),
//                new ZidZag(new List<Point>
//                {
//                    new Point(10, 120),
//                    new Point(80, 150),
//                    new Point(150, 120),
//                    new Point(220, 150)
//                }, context.CreatePen())
//            });
//        }
    }
}