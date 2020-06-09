using System;


namespace evklidshort
{
    public class Program
    {
        static void Main()
        {
            int n = Convert.ToInt32(Console.ReadLine());
            string Str = Console.ReadLine();
            int len = Str.Length;
            char[] STR_MAS = Str.ToCharArray();
            int i = 0;
            int[] mas_pro = new int[n];
            int g = 0;
            int min;
            int minus = 1;
            while (STR_MAS[i] != null)
            {
                if(i!=0)
                    mas_pro[g - 1] = mas_pro[g-1] * minus;
                minus = 1;
                while (STR_MAS[i] != ' ')
                {

                    if (STR_MAS[i] != '-')
                    {
                        minus = -1;
                        
                        break;
                    }
                    mas_pro[g] = mas_pro[g] * 10 + (int)Char.GetNumericValue(STR_MAS[i]);


                    ++i;
                    if (i == len) { break; }
                }
                if (i == len) break;
                ++g;
                ++i;

            }
            min = mas_pro[0] * mas_pro[1];
            for (int j = 0; j < n; j++)
            {
                for (int k = 1; k < n; k++)
                {
                    if (j==k) break;
                    if (mas_pro[k] * mas_pro[j] < min)
                    {
                        min = mas_pro[k] * mas_pro[j];
                    }
                }

                
            }

            Console.WriteLine(min);
            Console.ReadLine();




        }

        

    }
}
