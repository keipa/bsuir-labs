using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using DES.Model;

namespace DES
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            messagebox.Focus();
        }

        private void cipherButton_Click(object sender, RoutedEventArgs e)
        {
            string plaintext = messagebox.Text;
            string key = keybox.Text;
            string ciphertext = string.Empty;
            string works = string.Empty;
            string send = string.Empty;
            bool hex = (bool)hexRadio.IsChecked;
            int round = roundBox.SelectedIndex + 1;
            if (hex)
            {
                for (int i = 0; i < plaintext.Length; i += 16)
                {
                    if (plaintext.Length - i > 16)
                    {
                        send = plaintext.Substring(i, 16);
                    }
                    else
                    {
                        send = plaintext.Substring(i, plaintext.Length - i);
                    }
                    if (send.Length != 16)
                    {
                        int missing = 16 - send.Length;
                        for (int j = 0; j < missing; j++)
                        {
                            send += "0";
                        }
                    }
                    works += string.Format("Part {0}{1}", i, Environment.NewLine);
                    var des = new DESClass() { Plaintext = send, Key = key };
                    des.CipherHex(round);
                    works += string.Format("{0}{1}{1}", des.Work, Environment.NewLine);
                    ciphertext += des.Ciphertext;
                }

            }
            else
            {
                for (int i = 0; i < plaintext.Length; i += 8)
                {
                    if (plaintext.Length - i > 8)
                    {
                        send = plaintext.Substring(i, 8);
                    }
                    else
                    {
                        send = plaintext.Substring(i, plaintext.Length - i);
                    }
                    if (send.Length != 8)
                    {
                        int missing = 8 - send.Length;
                        for (int j = 0; j < missing; j++)
                        {
                            send += "0";
                        }
                    }
                    works += string.Format("Part {0}{1}", i, Environment.NewLine);
                    var des = new DESClass() { Plaintext = send, Key = key };
                    des.CipherString(round);
                    works += string.Format("{0}{1}{1}", des.Work, Environment.NewLine);
                    ciphertext += des.Ciphertext;
                }

            }
            workText.Text = string.Format("{0}{1} CipherBytes: {2}", works, Environment.NewLine, ciphertext);
        }

        private void decipherButton_Click(object sender, RoutedEventArgs e)
        {
            string ciphertext = messagebox.Text;
            string key = keybox.Text;
            string plaintext = string.Empty;
            string works = string.Empty;
            string send = string.Empty;
            bool hex = (bool)hexRadio.IsChecked;
            int round = roundBox.SelectedIndex + 1;
            if (hex)
            {
                for (int i = 0; i < ciphertext.Length; i += 16)
                {
                    if (ciphertext.Length - i > 16)
                    {
                        send = ciphertext.Substring(i, 16);
                    }
                    else
                    {
                        send = ciphertext.Substring(i, plaintext.Length - i);
                    }
                    if (send.Length != 16)
                    {
                        int missing = 16 - send.Length;
                        for (int j = 0; j < missing; j++)
                        {
                            send += "0";
                        }
                    }
                    works += string.Format("Part {0}{1}", i, Environment.NewLine);
                    var des = new DESClass() { Ciphertext = send, Key = key };
                    des.DecipherHex(round);
                    works += string.Format("{0}{1}{1}", des.Work, Environment.NewLine);
                    plaintext += des.Plaintext;
                }
               
            }
            else
            {
                for (int i = 0; i < ciphertext.Length; i += 16)
                {
                    if (ciphertext.Length - i > 16)
                    {
                        send = ciphertext.Substring(i, 16);
                    }
                    else
                    {
                        send = ciphertext.Substring(i, ciphertext.Length - i);
                    }
                    if (send.Length != 16)
                    {
                        int missing = 16 - send.Length;
                        for (int j = 0; j < missing; j++)
                        {
                            send += "0";
                        }
                    }
                    works += string.Format("Part {0}{1}", i, Environment.NewLine);
                    var des = new DESClass() { Ciphertext = send, Key = key };
                    des.DecipherString(round);
                    works += string.Format("{0}{1}{1}", des.Work, Environment.NewLine);
                    plaintext += des.Plaintext;
                }
            }
            workText.Text = string.Format("{0}{1} PlainBytes: {2}", works, Environment.NewLine, plaintext);
        }

        private void randomKey_Click(object sender, RoutedEventArgs e)
        {
            string key = string.Empty;
            char[] possible = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
            Random random = new Random();

            int posicion;
            for (var j = 0; j < 16; j++)
            {
                posicion = random.Next(16);
                key += possible[posicion];
            }
            keybox.Text = key;
        }
    }
}
