using DES.Model;


namespace WebAPI.Encrypt
{
    public class DES3K2 : IEncryption
    {
        private string key1 = "EA47A012E71F428F";
        private string key2 = "55931761C6C59227";
        private int rounds = 1;
        
        public string Encrypt(string sourceString)
        {
            
            return Ciphertext(Ciphertext(Ciphertext(sourceString,  key1), key2), key1);
        }

        private string Ciphertext(string sourceString, string key)
        {
            string send = string.Empty;
            string ciphertext = string.Empty;
            for (int i = 0; i < sourceString.Length; i += 8)
            {
                if (sourceString.Length - i > 8)
                {
                    send = sourceString.Substring(i, 8);
                }
                else
                {
                    send = sourceString.Substring(i, sourceString.Length - i);
                }
                if (send.Length != 8)
                {
                    int missing = 8 - send.Length;
                    for (int j = 0; j < missing; j++)
                    {
                        send += "0";
                    }
                }
                var des = new DESClass() {Plaintext = send, Key = key};
                des.CipherString(rounds);
                ciphertext += des.Ciphertext;
            }
            return ciphertext;
        }

        public string Decrypt(string encryptedString)
        {
            return Plaintext(Plaintext(Plaintext(encryptedString, key1), key2), key1);
        }

        private string Plaintext(string encryptedString, string key)
        {
            string send = string.Empty;
            string plaintext = string.Empty;

            for (int i = 0; i < encryptedString.Length; i += 16)
            {
                if (encryptedString.Length - i > 16)
                {
                    send = encryptedString.Substring(i, 16);
                }
                else
                {
                    send = encryptedString.Substring(i, encryptedString.Length - i);
                }
                if (send.Length != 16)
                {
                    int missing = 16 - send.Length;
                    for (int j = 0; j < missing; j++)
                    {
                        send += "0";
                    }
                }

                var des = new DESClass() {Ciphertext = send, Key = key};
                des.DecipherString(rounds);
                plaintext += des.Plaintext;
            }
            return plaintext;
        }
    }
    }

