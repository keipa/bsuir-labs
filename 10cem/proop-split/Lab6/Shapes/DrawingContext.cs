using System.Drawing;

namespace Shapes
{
    /// <summary>
    /// A mutable class containing settings for creating shapes.
    /// </summary>
    public class DrawingContext
    {
        public BrushType BrushType { get; set; } = BrushType.Solid;

        public Color FillColor { get; set; } = Color.Black;

        public string FontFamily { get; set; } = "Arial";

        public float FontSize { get; set; } = 14;

        public int LineWidth { get; set; } = 1;

        public Color LineColor { get; set; } = Color.Black;

        public BrushBillet CreateBrushBillet()
        {
            return new BrushBillet(FillColor, BrushType);
        }

        public FontBillet CreateFontBillet()
        {
            return new FontBillet(FontFamily, FontSize);
        }

        public PenBillet CreatePenBillet()
        {
            return new PenBillet(LineColor, LineWidth);
        }
    }
}
