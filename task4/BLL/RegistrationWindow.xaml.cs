﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ClientWpf
{

    public partial class RegistrationWindow : Window
    {
        string login;
        string email;
        string password;
        string confPassword;
        string image;

        public RegistrationWindow()
        {
            InitializeComponent();
            login = "";
            email = "";
            password = "";
            confPassword = "";
            image = "";
        }

        public string Login { get => login; set => login = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
        public string Image { get => image; set => image = value; }

        Client c = new Client();
        private void RegisttrationButton_Click(object sender, RoutedEventArgs e)
        {

            if (PasswordBox.Password.Length > 3)
            {
                if (LoginBox.Text != "" && EmailBox.Text != "")
                {
                    email = EmailBox.Text;
                    Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                    Match match = regex.Match(email);
                    if (match.Success)
                    {
                        login = LoginBox.Text;
                        password = PasswordBox.Password;
                        confPassword = PasswordBoxCheck.Password;

                        if (password != confPassword)
                        {
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
                        MessageBox.Show("email is incorrect");
                }
                else
                {
                    MessageBox.Show("Fill all fields");
                }
            }
            else
            {
                MessageBox.Show("Password is short, minimum 4 characters!!!");
                PasswordBox.Password = "";
                PasswordBoxCheck.Password = "";
            }
        }


        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
                DragMove();
        }

        private void minimizeWindow_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }

        private void closeWindow_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

    }
}