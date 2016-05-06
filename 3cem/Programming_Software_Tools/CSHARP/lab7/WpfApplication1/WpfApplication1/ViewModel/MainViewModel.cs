using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfApplication1.Model;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Threading;
using System.Collections.ObjectModel;
using Microsoft.Win32;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO.Compression;
using System.Collections;
using System.Reflection;
using System.Globalization;

namespace WpfApplication1.ViewModel
{
    public class MainViewModel : IEnumerable<Model.PlaylistModel>
    {
        #region
        public List<Model.PlaylistModel> current = new List<PlaylistModel>();
        public Model.PlaylistModel currentPlaylist;
        public Model.SongModel currentSong = new SongModel();
        //public event NotifyCollectionChangedEventHandler CollectionChanged;
        #endregion

        public MainViewModel()
        {
            current = new List<PlaylistModel>();
            

            
           
            //#region testing
            //Model.PlaylistModel testp = new PlaylistModel();
            //Model.SongModel tests = new SongModel();

            //testp.Add(tests);
            //current.Add(testp);
            //#endregion


        }

        public List<Model.PlaylistModel> GetPlaylistsTabs()
        {
            return current;
        }
        public void AddPlaylist(int id, string name)
        {
            currentPlaylist = new PlaylistModel();
            Model.PlaylistModel newP = new PlaylistModel();
            newP._name = name;
            newP._id = id;
            current.Add(newP);
            currentPlaylist = newP;

        }
        
        public void DelPlaylist(int selected_playlist)
        {
            try
            {
                current.Remove(current[selected_playlist]);
            }
            catch (System.ArgumentOutOfRangeException)
            {
                MessageBox.Show("You have no playlists");

            }
            
        }
        public void AddSong(int id,string artist, string name, string janr, int rating, int sdurtion, int mduration, int selected_playlist)
        {
            
            try
            {
                currentPlaylist = current[selected_playlist];
            }
            catch (System.ArgumentOutOfRangeException)
            {
                MessageBox.Show("Playlist does not exist");
            }
            Model.SongModel newS = new SongModel();
            newS._name = name;
            newS._artist = artist;
            newS._genre = janr;
            newS._id = id;
            newS._mduration = mduration;
            newS._sduration = sdurtion;


            newS._rating = rating;
            currentPlaylist.Add(newS);
            currentSong = newS;
           
        }
        public void DelSong(int playlist, int song)
        {
            try
            {
                current[playlist].current.Remove(current[playlist].current[song]);

            }
            catch (System.ArgumentOutOfRangeException)
            {
                MessageBox.Show("you havent got songs");              
            }
        }
        #region InterfaceRealizaiton

        /*interface realization*/
        public void Add(Model.PlaylistModel s)
        {
            current.Add(s);
        }
        public void Clear()
        {
            current.Clear();
        }

        public bool Contains(Model.PlaylistModel q)
        {
            return current.Contains(q);
        }


        public bool Remove(Model.PlaylistModel q)
        {

            return current.Remove(q);
        }

        public void CopyTo(Model.PlaylistModel[] q, int index)
        {
            current.CopyTo(q, index);
        }


        public IEnumerator<Model.PlaylistModel> GetEnumerator()
        {
            foreach (Model.PlaylistModel i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
        #endregion

    }
}
