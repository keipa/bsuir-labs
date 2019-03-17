using System.Drawing;

namespace Shapes
{
    public class Rectangle : IShape
    {
        private readonly Point _upperLeftCorner;

        public Rectangle(Point upperLeftCorner, Point lowerRightCorner, Pen billet)
        {
            _upperLeftCorner = upperLeftCorner;
            Pen = billet;
            Width = lowerRightCorner.X - upperLeftCorner.X;
            Height = lowerRightCorner.Y - upperLeftCorner.Y;
        }

        private int Height { get; }

        private Pen Pen { get; }

        private int Width { get; }

        public void Draw(Graphics graphics)
        {
            using (var pen = Pen.CreatePen())
            {
                graphics.DrawRectangle(pen, _upperLeftCorner.X, _upperLeftCorner.Y, Width, Height);
            }
        }

        public void Draw()
        {
            throw new System.NotImplementedException();
        }
    }
}