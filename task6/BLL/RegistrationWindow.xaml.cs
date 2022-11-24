using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace ClientWpf
{
    public partial class RegistrationWindow : Window
    {
        string confPassword;
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public RegistrationWindow()
        {
            InitializeComponent();
            Login = "";
            Email = "";
            Password = "";
            confPassword = "";
            Image = "";
        }

        public string Login { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Image { get; set; }

        readonly Client client = new Client();
        private void RegisttrationButton_Click(object sender, RoutedEventArgs e)
        {
            if (PasswordBox.Password.Length > 3)
            {
                if (LoginBox.Text != "" && EmailBox.Text != "")
                {
                    Email = EmailBox.Text;
                    Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                    Match match = regex.Match(Email);
                    if (match.Success)
                    {
                        Login = LoginBox.Text;
                        Password = PasswordBox.Password;
                        confPassword = PasswordBoxCheck.Password;

                        if (Password != confPassword)
                        {
                            log.Info($"User {Login} entered wrong password");
                            MessageBox.Show("Passwords do not match");
                            PasswordBoxCheck.Password = "";
                        }
                        else
                        {
                            this.DialogResult = true;
                            Close();
                        }
                    }
                    else
                    {
                        log.Info("Email is incorrect");
                        MessageBox.Show("Email is incorrect");
                    }
                }
                else
                {
                    log.Info("All fields must be filled");
                    MessageBox.Show("All fields must be filled");
                }
            }
            else
            {
                log.Info("Password is short");
                MessageBox.Show("Password is short");
                PasswordBox.Password = "";
                PasswordBoxCheck.Password = "";
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
            this.Close();
        }
    }
}