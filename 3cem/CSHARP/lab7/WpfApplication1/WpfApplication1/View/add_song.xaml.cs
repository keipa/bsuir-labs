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


namespace WpfApplication1.View
{
    /// <summary>
    /// Логика взаимодействия для add_song.xaml
    /// </summary>
    public partial class add_song : Window
    {

        public MainViewModel add;
        int selected_playlist_index = 0;
        #region Constructor
        public add_song(MainViewModel a, int s)
        {
            selected_playlist_index = s;
            add = a;
            Random rnd = new Random();
            InitializeComponent();
            ID.Text = Convert.ToString(rnd.Next(10000, 100000));
            _min.Text = "20";
            
        }
        #endregion
   
        
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
        #region Clicks

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            //MainViewModel add = new MainViewModel();
            add.AddSong(Convert.ToInt32(ID.Text),
                ARTIST.Text,
                SONGNAME.Text,
                GENRE.Text,
                RATING.SelectedIndex + 1,
                Convert.ToInt32(_sec.Text),
                Convert.ToInt32(_min.Text),selected_playlist_index);

            View.MainWindow back = new View.MainWindow(add,selected_playlist_index);
            back.Show();
            Hide();
        }

        #endregion
    }
}
