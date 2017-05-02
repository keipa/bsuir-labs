using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.String;

namespace SyntaxAnalyse
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
            int n = 12;
            string[] lines = output
                .Split(Environment.NewLine.ToCharArray())
                .Skip(n)
                .ToArray();
            string output2 = string.Join(Environment.NewLine, lines);
            Console.WriteLine("output>>" + (IsNullOrEmpty(output2) ? "(none)" : output2));

            Console.WriteLine("ExitCode: " + exitCode.ToString(), "ExecuteCommand");
            process.Close();
            Console.ReadKey();
        }
    }
}
