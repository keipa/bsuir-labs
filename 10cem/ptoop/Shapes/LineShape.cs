using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A line shape.
    /// </summary>
    [DataContract]
    public class LineShape : IShape
    {
        [DataMember] private readonly Point start_;
        [DataMember] private readonly Point end_;
        [DataMember] private readonly PenBillet penBillet_;

        public LineShape(Point start, Point end, PenBillet billet)
        {
            start_ = start;
            end_ = end;
            penBillet_ = billet;
        }

        public Point End => end_.Clone();

        public PenBillet PenBillet => penBillet_;

        public Point Start => start_.Clone();

        public void Draw(Graphics graphics)
        {
            using (var pen = PenBillet.CreatePen())
            {
                graphics.DrawLine(pen, start_, end_);
            }
        }
    }
}
