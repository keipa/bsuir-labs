using System;
using System.Collections.Generic;
using System.Linq;
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
        }


        private void Button_Click(object sender, RoutedEventArgs e)
        {

            TestClient.StartSendThread($"ws://localhost:{portSend.Text}/chat", Message.Text);
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
