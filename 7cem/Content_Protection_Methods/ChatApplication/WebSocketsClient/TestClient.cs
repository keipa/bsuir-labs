using System;
using System.Configuration;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Threading;
using System.Windows.Controls;
using WebSocketClientWebSockets;
using WebSockets.Common;
using WebSockets.Events;
using WebSocketsClient.Client;
using WebSocketsClient.Server;

namespace WebSocketsClient
{
    static class TestClient
    {

        private static string messageToSend;
        private static IWebSocketLogger _logger;

        public static void initLogger(ListBox debugList, ListBox chatlist)
        {
            _logger = new WebSocketLogger(debugList,  chatlist);
        }

        public static void StartRecieveThread(int port)
        {
            Thread t = new Thread(() => Recieve(port));
            t.IsBackground = true;
            t.Start();
        }

        public static void Recieve(int port)
        {

            try
            {


                string webRoot = string.Empty;
                string baseFolder = AppDomain.CurrentDomain.BaseDirectory;
                _logger.Warning(typeof(MainWindow), "Webroot folder {0} not found. Using application base directory: {1}", webRoot, baseFolder);
                webRoot = baseFolder;


                // used to decide what to do with incoming connections
                var serviceFactory = new ServiceFactory(webRoot, _logger);

                using (var server = new WebServer(serviceFactory, _logger))
                {

                    server.Listen(port);

                    Thread.Sleep(100000);

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public static void Send(object state, string message)
        {
            try
            {
                string url = (string)state;
                using (var client = new ChatWebSocketClient(true, _logger))
                {
                    Uri uri = new Uri(url);
                    client.TextFrame += Client_TextFrame;
                    client.ConnectionOpened += Client_ConnectionOpened;

                    // test the open handshake
                    client.OpenBlocking(uri);
                }

                _logger.Information(typeof(MainWindow), "Client finished, press any key");
            }
            catch (Exception ex)
            {
                _logger.Error(typeof(MainWindow), ex.ToString());
                _logger.Information(typeof(MainWindow), "Client terminated: Press any key");
            }
        }

        public static void StartSendThread(object state, string message)
        {
            messageToSend = message;
            Thread t = new Thread(() => Send(state, message));
            t.IsBackground = true;
            t.Start();
        }

        private static void Client_ConnectionOpened(object sender, EventArgs e)
        {
            _logger.Information(typeof(MainWindow), "Client: Connection Opened");
            var client = (ChatWebSocketClient)sender;

            // test sending a message to the server
            client.Send(messageToSend);
        }

        private static void Client_TextFrame(object sender, TextFrameEventArgs e)
        {
            _logger.Information(typeof(MainWindow), "Client: {0}", e.Text);
            var client = (ChatWebSocketClient)sender;

            // lets test the close handshake
            client.Dispose();
        }

     
    }
}
