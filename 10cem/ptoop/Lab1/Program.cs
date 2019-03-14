using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using Shapes;

namespace Lab1
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            Application.Run(CreateMainForm());
        }

        private static Form CreateMainForm()
        {
            var form = new Form
            {
                Size = new Size(400, 400),
            };
            var shapes = GetShape();
            form.Paint += (o, e) =>
            {
                shapes.Draw(e.Graphics);
            };
            return form;
        }

        private static IShape GetShape()
        {
            var context = new DrawingContext();
            return new AggregateShape(new IShape[]
            {
                new LineShape(new Point(10, 10), new Point(250, 10), context.CreatePen()),
                new EllipseShape(new Point(300, 40), new Point(150, 80), context.CreatePen()), 
                new ArcShape(new Rectangle(100, 100, 250, 250), 90, 90, context.CreatePen()),
                new RectangleShape(new Point(200, 160), new Point(350, 260), context.CreatePen()),
                new StringShape("Rovdo Nikolay", new Point(10, 60), context.CreateBrush(), context.CreateFont()),
                new ZidZagShape(new List<Point>
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
