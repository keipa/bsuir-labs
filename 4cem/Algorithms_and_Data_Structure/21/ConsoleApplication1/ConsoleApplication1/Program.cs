using System;
using System.Collections.Generic;


namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Queue<List<int>> horse_steps = new Queue<List<int>>();
            List<int> current_status = new List<int> { 0, 0, 0 };
            //List<int> current_position = new List<int> {1, 1};
            string[] properties = Console.ReadLine().Split(' ');
            int x = Convert.ToInt32(properties[0]);
            int y = Convert.ToInt32(properties[1]);
            int count = 0;
            bool[,] desk = new bool[x, y];
            desk[0, 0] = true;
            horse_steps.Enqueue(new List<int> { 0, 0, 0 });
            List<int> finish = new List<int> { Convert.ToInt32(properties[2]) - 1, Convert.ToInt32(properties[3]) - 1 };
            while (true)
            {
                ++count;
                if (horse_steps.Count == 0)
                {
                    Console.WriteLine("NEVAR");
                    break;
                }
                current_status = horse_steps.Dequeue();
                if (current_status[0] == finish[0] && current_status[1] == finish[1])
                {
                    Console.WriteLine(current_status[2]);
                    break;
                }
                //desk[current_status[0], current_status[1]] = true;



                //Console.WriteLine(current_status[2]+ "   " + count);



                if (current_status[0] + 1 < x && current_status[1] + 2 < y)
                {
                    if (desk[current_status[0] + 1, current_status[1] + 2] != true)
                    {
                        desk[current_status[0] + 1, current_status[1] + 2] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] + 1, current_status[1] + 2, current_status[2] + 1 });
                    }
                }


                if (current_status[0] - 1 >= 0 && current_status[1] + 2 < y)
                {
                    if (desk[current_status[0] - 1, current_status[1] + 2] != true)
                    {
                        desk[current_status[0] - 1, current_status[1] + 2] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] - 1, current_status[1] + 2, current_status[2] + 1 });
                    }
                }


                if (current_status[0] + 1 < x && current_status[1] - 2 >= 0)
                {
                    if (desk[current_status[0] + 1, current_status[1] - 2] != true)
                    {
                        desk[current_status[0] + 1, current_status[1] - 2] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] + 1, current_status[1] - 2, current_status[2] + 1 });

                    }
                }

                if (current_status[0] - 1 >= 0 && current_status[1] - 2 >= 0)
                {

                    if (desk[current_status[0] - 1, current_status[1] - 2] != true)
                    {
                        desk[current_status[0] - 1, current_status[1] - 2] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] - 1, current_status[1] - 2, current_status[2] + 1 });
                    }
                }




                if (current_status[0] + 2 < x && current_status[1] + 1 < y)
                {

                    if (desk[current_status[0] + 2, current_status[1] + 1] != true)
                    {
                        desk[current_status[0] + 2, current_status[1] + 1] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] + 2, current_status[1] + 1, current_status[2] + 1 });
                    }
                }


                if (current_status[0] - 2 >= 0 && current_status[1] + 1 < y)
                {

                    if (desk[current_status[0] - 2, current_status[1] + 1] != true)
                    {
                        desk[current_status[0] - 2, current_status[1] + 1] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] - 2, current_status[1] + 1, current_status[2] + 1 });
                    }
                }


                if (current_status[0] + 2 < x && current_status[1] - 1 >= 0)
                {

                    if (desk[current_status[0] + 2, current_status[1] - 1] != true)
                    {
                        desk[current_status[0] + 2, current_status[1] - 1] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] + 2, current_status[1] - 1, current_status[2] + 1 });
                    }
                }


                if (current_status[0] - 2 >= 0 && current_status[1] - 1 >= 0)
                {

                    if (desk[current_status[0] - 2, current_status[1] - 1] != true)
                    {
                        desk[current_status[0] - 2, current_status[1] - 1] = true;
                        horse_steps.Enqueue(new List<int> { current_status[0] - 2, current_status[1] - 1, current_status[2] + 1 });
                    }
                }

                //int rowLength = desk.GetLength(0);
                //int colLength = desk.GetLength(1);

                //Console.Clear();
                //for (int i = 0; i < rowLength; i++)
                //{
                //    for (int j = 0; j < colLength; j++)
                //    {
                //        if (desk[i, j] == true) { Console.Write(string.Format("{0}", 1)); } else { Console.Write(string.Format("{0}", 0)); }
                //    }
                //    Console.Write(Environment.NewLine);
                //}

            }
            Console.ReadKey();
        }
    }
}
