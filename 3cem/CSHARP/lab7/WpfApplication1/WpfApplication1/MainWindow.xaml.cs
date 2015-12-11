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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApplication1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 

    public partial class MainWindow : Window
    {


        public MainWindow()
        {
            InitializeComponent();
            tabs.Items.Clear();
        }



     
        private void click_add_song(object sender, RoutedEventArgs e)
        {
            add_song asi = new add_song();
            asi.Show();
            Hide();
        }

        private void play_clicked(object sender, RoutedEventArgs e)
        {
            for (double i = 0; i < 100; i++)
            {
                Progres.Value = i;
            }
        }

        private void pause_click(object sender, RoutedEventArgs e)
        {
            Progres.Value = 0;

        }

        private void add_playlist_click(object sender, RoutedEventArgs e)
        {
            add_playlist abi = new add_playlist();
            abi.Show();
            Hide();
        }
    }
}
