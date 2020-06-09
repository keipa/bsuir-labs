using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    class Circle:Shape
    {
        public int x1, y1, r1;
        public Circle(PaintEventArgs e, int point1_x, int point1_y, int radius): base(e)
        {
            r1 = radius;
            x1 = point1_x;
            y1 = point1_y;
        }

        public override void Draw()
        {
            Rectangle rect = new Rectangle();
            rect.X = x1;
            rect.Y = y1;
            rect.Width = 2 * r1;
            rect.Height = 2 * r1;
            g.DrawEllipse(pen, rect);
        }
    
    }
}
