using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;

namespace op
{

    class Problems
    {
        static public uint BecauseICan(int a)
        {
            Console.WriteLine("It is working!!!");
            return 0;
        }

        static public uint EqualsNumer(int a)
        {
            Console.WriteLine("Beware! Numbers are equals");
            return 1;
        }

        static public uint LessZero(int a)
        {
            Console.WriteLine("Alert!!! Number is less the zero");
            return (uint)Math.Abs(a);
        }

        static public uint ZeroEquals(int a)
        {
            Console.WriteLine("Alert!!! Number is equal to zero");
            return 1;
        }
    }
    delegate uint ProblemMethod(int a);

    class Rational : IEquatable<Rational>, IComparable<Rational>
    {
        private uint n;
        private uint m;

        public Rational() { }

        public Rational(uint a, uint b)
        {
            n = a;
            m = (b > 0) ? b : 1;
        }

        public event ProblemMethod ZeroCheck;
        public event ProblemMethod ZeroCheck1;

        public uint N
        {
            get { return n; }
            set
            {
                if (value == 0)
                {
                    if (ZeroCheck != null)
                    {
                        n = ZeroCheck((int)value);
                    }
                    else
                    {
                        n = 1;
                    }
                }
                else
                {
                    n = value;
                }
            }

        }

        public uint M
        {
            get { return m; }
            set
            {
                if (value == 0)
                {
                    if (ZeroCheck1 != null)
                    {
                        m = ZeroCheck1((int)value);
                    }
                    else
                    {
                        m = 1;
                    }
                }
                else
                {
                    m = value;
                }
            }
        }

        public static Rational operator +(Rational a, Rational b)
        {
            Rational result = new Rational(1, 1);

            result.m = a.m * b.m;
            result.n = result.m / a.n + result.m / b.n;

            return result;
        }

        public static Rational operator -(Rational a, Rational b)
        {
            Rational result = new Rational(1, 1);

            result.m = a.m * b.m;
            result.n = result.m / a.n - result.m / b.n;

            return result;
        }

        public static Rational operator *(Rational a, Rational b)
        {
            Rational result = new Rational();
            result.n = a.n * b.n;
            result.m = a.m * b.m;
            return result;
        }

        public static Rational operator /(Rational a, Rational b)
        {
            Rational result = new Rational();
            result.n = a.n * b.m;
            result.m = a.m * b.n;
            return result;
        }

        public static bool operator >(Rational a, Rational b)
        {
            if (a.CompareTo(b) == 1)
                return true;
            else
                return false;
        }

        public static bool operator >=(Rational a, Rational b)
        {
            if (a.CompareTo(b) >= 0)
                return true;
            else
                return false;
        }

        public static bool operator <(Rational a, Rational b)
        {
            if (a.CompareTo(b) == -1)
                return true;
            else
                return false;
        }

        public static bool operator <=(Rational a, Rational b)
        {
            if (a.CompareTo(b) <= 0)
                return true;
            else
                return false;
        }

        public static bool operator !=(Rational a, Rational b)
        {
            if (a.n == b.n && a.m == b.m)
                return false;
            else
                return true;
        }

        public static bool operator ==(Rational a, Rational b)
        {
            return a.Equals(b);
        }

        public static implicit operator Rational(uint a)
        {
            return new Rational(a, 1);
        }

        public static explicit operator double(Rational a)
        {
            return (a.N / a.M);
        }

        public override string ToString()
        {
            return string.Format("{0}/{1}", n, m);
        }

        public string ToStringDecFrac(int r)
        {
            double DecFrac = n / m;
            return string.Format("{0}", DecFrac);
        }

        public bool Equals(Rational other)
        {
            if (this.n == other.n && this.m == other.m)
                return true;
            else
                return false;
        }

        public override bool Equals(Object obj)
        {
            Rational RationalObj = obj as Rational;
            return Equals(RationalObj);
        }

        public override int GetHashCode()
        {
            return (this.n / this.m).GetHashCode();
        }

        public int CompareTo(Rational other)
        {
            if (this.Equals(other)) return 0;
            else if (this.m > other.m) return 1;
            else if (this.m < other.m) return -1;
            else if (this.m == other.m && this.n > other.n) return 1;
            else if (this.m == other.m && this.n < other.n) return -1;
            else return 1;
        }
    }

    static class op
    {
        static public void Main()
        {
            Rational first = new Rational();
            first.ZeroCheck += Problems.BecauseICan;
            first.ZeroCheck += Problems.ZeroEquals;

            Console.WriteLine("Read rational number as a fraction");
            string ast = Console.ReadLine();
            string bst = Console.ReadLine();

            ProblemMethod first_problem = new ProblemMethod(Problems.LessZero);
            ProblemMethod second_problem = delegate(int a)
            {
                Console.WriteLine("Alert!!! Number is --------------less the zero");
                return (uint)Math.Abs(a);
            };
            Func<int, uint> third_problem = Problems.LessZero;
            ProblemMethod fourth_problem = (int a) => Problems.LessZero(a);


            try
            {
                first.N = Convert.ToUInt16(ast);
            }
            catch (OverflowException)
            {
                first.N = first_problem(Convert.ToInt16(ast));
            }

            try
            {
                first.M = Convert.ToUInt16(bst);
            }
            catch (OverflowException)
            {
                first.M = second_problem(Convert.ToInt16(bst));
            }

            Console.WriteLine("Nothing");
            Console.WriteLine(first.ToString());
            Console.WriteLine(first.ToStringDecFrac(0));

            Rational second = new Rational();
            Console.WriteLine("Read rational number as string");
            string rational_number = Console.ReadLine();
            Regex slash = new Regex("/");
            string[] two_numbers = slash.Split(rational_number);
            first_problem = new ProblemMethod(Problems.LessZero);

            try
            {
                second.N = Convert.ToUInt16(two_numbers[0]);
            }
            catch (OverflowException)
            {
                second.N = third_problem(Convert.ToInt16(two_numbers[0]));
            }

            try
            {
                second.M = Convert.ToUInt16(two_numbers[1]);
            }
            catch (OverflowException)
            {
                second.M = fourth_problem(Convert.ToInt16(two_numbers[1]));
            }
            Console.WriteLine(second.ToString());
            Console.WriteLine(second.ToStringDecFrac(0));

            Console.WriteLine("Does First equals to Second?");
            if ((object)first == (object)second)
            {
                Console.WriteLine("True");
            }
            else
            {
                Console.WriteLine("False");
            }

            Console.WriteLine("What is more?");
            Console.WriteLine(first.CompareTo(second));

            first = 84927;
            Console.WriteLine(first.ToStringDecFrac(0));

            double end = (double)second;
            Console.WriteLine(end);
        }
    }
}