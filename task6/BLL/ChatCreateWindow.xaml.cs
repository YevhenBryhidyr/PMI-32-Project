using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Input;
using Microsoft.Data.SqlClient;

namespace ClientWpf
{
    public partial class ChatCreator : Window
    {
        public ChatCreator()
        {
            InitializeComponent();
        }
        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
                DragMove();
        }
        private void MinimizeWindow_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }
        private void CloseWindow_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        private void CreateChat_Click(object sender, RoutedEventArgs e)
        {
            List<string> users = new List<string>();
            using SqlConnection connection = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=NewDb;Integrated Security=True");
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT Login FROM Users", connection);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                users.Add(reader.GetString(0));
            }
            if (users.Any(x => x == SearchFor.Text))
            {

                foreach (Window window in Application.Current.Windows)
                {
                    if (window.GetType() == typeof(MainWindow))
                    {
                        (window as MainWindow).ListBoxContacts.Items.Add(SearchFor.Text);

                    }
                }
            }
        }
    }
}
