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
using WpfApplication1.ViewModel;
using WpfApplication1.View;

namespace WpfApplication1.View
{
    /// <summary>
    /// Логика взаимодействия для add_playlist.xaml
    /// </summary>
    /// 

    public partial class add_playlist : Window
    {

        public MainViewModel add;

        public add_playlist(MainViewModel a)
        {
            add = a;
            Random rnd = new Random();
            InitializeComponent();
            ID.Text = Convert.ToString(rnd.Next(10000, 100000));
        }

        #region Clicks
        private void add_clicked(object sender, RoutedEventArgs e)
        {
            
            
            add.AddPlaylist(Convert.ToInt32(ID.Text),
                            NameOfPlaylist.Text);
            View.MainWindow back = new View.MainWindow(add);
            back.Show();
            Hide();
        }
        #endregion
    }
}
