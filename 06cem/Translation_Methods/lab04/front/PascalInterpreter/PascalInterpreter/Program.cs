using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
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

            Console.WriteLine(string.IsNullOrEmpty(error) ? string.Empty : error.Split("\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Last());
          
         
            Console.WriteLine("ExitCode: " + exitCode.ToString(), "ExecuteCommand");
            process.Close();

            string text = File.ReadAllText("C:/Users/keipa/Desktop/print/hello.ppc");
            text = text.Replace("printf", "writeln");
            File.WriteAllText("C:\\Users\\keipa\\Desktop\\print\\hello.ppc", text);





            Console.ReadKey();
        }
    }
}
