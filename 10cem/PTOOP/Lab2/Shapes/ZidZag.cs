using System.Collections.Generic;
using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class ZidZag : IShape
    {
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