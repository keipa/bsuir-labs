using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Line : IShape
    {
        private readonly ActualDrawer drawer;

        public Line(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }

        public void Draw(Graphics graphics)
        {
            drawer.DrawCircle(graphics);
        }
    }
}