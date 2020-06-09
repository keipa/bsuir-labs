using DES.Model;


namespace WebAPI.Encrypt
{
    public class DES : IEncryption
    {
        
        private string key = "EA47A012E71F428F";
        private int rounds = 1;
        
        public string Encrypt(string sourceString)
        {
            var des = new DESClass() { Plaintext = sourceString, Key = key };
            des.CipherString(rounds);
            return des.Ciphertext;
        }

        public string Decrypt(string encryptedString)
        {
            var des = new DESClass() { Ciphertext = encryptedString, Key = key};
            des.DecipherString(rounds);
            return des.Plaintext;
        }
    }
    }

