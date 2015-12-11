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
    /// Логика взаимодействия для add_playlist.xaml
    /// </summary>
    public partial class add_playlist : Window
    {
        public add_playlist()
        {
            Random rnd = new Random();
            InitializeComponent();
            ID.Text = Convert.ToString(rnd.Next(10000, 100000));
        }

        private void add_clicked(object sender, RoutedEventArgs e)
        {

            MainWindow back = new MainWindow();
            back.Show();
            Hide();
        }
    }
}
