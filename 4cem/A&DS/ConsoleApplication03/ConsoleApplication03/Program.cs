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
