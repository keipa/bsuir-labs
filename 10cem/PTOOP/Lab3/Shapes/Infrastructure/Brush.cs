using System.Drawing;

namespace Shapes
{
    public class Brush
    {
        private readonly Color _color;

        public Brush(Color color)
        {
            _color = color;
        }

        public System.Drawing.Brush CreateBrush()
        {
            return new SolidBrush(_color);
        }
    }
}