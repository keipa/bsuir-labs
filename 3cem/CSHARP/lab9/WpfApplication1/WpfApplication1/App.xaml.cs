using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Globalization;

namespace WpfApplication1
{
    /// <summary>
    /// Логика взаимодействия для App.xaml
    /// </summary>
    /// 
    public partial class App : Application
    {
        private static List<CultureInfo> languages = new List<CultureInfo>();
        public static event EventHandler LanguageChanged;
        public static List<CultureInfo> Languages { get { return languages; } }

        public App()
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            languages.Clear();
            languages.Add(new CultureInfo("en-US"));
            languages.Add(new CultureInfo("ru-RU"));
        }
        public static CultureInfo Language {
            get
            { return System.Threading.Thread.CurrentThread.CurrentUICulture; }
            set
            { if (value == null) { throw new ArgumentNullException("value"); }
              if (value == System.Threading.Thread.CurrentThread.CurrentUICulture) { return; }
                System.Threading.Thread.CurrentThread.CurrentUICulture = value;
                ResourceDictionary diction = new ResourceDictionary();
                switch (value.Name)
                {
                    case "ru-RU": diction.Source = new Uri(string.Format("localize/lang.{0}.xaml", value.Name), UriKind.Relative); break;
                    default: diction.Source = new Uri("localize/lang.xaml", UriKind.Relative); break;
                }
                ResourceDictionary removeDiction = (from d in Application.Current.Resources.MergedDictionaries
                                                    where d.Source != null && d.Source.OriginalString.StartsWith("localize/lang.")
                                                    select d).First();
                if (removeDiction != null)
                {
                    int index = Application.Current.Resources.MergedDictionaries.IndexOf(removeDiction);
                    Application.Current.Resources.MergedDictionaries.Remove(removeDiction);
                    Application.Current.Resources.MergedDictionaries.Insert(index, diction);

                }
                else {
                    Application.Current.Resources.MergedDictionaries.Add(diction); // 

                }
                LanguageChanged(Application.Current, new EventArgs());
            }
             }
    }
}
