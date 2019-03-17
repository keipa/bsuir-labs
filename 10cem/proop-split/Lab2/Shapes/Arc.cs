using System.Drawing;

namespace Shapes
{
    public class Arc : IShape
    {
        private readonly float _finishAngle;

        private readonly Pen _pen;
        private readonly System.Drawing.Rectangle _rect;

        private readonly float _startAngle;


        public Arc(System.Drawing.Rectangle rect, float startAngle, float finishAngle, Pen pen)
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

        public void Draw()
        {
            throw new System.NotImplementedException();
        }
    }
}