using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Line : IShape
    {
        private readonly Point _end;

        private readonly Point _start;

        private readonly ActualDrawer drawer;


        public Line(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }

        
        

        public Line(Point start, Pen pen)
        {
            _start = start;
            var end = start.Clone();
            end.X += 100;
            end.Y += 100;
            _end = end;
            Pen = pen;
        }

        public Line(Point start, Point end, Pen billet)
        {
            _start = start;
            _end = end;
            Pen = billet;
        }

        private Pen Pen { get; }
        
//        public void Draw(Graphics graphics)
//        {
//            drawer.DrawCircle(graphics);
//        }

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawLine(pen, _start, _end);
            }
        }
    }
}