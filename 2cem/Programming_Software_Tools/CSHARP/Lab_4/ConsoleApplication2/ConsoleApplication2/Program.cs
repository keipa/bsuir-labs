using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace ConsoleApplication2
{
    class Program
    {

        [DllImport("lib2.dll", CallingConvention = CallingConvention.Cdecl, SetLastError = true)]
        extern static double Add(double a, double b);
       /*  [DllImport("lib.dll")]
         extern static double Subtract(double a, double b);
         [DllImport("lib.dll")]
         extern static double Multiply(double a, double b);
         [DllImport("lib.dll")]
         extern static double Divide(double a, double b);*/
         [DllImport("winmm.dll")]
         extern static int mciSendString(string command, IntPtr responseBuffer, int bufferLength, int nothing);

        static void Main(string[] args)
        {
            //Add(3,4);
            
           double a = 1;
           double b = 1;

            a = Add(a, b);
            string command = string.Format("play D:\\Music\\zakadr.mp3");
            IntPtr pt = Marshal.AllocHGlobal(0);
            mciSendString(command,pt,0,0);
            Console.WriteLine(a);
            Console.ReadKey();
        }   
    }
}
