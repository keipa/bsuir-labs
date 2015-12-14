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

namespace WpfApplication1.View
{
    /// <summary>
    /// Логика взаимодействия для PlaylistThread.xaml
    /// </summary>
    public partial class PlaylistThread : Window
    {
        public PlaylistThread(Model.PlaylistModel playlist)
        {
            InitializeComponent();
            foreach (var song in playlist)
	{
        ListWithSongs.Items.Add("[" + song._mduration + ":" + song._sduration + "] " + song._artist + " - " + song._name + "(" + song._genre + ")");
	}
           
        }
    }
}
