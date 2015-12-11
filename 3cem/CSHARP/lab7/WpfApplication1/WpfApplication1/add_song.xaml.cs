using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WpfApplication1
{
    /// <summary>
    /// Логика взаимодействия для add_song.xaml
    /// </summary>
    public partial class add_song : Window
    {
        public add_song()
        {
            Random rnd = new Random();
            InitializeComponent();
            ID.Text = Convert.ToString(rnd.Next(10000, 100000));
            _min.Text = "20";
            
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
           
            MainWindow back = new MainWindow();
            back.Show();
            Hide();
            
        }

      
       

        
        private void set_time_move(object sender, MouseEventArgs e)
        {
            int min = (int)slide.Value / 60;

            if ((int)slide.Value / 60 < 1)
            {

                _min.Text = (String)"00";
                _sec.Text = Convert.ToString((int)slide.Value);
            }
            else
            {
                _min.Text = Convert.ToString(min);
                if ((int)slide.Value - min * 60 == 0)
                {
                    _sec.Text = "00";
                }
                else
                    if ((int)slide.Value - min * 60 < 10)
                    {
                        _sec.Text = "0"+ Convert.ToString((int)slide.Value - min * 60);
                    }else
                    _sec.Text = Convert.ToString((int)slide.Value - min * 60);
            }
        }

        
    }
}
