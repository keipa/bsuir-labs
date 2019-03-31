using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Ellipse : IShape
    {
        private readonly ActualDrawer drawer;

        public Ellipse(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }

        public void Draw(Graphics graphics)
        {
            drawer.DrawEllipse(graphics);
        }
    }
}