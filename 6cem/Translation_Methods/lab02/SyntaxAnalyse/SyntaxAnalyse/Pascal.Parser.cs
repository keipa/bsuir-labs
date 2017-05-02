using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace SyntaxAnalyse
{
    internal partial class PascalParser
    {
        public PascalParser() : base(null) { }

        public void Parse(string s)
        {
            byte[] inputBuffer = System.Text.Encoding.Default.GetBytes(s);
            MemoryStream stream = new MemoryStream(inputBuffer);
            this.Scanner = new PascalScanner(stream);
            this.Parse();
        }
    }
}
