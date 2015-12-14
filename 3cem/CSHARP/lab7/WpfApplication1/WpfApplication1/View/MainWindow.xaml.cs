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
            
            //tabs.ItemsSource = add.GetPlaylistsTabs();
        }
        public MainWindow(MainViewModel a)
        {
            add = a;
            InitializeComponent();
            tabs.Items.Clear();
            UpdateList();
        }

        public MainWindow(MainViewModel a, int select_playlist)
        {
            
            add = a;
            InitializeComponent();
            tabs.Items.Clear();
            UpdateList();
            tabs.SelectedIndex = select_playlist;
        }

        private void click_add_song(object sender, RoutedEventArgs e)
        {
            View.add_song asi = new View.add_song(add,tabs.SelectedIndex);
            asi.Show();
            Hide();
        }

        private void play_clicked(object sender, RoutedEventArgs e)
        {
            
        }

        

        private void add_playlist_click(object sender, RoutedEventArgs e)
        {

            View.add_playlist abi = new View.add_playlist(add);
            abi.Show();
            Hide();

        }

        private void Refresh(object sender, RoutedEventArgs e)
        {
            UpdateList();
        }

        private void UpdateList()
        {
            //TabItem a = new TabItem();
            tabs.Items.Clear();
            foreach (Model.PlaylistModel playlist in add.GetPlaylistsTabs())
            {
                TabItem a = new TabItem();
                a.Header = playlist._name + "[" + playlist._id + "]";
                tabs.Items.Add(a);
                ListBox grid = new ListBox();
                foreach (Model.SongModel song in playlist)
                {
                    TextBlock textBlock = new TextBlock();


                    textBlock.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
                    textBlock.VerticalAlignment = System.Windows.VerticalAlignment.Top;
                    textBlock.Text = "[" + song._mduration + ":" + song._sduration + "] " + song._artist + " - " + song._name + "(" + song._genre + ")";

                    grid.Items.Add(textBlock);
                    a.Content = grid;

                }

            }
        }
    }
}
