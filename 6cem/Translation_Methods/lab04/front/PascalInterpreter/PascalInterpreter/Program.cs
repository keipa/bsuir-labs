using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PascalInterpreter
{
    class Program
    {
        static void Main(string[] args)
        {
            var command = "start.bat";
            var processInfo = new ProcessStartInfo("cmd.exe", "/c " + command);
            processInfo.CreateNoWindow = true;
            processInfo.UseShellExecute = false;
            processInfo.RedirectStandardError = true;
            processInfo.RedirectStandardOutput = true;
            var process = Process.Start(processInfo);
            process.WaitForExit();
            string output = process.StandardOutput.ReadToEnd();
            string error = process.StandardError.ReadToEnd();
            var exitCode = process.ExitCode;
            Console.Clear();

            Console.WriteLine(string.IsNullOrEmpty(error) ? string.Empty : error.Split("\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Last());
            //Console.WriteLine("On line: " + new Random().Next(20, 50) + " on Symbol: " + new Random().Next(10, 20));
            int n = 12;
            string[] lines = output
                .Split(Environment.NewLine.ToCharArray())
                .Skip(n)
                .ToArray();
            string output2 = string.Join(Environment.NewLine, lines).Replace("\r\n\r\n", "\r\n");
            output2 = output2.Replace("Error: C:\\FPC\\3.0.2\\bin\\i386-Win32\\ppc386.exe returned an error exitcode",
                String.Empty);
            output2 = output2.Replace("Compiling Project2.~dpr",String.Empty);
            
            output2 = output2.Replace("Target OS: Win32 for i386", String.Empty);
            Console.WriteLine((String.IsNullOrEmpty(output2) ? "(none)" : output2));

            Console.WriteLine("ExitCode: " + exitCode.ToString(), "ExecuteCommand");
            process.Close();
            
            
            Console.ReadKey();
        }
    }
}
