
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
        private static RoutedUICommand clear;
        //private static RoutedUICommand 


        static HotKeys()
        {

            
            InputGestureCollection primary = new InputGestureCollection();
            InputGestureCollection secondary = new InputGestureCollection();
          
            primary.Add(new KeyGesture(Key.F2, ModifierKeys.None ,"F2"));
            addTest = new RoutedUICommand("Add Test","Add",typeof(HotKeys),primary);

            secondary.Add(new KeyGesture(Key.F3, ModifierKeys.None, "F3"));
            clear = new RoutedUICommand("Clear All", "clear", typeof(HotKeys), secondary);
            
            primary = new InputGestureCollection();
            secondary = new InputGestureCollection();
            

        }
        public static RoutedUICommand AddTest { get { return addTest; } }
        public static RoutedUICommand Clear { get { return clear; } }
    }
   

}
