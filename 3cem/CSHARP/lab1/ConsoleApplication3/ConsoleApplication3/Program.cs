using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;


class Program
{
    static void Main(string[] args)
    {

        Test One = CreateCollection();
        Question q1 = new Question("What's your name", 5);
        Question q2 = new Question("How old are you", 4);
        Question q3 = new Question("How are you", 6);
        int switcher = 10;
        Console.WriteLine();
        while (switcher != 0 )
        {
            Console.Clear();
            Console.WriteLine("1 - Create new Test\n2 - Add Q1\n3 - Add Q2\n4 - Add Q3\n5 - Remove Q1\n6 - Remove Q2\n7 - Remove Q3\n8 - Count of the questions\n9 - Print test\n0 - for exit\n10 - autoadd\n");
            Console.WriteLine("Next question must be harder than previous");
            try { switcher = Convert.ToInt32(Console.ReadLine()); }
            catch (System.FormatException)
            {
                Console.WriteLine("Program skipped");
                break;
            }

            switch (switcher)
            {
                case 1:
                    Console.Clear();
                    One.Clear();
                    One.Count = 0;
                    Console.WriteLine("New test created! Press any key");
                    Console.ReadKey();
                    break;
                case 2:
                    Console.Clear();
                    
                    One.Add(q1);
                    Variants v1_1 = new Variants("Petya");
                    Variants v1_2 = new Variants("Sasha");
                    Variants v1_3 = new Variants("Nastia");

                    if (One.Contains(q1))
                    {
                        Console.WriteLine("First question added");
                        q1.Add(v1_1);
                        q1.Add(v1_2);
                        q1.Add(v1_3);
                        Console.WriteLine("New question created! Press any key");
                    }
                    else
                    {
                        Console.WriteLine("First question : ERROR. Press any key");
                    }
                    
                    Console.ReadKey();
                    break;
                case 3:
                    Console.Clear();
                    
                    One.Add(q2);
                    Variants v2_1 = new Variants("6 years");
                    Variants v2_2 = new Variants("8 years");
                    Variants v2_3 = new Variants("9 years");

                    if (One.Contains(q2))
                    {
                        Console.WriteLine("Second question added");
                        q2.Add(v2_1);
                        q2.Add(v2_2);
                        q2.Add(v2_3);
                        Console.WriteLine("New question created! Press any key");
                    }
                    else
                    {
                        Console.WriteLine("Second question : ERROR. Press any key");
                    }
                    Console.ReadKey();
                    break;

                case 4:
                    Console.Clear();
                    
                    One.Add(q3);
                    Variants v3_1 = new Variants("Im doing well");
                    Variants v3_2 = new Variants("Fine");
                    Variants v3_3 = new Variants("So so");

                    
                    if (One.Contains(q3))
                    {
                        Console.WriteLine("Third question added");
                        q3.Add(v3_1);
                        q3.Add(v3_2);
                        q3.Add(v3_3);
                        Console.WriteLine("New question created! Press any key");
                    }
                    else
                    {
                        Console.WriteLine("Third question : ERROR. Press any key");
                    }
                    Console.ReadKey();
                    break;
                case 5:
                    One.Remove(q1);
                    Console.WriteLine("Removed! Press any key");
                    Console.ReadKey();
                    break;
                case 6:
                    One.Remove(q2);
                    Console.WriteLine("Removed! Press any key");
                    Console.ReadKey();
                    break;
                case 7:
                    One.Remove(q3);
                    Console.WriteLine("Removed! Press any key");
                    Console.ReadKey();
                    break;
                case 8:
                    Console.Clear();
                    Console.WriteLine("Count of the questions: " + One.Count);
                        Console.ReadKey();
                    break;
                case 9:
                    Console.Clear();
                    int c1 = 1;
                    foreach(Question q in One)
                    {
                        int c2 = 1;
                        Console.WriteLine("Q"+c1+": "+"Difficulty - " + q.Difficulty);
                        ++c1;
                        Console.WriteLine(q.Name);
                        foreach(Variants v in q)
                        {

                            Console.WriteLine(c2+") "+v.Name);
                            ++c2;
                        }
                        Console.WriteLine();
                    }
                    Console.WriteLine("Press any key to continue...");
                    Console.ReadKey();
                    break;
                case 10:
                    
                    break;

                default: break;
            }
        }





       

       

        


        //One.Add();

        // CreateTest(One);
    }

    private static Test CreateCollection()
    {
        Test One = new Test();
        return One;
    }

    public static void CreateTest(Test test)
    {

    }
}




public class Test : ICollection<Question>
{
    private List<Question> current;
    public int Count { get; set; }
    public bool IsReadOnly { get; set; }






    public Test()
    {
        current = new List<Question>();
    }


    public void Add(Question q)
    {
        current.Add(q);
        ++Count;
        if (Count > 1 && current[Count - 1].Difficulty < current[Count - 2].Difficulty)
        {
            Console.WriteLine("Difficulty is less than previous!!");
            current.Remove(q);
            --Count;
        }


    }



    public void Clear()
    {
        current.Clear();
    }


    public bool Contains(Question q)
    {
        return current.Contains(q);
    }


    public bool Remove(Question q)
    {
        return current.Remove(q);
    }

    public void CopyTo(Question[] q, int index)
    {
        current.CopyTo(q, index);
    }


    public IEnumerator<Question> GetEnumerator()
    {
        foreach (Question i in current)
        {
            yield return i;
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

}




public class Question : ICollection<Variants>
{
    public int Count { get; set; }
    public bool IsReadOnly { get; set; }
    public string Name { get; set; }
    public int Difficulty { get; set; }
    private List<Variants> current;

    public Question(string name, int difficulty)
    {
        current = new List<Variants>();
        Name = name;
        Difficulty = difficulty;
    }

    public void Add(Variants q)
    {

        current.Add(q);
    }



    public void Clear()
    {
        current.Clear();
    }


    public bool Contains(Variants q)
    {
        return current.Contains(q);
    }


    public bool Remove(Variants q)
    {
        return current.Remove(q);
    }

    public void CopyTo(Variants[] q, int index)
    {
        current.CopyTo(q, index);
    }






    public bool Equals(Question other)
    {
        if (this.Name == other.Name)
        {
            return true;
        }
        else
            return false;
    }



    public override int GetHashCode()
    {

        return base.GetHashCode();

    }

    public IEnumerator<Variants> GetEnumerator()
    {
        foreach (Variants i in current)
        {
            yield return i;
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }


}
public class Variants
{
    public string Name;
    public Variants(string name)
    {
        Name = name;
    }
}