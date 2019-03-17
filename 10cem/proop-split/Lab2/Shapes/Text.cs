using System.Drawing;
using Shapes.Infrastructure;

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