using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfApplication1.Model
{
    public class SongModel
    {
        #region Properties
        public int _id { get; set; }
        public string _name { get; set; }
        public int _mduration { get; set; }
        public int _sduration { get; set; }

        public string _artist { get; set; }
        public int _rating { get; set; }
        public string _genre { get; set; }
        #endregion

        #region Constructor
        public SongModel()
        {
            _id = 0;
            _name = "default";
            _sduration = 0;

            _mduration = 0;
            _artist = "default artist";
            _rating = 1;
            _genre = "no";
        }

        #endregion
    }
}
