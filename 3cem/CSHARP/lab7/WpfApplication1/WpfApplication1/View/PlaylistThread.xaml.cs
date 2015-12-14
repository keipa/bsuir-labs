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
using System.Threading;
using System.ComponentModel;

namespace WpfApplication1.View
{
    /// <summary>
    /// Логика взаимодействия для PlaylistThread.xaml
    /// </summary>
    public partial class PlaylistThread : Window
    {
        BackgroundWorker backgroundWorker;
        Model.PlaylistModel current = new Model.PlaylistModel();
        Model.SongModel currentSong = new Model.SongModel();
        public PlaylistThread(Model.PlaylistModel playlist)
        {
            current = playlist;
            InitializeComponent();
            foreach (var song in playlist)
            {
                
                ListWithSongs.Items.Add("[" + song._mduration + ":" + song._sduration + "] " + song._artist + " - " + song._name + "(" + song._genre + ")");
            }

        }


        private void StartTread(object sender, RoutedEventArgs e)
        {

            backgroundWorker = new BackgroundWorker(); //создает объект класса
            backgroundWorker.WorkerReportsProgress = true; //включает индикацию хода выполнения
            //backgroundWorker.ProgressChanged +=
            //    new ProgressChangedEventHandler(backgroundWorker_ProgressChanged); //привязывает метод для индикации хода выполнения
            foreach (var song in current)
            {
                currentSong = song;
                //REPORT.Text += "\n" + "Playing now:" + currentSong._name;
                backgroundWorker.DoWork += new DoWorkEventHandler(backgroundWorker_DoWork); //метод который выполняет в другом потоке
                
            }
            
            
            backgroundWorker.RunWorkerAsync(); //старт потока

            #region threadnotwoked
            //Thread t = new Thread(ThreadProc);
            //Console.WriteLine("Before setting apartment state: {0}",
            //    t.GetApartmentState());

            //t.SetApartmentState(ApartmentState.STA);
            //Console.WriteLine("After setting apartment state: {0}",
            //    t.GetApartmentState());

            //bool result = t.TrySetApartmentState(ApartmentState.MTA);
            //Console.WriteLine("Try to change state: {0}", result);

            //t.Start();

            ////Thread.Sleep(500);

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
            #endregion

        }

        private void backgroundWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            int count = ListWithSongs.Items.Count;
            MediaPlayer eric = new MediaPlayer();
            eric.Open(new Uri(@"D:\LABS\BSUIR_labs\3cem\CSHARP\lab7\WpfApplication1\WpfApplication1\bin\Debug\The Eric Andre Show - We'll Be Right Back.mp3",UriKind.Absolute));
            int summ = (currentSong._mduration * 60 + currentSong._sduration) * 1000;
            
            eric.Play();
           // eric.Close();
            for (int i = summ; i > 0; i -= 5000)
                {
                    if (i < 5000)
                    {
                        Thread.Sleep(summ);
                        //eric.Open(new Uri(@"D:\LABS\BSUIR_labs\3cem\CSHARP\lab7\WpfApplication1\WpfApplication1\bin\Debug\The Eric Andre Show - We'll Be Right Back.mp3", UriKind.Absolute));
                        eric.Position = TimeSpan.FromSeconds(0);
                        eric.Play();

                    }
                    else
                    {
                        Thread.Sleep(5000);
                        //REPORT.Text += "\n" + "Playing now:" + currentSong._name;
                        
                        eric.Position = TimeSpan.FromSeconds(0);
                        eric.Play();
                    }
                }
                //if (ListWithSongs.SelectedIndex != count - 1)
                //{
                //    ++ListWithSongs.SelectedIndex;
                //}
            
            //Thread.Sleep((current._mduration*60+current._sduration)*1000);
            MessageBox.Show("You just heard "+currentSong._name);
        }

        public static void ThreadProc()
        {
            Thread.Sleep(2000);
        }//notworkthread
    }
}
