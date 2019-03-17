using System.Drawing;

namespace Shapes
{
    public class Ellipse : IShape
    {
        private readonly int _height;

        private readonly Point _upperLeftCorner;

        private readonly int _width;


        public Ellipse(Point upperLeftCorner, Point lowerRightCorner, Pen pen)
        {
            _upperLeftCorner = upperLeftCorner;
            Pen = pen;
            _width = lowerRightCorner.X - upperLeftCorner.X;
            _height = lowerRightCorner.Y - upperLeftCorner.Y;
        }

        private Pen Pen { get; }

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawEllipse(pen, _upperLeftCorner.X, _upperLeftCorner.Y, _width, _height);
            }
        }
    }
}