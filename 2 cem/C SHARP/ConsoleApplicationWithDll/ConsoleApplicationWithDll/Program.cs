using System;
using System.Runtime.InteropServices;
class Program
{

    [DllImport("Lab4.dll", CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
    public static extern bool OpenSound(string _filename);

    [DllImport("Lab4.dll", CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Ansi)]
    public static extern bool CloseSound();

    [DllImport("Lab4.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
    public static extern bool StartSound();

    [DllImport("Lab4.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
    public static extern bool StopSound();

    static void Main()
    {
        ConsoleKeyInfo ch;
        string _filename;

        while (true)
        {
            Console.Clear();
            Console.WriteLine("1 - Choose a sound to play");
            Console.WriteLine("2 - Play");
            Console.WriteLine("3 - Stop");
            Console.WriteLine("0 - Exit");
            ch = Console.ReadKey();
            if (ch.KeyChar == '1')
            {
                Console.Clear();
                Console.WriteLine("Enter the name of a sound:");
                _filename = Console.ReadLine();
                OpenSound(_filename);
            }
            if (ch.KeyChar == '2')
            {
                StartSound();
            }
            if (ch.KeyChar == '3')
            {
                StopSound();
            }
            if (ch.KeyChar == '0')
            {
                CloseSound();
                break;
            }
        }
    }
}
