using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// An ellipse shape.
    /// </summary>
    [DataContract]
    public class EllipseShape : IShape
    {
        [DataMember] private readonly Point upperLeftCorner_;
        [DataMember] private readonly PenBillet penBillet_;
        [DataMember] private readonly int height_;
        [DataMember] private readonly int width_;

        public EllipseShape(Point upperLeftCorner, Point lowerRightCorner, PenBillet billet)
        {
            upperLeftCorner_ = upperLeftCorner;
            penBillet_ = billet;
            width_ = lowerRightCorner.X - upperLeftCorner.X;
            height_ = lowerRightCorner.Y - upperLeftCorner.Y;
        }

        public PenBillet Billet => penBillet_;

        public int Height => height_;

        public Point UpperLeftCorner => upperLeftCorner_.Clone();

        public int Width => width_;

        public void Draw(Graphics graphics)
        {
            using (var pen = Billet.CreatePen())
            {
                graphics.DrawEllipse(pen, upperLeftCorner_.X, upperLeftCorner_.Y, Width, Height);
            }
        }
    }
}
