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
            string[] WordList = new string[10]{"boolean","console","sharp","windows","software", "microsoft","bsuir","fksis","student","teacher"};
            Random rnd = new Random();
            int length_of_line;
            int checking_letter = 0; 
            bool fillword = true;

            Console.WriteLine("Welcome To Fortune Wheel!");
            ran = rnd.Next(10);                     // creates a number between 0 and 9 to get a random word
            secret_word = WordList[ran];
            length_of_line = secret_word.Length;

            for(int i = 0;i<length_of_line;i++){
                opening_word+="_";
            }
            char[] opening_word_Mas = opening_word.ToCharArray();
            char[] secret_word_Mas = secret_word.ToCharArray();
            Enterletter(opening_word,score);
            
            while (fillword)
            {
                string guess_letter = "";
                guess_letter = Console.ReadLine();
                char[] guess_letter_Mas = guess_letter.ToCharArray();
                for (int i = 0; i < length_of_line; i++)
                {
                    

                if (guess_letter[0] == secret_word[i])
                {
                    opening_word_Mas[i] = guess_letter[0];             // checking guessed letter
                    score += 25;
                    
                    Console.WriteLine("You are so lucky!");
                    EnterScore(score);
                    for (int g = 0; g < length_of_line; g++)
                    {
                        Console.WriteLine(opening_word_Mas[g]);
                    }
                    checking_letter += 1;
                }
                

                   
                }
                if (checking_letter == 0){
                    Console.WriteLine("Baaaad! Try again");
                     score -= 10;
                     EnterScore(score);
                        }
                
                int count = 0;
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
            Console.WriteLine("Enter next letter to guess a word: " + opening_word+" You score is " +score+" points");
        }
        private static void EnterScore(int score)
        {
            Console.WriteLine(" You score is " + score + " points");
        }
    }
}
