using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DES.Model
{
    static class Helper
    {
        public static bool Bit(this BitArray bits, int index) //hace que la little endian class de BitArray se lea como big endian
        {
            return bits[bits.Length - index];
        }

        public static void Bit(this BitArray bits, int index, bool value) //asigna valores como big endian
        {
            bits[bits.Length - index] = value;
        }

        public static byte[] ToByteArray(this BitArray bits)
        {
            int numBytes = bits.Count / 8;
            if (bits.Count % 8 != 0) numBytes++; //evita que sea divisible entre 0

            byte[] bytes = new byte[numBytes];
            int byteIndex = 0;
            int bitIndex = 0;

            for (var i = (bits.Length - 1); i >= 0; i--)
            {
                if (bits[i])
                {
                    bytes[byteIndex] |= (byte)(1 << (7 - bitIndex)); //arma los bytes
                }

                bitIndex++;
                if (bitIndex == 8)
                {
                    bitIndex = 0;
                    byteIndex++;
                }
            }

            return bytes;
        }

        public static int ToInt(this BitArray bits)
        {
            int toReturn = 0;
            for (var i = 0; i < bits.Length; i++)
            {
                toReturn += bits[i] ? (int)Math.Pow(2, i) : 0;
            }
            return toReturn;
        }

        public static void ShiftLeft(this BitArray bits)
        {
            bool first = bits.Bit(1); //guardar el primero
            for (var i = 2; i <= bits.Length; i++)
            {
                bits.Bit(i - 1, bits.Bit(i)); //recorre a la izquierda
            }
            bits.Bit(bits.Length, first);
        }

        public static void ShiftRight(this BitArray bits)
        {
            bool last = bits.Bit(bits.Length); //guardar el ultimo
            for (var i = bits.Length; i > 1; i--)
            {
                bits.Bit(i, bits.Bit(i-1)); //recorre a la derecha
            }
            bits.Bit(1, last);
        }

        public static BitArray GetInnerBits(this BitArray bits)
        {
            BitArray toReturn = new BitArray(bits);
            for (var i = 1; i < bits.Length; i++)
            {
                toReturn[i - 1] = toReturn[i];
            }
            toReturn.Length = toReturn.Length - 2;
            return toReturn;
        }

        public static string Print(this BitArray bits, int group = 4)
        {
            var builder = new StringBuilder();
            string append;
            
                for (var i = 1; i <= bits.Length; i++)
                {
                    append = bits.Bit(i) ? "1" : "0"; //imprime 0 y 1 y no true y false
                    builder.AppendFormat("{0}", append);
                    if (i % group == 0)
                    {
                        builder.Append(" ");
                    }
                }
            
            
            return builder.ToString();
        }

        public static BitArray Concat(this BitArray bits, BitArray back)
        {
            var toReturn = new BitArray(bits.Length + back.Length);
            for (var i = 1; i <= toReturn.Length; i++)
            {
                if (i <= bits.Length)
                {
                    toReturn.Bit(i, bits.Bit(i));
                }
                else
                {
                    toReturn.Bit(i, back.Bit(i - bits.Length));
                }
            }
            return toReturn;
        }

        public static byte[] StringToByteArray(this string hex)
        {
            int NumberChars = hex.Length;
            byte[] bytes = new byte[NumberChars / 2];
            for (int i = 0; i < NumberChars; i += 2)
            {
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bytes;
        }

        public static string ByteArrayToStringValue(this byte[] bytes)
        {
            string hex = BitConverter.ToString(bytes);
            return hex.Replace("-", "");
        }
        public static string ByteArrayToString(this byte[] bytes)
        {
            var builder = new StringBuilder();
            foreach (var b in bytes)
            {
                builder.Append((char)b);
            }
            return builder.ToString();
        }
    }
}
