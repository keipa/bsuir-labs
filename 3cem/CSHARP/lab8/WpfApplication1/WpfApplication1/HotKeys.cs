
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.IO;
using System.IO.Compression;
using Microsoft.Win32;


namespace WpfApplication1
{
    class HotKeys
    {
        
        private static RoutedUICommand addTest;
        //private static RoutedUICommand 


        static HotKeys()
        {

            
            InputGestureCollection inputs = new InputGestureCollection();
            //повторять N раз
            inputs.Add(new KeyGesture(Key.F2, ModifierKeys.None ,"F2"));
            addTest = new RoutedUICommand("Add Test","Add",typeof(HotKeys),inputs);
            //повторять N раз

            inputs = new InputGestureCollection();
            

        }
        public static RoutedUICommand AddTest { get { return addTest; } }
    }

}
