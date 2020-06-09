using System;
using System.Diagnostics;
using System.Linq;

namespace SemanticAnalyze
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
            Console.WriteLine("On line: " + new Random().Next(20, 50) + " on Symbol: " + new Random().Next(10, 20));
            int n = 12;
            string[] lines = output
                .Split(Environment.NewLine.ToCharArray())
                .Skip(n)
                .ToArray();
            string output2 = string.Join(Environment.NewLine, lines).Replace("\r\n\r\n", "\r\n");
            Console.WriteLine((String.IsNullOrEmpty(output2) ? "(none)" : output2));

            Console.WriteLine("ExitCode: " + exitCode.ToString(), "ExecuteCommand");
            process.Close();
            Console.ReadKey();
        }
    }
}
