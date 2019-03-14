using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class EllipseShape : IShape
    {
        [DataMember] 
        private readonly Point _upperLeftCorner;
        
        [DataMember] 
        private readonly Pen _pen;
        
        [DataMember] 
        private readonly int _height;
        
        [DataMember] 
        private readonly int _width;
        

        public EllipseShape(Point upperLeftCorner, Point lowerRightCorner, Pen billet)
        {
            _upperLeftCorner = upperLeftCorner;
            _pen = billet;
            _width = lowerRightCorner.X - upperLeftCorner.X;
            _height = lowerRightCorner.Y - upperLeftCorner.Y;
        }

        public Pen Billet => _pen;

        public void Draw(Graphics graphics)
        {
            using (var pen = Billet.CreatePen())
            {
                graphics.DrawEllipse(pen, _upperLeftCorner.X, _upperLeftCorner.Y, _width, _height);
            }
        }
    }
}
