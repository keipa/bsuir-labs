using System.IO;
using System.Security.Cryptography;

namespace Shapes.Serialization.ThirdParty
{
    public class Md5Hash : IHash
    {
        public int ByteLength => 16;

        public byte[] Compute(Stream stream)
        {
            using (var md5 = MD5.Create())
            {
                return md5.ComputeHash(stream);
            }
        }
    }
}
