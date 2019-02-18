using System;
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

        public static Form CreateMainForm()
        {
            var form = new Form
            {
                Text = "Shapes",
                Size = new Size(640, 400),
                FormBorderStyle = FormBorderStyle.FixedDialog,
                StartPosition = FormStartPosition.CenterScreen
            };
            var shapes = GetShape();
            form.Paint += (o, e) =>
            {
                shapes.Draw(e.Graphics);
            };
            return form;
        }

        public static IShape GetShape()
        {
            var context = new DrawingContext();
            return new AggregateShape(new IShape[]
            {
                new LineShape(new Point(10, 10), new Point(150, 10), context.CreatePenBillet()),
                new EllipseShape(new Point(10, 40), new Point(150, 80), context.CreatePenBillet()), 
                new ArcShape(new Rectangle(100, 100, 100, 150), 90, 90, context.CreatePenBillet()), 
                new RectangleShape(new Point(10, 80), new Point(150, 120), context.CreatePenBillet()),
                new StringShape("shaaaapes", new Point(10, 100), context.CreateBrushBillet(), context.CreateFontBillet()),
                new CurveShape(new []
                {
                    new Point(10, 120), new Point(80, 150), new Point(150, 120)
                }, context.CreatePenBillet()), 
            });
        }
    }
}
