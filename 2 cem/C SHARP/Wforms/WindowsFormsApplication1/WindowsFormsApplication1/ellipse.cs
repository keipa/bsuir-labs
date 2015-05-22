using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Windows.Forms;


namespace WindowsFormsApplication1
{
    class Ellipse:Circle
    {
        public int r2;
        public Ellipse(PaintEventArgs e, int point1_x, int point1_y, int radius1, int radius2): base(e,point1_x,point1_y,radius1)
        {
            
            r2 = radius2;
           
        }
        public override void Draw()
        {
            Rectangle rect = new Rectangle();
            rect.X = x1;
            rect.Y = y1;
            rect.Width = 2 * r1;
            rect.Height = 2 * r2;
            g.DrawEllipse(pen, rect);
        }
             
    }
}
