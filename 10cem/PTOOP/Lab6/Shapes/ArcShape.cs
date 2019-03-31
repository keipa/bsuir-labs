using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// An arc shape.
    /// </summary>
    [DataContract]
    public class ArcShape : IShape
    {
        [DataMember] private readonly Rectangle rect_;
        [DataMember] private readonly float startAngle_;
        [DataMember] private readonly float sweepAngle_;
        [DataMember] private readonly PenBillet penBillet_;

        /// <summary>
        /// Creates an arc shape.
        /// </summary>
        /// <param name="rect">Bounding rectangle of the ellipse the arc belongs to.</param>
        /// <param name="startAngle"></param>
        /// <param name="sweepAngle"></param>
        /// <param name="penBillet"></param>
        public ArcShape(Rectangle rect, float startAngle, float sweepAngle, PenBillet penBillet)
        {
            rect_ = rect;
            startAngle_ = startAngle;
            sweepAngle_ = sweepAngle;
            penBillet_ = penBillet;
        }

        public Rectangle EllipseRectangle => rect_.Clone();

        public float StartAngle => startAngle_;

        public float SweepAngle => sweepAngle_;

        public PenBillet PenBillet => penBillet_;

        public void Draw(Graphics graphics)
        {
            using (var pen = PenBillet.CreatePen())
            {
                graphics.DrawArc(pen, rect_, startAngle_, sweepAngle_);
            }
        }
    }
}
