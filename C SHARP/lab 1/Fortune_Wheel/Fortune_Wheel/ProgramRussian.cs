using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Fortune_Wheel
{
    class Program
    {
        static void Main(string[] args)
        {
            string secret_word;
            string opening_word = "";
            int ran;
            int score = 0;
            string[] WordList = new string[10] { "boolean", "console", "csharp", "windows", "software", "microsoft", "bsuir", "fksis", "student", "teacher" };
            Random rnd = new Random();
            int length_of_line;
            int checking_letter = 0;
            bool fillword = true;

            Console.WriteLine("Welcome To Fortune Wheel!");
            ran = rnd.Next(10);                     // creates a number between 0 and 9 to get a random word
            Console.WriteLine("The question:");
            switch (ran)                            //list of a questions
            {
                case 0:
                    Console.WriteLine("What is a data type, having two values?");
                    break;
                case 1:
                    Console.WriteLine("What is a computer program designed to be used via a text-only computer interface?");
                    break;
                case 2:
                    Console.WriteLine("What  is a multi-paradigm programming language encompassing strong typing, imperative, declarative, functional, generic, object-oriented (class-based), and component-oriented programming disciplines?");
                    break;
                case 3:
                    Console.WriteLine("What is is a metafamily of graphical operating systems developed, marketed, and sold by Microsoft?");
                    break;
                case 4:
                    Console.WriteLine("What is any set of machine-readable instructions that directs a computer's processor to perform specific operations ?");
                    break;
                case 5:
                    Console.WriteLine("What is an American multinational corporation headquartered in Redmond, Washington, that develops, manufactures, licenses, supports and sells computer software, consumer electronics and personal computers and services ?");
                    break;
                case 6:
                    Console.WriteLine("What is a public Higher Education Institution accredited by the Ministry of Education of the Republic of Belarus? Nowadays it is a large educational and scientific complex in Minsk, Belarus.");
                    break;
                case 7:
                    Console.WriteLine("Your Faculty of BSUIR");
                    break;
                case 8:
                    Console.WriteLine("Who  is a learner, or someone who attends an educational institution?");
                    break;
                case 9:
                    Console.WriteLine("Who is a person who provides education for students?");
                    break;
                

            }

            secret_word = WordList[ran];
            length_of_line = secret_word.Length;
            for (int i = 0; i < length_of_line; i++)        //initilization ______ word
                opening_word += "_";
            
            char[] opening_word_Mas = opening_word.ToCharArray();           // transform string to char array x2
            char[] secret_word_Mas = secret_word.ToCharArray();
            Enterletter(opening_word, score);                               

            while (fillword)
            {
                string guess_letter = "";
                guess_letter = Console.ReadLine();                  //having a letter from a console
                char[] guess_letter_Mas = guess_letter.ToCharArray();
                for (int i = 0; i < length_of_line; i++)
                {
                    if (guess_letter[0] == secret_word[i])                  // checking concidence
                    {
                        opening_word_Mas[i] = guess_letter[0];             // checking guessed letter
                        score += 25;
                        Console.WriteLine("You are so lucky!");         //winning result
                        EnterScore(score);
                        for (int g = 0; g < length_of_line; g++)
                           Console.WriteLine(opening_word_Mas[g]);
                        checking_letter += 1;
                    }
                }
                if (checking_letter == 0)
                {
                    Console.WriteLine("Baaaad! Try again");         //lose result
                    score -= 10;
                    EnterScore(score);
                }

                int count = 0;                              //full word coincidence
                for (int g = 0; g < length_of_line; g++)
                {
                    if (secret_word_Mas[g] == opening_word_Mas[g])
                        count += 1;
                }
                if (count == length_of_line)
                    fillword = false;
            }

            Console.WriteLine("This is the end. The word is: " + secret_word + " Your score is " + score);     // game is over
            if (score > 100)
                Console.WriteLine("Prize in a studio!!!Well done!!!");
            else
                Console.WriteLine("You won. Goo job!");

            Console.ReadLine();



        }

        private static void Enterletter(string opening_word, int score)
        {
            Console.WriteLine("Enter next letter to guess a word: " + opening_word + " You score is " + score + " points");
        }


        private static void EnterScore(int score)
        {
            Console.WriteLine(" You score is " + score + " points");
        }
    }
}
