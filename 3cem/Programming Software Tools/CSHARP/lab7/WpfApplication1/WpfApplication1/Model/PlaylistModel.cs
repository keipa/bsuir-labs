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

namespace WpfApplication1.Model
{
     public class PlaylistModel : IEnumerable<Model.SongModel>
    {
        #region Constructor
        public PlaylistModel()
        {
            _name = "default";
            _id = 0;
            _mduration = 0;
            _sduration = 0;
            _rating = 0;
        }


        #endregion
        #region Properties
        public List<Model.SongModel> current = new List<SongModel>();

        public string _name { get; set; }
        public int _id { get; set; }
        public int _mduration
        {
            get
            {
                if (current.Count == 0)
                {
                    return 0;
                }
                else
                {
                    double summ = 0;
                    double summseconds = 0;
                    foreach (Model.SongModel song in current)
                    {
                        summ += song._mduration;
                        summseconds += song._sduration;
                        if (summseconds >= 60)
                        {
                            summ += (int)Math.Truncate(summseconds / 60);
                        }
                    }
                    return (int)summ;
                }
            }
            set { }
        }//badass
        public int _sduration
        {
            get
            {
                if (current.Count == 0)
                {
                    return 0;
                }
                else
                {
                    double summ = 0;
                    int plus_min;
                    foreach (Model.SongModel song in current)
                    {
                        summ += song._sduration;
                    }
                    if (summ >= 60)
                    {
                        plus_min = (int)Math.Truncate(summ / 60);
                        _mduration += plus_min;
                        summ = summ - plus_min * 60;
                        return (int)summ;
                    }
                    else { return (int)summ; }
                }
            }
            set { }
        }//useless strings
        public int _rating
        {
            get
            {
                int summ = 0;
                int count = 0;
                foreach (Model.SongModel song in current)
                {
                    ++count;
                    summ += song._rating;

                }
                if (count == 0)
                {
                    return 0;
                }else
                return summ / count;
            }
            set { }
        }//well
        #endregion

        #region InterfaceRealizaiton

        /*interface realization*/
        public void Add(Model.SongModel s)
        {
            current.Add(s);
        }
        public void Clear()
        {
            current.Clear();
        }

        public bool Contains(Model.SongModel q)
        {
            return current.Contains(q);
        }


        public bool Remove(Model.SongModel q)
        {
            return current.Remove(q);
        }

        public void CopyTo(Model.SongModel[] q, int index)
        {
            current.CopyTo(q, index);
        }


        public IEnumerator<Model.SongModel> GetEnumerator()
        {
            foreach (Model.SongModel i in current)
            {
                yield return i;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
        #endregion//well

    }
}
