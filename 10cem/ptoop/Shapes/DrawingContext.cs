using System.Drawing;

namespace Shapes
{
    public class DrawingContext
    {
        private Color FillColor { get; } = Color.Green;

        private string FontFamily { get; } = "Comic Sans MS";

        private float FontSize { get; } = 32;

        private int LineWidth { get; } = 2;

        private Color LineColor { get; } = Color.Red;

        public Brush CreateBrush()
        {
            return new Brush(FillColor);
        }

        public Font CreateFont()
        {
            return new Font(FontFamily, FontSize);
        }

        public Pen CreatePen()
        {
            return new Pen(LineColor, LineWidth);
        }
    }
}