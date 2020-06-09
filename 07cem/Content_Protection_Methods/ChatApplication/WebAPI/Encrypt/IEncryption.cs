using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPI.Encrypt
{
    interface IEncryption
    {
        string Encrypt(string sourceString);

        string Decrypt(string encryptedString);
    }

    enum ProcedureTypes
    {
        Encrypt,Decrypt
    }
}
