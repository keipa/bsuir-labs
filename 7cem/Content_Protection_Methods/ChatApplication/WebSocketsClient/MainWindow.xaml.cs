using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
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
using Convert = System.Convert;


namespace WebSocketsClient
{

    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            TestClient.initLogger(DebugList, ChatList);
            InitDropdown();
        }

        private void InitDropdown()
        {
            algorythmBox.Items.Add("caesar");
            algorythmBox.Items.Add("des");
            algorythmBox.Items.Add("des3");
            algorythmBox.Items.Add("des3k2");
            algorythmBox.Items.Add("gost28147_ECB");
            algorythmBox.Items.Add("gost28147_CBC");
            algorythmBox.Items.Add("gost28147_CFB");
            algorythmBox.Items.Add("gost28147_OFB");
            algorythmBox.Items.Add("aes");
            algorythmBox.Items.Add("rsamd5");
            algorythmBox.Items.Add("gost_3410");
            algorythmBox.Items.Add("deffihelman");
            algorythmBox.Items.Add("ECDSA");
            algorythmBox.Items.Add("elipticcurves");
        }


        private void Button_Click(object sender, RoutedEventArgs e)
        {

            string html = string.Empty;
            string url = $"http://localhost:58850/api/{algorythmBox.Text}/{Message.Text}/encrypt";

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream stream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                html = reader.ReadToEnd();
            }

            TestClient.StartSendThread($"ws://localhost:{portSend.Text}/chat", html);
            ChatList.Items.Insert(0, Message.Text);
            Message.Text = string.Empty;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            TestClient.StartRecieveThread(Convert.ToInt32(portRecieve.Text));
        }
        private static readonly HttpClient client = new HttpClient();

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            TestClient.TestPost();
        }
    }
}
