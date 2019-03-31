using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using Shapes.Infrastructure;
using Shapes.Serialization.ThirdParty;

namespace Shapes
{
    public class MD5Adapter : IPostDecorator
    {
        private Md5Hash thirdPartyMd5 = new Md5Hash();
        public void Apply(string path)
        {
            
            byte[] file = File.ReadAllBytes($"{path}");  
  
            using (Stream memory = new MemoryStream(file))
            {
                var hash = thirdPartyMd5.Compute(memory);
                string converted = Encoding.UTF8.GetString(hash, 0, hash.Length);
                
                File.WriteAllText($"{path}.md555", converted);
                MessageBox.Show("The Plugin MD5 hash of is: " + hash + ".");
            }  
        }
    }
}