using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Maxlex
{
    class Program
    {
        static void Main(string[] args)
        {

            string Str = Console.ReadLine();
            char[] s = Str.ToCharArray();
             int x = Str.Length;
            int e;
            int n=0;
    for ( int i=0;i<x; i++ ) {
        while ( n>0 && s[i]>s[n-1] ) n--;
        s[n++]=s[i];
    }

            e = x - n;
            if (e % 2 == 1)
            {
                Console.WriteLine("FIRST");
            }
            else
            {
                Console.WriteLine("SECOND");
            }
            
            


          /*  string Str = Console.ReadLine();
            char[] Str_mas = Str.ToCharArray();
            char it = 'z';
            char del;
            int start;

            for (int i = 0; i < Str.Length; i++)
            {
                if (Str[i] == it)
                {
                    index = i;
                    
                }

                else --it;
                if (Str[i] >= 'a' && Str[i] <= 'z')         //condition for each symbol left and right border
                    Console.WriteLine(Str[i]); */ 
            }
        }
        
        
    }

