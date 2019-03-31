using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Serialization;

namespace Shapes
{
    /// <summary>
    /// A curvd line shape.
    /// </summary>
    [DataContract]
    public class CurveShape : IShape
    {
        [DataMember] private readonly Point[] points_;
        [DataMember] private readonly PenBillet penBillet_;

        public CurveShape(IEnumerable<Point> points, PenBillet billet)
        {
            penBillet_= billet;
            points_ = points.ToArray();
        }

        public PenBillet PenBillet => penBillet_;

        public IEnumerable<Point> Points => points_.Select(point => point.Clone());

        public void Draw(Graphics graphics)
        {
            using (var pen = PenBillet.CreatePen())
            {
                graphics.DrawCurve(pen, points_);
            }
        }
    }
}
