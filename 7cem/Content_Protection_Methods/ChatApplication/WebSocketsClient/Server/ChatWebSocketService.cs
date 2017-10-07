using System.Net.Sockets;
using WebSockets.Server.WebSocket;
using WebSockets.Common;
using System.IO;
using System.Net;

namespace WebSocketsClient.Server
{
    internal class ChatWebSocketService : WebSocketService
    {
        private readonly IWebSocketLogger _logger;

        public ChatWebSocketService(Stream stream, TcpClient tcpClient, string header, IWebSocketLogger logger)
            : base(stream, tcpClient, header, true, logger)
        {
            _logger = logger;
        }

        protected override void OnTextFrame(string text)
        {

            string html = string.Empty;
            string url = $"http://localhost:58850/api/caesar/{text}/decrypt";

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (HttpWebResponse httpresponse = (HttpWebResponse)request.GetResponse())
            using (Stream stream = httpresponse.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                html = reader.ReadToEnd();
            }

            string response = "Responce ServerABC: " + html;
            base.Send(response);
            _logger.Chat(response);
        }
    }
}
