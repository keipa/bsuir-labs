using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Text : IShape
    {
        private readonly ActualDrawer drawer;

        public Text(ActualDrawer _drawer)
        {
            drawer = _drawer;
        }

        public void Draw(Graphics graphics)
        {
            drawer.DrawText(graphics);
        }
    }
}