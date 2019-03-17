using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Arc : IShape
    {
        private readonly ActualDrawer drawer;

        public Arc(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }
        
        public void Draw(Graphics graphics)
        {
            drawer.DrawArc(graphics);
        }
    }
}