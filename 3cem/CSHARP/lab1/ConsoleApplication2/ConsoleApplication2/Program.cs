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
            Test One = new Test();
            One.Add();
            string[] old =  new string[5]{"1 year","2 years","3 years","4 years","5 years"};
            One.Add(new Question("How old are you", old,2));

            CreateTest(One);
        }

        public static void CreateTest(Test test)
        {
            
        }
    }




    public class Test:ICollection<Question>
    {
        private List<Question> current;
        public int Count {get;set;}
        public bool IsReadOnly { get; set; }



        public Question this[int index]
        {
            get { return (Question)current[index]; }
            set { current[index] = value; }
        }


        public Test()
        {
            Count = 0;
            current = new List<Question>();
        }



        public void Add(Question q)
        {
            ++Count;
            current[Count].Name = q.Name;
            current[Count].Variants = q.Variants;
            current[Count].Difficulty = q.Difficulty;
        }

        public void Add(string name, string[] variants)
        {
            ++Count;
            current[Count].Name = name;
            current[Count].Variants = variants;
        }

        public void Add()
        {
            ++Count;
            string[] currentVar = {"Vasya", "Petya", "Dasha"};
            
current[Count].Name ="Who am i";
            current[Count].Variants = currentVar;
            if (Count > 0)
                current[Count].Difficulty = current[Count - 1].Difficulty + 1;
            else
                current[Count].Difficulty = 2;
        }





        public void Clear()
        {
            Count = 0;
        }

        //how to use without list<T>??
        public bool Contains(Question q)
        {
            bool found  = false;

            foreach (Question qw in current)
            {
                if (q.Name == qw.Name)
                {
                    found = true;
                }
            }
            return found;            
        }





        public bool Remove(Question q)
        {
            return true;
        }

        public void CopyTo(Question[] q, int index)
        {
            
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
        private Test _test;
        private int _count;
        private Question _curquest;


        public TestEnumerator(Test collection){
            _test = collection;
            _count = -1;
            _curquest = default(Question);


    }

        public bool MoveNext()
        {
            //Avoids going beyond the end of the collection.
            if (++_count >= _test.Count)
            {
                return false;
            }
            else
            {
                // Set current box to next item in collection.
               // _curquest = _test.current[_count];
            }
            return true;
        }

        public void Reset() { _count = -1; }

        void IDisposable.Dispose() { }

        public Question Current
        {
            get { return _curquest; }
        }


        object IEnumerator.Current
        {
            get { return Current; }
        }
    }

    public class Question:IEquatable<Question>
    {
        public string Name{get;set;}
        public string[] Variants{get;set;}
        public int Difficulty { get; set; }
        public string FormatQuest
        {
            get { string format = "";
            foreach (string item in Variants)
            {
                format = format + "\n" + item;
            }
                return string.Format("{0} \n{1} ", Name, format); }
        }

        public Question()
        {
            this.Name = "Who am i";
            string[] currentVar = {"Vasya", "Petya", "Dasha"};
            this.Variants = currentVar;
            this.Difficulty = 0;
        }


        public Question(string name, string[] vars,int difficulty){
            this.Name= name;
            this.Variants=vars;
            this.Difficulty = difficulty;
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



        public override int GetHashCode(){

        return base.GetHashCode();
        
        }
     

}

