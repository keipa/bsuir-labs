using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class ArcShape : IShape
    {
        [DataMember] 
        private readonly Rectangle _rect;
        
        [DataMember] 
        private readonly float _startAngle;
        
        [DataMember] 
        private readonly float _finishAngle;
        
        [DataMember] 
        private readonly Pen _pen;


        public ArcShape(Rectangle rect, float startAngle, float finishAngle, Pen pen)
        {
            _rect = rect;
            _startAngle = startAngle;
            _finishAngle = finishAngle;
            _pen = pen;
        }

        public void Draw(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawArc(pen, _rect, _startAngle, _finishAngle);
            }
        }
    }
}
