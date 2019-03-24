using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A string shape.
    /// </summary>
    [DataContract]
    public class StringShape : IShape
    {
        [DataMember] private readonly Point point_;
        [DataMember] private readonly BrushBillet brushBillet_;
        [DataMember] private readonly FontBillet fontBillet_;
        [DataMember] private readonly string text_;

        public StringShape(string text, Point point, BrushBillet brushBillet, FontBillet fontBillet)
        {
            text_ = text;
            point_ = point;
            brushBillet_= brushBillet;
            fontBillet_ = fontBillet;
        }

        public BrushBillet BrushBillet => brushBillet_;

        public FontBillet FontBillet => fontBillet_;

        public Point Point => point_.Clone();

        public string Text => text_;

        public void Draw(Graphics graphics)
        {
            using (var brush = BrushBillet.CreateBrush())
            using (var font = FontBillet.CreateFont())
            {
                graphics.DrawString(Text, font, brush, point_);
            }
        }
    }
}
