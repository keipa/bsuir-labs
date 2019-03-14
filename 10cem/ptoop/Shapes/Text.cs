using System.Drawing;

namespace Shapes
{
    public class Text : IShape
    {
        private readonly Point _point;

        public Text(string text, Point point, Brush brush, Font font)
        {
            Label = text;
            _point = point;
            Brush = brush;
            Font = font;
        }

        private Brush Brush { get; }
        private Font Font { get; }
        private string Label { get; }

        public void Draw(Graphics graphics)
        {
            using (var brush = Brush.CreateBrush())
            using (var font = Font.CreateFont())
            {
                graphics.DrawString(Label, font, brush, _point);
            }
        }
    }
}