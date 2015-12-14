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
using System.Threading;

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
      
        private void add_playlist_click(object sender, RoutedEventArgs e)
        {

            View.add_playlist abi = new View.add_playlist(add);
            abi.Show();
            Hide();

        }
        private void deletePlaylist(object sender, RoutedEventArgs e)
        {
            add.DelPlaylist(tabs.SelectedIndex);
            tabs.SelectedIndex = -1;
            UpdateList();

        }
        private void playlist_info(object sender, SelectionChangedEventArgs e)
        {
            PLAYLISTINFO.Text = add.GetPlaylistsTabs()[tabs.SelectedIndex]._id+"\n"+
                                add.GetPlaylistsTabs()[tabs.SelectedIndex]._name+"\n"+
            add.GetPlaylistsTabs()[tabs.SelectedIndex]._rating+"\n"+
            add.GetPlaylistsTabs()[tabs.SelectedIndex]._mduration + ":" +
            add.GetPlaylistsTabs()[tabs.SelectedIndex]._sduration;
        }

        /*click refresh button*/
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

        

        
        #region Threading

        private void play_clicked(object sender, RoutedEventArgs e)
        {
            View.PlaylistThread ati = new View.PlaylistThread(add.GetPlaylistsTabs()[tabs.SelectedIndex]);
            ati.Title = add.GetPlaylistsTabs()[tabs.SelectedIndex]._name;
            ati.Show();
            //Thread t = new Thread(ThreadProc);
            //Console.WriteLine("Before setting apartment state: {0}",
            //    t.GetApartmentState());

            //t.SetApartmentState(ApartmentState.STA);
            //Console.WriteLine("After setting apartment state: {0}",
            //    t.GetApartmentState());

            //bool result = t.TrySetApartmentState(ApartmentState.MTA);
            //Console.WriteLine("Try to change state: {0}", result);

            //t.Start();

            //Thread.Sleep(500);

            //try
            //{
            //    t.TrySetApartmentState(ApartmentState.STA);
            //}
            //catch (ThreadStateException)
            //{
            //    Console.WriteLine("ThreadStateException occurs " +
            //        "if apartment state is set after starting thread.");
            //}

            //t.Join();
        }

        //public static void ThreadProc()
        //{
        //    Thread.Sleep(2000);
        //}

        #endregion

        
    }
}
