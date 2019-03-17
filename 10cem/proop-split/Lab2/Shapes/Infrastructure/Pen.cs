using System.Drawing;

namespace Shapes
{
    public class Pen
    {
        public Pen(Color color, int width)
        {
            Color = color;
            Width = width;
        }

        private Color Color { get; }

        private int? Width { get; }

        public System.Drawing.Pen CreatePen()
        {
            return Width.HasValue
                ? new System.Drawing.Pen(Color, Width.Value)
                : new System.Drawing.Pen(Color);
        }
    }
}