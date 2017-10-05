using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DES.Model
{
    public class DESClass
    {
        private string plaintext;
        private string ciphertext;
        private string work;
        private string key;

        public string Key
        {
            get { return key; }
            set { key = value; }
        }

        public string Work
        {
            get { return work; }
            set { work = value; }
        }
        public string Plaintext
        {
            get { return plaintext; }
            set { plaintext = value; }
        }
        public string Ciphertext
        {
            get { return ciphertext; }
            set { ciphertext = value; }
        }

        public DESClass()
        {

        }


        public string CipherHex(int rounds = 5)
        {
            Ciphertext = Cipher(Plaintext.StringToByteArray(), Key.StringToByteArray(), rounds).ToByteArray().ByteArrayToStringValue();
            return Ciphertext;
        }

        public string CipherString(int rounds = 5)
        {
            Ciphertext = Cipher(Encoding.UTF8.GetBytes(Plaintext), Key.StringToByteArray(), rounds).ToByteArray().ByteArrayToStringValue();
            return Ciphertext;
        }

        private BitArray Cipher(byte[] message, byte[] key, int rounds)
        {
            var builder = new StringBuilder();
            var left = new BitArray(32);
            var right = new BitArray(32);
            var c = new BitArray(28);
            var d = new BitArray(28);
            Ciphertext = string.Empty;
            var keyBits = new BitArray(key.Reverse().ToArray());
            var plainBits = new BitArray(message.Reverse().ToArray());
            BitArray switchTemp;
            builder.AppendFormat("Transformed {0} text to {1} {2}", Plaintext, plainBits.Print(), Environment.NewLine);
            builder.AppendFormat("Using key {0} with bits {1} {2}", key.ByteArrayToStringValue(), keyBits.Print(), Environment.NewLine);
            plainBits = InitialPermutation(plainBits);
            builder.AppendFormat("Initial permutation result {0}{1}", plainBits.Print(), Environment.NewLine);
            keyBits = PermutedChoiceOne(keyBits);
            builder.AppendFormat("Permuted choice one {0}{1}", keyBits.Print(), Environment.NewLine);
            for (var i = 1; i <= 64; i++) //copiar los arreglos de bit a los nuevos Array.Copy no sirve con BitArray
            {
                if (i <= 32)
                {
                    left.Bit(i, plainBits.Bit(i));
                }
                else
                {
                    right.Bit(i - 32, plainBits.Bit(i));
                }
                if (i <= 28)
                {
                    c.Bit(i, keyBits.Bit(i));
                }
                else if (i <= 56)
                {
                    d.Bit(i - 28, keyBits.Bit(i));
                }
            }
            builder.AppendFormat("Left {0}{1}", left.Print(), Environment.NewLine);
            builder.AppendFormat("Right {0}{1}", right.Print(), Environment.NewLine);
            builder.AppendFormat("c0 {0}{1}", c.Print(), Environment.NewLine);
            builder.AppendFormat("d0 {0}{1}", d.Print(), Environment.NewLine);
            builder.Append(Environment.NewLine);
            for (var i = 1; i <= rounds; i++)
            {
                builder.AppendFormat("Round {0}{1}", i, Environment.NewLine);
                c = KeyLeftShift(c, i);
                d = KeyLeftShift(d, i);
                builder.AppendFormat("c{0} {1}{2}", i, c.Print(), Environment.NewLine);
                builder.AppendFormat("d{0} {1}{2}", i, d.Print(), Environment.NewLine);
                var expansion = ExpansionPermutation(right);
                builder.AppendFormat("Expansion permutation {0}{1}", expansion.Print(6), Environment.NewLine);
                var k = PermutedChoiceTwo(c.Concat(d));
                builder.AppendFormat("K{0} {1}{2}", i, k.Print(6), Environment.NewLine);
                var xor = expansion.Xor(k);
                builder.AppendFormat("XOR result {0}{1}", xor.Print(6), Environment.NewLine);
                var permutation = new BitArray(0);
                for (var j = 0; j < 8; j++) //xor y sboxes, el 0 facilita las operaciones para separar en 6
                {
                    var temp = new BitArray(6);
                    temp.Bit(1, xor.Bit((j * 6) + 1));
                    temp.Bit(2, xor.Bit((j * 6) + 2));
                    temp.Bit(3, xor.Bit((j * 6) + 3));
                    temp.Bit(4, xor.Bit((j * 6) + 4));
                    temp.Bit(5, xor.Bit((j * 6) + 5));
                    temp.Bit(6, xor.Bit((j * 6) + 6));
                    var sbox = SBoxSelector(temp, j + 1);
                    builder.AppendFormat("{0} sbox{1} result {2}{3}", temp.Print(6), (j + 1), sbox.Print(), Environment.NewLine);
                    permutation = permutation.Concat(sbox);
                }
                builder.AppendFormat("Prepermutation {0} {1}", permutation.Print(), Environment.NewLine);
                permutation = Permutation(permutation);
                builder.AppendFormat("Permutation {0} {1}", permutation.Print(), Environment.NewLine);
                switchTemp = right; //para hacer el cambio de valores
                right = permutation.Xor(left);
                left = switchTemp;
                builder.AppendFormat("Left{0} {1}{2}", i, left.Print(), Environment.NewLine);
                builder.AppendFormat("Right{0} {1}{2}", i, right.Print(), Environment.NewLine);
                builder.Append(Environment.NewLine);
            }
            switchTemp = right; //para hacer el cambio de valores
            right = left;
            left = switchTemp;
            builder.AppendFormat("Left{0} {1}{2}", " Final", left.Print(), Environment.NewLine);
            builder.AppendFormat("Right{0} {1}{2}", " Final", right.Print(), Environment.NewLine);
            plainBits = InverseInitialPermutation(left.Concat(right));
            builder.AppendFormat("Inverse permutation result {0}{1}", plainBits.Print(), Environment.NewLine);
            Work = builder.ToString();
            return plainBits;
        }
        public string DecipherHex(int rounds = 5)
        {
            Plaintext = Decipher(Ciphertext.StringToByteArray(), Key.StringToByteArray(), rounds).ToByteArray().ByteArrayToStringValue();
            return Plaintext;
        }

        public string DecipherString(int rounds = 5)
        {
            Plaintext = Decipher(Ciphertext.StringToByteArray(), Key.StringToByteArray(), rounds).ToByteArray().ByteArrayToString();
            return Plaintext;
        }
        private BitArray Decipher(byte[] message, byte[] key, int rounds)
        {
            var builder = new StringBuilder();
            var left = new BitArray(32);
            var right = new BitArray(32);
            var c = new BitArray(28);
            var d = new BitArray(28);

            Plaintext = string.Empty;
            var keyBits = new BitArray(key.Reverse().ToArray());
            var cipherbits = new BitArray(message.Reverse().ToArray());
            BitArray switchTemp;
            builder.AppendFormat("Transformed {0} text to {1} {2}", Ciphertext, cipherbits.Print(), Environment.NewLine);
            builder.AppendFormat("Using key {0} with bits {1} {2}", key.ByteArrayToStringValue(), keyBits.Print(), Environment.NewLine);
            cipherbits = InitialPermutation(cipherbits);
            builder.AppendFormat("Initial permutation result {0}{1}", cipherbits.Print(), Environment.NewLine);
            keyBits = PermutedChoiceOne(keyBits);
            builder.AppendFormat("Permuted choice one {0}{1}", keyBits.Print(), Environment.NewLine);
            for (var i = 1; i <= 64; i++) //copiar los arreglos de bit a los nuevos Array.Copy no sirve con BitArray
            {
                if (i <= 32)
                {
                    left.Bit(i, cipherbits.Bit(i));
                }
                else
                {
                    right.Bit(i - 32, cipherbits.Bit(i));
                }
                if (i <= 28)
                {
                    c.Bit(i, keyBits.Bit(i));
                }
                else if (i <= 56)
                {
                    d.Bit(i - 28, keyBits.Bit(i));
                }
            }
            c = AllKeyShifts(c, rounds);
            d = AllKeyShifts(d, rounds);
            builder.AppendFormat("Left {0}{1}", left.Print(), Environment.NewLine);
            builder.AppendFormat("Right {0}{1}", right.Print(), Environment.NewLine);
            switchTemp = right; //para hacer el cambio de valores del final
            right = left;
            left = switchTemp;
            builder.AppendFormat("Left {0}{1}", left.Print(), Environment.NewLine);
            builder.AppendFormat("Right {0}{1}", right.Print(), Environment.NewLine);
            builder.Append(Environment.NewLine);
            for (var i = rounds; i > 0; i--)
            {
                if (i != rounds) //empieza con las c y d finales
                {
                    c = KeyRightShift(c, i);
                    d = KeyRightShift(d, i);
                }
                builder.AppendFormat("Round {0}{1}", i, Environment.NewLine);
                //c = AllKeyShifts(cOriginal, i);
                //d = AllKeyShifts(dOriginal, i);
                builder.AppendFormat("c{0} {1}{2}", i, c.Print(), Environment.NewLine);
                builder.AppendFormat("d{0} {1}{2}", i, d.Print(), Environment.NewLine);
                switchTemp = right;
                right = left;

                var expansion = ExpansionPermutation(right);
                builder.AppendFormat("Expansion permutation {0}{1}", expansion.Print(6), Environment.NewLine);
                var k = PermutedChoiceTwo(c.Concat(d));
                builder.AppendFormat("K{0} {1}{2}", i, k.Print(6), Environment.NewLine);
                var xor = expansion.Xor(k);
                builder.AppendFormat("XOR result {0}{1}", xor.Print(6), Environment.NewLine);
                var permutation = new BitArray(0);
                for (var j = 0; j < 8; j++) //xor y sboxes, el 0 facilita las operaciones para separar en 6
                {
                    var temp = new BitArray(6);
                    temp.Bit(1, xor.Bit((j * 6) + 1));
                    temp.Bit(2, xor.Bit((j * 6) + 2));
                    temp.Bit(3, xor.Bit((j * 6) + 3));
                    temp.Bit(4, xor.Bit((j * 6) + 4));
                    temp.Bit(5, xor.Bit((j * 6) + 5));
                    temp.Bit(6, xor.Bit((j * 6) + 6));
                    var sbox = SBoxSelector(temp, j + 1);
                    builder.AppendFormat("{0} sbox{1} result {2}{3}", temp.Print(6), (j + 1), sbox.Print(), Environment.NewLine);
                    permutation = permutation.Concat(sbox);
                }
                builder.AppendFormat("Prepermutation {0} {1}", permutation.Print(), Environment.NewLine);
                permutation = Permutation(permutation);
                builder.AppendFormat("Permutation {0} {1}", permutation.Print(), Environment.NewLine);

                left = permutation.Xor(switchTemp);


                builder.AppendFormat("Left{0} {1}{2}", (i - 1), left.Print(), Environment.NewLine);
                builder.AppendFormat("Right{0} {1}{2}", (i - 1), right.Print(), Environment.NewLine);
                builder.Append(Environment.NewLine);
            }

            builder.AppendFormat("Left{0} {1}{2}", " Beginning", left.Print(), Environment.NewLine);
            builder.AppendFormat("Right{0} {1}{2}", " Beginning", right.Print(), Environment.NewLine);
            cipherbits = InverseInitialPermutation(left.Concat(right));
            builder.AppendFormat("Inverse permutation result {0}{1}", cipherbits.Print(), Environment.NewLine);
            Work = builder.ToString();
            return cipherbits;
        }

        private BitArray InitialPermutation(BitArray bits)
        {
            if (bits.Length != 64)
            {
                return null;
            }
            var toReturn = new BitArray(bits.Length);
            #region asignaciones de los valores
            toReturn.Bit(1, bits.Bit(58));
            toReturn.Bit(2, bits.Bit(50));
            toReturn.Bit(3, bits.Bit(42));
            toReturn.Bit(4, bits.Bit(34));
            toReturn.Bit(5, bits.Bit(26));
            toReturn.Bit(6, bits.Bit(18));
            toReturn.Bit(7, bits.Bit(10));
            toReturn.Bit(8, bits.Bit(2));
            toReturn.Bit(9, bits.Bit(60));
            toReturn.Bit(10, bits.Bit(52));
            toReturn.Bit(11, bits.Bit(44));
            toReturn.Bit(12, bits.Bit(36));
            toReturn.Bit(13, bits.Bit(28));
            toReturn.Bit(14, bits.Bit(20));
            toReturn.Bit(15, bits.Bit(12));
            toReturn.Bit(16, bits.Bit(4));
            toReturn.Bit(17, bits.Bit(62));
            toReturn.Bit(18, bits.Bit(54));
            toReturn.Bit(19, bits.Bit(46));
            toReturn.Bit(20, bits.Bit(38));
            toReturn.Bit(21, bits.Bit(30));
            toReturn.Bit(22, bits.Bit(22));
            toReturn.Bit(23, bits.Bit(14));
            toReturn.Bit(24, bits.Bit(6));
            toReturn.Bit(25, bits.Bit(64));
            toReturn.Bit(26, bits.Bit(56));
            toReturn.Bit(27, bits.Bit(48));
            toReturn.Bit(28, bits.Bit(40));
            toReturn.Bit(29, bits.Bit(32));
            toReturn.Bit(30, bits.Bit(24));
            toReturn.Bit(31, bits.Bit(16));
            toReturn.Bit(32, bits.Bit(8));
            toReturn.Bit(33, bits.Bit(57));
            toReturn.Bit(34, bits.Bit(49));
            toReturn.Bit(35, bits.Bit(41));
            toReturn.Bit(36, bits.Bit(33));
            toReturn.Bit(37, bits.Bit(25));
            toReturn.Bit(38, bits.Bit(17));
            toReturn.Bit(39, bits.Bit(9));
            toReturn.Bit(40, bits.Bit(1));
            toReturn.Bit(41, bits.Bit(59));
            toReturn.Bit(42, bits.Bit(51));
            toReturn.Bit(43, bits.Bit(43));
            toReturn.Bit(44, bits.Bit(35));
            toReturn.Bit(45, bits.Bit(27));
            toReturn.Bit(46, bits.Bit(19));
            toReturn.Bit(47, bits.Bit(11));
            toReturn.Bit(48, bits.Bit(3));
            toReturn.Bit(49, bits.Bit(61));
            toReturn.Bit(50, bits.Bit(53));
            toReturn.Bit(51, bits.Bit(45));
            toReturn.Bit(52, bits.Bit(37));
            toReturn.Bit(53, bits.Bit(29));
            toReturn.Bit(54, bits.Bit(21));
            toReturn.Bit(55, bits.Bit(13));
            toReturn.Bit(56, bits.Bit(5));
            toReturn.Bit(57, bits.Bit(63));
            toReturn.Bit(58, bits.Bit(55));
            toReturn.Bit(59, bits.Bit(47));
            toReturn.Bit(60, bits.Bit(39));
            toReturn.Bit(61, bits.Bit(31));
            toReturn.Bit(62, bits.Bit(23));
            toReturn.Bit(63, bits.Bit(15));
            toReturn.Bit(64, bits.Bit(7));
            #endregion

            return toReturn;
        }

        private BitArray InverseInitialPermutation(BitArray bits)
        {
            if (bits.Length != 64)
            {
                return null;
            }
            var toReturn = new BitArray(bits.Length);
            #region asignaciones de los valores
            toReturn.Bit(1, bits.Bit(40));
            toReturn.Bit(2, bits.Bit(8));
            toReturn.Bit(3, bits.Bit(48));
            toReturn.Bit(4, bits.Bit(16));
            toReturn.Bit(5, bits.Bit(56));
            toReturn.Bit(6, bits.Bit(24));
            toReturn.Bit(7, bits.Bit(64));
            toReturn.Bit(8, bits.Bit(32));
            toReturn.Bit(9, bits.Bit(39));
            toReturn.Bit(10, bits.Bit(7));
            toReturn.Bit(11, bits.Bit(47));
            toReturn.Bit(12, bits.Bit(15));
            toReturn.Bit(13, bits.Bit(55));
            toReturn.Bit(14, bits.Bit(23));
            toReturn.Bit(15, bits.Bit(63));
            toReturn.Bit(16, bits.Bit(31));
            toReturn.Bit(17, bits.Bit(38));
            toReturn.Bit(18, bits.Bit(6));
            toReturn.Bit(19, bits.Bit(46));
            toReturn.Bit(20, bits.Bit(14));
            toReturn.Bit(21, bits.Bit(54));
            toReturn.Bit(22, bits.Bit(22));
            toReturn.Bit(23, bits.Bit(62));
            toReturn.Bit(24, bits.Bit(30));
            toReturn.Bit(25, bits.Bit(37));
            toReturn.Bit(26, bits.Bit(5));
            toReturn.Bit(27, bits.Bit(45));
            toReturn.Bit(28, bits.Bit(13));
            toReturn.Bit(29, bits.Bit(53));
            toReturn.Bit(30, bits.Bit(21));
            toReturn.Bit(31, bits.Bit(61));
            toReturn.Bit(32, bits.Bit(29));
            toReturn.Bit(33, bits.Bit(36));
            toReturn.Bit(34, bits.Bit(4));
            toReturn.Bit(35, bits.Bit(44));
            toReturn.Bit(36, bits.Bit(12));
            toReturn.Bit(37, bits.Bit(52));
            toReturn.Bit(38, bits.Bit(20));
            toReturn.Bit(39, bits.Bit(60));
            toReturn.Bit(40, bits.Bit(28));
            toReturn.Bit(41, bits.Bit(35));
            toReturn.Bit(42, bits.Bit(3));
            toReturn.Bit(43, bits.Bit(43));
            toReturn.Bit(44, bits.Bit(11));
            toReturn.Bit(45, bits.Bit(51));
            toReturn.Bit(46, bits.Bit(19));
            toReturn.Bit(47, bits.Bit(59));
            toReturn.Bit(48, bits.Bit(27));
            toReturn.Bit(49, bits.Bit(34));
            toReturn.Bit(50, bits.Bit(2));
            toReturn.Bit(51, bits.Bit(42));
            toReturn.Bit(52, bits.Bit(10));
            toReturn.Bit(53, bits.Bit(50));
            toReturn.Bit(54, bits.Bit(18));
            toReturn.Bit(55, bits.Bit(58));
            toReturn.Bit(56, bits.Bit(26));
            toReturn.Bit(57, bits.Bit(33));
            toReturn.Bit(58, bits.Bit(1));
            toReturn.Bit(59, bits.Bit(41));
            toReturn.Bit(60, bits.Bit(9));
            toReturn.Bit(61, bits.Bit(49));
            toReturn.Bit(62, bits.Bit(17));
            toReturn.Bit(63, bits.Bit(57));
            toReturn.Bit(64, bits.Bit(25));
            #endregion

            return toReturn;
        }

        private BitArray ExpansionPermutation(BitArray bits)
        {
            if (bits.Length != 32)
            {
                return null;
            }
            var toReturn = new BitArray(0);
            for (var i = 0; i < 8; i++)
            {
                var temp = new BitArray(6);
                temp.Bit(2, bits.Bit((i * 4) + 1));
                temp.Bit(3, bits.Bit((i * 4) + 2));
                temp.Bit(4, bits.Bit((i * 4) + 3));
                temp.Bit(5, bits.Bit((i * 4) + 4));

                int assign = i == 0 ? 32 : ((i - 1) * 4) + 4;
                temp.Bit(1, bits.Bit(assign));
                assign = i == 7 ? 1 : ((i + 1) * 4) + 1;
                temp.Bit(6, bits.Bit(assign));
                toReturn = toReturn.Concat(temp);
            }

            return toReturn;
        }

        private BitArray KeyLeftShift(BitArray key, int round)
        {
            switch (round)
            {
                case 1: key.ShiftLeft();
                    break;
                case 2: key.ShiftLeft();
                    break;
                case 3: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 4: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 5: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 6: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 7: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 8: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 9: key.ShiftLeft();
                    break;
                case 10: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 11: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 12: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 13: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 14: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 15: key.ShiftLeft();
                    key.ShiftLeft();
                    break;
                case 16: key.ShiftLeft();
                    break;
                default: break;
            }

            return key;
        }

        private BitArray KeyRightShift(BitArray key, int round)
        {
            switch (round)
            {
                case 0: key.ShiftRight();
                    break;
                case 1: key.ShiftRight();
                    break;
                case 2: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 3: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 4: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 5: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 6: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 7: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 8: key.ShiftRight();
                    break;
                case 9: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 10: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 11: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 12: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 13: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 14: key.ShiftRight();
                    key.ShiftRight();
                    break;
                case 15: key.ShiftRight();
                    break;
                default: break;
            }

            return key;
        }

        private BitArray SBoxSelector(BitArray bits, int number)
        {
            switch (number)
            {
                case 1: return Sbox1(bits);
                case 2: return Sbox2(bits);
                case 3: return Sbox3(bits);
                case 4: return Sbox4(bits);
                case 5: return Sbox5(bits);
                case 6: return Sbox6(bits);
                case 7: return Sbox7(bits);
                case 8: return Sbox8(bits);
                default: return null;
            }
        }

        private BitArray Permutation(BitArray bits)
        {
            if (bits.Length != 32)
            {
                return null;
            }
            var toReturn = new BitArray(32);
            #region asignaciones de los valores
            toReturn.Bit(1, bits.Bit(16));
            toReturn.Bit(2, bits.Bit(7));
            toReturn.Bit(3, bits.Bit(20));
            toReturn.Bit(4, bits.Bit(21));
            toReturn.Bit(5, bits.Bit(29));
            toReturn.Bit(6, bits.Bit(12));
            toReturn.Bit(7, bits.Bit(28));
            toReturn.Bit(8, bits.Bit(17));
            toReturn.Bit(9, bits.Bit(1));
            toReturn.Bit(10, bits.Bit(15));
            toReturn.Bit(11, bits.Bit(23));
            toReturn.Bit(12, bits.Bit(26));
            toReturn.Bit(13, bits.Bit(5));
            toReturn.Bit(14, bits.Bit(18));
            toReturn.Bit(15, bits.Bit(31));
            toReturn.Bit(16, bits.Bit(10));
            toReturn.Bit(17, bits.Bit(2));
            toReturn.Bit(18, bits.Bit(8));
            toReturn.Bit(19, bits.Bit(24));
            toReturn.Bit(20, bits.Bit(14));
            toReturn.Bit(21, bits.Bit(32));
            toReturn.Bit(22, bits.Bit(27));
            toReturn.Bit(23, bits.Bit(3));
            toReturn.Bit(24, bits.Bit(9));
            toReturn.Bit(25, bits.Bit(19));
            toReturn.Bit(26, bits.Bit(13));
            toReturn.Bit(27, bits.Bit(30));
            toReturn.Bit(28, bits.Bit(6));
            toReturn.Bit(29, bits.Bit(22));
            toReturn.Bit(30, bits.Bit(11));
            toReturn.Bit(31, bits.Bit(4));
            toReturn.Bit(32, bits.Bit(25));
            #endregion
            return toReturn;
        }

        private BitArray PermutedChoiceOne(BitArray bits)
        {
            if (bits.Length != 64)
            {
                return null;
            }
            var toReturn = new BitArray(bits.Length - 8);
            #region asignaciones de los valores
            toReturn.Bit(1, bits.Bit(57));
            toReturn.Bit(2, bits.Bit(49));
            toReturn.Bit(3, bits.Bit(41));
            toReturn.Bit(4, bits.Bit(33));
            toReturn.Bit(5, bits.Bit(25));
            toReturn.Bit(6, bits.Bit(17));
            toReturn.Bit(7, bits.Bit(9));
            toReturn.Bit(8, bits.Bit(1));
            toReturn.Bit(9, bits.Bit(58));
            toReturn.Bit(10, bits.Bit(50));
            toReturn.Bit(11, bits.Bit(42));
            toReturn.Bit(12, bits.Bit(34));
            toReturn.Bit(13, bits.Bit(26));
            toReturn.Bit(14, bits.Bit(18));
            toReturn.Bit(15, bits.Bit(10));
            toReturn.Bit(16, bits.Bit(2));
            toReturn.Bit(17, bits.Bit(59));
            toReturn.Bit(18, bits.Bit(51));
            toReturn.Bit(19, bits.Bit(43));
            toReturn.Bit(20, bits.Bit(35));
            toReturn.Bit(21, bits.Bit(27));
            toReturn.Bit(22, bits.Bit(19));
            toReturn.Bit(23, bits.Bit(11));
            toReturn.Bit(24, bits.Bit(3));
            toReturn.Bit(25, bits.Bit(60));
            toReturn.Bit(26, bits.Bit(52));
            toReturn.Bit(27, bits.Bit(44));
            toReturn.Bit(28, bits.Bit(36));
            toReturn.Bit(29, bits.Bit(63));
            toReturn.Bit(30, bits.Bit(55));
            toReturn.Bit(31, bits.Bit(47));
            toReturn.Bit(32, bits.Bit(39));
            toReturn.Bit(33, bits.Bit(31));
            toReturn.Bit(34, bits.Bit(23));
            toReturn.Bit(35, bits.Bit(15));
            toReturn.Bit(36, bits.Bit(7));
            toReturn.Bit(37, bits.Bit(62));
            toReturn.Bit(38, bits.Bit(54));
            toReturn.Bit(39, bits.Bit(46));
            toReturn.Bit(40, bits.Bit(38));
            toReturn.Bit(41, bits.Bit(30));
            toReturn.Bit(42, bits.Bit(22));
            toReturn.Bit(43, bits.Bit(14));
            toReturn.Bit(44, bits.Bit(6));
            toReturn.Bit(45, bits.Bit(61));
            toReturn.Bit(46, bits.Bit(53));
            toReturn.Bit(47, bits.Bit(45));
            toReturn.Bit(48, bits.Bit(37));
            toReturn.Bit(49, bits.Bit(29));
            toReturn.Bit(50, bits.Bit(21));
            toReturn.Bit(51, bits.Bit(13));
            toReturn.Bit(52, bits.Bit(5));
            toReturn.Bit(53, bits.Bit(28));
            toReturn.Bit(54, bits.Bit(20));
            toReturn.Bit(55, bits.Bit(12));
            toReturn.Bit(56, bits.Bit(4));
            #endregion

            return toReturn;
        }

        private BitArray PermutedChoiceTwo(BitArray bits)
        {
            if (bits.Length != 56)
            {
                return null;
            }
            var toReturn = new BitArray(48);
            #region asignaciones de los valores
            toReturn.Bit(1, bits.Bit(14));
            toReturn.Bit(2, bits.Bit(17));
            toReturn.Bit(3, bits.Bit(11));
            toReturn.Bit(4, bits.Bit(24));
            toReturn.Bit(5, bits.Bit(1));
            toReturn.Bit(6, bits.Bit(5));
            toReturn.Bit(7, bits.Bit(3));
            toReturn.Bit(8, bits.Bit(28));
            toReturn.Bit(9, bits.Bit(15));
            toReturn.Bit(10, bits.Bit(6));
            toReturn.Bit(11, bits.Bit(21));
            toReturn.Bit(12, bits.Bit(10));
            toReturn.Bit(13, bits.Bit(23));
            toReturn.Bit(14, bits.Bit(19));
            toReturn.Bit(15, bits.Bit(12));
            toReturn.Bit(16, bits.Bit(4));
            toReturn.Bit(17, bits.Bit(26));
            toReturn.Bit(18, bits.Bit(8));
            toReturn.Bit(19, bits.Bit(16));
            toReturn.Bit(20, bits.Bit(7));
            toReturn.Bit(21, bits.Bit(27));
            toReturn.Bit(22, bits.Bit(20));
            toReturn.Bit(23, bits.Bit(13));
            toReturn.Bit(24, bits.Bit(2));
            toReturn.Bit(25, bits.Bit(41));
            toReturn.Bit(26, bits.Bit(52));
            toReturn.Bit(27, bits.Bit(31));
            toReturn.Bit(28, bits.Bit(37));
            toReturn.Bit(29, bits.Bit(47));
            toReturn.Bit(30, bits.Bit(55));
            toReturn.Bit(31, bits.Bit(30));
            toReturn.Bit(32, bits.Bit(40));
            toReturn.Bit(33, bits.Bit(51));
            toReturn.Bit(34, bits.Bit(45));
            toReturn.Bit(35, bits.Bit(33));
            toReturn.Bit(36, bits.Bit(48));
            toReturn.Bit(37, bits.Bit(44));
            toReturn.Bit(38, bits.Bit(49));
            toReturn.Bit(39, bits.Bit(39));
            toReturn.Bit(40, bits.Bit(56));
            toReturn.Bit(41, bits.Bit(34));
            toReturn.Bit(42, bits.Bit(53));
            toReturn.Bit(43, bits.Bit(46));
            toReturn.Bit(44, bits.Bit(42));
            toReturn.Bit(45, bits.Bit(50));
            toReturn.Bit(46, bits.Bit(36));
            toReturn.Bit(47, bits.Bit(29));
            toReturn.Bit(48, bits.Bit(32));
            #endregion

            return toReturn;
        }

        private BitArray AllKeyShifts(BitArray bits, int rounds)
        {
            var toReturn = new BitArray(bits);
            for (var i = 1; i <= rounds; i++)
            {
                toReturn = KeyLeftShift(toReturn, i);
            }
            return toReturn;
        }

        #region SBox methods
        private BitArray Sbox1(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }
            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    #region asignacion
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    default: return null;
                    #endregion
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    #region asignacion
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    default: return null;
                    #endregion
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    #region asignacion
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    default: return null;
                    #endregion
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    #region asignacion
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    default: return null;
                    #endregion
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox2(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }
            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox3(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox4(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox5(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox6(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox7(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        private BitArray Sbox8(BitArray bits)
        {
            if (bits.Length != 6)
            {
                return null;
            }

            BitArray toReturn = null;
            int inner = bits.GetInnerBits().ToInt();

            if (!bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    default: return null;
                }
            }
            else if (!bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && !bits.Bit(6))
            {
                switch (inner)
                {
                    case 0: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    default: return null;
                }
            }

            else if (bits.Bit(1) && bits.Bit(6))
            {
                switch (inner)
                {

                    case 0: toReturn = new BitArray(BitConverter.GetBytes(2));
                        break;
                    case 1: toReturn = new BitArray(BitConverter.GetBytes(1));
                        break;
                    case 2: toReturn = new BitArray(BitConverter.GetBytes(14));
                        break;
                    case 3: toReturn = new BitArray(BitConverter.GetBytes(7));
                        break;
                    case 4: toReturn = new BitArray(BitConverter.GetBytes(4));
                        break;
                    case 5: toReturn = new BitArray(BitConverter.GetBytes(10));
                        break;
                    case 6: toReturn = new BitArray(BitConverter.GetBytes(8));
                        break;
                    case 7: toReturn = new BitArray(BitConverter.GetBytes(13));
                        break;
                    case 8: toReturn = new BitArray(BitConverter.GetBytes(15));
                        break;
                    case 9: toReturn = new BitArray(BitConverter.GetBytes(12));
                        break;
                    case 10: toReturn = new BitArray(BitConverter.GetBytes(9));
                        break;
                    case 11: toReturn = new BitArray(BitConverter.GetBytes(0));
                        break;
                    case 12: toReturn = new BitArray(BitConverter.GetBytes(3));
                        break;
                    case 13: toReturn = new BitArray(BitConverter.GetBytes(5));
                        break;
                    case 14: toReturn = new BitArray(BitConverter.GetBytes(6));
                        break;
                    case 15: toReturn = new BitArray(BitConverter.GetBytes(11));
                        break;
                    default: return null;
                }
            }

            toReturn.Length = 4;
            return toReturn;
        }
        #endregion

    }
}
