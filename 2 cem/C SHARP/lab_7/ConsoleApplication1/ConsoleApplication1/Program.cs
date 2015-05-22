using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;

namespace Program
{
    class Rnumber : IEquatable<Rnumber>, IComparable<Rnumber>
    {
        private int dividend;
        private int denominator;

        public Rnumber(int a, int b)
        {
            dividend = a;
            denominator = b;
        }

        public Rnumber()
        {
            dividend = 0;
            denominator = 1;
        }

        public int Dividend
        {
            get
            {
                return dividend;
            }
            set
            {
                dividend = value;
            }
        }

        public int Denominator
        {
            get
            {
                return denominator;
            }
            set
            {
                if (value != 0)
                    denominator = value;
            }
        }

        public static Rnumber operator +(Rnumber c1, Rnumber c2)
        {
            Rnumber temp = new Rnumber();
            temp.dividend = c1.dividend * c2.denominator + c2.dividend * c1.denominator;
            temp.denominator = c1.denominator * c2.denominator;
            return temp;
        }

        public static Rnumber operator -(Rnumber c1, Rnumber c2)
        {
            Rnumber temp = new Rnumber();
            temp.dividend = c1.dividend * c2.denominator - c2.dividend * c1.denominator;
            temp.denominator = c1.denominator * c2.denominator;
            return temp;
        }

        public static Rnumber operator *(Rnumber c1, Rnumber c2)
        {
            Rnumber temp = new Rnumber();
            temp.dividend = c1.dividend * c2.dividend;
            temp.denominator = c1.denominator * c2.denominator;
            return temp;
        }

        public static Rnumber operator /(Rnumber c1, Rnumber c2)
        {
            Rnumber temp = new Rnumber();
            temp.dividend = c1.dividend * c2.denominator;
            temp.denominator = c1.denominator * c2.dividend;
            return temp;
        }

        public static bool operator ==(Rnumber c1, Rnumber c2)
        {
            if (c1.Equals(c2))
                return true;
            else
                return false;
        }

        public static bool operator !=(Rnumber c1, Rnumber c2)
        {
            if (c1.Equals(c2))
                return false;
            else
                return true;
        }

        public static bool operator >(Rnumber c1, Rnumber c2)
        {
            if (c1.CompareTo(c2) == 1)
                return true;
            else
                return false;
        }

        public static bool operator >=(Rnumber c1, Rnumber c2)
        {
            if (c1.CompareTo(c2) >= 0)
                return true;
            else
                return false;
        }

        public static bool operator <(Rnumber c1, Rnumber c2)
        {
            if (c1.CompareTo(c2) == -1)
                return true;
            else
                return false;
        }

        public static bool operator <=(Rnumber c1, Rnumber c2)
        {
            if (c1.CompareTo(c2) <= 0)
                return true;
            else
                return false;
        }

        public string toString1()
        {
            return String.Format("{0}/{1}", Dividend, Denominator);
        }

        public string toString2()
        {
            return String.Format("Dividend:{0}\nDenominator:{1}", Dividend, Denominator);
        }

        public static Rnumber Parse(string input)
        {
            Regex regex = new Regex("\\d+");
            Match match = regex.Match(input);
            Rnumber temp = new Rnumber();
            temp.Dividend = Int32.Parse(match.Groups[0].Value);
            match = match.NextMatch();
            temp.Denominator = Int32.Parse(match.Groups[0].Value);
            return temp;
        }

        public bool Equals(Rnumber temp)
        {
            if (this.Dividend * temp.Denominator == temp.Dividend * this.Denominator)
                return true;
            else
                return false;
        }

        public override bool Equals(Object obj)
        {
            Rnumber RnumberObj = obj as Rnumber;
            return Equals(RnumberObj);
        }

        public override int GetHashCode()
        {
            return this.dividend.GetHashCode();
        }

        public int CompareTo(Rnumber temp)
        {
            if (this.Equals(temp))
                return 0;
            else if (this.Dividend * temp.Denominator < temp.Dividend * this.Denominator)
                return -1;
            else
                return 1;
        }

        public static explicit operator int(Rnumber temp)
        {
            int rezult;
            if (temp.Dividend % temp.Denominator == 0)
                rezult = temp.Dividend / temp.Denominator;
            else
                rezult = -1;
            return rezult;
        }

        public static implicit operator double(Rnumber temp)
        {
            return (double)temp.Dividend / temp.Denominator;
        }
    }

    class Program
    {
        static int Main()
        {
            Rnumber r1 = new Rnumber(4, 2);
            int intr = (int)r1;
            double doubler = r1;
            Rnumber r2 = new Rnumber(3, 4);
            Rnumber r3 = r1 * r2;
            r3.Denominator = 0;
            r3 = Rnumber.Parse("Dividend: 12, Denominator = 3");
            Console.WriteLine("{0}/{1}", r3.Dividend, r3.Denominator);
            Console.WriteLine(r3.toString1());
            Console.WriteLine(r3.toString2());
            Console.WriteLine("{0} {1}", intr, doubler);
            if (r1 == r2)
            {
                Console.WriteLine("ravno");
            }
            Console.ReadKey();
            return 0;

        }
    }
}