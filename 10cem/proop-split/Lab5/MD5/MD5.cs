using System;
using System.Text;
using System.Security.Cryptography;
using Shapes.Infrastructure;

namespace MD5plugin
{
    public class MD5plg : IPostDecorator
    {
        public void Apply(string path)
        {
            string source = "Hello World!";
            using (MD5 md5Hash = MD5.Create())
            {
                var hash = GetMd5Hash(md5Hash, System.IO.File.ReadAllText(path));
                System.IO.File.WriteAllText($"{path}.md5", hash);
                Console.WriteLine("The MD5 hash of " + source + " is: " + hash + ".");
            }
        }

        private string GetMd5Hash(MD5 md5Hash, string input)
        {
            var data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));
            var sBuilder = new StringBuilder();
            foreach (var bit in data)
            {
                sBuilder.Append(bit.ToString("x2"));
            }
            return sBuilder.ToString();
        }
    }
}