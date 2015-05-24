using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;

namespace Program
{
    class Ratio : IEquatable<Ratio>, IComparable<Ratio>
    {
        private int upnum;
        private int downnum;

        public Ratio(int a, int b)
        {
            upnum = a;
            downnum = b;
        }

        public Ratio()
        {
            upnum = 0;
            downnum = 1;
        }

        public int Up
        {
            get
            {
                return upnum;
            }
            set
            {
                upnum = value;
            }
        }

        public int Down
        {
            get
            {
                return downnum;
            }
            set
            {
                if (value != 0)
                    downnum = value;
            }
        }

        public static Ratio operator +(Ratio c1, Ratio c2)
        {
            Ratio temp = new Ratio();
            temp.upnum = c1.upnum * c2.downnum + c2.upnum * c1.downnum;
            temp.downnum = c1.downnum * c2.downnum;
            return temp;
        }

        public static Ratio operator -(Ratio c1, Ratio c2)
        {
            Ratio temp = new Ratio();
            temp.upnum = c1.upnum * c2.downnum - c2.upnum * c1.downnum;
            temp.downnum = c1.downnum * c2.downnum;
            return temp;
        }

        public static Ratio operator *(Ratio c1, Ratio c2)
        {
            Ratio temp = new Ratio();
            temp.upnum = c1.upnum * c2.upnum;
            temp.downnum = c1.downnum * c2.downnum;
            return temp;
        }

        public static Ratio operator /(Ratio c1, Ratio c2)
        {
            Ratio temp = new Ratio();
            temp.upnum = c1.upnum * c2.downnum;
            temp.downnum = c1.downnum * c2.upnum;
            return temp;
        }

        public static bool operator ==(Ratio c1, Ratio c2)
        {
            if (c1.Equals(c2))
                return true;
            else
                return false;
        }

        public static bool operator !=(Ratio c1, Ratio c2)
        {
            if (c1.Equals(c2))
                return false;
            else
                return true;
        }

        public static bool operator >(Ratio c1, Ratio c2)
        {
            if (c1.CompareTo(c2) == 1)
                return true;
            else
                return false;
        }

        public static bool operator >=(Ratio c1, Ratio c2)
        {
            if (c1.CompareTo(c2) >= 0)
                return true;
            else
                return false;
        }

        public static bool operator <(Ratio c1, Ratio c2)
        {
            if (c1.CompareTo(c2) == -1)
                return true;
            else
                return false;
        }

        public static bool operator <=(Ratio c1, Ratio c2)
        {
            if (c1.CompareTo(c2) <= 0)
                return true;
            else
                return false;
        }

        public string toString1()
        {
            return String.Format("{0}/{1}", Up, Down);
        }

        public string toString2()
        {
            return String.Format("Up:{0}\nDown:{1}", Up, Down);
        }

        public static Ratio Parse(string input)
        {
            Regex regex = new Regex("\\d+");
            Match match = regex.Match(input);
            Ratio temp = new Ratio();
            temp.Up = Int32.Parse(match.Groups[0].Value);
            match = match.NextMatch();
            temp.Down = Int32.Parse(match.Groups[0].Value);
            return temp;
        }

        public bool Equals(Ratio temp)
        {
            if (this.Up * temp.Down == temp.Up * this.Down)
                return true;
            else
                return false;
        }

        public override bool Equals(Object obj)
        {
            Ratio RatioObj = obj as Ratio;
            return Equals(RatioObj);
        }

        public override int GetHashCode()
        {
            return this.upnum.GetHashCode();
        }

        public int CompareTo(Ratio temp)
        {
            if (this.Equals(temp))
                return 0;
            else if (this.Up * temp.Down < temp.Up * this.Down)
                return -1;
            else
                return 1;
        }

        public static explicit operator int(Ratio temp)
        {
            int rezult;
            if (temp.Up % temp.Down == 0)
                rezult = temp.Up / temp.Down;
            else
                rezult = -1;
            return rezult;
        }

        public static implicit operator double(Ratio temp)
        {
            return (double)temp.Up / temp.Down;
        }
    }

    class Program
    {
        static int Main()
        {
            Ratio r1 = new Ratio(4, 2);
           // int intr = (int)r1;
            //double doubler = r1;
            Ratio r2 = new Ratio(3, 4);
            Ratio r3 = r1 * r2;
            r3.Down = 0;
            r3 = Ratio.Parse("Up: 12, Down = 3");
            Console.WriteLine("{0}\n--\n{1}\n", r3.Up, r3.Down);
            Console.WriteLine(r3.toString1());
            Console.WriteLine(r3.toString2());
          //  Console.WriteLine("{0} {1}", intr, doubler);
            if (r1 == r2)
            {
                Console.WriteLine("equal");
            }
            else
                Console.WriteLine("not equal");
            Console.ReadKey();
            return 0;

        }
    }
}