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
namespace WpfApplication1
{
    class Playlist:IEnumerable<Song>
    {
      public List<Song> current;

      public int _mduration{get;set;}
      public int _sduration{get;set;}
      public int _rating{get;set;}



        /*interface realization*/
      public bool Contains(Song q)
      {
          return current.Contains(q);
      }


      public bool Remove(Song q)
      {

          return current.Remove(q);
      }

      public void CopyTo(Song[] q, int index)
      {
          current.CopyTo(q, index);
      }


      public IEnumerator<Song> GetEnumerator()
      {
          foreach (Song i in current)
          {
              yield return i;
          }
      }

      IEnumerator IEnumerable.GetEnumerator()
      {
          return GetEnumerator();
      }
    }
}
