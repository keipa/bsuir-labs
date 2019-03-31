using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Pie : IShape
    {
        private readonly ActualDrawer drawer;

        public Pie(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }

        public void Draw(Graphics graphics)
        {
            drawer.DrawPie(graphics);
        }
    }
}