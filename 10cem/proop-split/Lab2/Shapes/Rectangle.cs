using System.Drawing;
using Shapes.Infrastructure;

namespace Shapes
{
    public class Rectangle : IShape
    {
        private readonly ActualDrawer _drawer;

        public Rectangle(ActualDrawer drawer)
        {
            _drawer = drawer;
        }


        public void Draw(Graphics graphics)
        {
            _drawer.DrawRectangle(graphics);
        }
    }
}