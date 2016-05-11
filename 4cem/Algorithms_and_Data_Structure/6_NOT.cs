using System;
using System.Collections.Generic;

namespace Dijkstras
{
    class Graph
    {
        Dictionary<int, Dictionary<int, int>> vertices = new Dictionary<int, Dictionary<int, int>>();

        public void add_vertex(int name, Dictionary<int, int> edges)
        {
            vertices[name] = edges;
        }

        public List<int> shortest_path(int start, int finish)
        {
            var previous = new Dictionary<int, int>();
            var distances = new Dictionary<int, int>();
            var nodes = new List<int>();

            List<int> path = null;
             
            foreach (var vertex in vertices)
            {
                if (vertex.Key == start)
                {
                    distances[vertex.Key] = 0;
                }
                else
                {
                    distances[vertex.Key] = int.MaxValue;
                }

                nodes.Add(vertex.Key);
            }

            while (nodes.Count != 0)
            {
                nodes.Sort((x, y) => distances[x] - distances[y]);

                var smallest = nodes[0];
                nodes.Remove(smallest);

                if (smallest == finish)
                {
                    path = new List<int>();
                    while (previous.ContainsKey(smallest))
                    {
                        path.Add(smallest);
                        smallest = previous[smallest];
                    }

                    break;
                }

                if (distances[smallest] == int.MaxValue)
                {
                    break;
                }

                foreach (var neighbor in vertices[smallest])
                {
                    var alt = distances[smallest] + neighbor.Value;
                    if (alt < distances[neighbor.Key])
                    {
                        distances[neighbor.Key] = alt;
                        previous[neighbor.Key] = smallest;
                    }
                }
            }

            return path;
        }
    }

    class MainClass
    {
        public static void Main(string[] args)
        {
            Graph g = new Graph();
            int vertex = Convert.ToInt32(Console.ReadLine());

            List<List<int[]>> verarr = new List<List<int[]>>();
            for (int i = 0; i < vertex; i++)
            {
                verarr.Add(new List<int[]>());
            }
            int count_of_edges = Convert.ToInt32(Console.ReadLine());
            for (int i = 0; i < count_of_edges; i++)
            {
                string[] edge = Console.ReadLine().Split(' ');
                verarr[Convert.ToInt32(edge[0]) - 1].Add(new int[2] { Convert.ToInt32(edge[1]) - 1, Convert.ToInt32(edge[2]) });
                verarr[Convert.ToInt32(edge[1]) - 1].Add(new int[2] { Convert.ToInt32(edge[0]) - 1, Convert.ToInt32(edge[2]) });
                //verarr[Convert.ToInt32(edge[0])] += Convert.ToInt32(edge[1]);
            }
            foreach (var item in verarr)
            {
                Dictionary<int, int> conv = new Dictionary<int, int>();
                foreach (var i in item)
                {
                    try { conv.Add(i[0], i[1]); }
                    catch (Exception) { }
                }
                g.add_vertex(verarr.IndexOf(item), conv);
            }
            int start = Convert.ToInt32(Console.ReadLine()) - 1;
            int finish = Convert.ToInt32(Console.ReadLine()) - 1;


            List<int> path = new List<int>();
            path = g.shortest_path(start, finish);
            path.Add(start);
            path.Reverse();
            int weight = 0;
            int collector = path[0];
            for (int i = 1; i < path.Count; i++)
            {
                foreach (var item in verarr[collector])
                {
                    if (item[0] == path[i]) { weight += item[1]; break; }
                }
                collector = path[i];
            }
            Console.WriteLine(weight);
            Console.ReadKey();
        }
    }
}