using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace ConsoleApplication5
{
    class Program
    {
        static void Main(string[] args)
        {
            
            int a = Convert.ToInt32(Console.ReadLine());
            List<int> nums = new List<int>();
            foreach (var k in Console.ReadLine().Split(' '))
            {
                if (k == ""){
                    break;
                } 
                nums.Add(Convert.ToInt32(k));
            }
            int p1 = nums.Max();
            nums.Remove(nums.Max());
            int p2 = nums.Max();
            nums.Remove(nums.Max());
            long positive = (long)p1 * (long)p2;
            nums.Add(p1);
            nums.Add(p2);
            int n1 = nums.Min();
            nums.Remove(nums.Min());
            int n2 = nums.Min();
            nums.Remove(nums.Min());
            long negative = (long)n1 * (long)n2;
            if (positive >= negative)
            {
                Console.WriteLine(positive);
            }
            else
            {
                Console.WriteLine(negative);
            }
        }
    }
}
