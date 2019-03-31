using System.Drawing;

namespace Shapes
{
    internal static class ShapeUtils
    {
        public static Point Clone(this Point point)
        {
            return new Point(point.X, point.Y);
        }

        public static Rectangle Clone(this Rectangle rect)
        {
            return Rectangle.Inflate(rect, 0, 0);
        }
    }
}
