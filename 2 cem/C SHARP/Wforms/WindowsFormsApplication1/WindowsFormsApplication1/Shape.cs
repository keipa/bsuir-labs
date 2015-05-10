using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Windows.Forms;


namespace WindowsFormsApplication1
{
    abstract class Shape
    {
        public Pen pen = new Pen(Color.Red);
        public Graphics g;
        public Shape (PaintEventArgs e)
        {
            g = e.Graphics;            
        }
        public abstract void Draw();
        
    }
}
