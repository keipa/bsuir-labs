using System.Drawing;

namespace Shapes
{
    public class Line : IShape
    {
        private readonly Point _end;

        private readonly Point _start;

        public Line(Point start, Point end, Pen billet)
        {
            _start = start;
            _end = end;
            Pen = billet;
        }

        private Pen Pen { get; }

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawLine(pen, _start, _end);
            }
        }
    }
}