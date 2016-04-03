using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace sharp
{
    class Program
    {
        static void Main(string[] args)
        {
            string s = Console.ReadLine();
            int x1, y1, x2, y2;
            x1 = Convert.ToInt32(s[4]);
            y1 = Convert.ToInt32(s[6]);
            x2 = Convert.ToInt32(s[8]);
            y2 = Convert.ToInt32(s[10]);
            if (x1 == x2 || y1 == y2)
            {
                Console.WriteLine("YES");
                return;
            }
            else if (x1<x2 && y1<y2)
            {
                while (x1 < x2 && y1 < y2)
                {
                    ++x1;
                    ++y1;
                    if (x1 == x2 && y1 == y2)
                    {
                        Console.WriteLine("NO");
                        return;
                    }
                }
                Console.WriteLine("YES");
                return;
            }
            else if(x2 < x1 && y2 < y1)
            {
                while (x2 < x1 && y2 < y1)
                {
                    ++x2;
                    ++y2;
                    if (x1 == x2 && y1 == y2)
                    {
                        Console.WriteLine("NO");
                        return;
                    }
                    
                }
                Console.WriteLine("YES");
                return;
            }
            else
            {
                Console.WriteLine("YES");
            }

        }
    }
}
