using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
namespace app
{
    class Program
    {
       // [DllImport("lib.dll",CallingConvention = CallingConvention.Cdecl]
       [DllImport("libmath.dll",CallingConvention = CallingConvention.Cdecl)]
             public static extern int Add(double a, double b);


        static void Main(string[] args)
        {
            int a = 5;
            int b = 6;
            Console.WriteLine("This is C# program");
          
            Console.WriteLine(Add(a, b));
            //DisplayHelloFromDLL();
            Console.ReadKey();
        }
    }
}
