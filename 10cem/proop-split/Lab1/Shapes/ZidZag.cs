using System.Collections.Generic;
using System.Drawing;
using System.Linq;

namespace Shapes
{
    public class ZidZag : IShape
    {
        private readonly Pen _pen;
        private readonly IEnumerable<Point> _points;

        public ZidZag(IEnumerable<Point> points, Pen pen)
        {
            _pen = pen;
            _points = points;
        }

        public void Draw(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawCurve(pen, _points.ToArray());
            }
        }
    }
}