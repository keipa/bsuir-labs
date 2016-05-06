using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication03
{
    class Program
    {
        static void Main(string[] args)
        {
            // рассматриваю три случая abacaba(len-1) - aaaaaaa(1) - asdfghj(len)
            int isFirstPoly = 0;
            string str = Console.ReadLine();
            int len = str.Length;
            bool brk = true;
            for (int i = 0; i < len / 2; i++)
            {
                if (str[i] != str[len - i - 1])
                {
                   ++isFirstPoly;
                }
                else if ((str[i] == str[len - i - 1]) && (str[i] != str[i + 1]))
                {
                    --isFirstPoly;
                }

                else if ((str[i] == str[len - i - 1]) && (str[i] == str[i + 1]))
                {
                    brk = false;
                    break;
                }
            }

            if (isFirstPoly > 0)
            {
                Console.WriteLine(len);
            }
            else if (isFirstPoly < 0)
            {
                Console.WriteLine(len - 1);
            }
            else if (!brk || len == 1)
            {
                Console.WriteLine(-1);
            }

        }
       

        }
}
