using System;
using System.Text;
using System.Collections.Generic;

public struct Temperature
{
    public int Twinter;
    public int Tspring;
    public int Tsummer;
    public int Tautamn;

    
}

public interface tourist_actions
{
    void Tourist_info();
    void reduce_price();
    void do_something(string action = "");
}

public abstract class TouristBase
{   
    protected string country;
    protected int population;
    protected Temperature currentTemp;
    protected int square_area;
    protected string capital;

    public virtual int TempWinter
    {
        get { return currentTemp.Twinter; } 
        set { currentTemp.Twinter = value; }
    }

    public virtual int TempSpring
    {
        get { return currentTemp.Tspring; }
        set { currentTemp.Tspring = value; }
    }

    public virtual int TempSummer
    {
        get { return currentTemp.Tsummer; }
        set { currentTemp.Tsummer = value; }
    }
    public virtual int TempAutamn
    {
        get { return currentTemp.Tautamn; }
        set { currentTemp.Tautamn = value; }
    }

    public string Country
    {
        get { return country; }
        set { country = value; }
    }

    public int Population
    {
        get { return population; }
        set { population = value; }
    }

    public int SquareArea
    {
        get { return square_area; }
        set { square_area = value; }
    }
    public string Capital
    {
        get { return capital; }
        set { capital = value; }
    }
}

public class TouristDestination : TouristBase, tourist_actions, IEquatable<TouristDestination>, IComparable<TouristDestination>
{
    public TouristDestination() { }

    public TouristDestination(string country, int population, int square_area, string capital)
    {
        this.country = country;
        this.population = population;
        this.square_area= square_area;
        this.capital = capital;
    }

    public bool Equals(TouristDestination obj)
    {
        if (obj == null)
            return false;
        if (this.population == obj.population && this.square_area == obj.square_area && this.capital == obj.capital && this.currentTemp.Twinter == obj.currentTemp.Twinter && this.currentTemp.Tspring == obj.currentTemp.Tspring && this.currentTemp.Tsummer == obj.currentTemp.Tsummer && this.currentTemp.Tautamn == obj.currentTemp.Tautamn)
            return true;
        else
            return false;
    }

    public int CompareTo(TouristDestination other)
    {
        if (other == null) return 1;
        else if (Equals(other)) return 0;
        else if (this.currentTemp.Twinter > other.currentTemp.Twinter) return 1;
        else if (this.currentTemp.Twinter < other.currentTemp.Twinter) return -1;
        else return 0;
    }

    public virtual void Tourist_info()
    {
        Console.WriteLine(country + "\n" + population + " people\n" + square_area + " km^2\n" + capital + "\n" + "Temperature in winter: " + currentTemp.Twinter + "'C\n" + "Temperature in spring: " + currentTemp.Tspring + " 'C\n" + "Temperature in summer: " + currentTemp.Tsummer + " 'C\n" + "Temperature in summer: "+ currentTemp.Tautamn+ "'C\n");
    }

    public virtual void reduce_price()
    {
        Console.WriteLine("Cho!? Are you adequate!?");
    }

    public virtual void do_something(string action = "Open source code")
    {
        Console.WriteLine("Nu ok " + action + "\n");
    }
}

class Program
{
    public static void Main()
    {
        
       

        TouristDestination Belarus = new TouristDestination("Belarus", 10000000, 200000, "Minsk");
        Belarus.TempWinter = -10;
        Belarus.TempSpring = 10;
        Belarus.TempSummer = 20;
        Belarus.TempAutamn = 10;
        Belarus.Tourist_info();
        

        TouristDestination Latvia = new TouristDestination("Latvia", 5000000, 100000, "Riga");
        Latvia.TempWinter = -10;
        Latvia.TempSpring = 10;
        Latvia.TempSummer = 20;
        Latvia.TempAutamn = 10;
        Latvia.Tourist_info();

        TouristDestination Chilie = new TouristDestination("Chilie", 600000, 600000, "Santiago");
        Chilie.TempWinter = 10;
        Chilie.TempSpring = 20;
        Chilie.TempSummer = 30;
        Chilie.TempAutamn = 10;
        Chilie.Tourist_info();
        Console.ReadKey();
        Console.Clear();
        Console.WriteLine("Equaling\n");
        Console.WriteLine("Belarus & Latvia " + Belarus.Equals(Latvia));
        Console.WriteLine("Belarus & Chilie " + Belarus.Equals(Chilie));
        Console.WriteLine("Latvia & Chilie " + Latvia.Equals(Chilie));
        Console.WriteLine();
        Console.WriteLine("Comparing temperature1   q`\n");
        Console.WriteLine("Belarus & Latvia " + Belarus.CompareTo(Latvia));
        Console.WriteLine("Belarus & Chilie " + Belarus.CompareTo(Chilie));
        Console.WriteLine("Latvia & Chilie " + Latvia.CompareTo(Chilie));

        Console.ReadKey();
        
    }
}


