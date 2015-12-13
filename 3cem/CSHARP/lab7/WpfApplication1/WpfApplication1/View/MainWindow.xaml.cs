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
using WpfApplication1.ViewModel;

namespace WpfApplication1.View
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 

    public partial class MainWindow : Window
    {
        public MainViewModel add = new MainViewModel();



        public MainWindow()
        {

            InitializeComponent();
            tabs.Items.Clear();
            add.AddPlaylist(0, "Default");
            add.AddPlaylist(1, "Default2");
            //tabs.ItemsSource = add.GetPlaylistsTabs();
        }
        public MainWindow(MainViewModel a)
        {
            add = a;
            
            InitializeComponent();
            tabs.Items.Clear();
        }


        private void click_add_song(object sender, RoutedEventArgs e)
        {
            View.add_song asi = new View.add_song(add);
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

            View.add_playlist abi = new View.add_playlist(add);
            abi.Show();
            Hide();

        }

        private void Refresh(object sender, RoutedEventArgs e)
        {
            //TabItem a = new TabItem();
            foreach (Model.PlaylistModel playlist in add.GetPlaylistsTabs()){
                TabItem a = new TabItem();
                a.Header = playlist._name + "[" + playlist._id+"]";
                tabs.Items.Add(a);

            }
    }
    }
}
