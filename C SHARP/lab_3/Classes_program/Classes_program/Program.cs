using System;


namespace Classes_program
{
  
    public class Human
    {
        static int intellect = 60;

        int Age { get; set; }
        string Name { get; set; }
        string Surname { get; set; }
        
     /*   public Human()
    {
        Age = 0;
        Name = "Default Name";
       // Surname = "Default Surname";
    }*/
   /*  public Human(int age, string name, string surname)
    {
        this.Age = age;
        this.Name = name;
        this.Surname = surname;
    }*/

        public void Walk()
        {
            Console.WriteLine(Surname);
        }

        public void Walk(string what)
        {
            Console.WriteLine("Void + " + what);
        }
    

    }
    
/*  public class Sportsman:Human
    {
        int Experience { get; set; }
        int Strong { get; set; }
        
        public Sportsman()
    {
        Experience = 0;
        Strong = 0;
    }

        public Sportsman(int exp,int strong)
    {
        this.Experience = exp;
        this.Strong = strong;
    }
        public void Work_out()
        {

        }
    }
public class Sport_Special:Sportsman
    {
        int Age_of_sport_practice { get; set; }
        string Specialization { get; set; }
 
        public Sport_Special()
    {
        Age_of_sport_practice = 0;
        Specialization = "Run";
    }

        public Sport_Special(int age,string spec)
    {
        this.Age_of_sport_practice = age;
        this.Specialization = spec;
    }
            public void Work_out()
        {
            
        }
            
    }
    */
    class Program
    {
        static void Main(string[] args)
        {
            Human man = new Human();
            man.Walk();
            
            man.Walk(Console.ReadLine());
      //    Sportsman typ_sport = new Sportsman(3, 10);
       //   Sport_Special spec_sport = new Sport_Special(1, "Skiing");
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
        }
    }
}
