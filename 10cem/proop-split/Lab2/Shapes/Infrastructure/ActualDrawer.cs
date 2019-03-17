using System.Drawing;

namespace Shapes.Infrastructure
{
    public class ActualDrawer
    {
        private Graphics Graphics { get; }
        private int X { get; }
        private int Y { get; }
       

        private readonly Pen _pen;

        public ActualDrawer(int x, int y, Pen context)
        {
            X = x;
            Y = y;
            _pen = context;
        }

        public void DrawCircle(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawLine(pen, new Point(X, Y), new Point(X+100, Y));
            }
        }
    }
}