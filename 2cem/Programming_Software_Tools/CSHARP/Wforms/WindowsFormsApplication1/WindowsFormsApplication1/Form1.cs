using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
        private void Form1_Print(object sender, PaintEventArgs e)
        {
            Line line = new Line(e, 50, 50, 100, 100);
            Circle circle = new Circle(e, 50, 50, 10);
            Triangle triangle = new Triangle(e, 50, 100, 200, 100, 50, 300);
            Ellipse elipse = new Ellipse(e, 100, 100, 50, 100);
            Quadrofree qua = new Quadrofree(e, 100, 200, 300, 200, 150, 150, 160, 160);
            
            line.Draw();
            circle.Draw();
            triangle.Draw();
            elipse.Draw();
            qua.Draw();
        }
    }
}
