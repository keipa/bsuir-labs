using System;
using System.Text;

abstract  class Human
{
    static string city = "Minsk";

    public int age { get; set; }
    public string name { get; set; }
    public string surname { get; set; }
    


    public static string City
    {
        get { return city; }
    }

    public void Print_Inf()
    {
        Console.WriteLine(age + "\n" + name + "\n" + surname +
                          "\n");
    }

    public void do_something()
    {
        Console.WriteLine("What?! I don't know what to do!");
    }

    public void do_something(string action)
    {
        Console.WriteLine("Ok! I'll " + action + "! :) \n");
    }

    abstract public void Work_hard();


}


abstract  class Student : Human
{
    public Student(int age, string name, string surname = "unknown")
    {
        this.age = age;
        this.name = name;
        this.surname = surname;
        

        Console.WriteLine("\nHello!. My name is " + name +";");
    }

    abstract public void Some_intellect_activity();
    abstract public override void Work_hard();
}

 class FKSIS :  Student
{
    /* public struct Subjects
     {
         static string first = "Math";
         static string second = "Programming";
     }*/

    public FKSIS(int age, string name, string surname = "unknown")
        : base(age, name, surname = "unknown")
    {
    }
   public override void Some_intellect_activity()
    {
        Console.WriteLine("Result: 100% done!");
    }
    
    public override void Work_hard()
    {
        Console.WriteLine("All engeneers work very hard");

    }
}

 class IEF : Student
{
    /*  public struct Subjects
      {
          static string first = "Economics";
          static string second = "English";
      }*/

    public IEF(int age, string name, string surname = "unknown")
        : base(age, name, surname = "unknown")
    {
    }

    public override void Some_intellect_activity()
    {
        Console.WriteLine("Result: 50% done!");
    }

    public override void Work_hard()
    {
        Console.WriteLine("All economists do not work very hard...");
    }
}

 class BSU_PED : Student
{
    

    public BSU_PED(int age, string name, string surname = "unknown")
        : base(age, name, surname = "unknown")                           //surname is optional
    {
    }

    public override void Some_intellect_activity()
    {
        Console.WriteLine("Result: 10% done(");
    }

    public override void Work_hard()
    {
        Console.WriteLine("All teachers do not work");
    }
}


class Lab5
{
    public static void Main()
    {
        Console.WriteLine(Human.City);

        Console.WriteLine("The student lives in the  " + Student.City);

        Student Kirill = new FKSIS(18, "Kirill");
        Kirill.Work_hard();
        
        Student Alex = new IEF(20, "Alex", "Alekseev");
        Alex.Work_hard();

        Student Tolik = new BSU_PED(22, "Tolik", "Mirski");
        Tolik.Work_hard();
        
        Console.WriteLine("\n" + Kirill.name + " is doing something right now");
        Kirill.Some_intellect_activity();
        Console.WriteLine("\n" + Alex.name + ", is doing something right now");
        Alex.Some_intellect_activity();
        Console.WriteLine("\n" + Tolik.name + ", is doing something right now");
        Tolik.Some_intellect_activity();


    


        Console.ReadKey();
    }

}