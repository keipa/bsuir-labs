using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace ConsoleApplication12
{
    class Program
    {
        static void Main(string[] args)
        {
            Int64 number = Convert.ToInt64(Console.ReadLine());
            if (number % 10 == 0)
                Console.WriteLine("NO");
            else
                Console.WriteLine(number % 10);
        }
    }
}
