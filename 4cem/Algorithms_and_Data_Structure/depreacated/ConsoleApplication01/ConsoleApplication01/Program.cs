using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace ConsoleApplication01
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = Convert.ToInt32(Console.ReadLine());
            
            //int[,] exclude = new int[a, a];
            ArrayList exclude = new ArrayList();
            exclude.Add(new ArrayList())
            for (int i = 0; i < a; i++)
            {
                for (int j = 0; j < a; j++)
                {
                    exclude[i, j] = 0;
                }
            }
            for (int i = 1; i < a; i++)
            {
                string[] t = Console.ReadLine().Split(' ');
                exclude[Convert.ToInt32(t[0]) - 1, Convert.ToInt32(t[1]) - 1] = 1;
                exclude[Convert.ToInt32(t[1]) - 1, Convert.ToInt32(t[0]) - 1] = -1;
            }
            Console.WriteLine(rank(exclude, a) / 2);
        }

        private static int rank(int[,] exclude, int a)
        {
            const double EPS = 1E-9;
            int rank = a;
            bool[] line_used = new bool[a];
            for (int i = 0; i < a; ++i)
            {
                int j;
                for (j = 0; j < a; ++j)
                    if (!line_used[j] && Math.Abs(exclude[j, i]) > EPS)
                        break;
                if (j == a)
                    --rank;
                else
                {
                    line_used[j] = true;
                    for (int p = i + 1; p < a; ++p)
                        exclude[j, p] /= exclude[j, i];
                    for (int k = 0; k < a; ++k)
                        if (k != j && Math.Abs(exclude[k, i]) > EPS)
                            for (int p = i + 1; p < a; ++p)
                                exclude[k, p] -= exclude[j, p] * exclude[k, i];
                }
            }
            return rank;
        }
    }
}
