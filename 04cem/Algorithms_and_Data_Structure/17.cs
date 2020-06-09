﻿using System;
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
            string[] words = s.Split(' ');
            int[] nums = new int[words.Length];
            for(int i = 0 ;i<words.Length;i++)
            {
                nums[i] = Convert.ToInt32(words[i]);
            }
            int x1, y1, x2, y2;
            x1 = nums[2];
            y1 = nums[3];
            x2 = nums[4];
            y2 = nums[5];
            if (Math.Abs(x1 - x2) == Math.Abs(y1 - y2))
            {
                Console.WriteLine("NO");
            }
            else
            {
                Console.WriteLine("YES");
            }
        }
    }
}