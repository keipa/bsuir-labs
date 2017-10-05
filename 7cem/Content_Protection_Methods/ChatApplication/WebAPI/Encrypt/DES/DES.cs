using System;
using System.IO;
using System.Text;
using DES.Model;


namespace WebAPI.Encrypt
{
    public class DES : IEncryption
    {
        public string Encrypt(string sourceString)
        {
            var des = new DESClass() { Plaintext = sourceString, Key = "EA47A012E71F428F" };
            des.CipherString(1);
            return des.Ciphertext;
        }

        public string Decrypt(string encryptedString)
        {
            var des = new DESClass() { Ciphertext = encryptedString, Key = "EA47A012E71F428F" };
            des.DecipherString(1);
            return des.Plaintext;
        }
    }
    }

