using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPI.Encrypt
{
    public class Caesar : IEncryption
    {
        public Caesar(string alphabetType, int shiftSize)
        {
            this.alphabet = AlphabetDict[alphabetType];
            this.shiftSize = shiftSize;
        }

        private readonly string alphabet;
        private readonly int shiftSize;

        private readonly Dictionary<string, string> AlphabetDict = new Dictionary<string, string>
        {
            { "ru","абвгдеёжзийклмнопрстуфхцчшщъыьэюя"},
            {"en","abcdefghijklmnopqrstuvwxyz" }
        };

        private string Cryption(string data, bool decrypt = false)
        {
            string result = String.Empty;
            int shiftDirection = decrypt ? -1 : 1;
            foreach (char symbol in data)
            {
                int symIndex = Char.IsLower(symbol) ? alphabet.IndexOf(Char.ToLower(symbol)) : -1;
                int newIndex = symIndex + shiftSize * shiftDirection;
                char newSymbol = symIndex == 1 ? symbol : alphabet[newIndex % alphabet.Length];
                result += Char.IsUpper(symbol) ? Char.ToUpper(newSymbol) : newSymbol;
            }
            return result;
        }

        public string Encrypt(string sourceString)
        {
            return Cryption(sourceString);
        }

        public string Decrypt(string encryptedString)
        {
            return Cryption(encryptedString, decrypt: true);
        }
    }
}
