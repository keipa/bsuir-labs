using System;
using System.Text;

abstract class Human 
{	
	static string planet = "Earth";

    public int age { get; set; }

    public string name { get; set; }
    public string country { get ; set; }
    public string city { get; set; }
		

	public static string Planet 
	{
		get { return planet; } 
	}

	public void Print_Inf()
	{
		Console.WriteLine(age + "\n" + name + "\n" + country +
			              "\n" + city + "\n");
	}

	public void do_something()
	{
		Console.WriteLine("What?! I don't know what to do!");
	}

	public void do_something(string action)
	{
		Console.WriteLine("Ok! I'll " + action + "! :) \n");
	}

    abstract public void Go_to_work();

	
}


abstract class Student : Human
{
    	public Student(int age, string name, string country = "unknown", 
		          string city = "unknown")  
	{
		this.age = age;
		this.name = name;
		this.country = country;
		this.city = city;

        Console.WriteLine("\nHello!. My name is " + name + "! :)"); 
	}

    abstract public void To_calculate_a_limit();
    abstract public override void Go_to_work();
}

class Ingeneer : Student
{
   /* public struct Subjects
    {
        static string first = "Math";
        static string second = "Programming";
    }*/

    public Ingeneer(int age, string name, string country = "unknown",
                  string city = "unknown")
        : base(age, name, country = "unknown", city = "unknown")
    {
    }
    public override void To_calculate_a_limit()
    {
        Console.WriteLine("Ok! No problem!");
    }

    public override void Go_to_work()
    {
        Console.WriteLine("I go to BSUIR because I am an ingeneer.");
 
    }
}

class Economist : Student
{
  /*  public struct Subjects
    {
        static string first = "Economics";
        static string second = "English";
    }*/

    public Economist(int age, string name, string country = "unknown",
                  string city = "unknown")
        : base(age, name, country = "unknown", city = "unknown")
    {
    }

    public override void To_calculate_a_limit()
    {
        Console.WriteLine("Ok, Google. Calculate a limit for me.");
    }

    public override void Go_to_work()
    {
        
    } 
}

class Teacher_of_Russian : Student
{
   /* public struct Subjects
    {
        string first; 
        string second;

        public Subjects()
        {
            first = "Math";
            second = "Programming";
        }
    }*/

    public Teacher_of_Russian(int age, string name, string country = "unknown",
                  string city = "unknown")
        : base(age, name, country = "unknown", city = "unknown")
    {
    }

    public override void To_calculate_a_limit()
    {
        Console.WriteLine("Что ты написал? Я учитель русского!");
    }

    public override void Go_to_work()
    {
        Console.WriteLine("I go to BSPU because I am a teacher.");    
    }     
}


class Lab3
{
	public static void Main()
	{
		Console.WriteLine(Human.Planet);

        Console.WriteLine("The student lives on the planet the " + Student.Planet +
                           " because he is a human.");

        Student Ivan = new Ingeneer(17, "Ivan");
        Ivan.Go_to_work();

        Student Alex = new Economist(19, "Alex", "Belarus", "Minsk");
        Alex.Go_to_work();

        Student Egor = new Teacher_of_Russian(22, "Egor", city : "Pekin");
        Egor.Go_to_work();

        Console.WriteLine("\n" + Ivan.name + ", calculate a limit please.");
        Ivan.To_calculate_a_limit();
        Console.WriteLine("\n" + Alex.name + ", calculate a limit please.");
        Alex.To_calculate_a_limit();
        Console.WriteLine("\n" + Egor.name + ", calculate a limit please.");
        Egor.To_calculate_a_limit();
   

        /*Ingeneer.Subjects in_sub = new Ingeneer.Subjects();
        Economist.Subjects ec_sub = new Economist.Subjects();
        Teacher_of_Russian.Subjects tc_sub = new Teacher_of_Russian.Subjects();

        Console.WriteLine("\nIngeneer learn {0} , {1}", Egor ,);*/


        Console.ReadKey();
	}		

}