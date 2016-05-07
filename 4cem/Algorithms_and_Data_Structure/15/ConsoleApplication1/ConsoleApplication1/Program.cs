using System;

public class Program
{
    public static int Main()
    {
        int c = 0;
        string str = " " + Console.ReadLine();
        int[] l = new int[str.Length];
        int[] r = new int[str.Length];
        int countofrequests = Convert.ToInt32(Console.ReadLine());
        if (countofrequests == 0)
        {
            Console.Write(str); //если ничего не меняем
            return 0;
        }

        for (int i = 0; i < countofrequests; i++)
        {
            string[] landr = Console.ReadLine().Split(' ');
            int le = Convert.ToInt32(landr[0]); 
            int ri = Convert.ToInt32(landr[1]);
            if (le > ri)
            {
                int t = le;
                le = ri;
                ri = t;
            }
            l[le] += 1;
            r[ri] += 1;
        }


        for (int each = 1; each < str.Length; each++)
        {
            c += l[each];
            if (c % 2 != 0)
            {
                if (Char.IsLower(str[each]))
                    Console.Write(Char.ToUpper(str[each]));


                else
                    Console.Write(Char.ToLower(str[each]));
            }
            else
                Console.Write(str[each]);
            c -= r[each];
        }
        return 0;
    }
}
