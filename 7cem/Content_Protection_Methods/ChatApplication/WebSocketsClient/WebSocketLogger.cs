using System;
using System.Diagnostics;
using System.Windows.Controls;
using WebSockets.Common;

namespace WebSocketsClient
{
    internal class WebSocketLogger : IWebSocketLogger
    {
        private readonly ListBox ChatList;
        private readonly ListBox debugList;

        public WebSocketLogger(ListBox debugList, ListBox chatList)
        {
            this.debugList = debugList;
            ChatList = chatList;
        }

        public void Chat(string format)
        {
            ChatList.Dispatcher.Invoke(() => { ChatList.Items.Insert(0, format); });
        }

        public void Information(Type type, string format, params object[] args)
        {
            debugList.Dispatcher.Invoke(() => { debugList.Items.Insert(0, string.Format(format, args)); });
            Debug.WriteLine(format, args);
        }

        public void Warning(Type type, string format, params object[] args)
        {
            Debug.WriteLine(format, args);
        }

        public void Error(Type type, string format, params object[] args)
        {
            Debug.WriteLine(format, args);
        }

        public void Error(Type type, Exception exception)
        {
            Error(type, "{0}", exception);
        }
    }
}