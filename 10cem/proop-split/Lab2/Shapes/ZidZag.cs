using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using Shapes.Infrastructure;

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

        private readonly ActualDrawer drawer;

        public ZidZag(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }
        
        public void Draw(Graphics graphics)
        {
            drawer.DrawZigZag(graphics);
        }
    }
}