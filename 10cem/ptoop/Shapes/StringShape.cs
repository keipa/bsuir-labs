using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class StringShape : IShape
    {
        [DataMember] 
        private readonly Point _point;
        
        [DataMember] 
        private readonly BrushBillet _brushBillet;
        
        [DataMember] 
        private readonly Font _font;
        
        [DataMember] 
        private readonly string _text;
        

        public StringShape(string text, Point point, BrushBillet brushBillet, Font font)
        {
            _text = text;
            _point = point;
            _brushBillet= brushBillet;
            _font = font;
        }

        public BrushBillet BrushBillet => _brushBillet;

        public Font Font => _font;

        public Point Point => _point.Clone();

        public string Text => _text;

        public void Draw(Graphics graphics)
        {
            using (var brush = BrushBillet.CreateBrush())
            using (var font = Font.CreateFont())
            {
                graphics.DrawString(Text, font, brush, _point);
            }
        }
    }
}
