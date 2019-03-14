using System.Drawing;
using System.Runtime.Serialization;

namespace Shapes
{
    [DataContract]
    public class RectangleShape : IShape
    {
        [DataMember] 
        private readonly Point _upperLeftCorner;
        
        [DataMember] 
        private readonly int _height;
        
        [DataMember] 
        private readonly Pen _pen;
        
        [DataMember] 
        private readonly int _width;
        
        public RectangleShape(Point upperLeftCorner, Point lowerRightCorner, Pen billet)
        {
            _upperLeftCorner = upperLeftCorner;
            _pen = billet;
            _width= lowerRightCorner.X - upperLeftCorner.X;
            _height = lowerRightCorner.Y - upperLeftCorner.Y;
        }

        public int Height => _height;

        public Pen Pen => _pen;

        public Point UpperLeftCorner => _upperLeftCorner.Clone();

        public int Width => _width;

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawRectangle(pen, _upperLeftCorner.X, _upperLeftCorner.Y, Width, Height);
            }
        }   
    }
}
