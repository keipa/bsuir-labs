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

            string str = Console.ReadLine();
            int poly = str.Length;
            bool brk = false;
            List<string> sub = showSubstrings(str);
            //Console.WriteLine(Reverse(str));
            //Console.WriteLine(str.Substring(2).Remove(2));
            //Console.ReadKey();

            //Console.WriteLine(isPoly("kek", str));
            for (int i = sub.Count-1; i > 0;i-- )
            {
                if (!isPoly(sub[i]))
                {
                    Console.WriteLine(sub[i].Length);
                    brk = true;
                    break;
                }
            }
            if (!brk)
            {
                Console.WriteLine(-1);
            }
            Console.ReadKey();

            //for (int p = str.Length; p > 0; p--)
            //{
            //    for (int i = 0; i <= str.Length - p; i++)
            //    {
            //        //if (p <= i)
            //        //{
            //        //    brk = true;
            //        //    break;
            //        //}
            //        if (p == str.Length && i == 0)
            //        {
            //            if (!isPoly(str))
            //            {
            //                Console.WriteLine(poly);
            //                brk = true;
            //                break;
            //            }
            //            continue;
            //        }
            //        if (!isPoly(str.Substring(i).Remove(p-i)))
            //        {
            //            Console.WriteLine(poly);
            //            brk = true;
            //            break;
            //        }
            //    }
            //    if (brk)
            //        break;
            //    --poly;
            //    if (poly == 1)
            //        brk = true;
            //}
            ////Console.WriteLine(poly);
            //if (poly == 1)
            //{
            //    Console.WriteLine(-1);
            //}
            //Console.ReadKey();
        }
        public static bool isPoly(string substr)
        {
            if (Reverse(substr) == substr)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public static List<String> showSubstrings(string str)
        {
            List<String> all = new List<string>();
            int len = 1;
            //all.Add(str);
            while (len <= str.Length)
            {
                for (int i = 0; i < str.Length && i+len <= str.Length; i++)
                {
                    all.Add(str.Substring(i, len));
                }

                ++len;
            }
                return all;

        }
        public static string Reverse(string text)
        {
            char[] cArray = text.ToCharArray();
            string reverse = String.Empty;
            for (int i = cArray.Length - 1; i > -1; i--)
            {
                reverse += cArray[i];
            }
            return reverse;
        }

    }
}
