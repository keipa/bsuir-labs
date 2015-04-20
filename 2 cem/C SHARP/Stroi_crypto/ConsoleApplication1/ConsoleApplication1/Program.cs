using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
             Console.WriteLine("1 - Find_Russian\n2 - Date_Count\n3 - String_Invert\nb - Exit"); //choose programm
             while (true)
             {
                 string r = Console.ReadLine();

                 switch (r)
                 {
                     case "1":
                         {
                            
                             Console.WriteLine(encrypt(Console.ReadLine()));
                             break;
                         }
                     case "2":
                         {

                             break;
                         }

                     case "b":
                         {
                             return;

                         }
                     default:
                         {

                             break;
                         }

                 }
             }
         


        }

        private static string encrypt(string cry)
        {
            
            char[] mas_s = cry.ToCharArray();
            char[] alpha = null;
            int i = 0;
            for (char a = 'a'; a <= 'z'; a++)
            {
                alpha[i] = a;
                ++i;

            }
            for (int g = 0; g < i; g++)
            {
                Console.Write(alpha[g]);
            }

        }
    }
}
