namespace InstantMessengerServer
{
    using System;
    using System.Collections.Generic;
    using System.Net;
    using System.Net.Sockets;
    using ChatServer;

    public class Program
    {
        public Dictionary<string, Client> Users = new Dictionary<string, Client>();
        private int port = 2000;
        private TcpListener server;
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public Program()
        {
            Console.Title = "Server";
            log.Info($"Server started at {DateTime.Now} properly");

            this.server = new TcpListener(IPAddress.Parse("127.0.0.1"), this.port);
            this.server.Start();

            this.Listen();
        }

        public void AddUser(string login, string email, string password, string image)
        {
            using (chatEntities dataBase = new chatEntities())
            {
                dataBase.Users.Add(new Users
                {
                    Login = login,
                    Email = email,
                    Password = password,
                    Image = image,
                });
                dataBase.SaveChanges();
                dataBase.Users.SqlQuery("UPDATE Users");
            }

            log.Debug($"User {login} added");
        }

        public void SaveMessage(int idFrom, int idTo, DateTime date, string message)
        {
            using (chatEntities dataBase = new chatEntities())
            {
                dataBase.Messages.Add(new Messages
                {
                    Id_user_from = idFrom,
                    Id_user_to = idTo,
                    Created_at = date,
                    Message1 = message,
                });
                dataBase.SaveChanges();
            }

            log.Debug($"Message from {idFrom} to {idTo} saved");
        }

        private static void Main(string[] args)
        {
            _ = new Program();
        }

        private void Listen()
        {
            while (true)
            {
                _ = new Client(this, this.server.AcceptTcpClient());
            }
        }
    }
}
