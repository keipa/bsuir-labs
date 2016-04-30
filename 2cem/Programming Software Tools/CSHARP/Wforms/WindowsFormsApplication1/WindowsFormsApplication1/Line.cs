using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    class Line:Shape
    {
        public int x1, x2, y1, y2;
        

        public Line(PaintEventArgs e, int point1_x,int point1_y,int point2_x,int point2_y):base(e)
        {
            this.x1 = point1_x;
            this.x2 = point2_x;
            this.y1 = point1_y;
            this.y2 = point2_y;

        }
        public override void Draw()
        {
            g.DrawLine(pen, x1, y1, x2, y2);
        }  
        
    }
    
}
