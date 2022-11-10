using System;
using System.Text;
using System.Net.Sockets;
using System.Threading;
using System.IO;

namespace ClientWpf
{
    public class Client
    {
        Thread tcpThread;     
        bool isConnected = false;   

        public event IMReceivedEventHandler MessageReceived;

        public string Server { get { return "localhost"; } }  
        public int Port { get { return 2000; } }

        public string UserName { get; private set; }
        public string Password { get; private set; }
        public string Email { get; private set; }
        public string Image { get; private set; }

        virtual protected void OnMessageReceived(IMReceivedEventArgs e)
        {
            MessageReceived?.Invoke(this, e);
        }
        public void Connect(string user, string password, string email, string image)
        {
            if (!isConnected)
            {
                isConnected = true;
                UserName = user;
                Password = password;
                Email = email;
                Image = image;

                tcpThread = new Thread(new ThreadStart(CreateConnection));
                tcpThread.Start();
            }
        }
        public void Disconnect()
        {
            if (isConnected)
                CloseConnection();
        }
        public void SendMessage(string to, string msg)
        {
            if (isConnected)
            {
                binaryWriter.Write(to);
                binaryWriter.Write(msg);
                binaryWriter.Flush();
            }
        }

        TcpClient client;
        NetworkStream networkStream;
        BinaryReader binaryReader;
        BinaryWriter binaryWriter;
    
        void CreateConnection()  
        {
            client = new TcpClient(Server, Port);  
            networkStream = client.GetStream();

            binaryReader = new BinaryReader(networkStream, Encoding.UTF8);
            binaryWriter = new BinaryWriter(networkStream, Encoding.UTF8);

            binaryWriter.Write(UserName);
            binaryWriter.Write(Password);
            binaryWriter.Write(Email);
            binaryWriter.Write(Image);
            binaryWriter.Flush();

            if (Email == "")
            {
                Receiver(); 
                if (isConnected)
                    CloseConnection();
            }
            else
            {
                if (isConnected)
                    CloseConnection();
            }
        }
        public void CloseConnection() 
        {
            binaryReader.Close();
            binaryWriter.Close();
            networkStream.Close();
            client.Close();
            isConnected = false;
        }
        void Receiver()  
        {
            try
            {
                while (client.Connected) 
                {
                    string from = binaryReader.ReadString();
                    string msg = binaryReader.ReadString();
                    Console.WriteLine("[{0}] ({1} -> {2}) Message sent!", DateTime.Now, from, msg);
                    OnMessageReceived(new IMReceivedEventArgs(from, msg));
                }
            }
            catch (IOException)
            {   }
        }
    }
    public class IMReceivedEventArgs : EventArgs
    {
        public IMReceivedEventArgs(string user, string msg)
        {
            From = user;
            Message = msg;
        }
        public string From { get; }
        public string Message { get; }
    }
    public delegate void IMReceivedEventHandler(object sender, IMReceivedEventArgs e);
}
