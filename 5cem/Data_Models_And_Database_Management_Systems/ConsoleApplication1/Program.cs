using System;
using System.Globalization;


namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                var count_of_points = 0;
                while (true)
                {
                Console.WriteLine("Количество очков сейчас:"+ count_of_points.ToString());
                Console.WriteLine("Берём ещё?(д/н)");
                var isgetcard = Console.ReadLine();
                    if (isgetcard == "д")
                    {
                        Random kek = new Random();
                        var nrandchislo = kek.Next(1, 10);
                        count_of_points += nrandchislo;
                        if (count_of_points > 21)
                        {
                            Console.WriteLine("Вы проиграли");
                            Console.WriteLine("Играем ещё?д/н");
                            var isplaychar = Console.ReadLine();
                            if (isplaychar != "д")
                            {
                                count_of_points = 0;
                                break;
                            }
                        }
                        continue;
                    }
                    else
                    {
                        if (count_of_points > 21)
                        {
                            Console.WriteLine("Вы проиграли");
                            Console.WriteLine("Играем ещё?д/н");
                            var isplaychar = Console.ReadLine();
                            if (isplaychar != "д")
                            {
                                count_of_points = 0;
                                break;
                            }
                        }
                        else
                        {
                            Random player = new Random();
                            var ranplayerpoint = count_of_points;
                            if (count_of_points > ranplayerpoint)
                            {
                                Console.WriteLine("Вы победили! Количество очков соперника:" +ranplayerpoint );
                                break;
                            }
                            else
                            {
                                if(count_of_points == ranplayerpoint)
                                Console.WriteLine("ничья! Количество очков соперника:" + ranplayerpoint);
                                if(count_of_points < ranplayerpoint)
                                    Console.WriteLine("вы проиграли! Количество очков соперника:" + ranplayerpoint);
                                break;
                            }
                        }

                    }
                }

            }
        }
    }
}
