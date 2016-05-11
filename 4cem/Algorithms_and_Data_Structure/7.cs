using System;
using System.Collections.Generic;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] properties = Console.ReadLine().Split(' ');
            int vertex = Convert.ToInt32(properties[0]);
            int count_of_edges = Convert.ToInt32(properties[1]);
            List<List<int>> verarr = new List<List<int>>();
            bool[] isVisited = new bool[vertex];
            //if (vertex == 1)
            //{
            //    Console.WriteLine(-1);
            //}
            for (int i = 0; i < vertex; i++)
            {
                verarr.Add(new List<int>());
            }

            for (int i = 0; i < count_of_edges; i++)
            {
                string[] edge = Console.ReadLine().Split(' ');
                verarr[Convert.ToInt32(edge[0]) - 1].Add(Convert.ToInt32(edge[1]) - 1);
                verarr[Convert.ToInt32(edge[1]) - 1].Add(Convert.ToInt32(edge[0]) - 1);
                //verarr[Convert.ToInt32(edge[0])] += Convert.ToInt32(edge[1]);
            }

            int concom = 0;

            for (int i = 0; i < vertex; i++)
            {
                if (isVisited[i] == false)
                {
                    ++concom;
                    dfs(i, isVisited, verarr);
                }
            }
            Console.WriteLine(concom - 1);

            Console.ReadKey();
        }

        public static void dfs(int i, bool[] isVisited, List<List<int>> verarr)
        {
            
            isVisited[i] = true; 
            foreach (var ver in verarr[i])
            {
                if (isVisited[ver] == false){
                    dfs(ver, isVisited, verarr);
                }
            }
        }


    }
}