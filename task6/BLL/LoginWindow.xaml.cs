using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using ChatServer;
using InstantMessengerServer;
using Microsoft.Data.SqlClient;

namespace ClientWpf
{
    public partial class LoginWindow : Window
    {
        string login;
        string email;
        string password;
        string image;
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public LoginWindow()
        {
            InitializeComponent();
            login = "";
            email = "";
            password = "";
            image = "";
        }

        readonly Client client = new Client();
        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
           
            List<string> users = new List<string>();
            using (SqlConnection connection = new SqlConnection("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=NewDb;Integrated Security=True"))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT Login FROM Users", connection);
                SqlDataReader reader = command.ExecuteReader();                
                while(reader.Read())
                {
                    users.Add(reader.GetString(0));
                }
            }
               

            if (PasswordBox.Password.Length > 3)
            {
                if (LoginBox.Text != "")
                {

                    if (users.Any(x => x == LoginBox.Text))
                    {
                        login = LoginBox.Text;
                        password = PasswordBox.Password;
                        email = "";
                        image = "";

                        client.Connect(login, password, email, image);

                        MainWindow mainWindow = new MainWindow(client);
                        Close();
                        mainWindow.Show();
                    }
                    else
                    {
                        log.Info("User not registered!");
                        MessageBox.Show("User not registered!");
                        MainWindow mw = new MainWindow(client);
                    }
                    
                }
                else
                {
                    log.Info("Fill all fields");
                    MessageBox.Show("Fill all fields");
                }
            }
            else
            {
                log.Info("Password is short");
                MessageBox.Show("Password is short");
                PasswordBox.Password = "";
            }
        }
        private void SignUpButton_Click(object sender, RoutedEventArgs e)
        {
            RegistrationWindow registrationWindow = new RegistrationWindow();
            registrationWindow.ShowDialog();
            login = LoginBox.Text = registrationWindow.Login;
            password = PasswordBox.Password = registrationWindow.Password;
            email = registrationWindow.Email;
            image = registrationWindow.Image;
            if ((bool)registrationWindow.DialogResult)
            {
                client.Connect(login, password, email, image);
            }

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
            Application.Current.Shutdown();
        }
    }



}

