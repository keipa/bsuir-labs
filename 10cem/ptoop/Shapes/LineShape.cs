using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class LineShape : IShape
    {
        [DataMember] 
        private readonly Point _start;
        
        [DataMember] 
        private readonly Point _end;
        
        [DataMember] 
        private readonly Pen _pen;


        public LineShape(Point start, Point end, Pen billet)
        {
            _start = start;
            _end = end;
            _pen = billet;
        }

        public Point End => _end.Clone();

        public Pen Pen => _pen;

        public Point Start => _start.Clone();

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawLine(pen, _start, _end);
            }
        }
    }
}
