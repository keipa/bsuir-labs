using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class ZidZagShape : IShape
    {
        [DataMember] 
        private readonly IEnumerable<Point> _points;
        
        [DataMember] 
        private readonly Pen _pen;
        
        public ZidZagShape(IEnumerable<Point> points, Pen billet)
        {
            _pen= billet;
            _points = points;
        }

        public void Draw(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawCurve(pen, _points.ToArray());
            }
        }
    }
}
