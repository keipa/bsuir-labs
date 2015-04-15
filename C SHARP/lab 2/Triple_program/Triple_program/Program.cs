using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Triple_program
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("1 - Find_Russian\n2 - Date_Count\n3 - String_Invert\nb - Exit"); //choose programm
            while (true){
                string r = Console.ReadLine();
                
            switch (r)
            {
                case "1":{
                    Find_Russian();
                    break;
                }
                case "2":{
                        Date_Count();
                        break;
                    }
                case "3":{
                        Console.WriteLine(String_Invert());
                        break;
                    }
                case "b":{
                        return;
                    
                    }
                default:{

                        break;
                    }
                    
            }
            Console.WriteLine("1 - Find_Russian\n2 - Date_Count\n3 - String_Invert\nb - Exit");
            }
            
            
            
        }

        private static void Find_Russian()
        {
            Console.WriteLine("Программа выводит из строки русские заглавные буквы");
            string Str = Console.ReadLine();
           char[] Str_mas = Str.ToCharArray();              // string to array

           
           
            for (int i = 0; i < Str.Length; i++)
            {
                if (Str[i] >= 'А' && Str[i] <= 'Я')         //condition for each symbol left and right border
                    Console.WriteLine(Str[i]);
            }
        }

        private static void Date_Count()
        {
            string TDate_one = DateTime.Now.ToString("hh/mm/dd/MM/yyyy");           //first format
            string TDate_two = DateTime.Now.ToString("h/mm/dd/M/yy");               //second format
            char[] TDate_one_mas = TDate_one.ToCharArray();
            char[] TDate_two_mas = TDate_two.ToCharArray();
            int digit = 0;
            int[] c_digit = new int[10];                            //array with 0-9 digits
            int[] b_digit = new int[10];
            Console.WriteLine("Первый формат " + TDate_one);

            for (int i = 0; i < TDate_one_mas.Length; i++)
            {
                while (digit <= 9)
                {
                    if (TDate_one_mas[i].ToString() == digit.ToString())        //search digits in string throught array X2
                        ++c_digit[digit];

                    ++digit;
                }
                digit = 0;
            }

            for (int u = 0; u < 10; u++)
                Console.WriteLine("Count of " + u.ToString() + " - " + c_digit[u].ToString());
            

            Console.WriteLine("Второй формат " + TDate_two);
            for (int i = 0; i < TDate_two_mas.Length; i++)
            {
                while (digit <= 9)
                {
                    if (TDate_two_mas[i].ToString() == digit.ToString())
                        ++b_digit[digit];
                    ++digit;
                }
                digit = 0;
            }
            for (int u = 0; u < 10; u++)
            {
                Console.WriteLine("Count of " + u.ToString() + " - " + b_digit[u].ToString());
            }
            
        }

        private static StringBuilder String_Invert()
        {
            string Str = Console.ReadLine();

            StringBuilder stringbuilder = new StringBuilder();
 
                Str += ' ';
            char[] Str_mas = Str.ToCharArray();
            int a = Str.Length;

            for (int i = 0; i < a - 1; i++)
            {
                int count = 0;
                                                        // reverse string with word checker '_'
                while (Str_mas[i + count] != ' ')
                    ++count;

                int plus_one = 0;

                for (int g = i; g < i + count / 2; g++)         //replace loop
                {
                    char Replace = Str_mas[g];
                    Str_mas[g] = Str_mas[i + count - 1 - plus_one];
                    Str_mas[i + count - 1 - plus_one] = Replace;
                    ++plus_one;
                }
                i += count;
            }
            Str = "";
            
            for (int u = 0; u < a; u++)
            {
                Str += Str_mas[u];
                stringbuilder.Append(Str_mas[u]);
            }
       
            return stringbuilder;
            
            
        
          
        }
    }
}
