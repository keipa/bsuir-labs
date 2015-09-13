using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



public class Question : IEquatable<Question>
{
    public int complexity { get; private set; }
    public string question { get; private set; }
    public int countOfVariation { get; private set; }

    public Question(string question, int complex, int variatino)
    {
        this.complexity = complex;
        this.countOfVariation = variatino;
        this.question = question;
    }

    public bool Equals(Question other)
    {

        if (complexity == other.complexity && question == other.question && countOfVariation == other.countOfVariation)
            return true;
        else
            return false;
    }
    public bool complexityRaise(Question next){
        if (complexity < next.complexity)
            return true;
        else
            return false;

    }
}

public class TestCollection : ICollection<Question>
{
    const int initialNumberOfQuestions = 10;

    public int NumberOfQuestions { get; set; }

    public int CurrentIndex { get; set; }

    
    public Question[] testArray;

   
    public TestCollection()
    {
        
        testArray = new Question[initialNumberOfQuestions];
        CurrentIndex = -1;
        NumberOfQuestions = initialNumberOfQuestions;
    }

    
    public Question this[int index]
    {
        get { return testArray[index]; }
        set { testArray[index] = value; }
    }

   
    public int Count
    {
        get
        {
            int counter = 0;
            do
            {
                counter++;
            } while (testArray[counter] != null);
            return counter;
        }
    }

    public bool IsReadOnly
    {
        get { return false; }
    }

    
    public void Add(Question item)
    {
        CurrentIndex++;
        if (CurrentIndex >= initialNumberOfQuestions)
            testArray[CurrentIndex] = item;
        else
        {
            Array.Resize<Question>(ref testArray, NumberOfQuestions * 2);
            NumberOfQuestions *= 2;
            testArray[CurrentIndex] = item;
        }
        Console.WriteLine("Question added");
    }

    
    public void Clear()
    {
        Array.Clear(testArray, 0, NumberOfQuestions);
        CurrentIndex = -1;
    }

    
    public bool Contains(Question item)
    {
        for (int counter = 0; counter < NumberOfQuestions; counter++)
        {
            if (testArray[counter].Equals(item))
                return true;

        }
        return false;
    }


    public void CopyTo(Question[] array, int arrayIndex)
    {
        for (int i = 0; i < Count; i++)
        {
            array[i + arrayIndex] = testArray[i];
        }
    }

    
    public bool Remove(Question item)
    {
        bool result = false;

       
        for (int i = 0; i < Count; i++)
        {
            Question currentQuest = testArray[i];

            if (currentQuest.Equals(item))
            {
                testArray[i] = null;
                for (int counter = i; counter < NumberOfQuestions; counter++)
                {
                    testArray[i] = testArray[i + 1];
                }
                NumberOfQuestions--;

                Console.WriteLine("Item with name '" + currentQuest.question + "' removed");
                result = true;
                break;
            }
        }
        return result;
    }


    
    public IEnumerator<Question> GetEnumerator()
    {
        return new TestEnumerator(this);
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return new TestEnumerator(this);
    }
   

}


public class TestEnumerator : IEnumerator<Question>
{
    private TestCollection collection;
    private Question[] array;
    private int currentIndex;
    private Question currentItem;

    public TestEnumerator(TestCollection collection)
    {
        this.collection = collection;
        this.array = collection.testArray;
        currentIndex = -1;
        currentItem = default(Question);
    }

    public bool MoveNext()
    {
        
        if (++currentIndex >= array.Length)
        {
            return false;
        }
        else
        {
            currentItem = array[currentIndex];
        }
        return true;
    }

    
    public void Reset() { currentIndex = -1; }

    
    void IDisposable.Dispose() { }

    public Question Current
    {
        get { return currentItem; }
    }

    object IEnumerator.Current
    {
        get { return Current; }
    }

}


class Program
{
    static void Main(string[] args)
    {
        TestCollection collection = new TestCollection();

        Question quiz = new Question( "Whats your name?", 1, 10);

        collection.Add(new Question( "How are you?", 2  , 5));
        collection.Add(new Question( "How old are you?",5, 7));
        collection.Add(quiz);

        if (collection.Contains(quiz))
            Console.WriteLine("Collection contains 'quiz'");
        else
            Console.WriteLine("Collection is not contains 'quiz'");

        Console.WriteLine("Count of items in the collection is " + collection.Count);
        collection.Remove(quiz);
        Console.WriteLine("Count of items in the collection is " + collection.Count);

     
        

        Console.Read();
    }
}