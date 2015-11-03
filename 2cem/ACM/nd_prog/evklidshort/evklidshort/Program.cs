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

            while (STR_MAS[i] != null)
            {

                while (STR_MAS[i] != ' ')
                {


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
                    if (mas_pro[i] * mas_pro[j] < min)
                    {
                        min = mas_pro[i] * mas_pro[j];
                    }
                }

                
            }

            Console.WriteLine(min);
            Console.ReadLine();




        }

        /*  private static float Evklid(float ax, float ay, float bx, float by)
          {


              float MAINY;
                  MAINY= (ay*by-by*by)/(2*ax+2*bx);
            

              float go;
              if (ay == by)
              {
                  if (bx > ax)
                  {
                      go = (bx - ax) / 2;
                      return go;
                  }
                  if (bx < ax)
                  {
                      go = (ax - bx) / 2;
                      return go;
                  }
                  if (ax == bx)
                  {
                      go = ax;
                      return go;
                  }
              }

              if (ax == bx)
              {
                  go = ax;
                  return go;
              }
           

           
              if (ax > bx)
              {
                  if (MAINY < 0) 
                      MAINY = -MAINY;
                  return bx + MAINY;
              }
              else
              {
                  if (MAINY < 0)
                  {
                      MAINY = -MAINY;
                  }
                  return ax + MAINY;
              }
          }
      }*/

    }
}
