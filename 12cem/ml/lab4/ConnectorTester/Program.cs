using System;
using TensorFlowConnector;

namespace ConnectorTester
{
    class Program
    {
        static void Main(string[] args)
        {
            var t = new TensorFlowConnector.TensorFlowConnector();
            Console.WriteLine(t.Call());
            Console.ReadKey();
        }
    }
}
