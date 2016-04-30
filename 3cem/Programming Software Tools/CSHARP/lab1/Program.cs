using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



public class Purchase: IEquatable<Purchase>
{
    public int count { get; private set; }
    public string name { get; private set; }

    public Purchase(string name, int count)  
	{
        this.name = name;
        this.count = count; 
	}

    public bool Equals(Purchase other)
    {

        if (count == other.count && name == other.name)
            return true;
        else
            return false;
    }
}

public class PurchaseCollection : ICollection<Purchase>
{
    const int initialNumberOfItems = 10;

    public int NumberOfItems { get; set; }

    public int CurrentIndex { get; set; }

    //Inner collection is using like a storage for objects
    public Purchase[] purchaseArray;

    //Constructor
    public PurchaseCollection()
    {
       // innerCollection = new List<Purchase>();
        purchaseArray = new Purchase[initialNumberOfItems];
        CurrentIndex = -1;
        NumberOfItems = initialNumberOfItems;
    }

    //The address on an index
    public Purchase this[int index]
    {
        get { return purchaseArray[index]; }
        set { purchaseArray[index] = value; }
    }

//-----------------------------------Realization of ICollection<T>---------------------------------------//
    //Returns a count of items
    public int Count
    {
        get
        {
            int counter = 0;
            do{
                counter++;
            } while (purchaseArray[counter] != null);
            return counter;
        }
    }
    
    public bool IsReadOnly
    {
        get { return false; }
    }

    //Adds item to the collection
    public void Add(Purchase item) 
    {
        CurrentIndex++;
        if (CurrentIndex >= initialNumberOfItems)
            purchaseArray[CurrentIndex] = item;
        else
        {
            Array.Resize<Purchase>(ref purchaseArray, NumberOfItems * 2);
            NumberOfItems *= 2;
            purchaseArray[CurrentIndex] = item;
        }
        Console.WriteLine("Item added");
    }

    //Removes all items from the collection 
    public void Clear()
    {
        Array.Clear(purchaseArray, 0, NumberOfItems);
        CurrentIndex = -1;
    }

    //Returns true if collection contains item, and false if it is not
    public bool Contains(Purchase item)
    {
        for (int counter = 0; counter < NumberOfItems; counter++)
        {
            if (purchaseArray[counter].Equals(item))
                    return true;

        }
        return false;
    }
    

    public void CopyTo(Purchase[] array, int arrayIndex)
    {
        for (int i = 0; i < Count; i++)
        {
            array[i + arrayIndex] = purchaseArray[i];
        }
    }

    //Removes item from the collection
    public bool Remove(Purchase item)
    {
        bool result = false;

        //Finds item which will be removed
        for (int i = 0; i < Count; i++)
        {
            Purchase currentItem = purchaseArray[i];

            if (currentItem.Equals(item))
            {
                purchaseArray[i] = null;
                for (int counter = i; counter < NumberOfItems; counter++)
                {
                    purchaseArray[i] = purchaseArray[i + 1];
                }
                NumberOfItems--;
                
                Console.WriteLine("Item with name '"+ currentItem.name +"' removed");
                result = true;
                break;
            }
        }
        return result;
    }


    //-----------------------------------End of Realization of ICollection<T>---------------------------------------//

    //-----------------------------------Realization of Enumerable------------------------------------------//
      // Спросить зачем 2 GetEnumerator. ( по другому ошибка компиляции)
    public IEnumerator<Purchase> GetEnumerator()
    {
        return new PurchaseEnumerator(this);
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return new PurchaseEnumerator(this); 
    }
    //----------------------------------- End of Realization of Enumerable------------------------------------------//
   
}

//My Enumerator class
public class PurchaseEnumerator : IEnumerator<Purchase>
{
    private PurchaseCollection collection;
    private Purchase[] array;
    private int currentIndex;
    private Purchase currentItem;

    public PurchaseEnumerator(PurchaseCollection collection)
    {
        this.collection = collection;
        this.array = collection.purchaseArray;
        currentIndex = -1;
        currentItem = default(Purchase);
    }

    public bool MoveNext()
    {
        //Increments index and check that is lower that count items of 
        // a collection
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

    //Set current index before the first item of the collection
    public void Reset() { currentIndex = -1; }

    //I dont know how to dispose resources!!
    void IDisposable.Dispose() { }

    public Purchase Current
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
        PurchaseCollection collection = new PurchaseCollection();

        Purchase milk = new Purchase("milk", 1);

        collection.Add(new Purchase("bread", 2));
        collection.Add(new Purchase("butter", 1));
        collection.Add(milk);

        if (collection.Contains(milk))
            Console.WriteLine("Collection contains 'milk'");
        else
            Console.WriteLine("Collection is not contains 'milk'");
        
        Console.WriteLine("Count of items in the collection is " + collection.Count);
        collection.Remove(milk);
        Console.WriteLine("Count of items in the collection is " + collection.Count);

        if (collection.Contains(milk))
            Console.WriteLine("Collection contains 'milk'");
        else
            Console.WriteLine("Collection is not contains 'milk'");


        Console.Read();
    }
}


