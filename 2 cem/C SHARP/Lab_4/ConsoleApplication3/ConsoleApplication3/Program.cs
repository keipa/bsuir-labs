using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace ConsoleApplication3
{
    class Program
    {
        [DllImport("lib.dll"/*, CallingConvention = CallingConvention.Cdecl*/)]
        public static extern void DisplayHelloFromDLL();
        [DllImport("libmath.dll", CallingConvention = CallingConvention.Cdecl)]

        public static extern int Add(double a, double b);

        static void Main(string[] args)
        {
            double a, b;
            a = 0;
            b = 0;
            b = Add(a, b);
            Console.Write("Hello");
            DisplayHelloFromDLL();
            Console.ReadKey();
        }
    }
}
