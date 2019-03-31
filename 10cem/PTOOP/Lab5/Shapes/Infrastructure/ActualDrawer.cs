using System.Collections.Generic;
using System.Drawing;

namespace Shapes.Infrastructure
{
    public class ActualDrawer
    {
        private readonly Pen _pen;
        private readonly Brush Brush;
        private readonly Font Font;

        public ActualDrawer(int x, int y, DrawingContext context)
        {
            X = x;
            Y = y;
            _pen = context.CreatePen();
            Brush = context.CreateBrush();
            Font = context.CreateFont();
        }
        private int X { get; }
        private int Y { get; }

        public void DrawCircle(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawLine(pen, new Point(X, Y), new Point(X + 100, Y));
            }
        }

        public void DrawRectangle(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawRectangle(pen, X, Y, 100, 100);
            }
        }

        public void DrawArc(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawArc(pen, new System.Drawing.Rectangle(X, Y, 250, 250), 90, 90);
            }
        }

        public void DrawEllipse(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawEllipse(pen, X, Y, 100, 70);
            }
        }
        
        public void DrawPie(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                float width = 200.0F;
                float height = 100.0F;
             
                float startAngle =  0.0F;
                float sweepAngle = 320.0F;
                
                graphics.DrawPie(pen, X, Y, width, height, startAngle, sweepAngle);
            }
        }

        public void DrawText(Graphics graphics)
        {
            using (var brush = Brush.CreateBrush())
            using (var font = Font.CreateFont())
            {
                graphics.DrawString("¯\\_(ツ)_/¯", font, brush, new Point(X, Y));
            }
        }

        public void DrawZigZag(Graphics graphics)
        {
            using (var pen = _pen.CreatePen())
            {
                graphics.DrawCurve(pen, new List<Point>
                {
                    new Point(X, Y),
                    new Point(X + 70, Y + 30),
                    new Point(X + 140, Y),
                    new Point(X + 210, Y + 30)
                }.ToArray());
            }
        }
    }
}