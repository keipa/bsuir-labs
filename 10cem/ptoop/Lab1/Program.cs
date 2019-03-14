using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using Shapes;
using Rectangle = Shapes.Rectangle;


namespace Lab1
{
    internal class Program
    {
        [STAThread]
        private static void Main(string[] args)
        {
            Application.Run(CreateMainForm());
        }

        private static Form CreateMainForm()
        {
            var form = new Form
            {
                Size = new Size(400, 400)
            };
            var shapes = GetShape();
            form.Paint += (o, e) => { shapes.Draw(e.Graphics); };
            return form;
        }

        private static IShape GetShape()
        {
            var context = new DrawingContext();
            return new Aggregation(new List<IShape>
            {
                new Line(new Point(10, 10), new Point(250, 10), context.CreatePen()),
                new Ellipse(new Point(300, 40), new Point(150, 80), context.CreatePen()),
                new Arc(new System.Drawing.Rectangle(100, 100, 250, 250), 90, 90, context.CreatePen()),
                new Rectangle(new Point(200, 160), new Point(350, 260), context.CreatePen()),
                new Text("Rovdo Nikolay", new Point(10, 60), context.CreateBrush(), context.CreateFont()),
                new ZidZag(new List<Point>
                {
                    new Point(10, 120),
                    new Point(80, 150),
                    new Point(150, 120),
                    new Point(220, 150)
                }, context.CreatePen())
            });
        }
    }
}