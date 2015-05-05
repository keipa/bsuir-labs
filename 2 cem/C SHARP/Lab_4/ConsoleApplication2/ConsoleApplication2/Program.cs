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
        [DllImport("winmm.dll")]
        extern static int mciSendString(string command,
        IntPtr responseBuffer, int bufferLength, int nothing);

        static void Main(string[] args)
        {
            string command = string.Format("play D:\\Music\\zakadr.mp3");
            IntPtr pt = Marshal.AllocHGlobal(0);
            mciSendString(command,pt,0,0);
            Console.ReadKey();
        }
    }
}
