using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebSocketsClient.Encryption
{
    static class Encryption
    {
        public static string EncAPI(string message)
        {
            return $"http://localhost:58850/api/des/{message}/encrypt";
        }
    }
}
