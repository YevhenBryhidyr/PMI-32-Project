using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;

namespace ClientWpf
{
    public partial class MainWindow : Window
    {
        readonly Client client;
        readonly IMReceivedEventHandler receivedHandler;
        public MainWindow(Client client)
        {
            InitializeComponent();
            receivedHandler = new IMReceivedEventHandler(OnMessageReceived);
            this.client = client;
            this.client.MessageReceived += receivedHandler;
        }
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            client.CloseConnection();
        }    
        void OnMessageReceived(object sender, IMReceivedEventArgs e)
        {
            Dispatcher.Invoke(() => ListBoxMess.Items.Add(($"[{DateTime.Now:HH:mm}] {e.From}: {e.Message}")));
                 
        }
        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            client.SendMessage((string)ChatWithName.Content, TextBoxMessage.Text);
            ListBoxMess.Items.Add(($"[{DateTime.Now.ToString("HH:mm")}] Me: {TextBoxMessage.Text}"));
            TextBoxMessage.Text = "";
        }
        private void CreateChatButton_Click(object sender, RoutedEventArgs e)
        {
            ChatCreater chatCreaterButton = new ChatCreater();
            chatCreaterButton.ShowDialog();
        }
        private void Contact_Select(object sender, MouseButtonEventArgs e)
        {
            if (ItemsControl.ContainerFromElement(sender as ListBox, e.OriginalSource as DependencyObject) is ListBoxItem item)
            {
                ChatWithName.Content = item.Content;
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

