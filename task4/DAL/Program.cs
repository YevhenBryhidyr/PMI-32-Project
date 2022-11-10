using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using ChatServer;

namespace InstantMessengerServer
{
    public class Program
    {
        static void Main(string[] args)
        {
            _ = new Program();
        }

        public int port = 2000;
        public TcpListener server;

        public Dictionary<string, Client> users = new Dictionary<string, Client>();

        public Program()
        {
            Console.Title = "Server";
            Console.WriteLine($"Server started at {DateTime.Now} properly");

            server = new TcpListener(IPAddress.Parse("127.0.0.1"), port);
            server.Start();

            Listen();
        }
        
        void Listen()  
        {
            while (true)
            {
                _ = new Client(this, server.AcceptTcpClient());
            }
        }
        
        public void AddUser(string login, string email, string password, string image)
        {
            using (chatEntities dataBase = new chatEntities())
            {
                dataBase.Users.Add(new Users { 
                    Login = login, 
                    Email = email, 
                    Password = password, 
                    Image = image 
                });
                dataBase.SaveChanges();
                dataBase.Users.SqlQuery("UPDATE Users");
            }
        }
        
        public void SaveMessage(int idFrom, int idTo, DateTime date, string message)
        {
            using (chatEntities dataBase = new chatEntities())
            {
                dataBase.Messages.Add(new Messages { 
                    Id_user_from = idFrom, 
                    Id_user_to = idTo, 
                    Created_at = date, 
                    Message1 = message 
                });
                dataBase.SaveChanges();
            }
        }
    }
}
