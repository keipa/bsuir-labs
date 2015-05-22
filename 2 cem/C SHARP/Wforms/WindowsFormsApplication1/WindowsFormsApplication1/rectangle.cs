using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    class rectangle:Line
    {
        public int x3, x4, y3, y4;
        public rectangle(PaintEventArgs e, int point1_x, int point1_y, int point2_x, int point2_y, int point3_x,int point3_y, int point4_x,int point4_y): base(e)
        {
            this.x1 = point1_x;
            this.x2 = point2_x;
            this.x3 = point3_x;
            this.x4 = point4_x;
            this.y1 = point1_y;
            this.y2 = point2_y;
            this.y3 = point3_y;
            this.y4 = point4_y;
         }
        public override void Draw()
        {
            base.Draw();
        }
    }
}
