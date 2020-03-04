using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace TensorFlowConnector
{
    public class TensorFlowConnector
    {
        private const string WorkDir = "C:\\Users\\keipa\\Desktop\\labs\\bsuir-labs\\12cem\\ml\\lab4\\shell";
        public string Call()
        {
            var output = new List<string>();
            var process = new Process
            {
                StartInfo = new ProcessStartInfo
                {
                    UseShellExecute = false,
                    RedirectStandardOutput = true,
                    WorkingDirectory = WorkDir,
                    FileName = $"{WorkDir}\\GetClass.bat"
                }
            };
            process.Start();
            process.WaitForExit();
            while (process.StandardOutput.Peek() > 0)
            {
                output.Add(process.StandardOutput.ReadLine());
            } 
            return output[output.Count-3];
        }
    }
}
