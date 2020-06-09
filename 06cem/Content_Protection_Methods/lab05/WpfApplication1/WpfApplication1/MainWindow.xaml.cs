using System;
using System.Data.SQLite;
using System.Diagnostics;
using System.Windows;
using System.Collections;
using System.Collections.Generic;


namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    /// 
    /// ';insert into users (username, password) values ('kek', 'kek');select * from users where password='
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            string user = username.Text;
            string pass = password.Text;
            var conn = new SQLiteConnection("Data Source=D:\\LABS\\BSUIR_labs\\6cem\\Content_Protection_Methods\\lab05\\users");
            conn.Open();
            string sql = "select * from users where username='" + user + "' and password='" + pass + "'";
            SQLiteCommand command = new SQLiteCommand(sql, conn);
            Debug.WriteLine(sql);
            command.ExecuteNonQuery();
            var list = new List<int>{3,6,8,9};

            foreach (var kek in list)
            {
                var a = '2';
                string t = "kek";
                List<string> lol = new List<string>();
            }
            SQLiteDataReader reader = command.ExecuteReader();
            try
            {
                textBlock.Text = reader.HasRows ? "Authed" : "Auth failed";
                //while (reader.Read())
                //    Debug.WriteLine("Name: " + reader["id"] + reader["username"] + reader["password"]);
            }
            catch (Exception)
            {
                
                Debug.WriteLine("ups..");
            }
           

        }
    }
}
