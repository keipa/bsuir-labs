using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Windows;
using Convert = System.Convert;


namespace WebSocketsClient
{

    public partial class MainWindow : Window
    {
        private bool _readyTowork = false;
        private readonly List<string> algorithms = new List<string>{"caesar",
                                                                    "des",
                                                                    "des3",
                                                                    "des3k2",
                                                                    "gost28147",
                                                                    "aes",
                                                                    "rsa",
                                                                    "gost3410",
                                                                    "deffihelman",
                                                                    "ECDSA",
                                                                    "elipticcurves"
                                                                   };
        
        public MainWindow()
        {
            InitializeComponent();
            TestClient.initLogger(DebugList, ChatList);
            foreach (var algorithm in algorithms) algorythmBox.Items.Add(algorithm);
        }

       private void Button_Click(object sender, RoutedEventArgs e)
        {
            if(!_readyTowork)
            {
                MessageBox.Show("Press start button");
                return;
            }
            string html = string.Empty;
            string url = Encryption.Encryption.EncAPI(Message.Text);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (var response = (HttpWebResponse)request.GetResponse())
            using (var stream = response.GetResponseStream())
            using (var reader = new StreamReader(stream))
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
            _readyTowork = true;
        }
        private static readonly HttpClient client = new HttpClient();

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            TestClient.TestPost();
        }
    }
}
