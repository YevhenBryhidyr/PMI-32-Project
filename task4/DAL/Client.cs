using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.IO;
using System.Threading;
using ChatServer;

namespace InstantMessengerServer
{
    public class Client
    {
        readonly Program program;
        public TcpClient client;
        public NetworkStream networkStream; 
        public BinaryReader binaryReader;
        public BinaryWriter binaryWriter;

        string currentUser; 
        string password;
        string email;
        string image;

        public Client(Program program, TcpClient client)
        {
            this.program = program;
            this.client = client;
            (new Thread(new ThreadStart(CreateConnention))).Start();
        }

        void CreateConnention() 
        {
            try
            {
                Console.WriteLine($"New connection at {DateTime.Now}");
                networkStream = client.GetStream();

                binaryReader = new BinaryReader(networkStream, Encoding.UTF8);
                binaryWriter = new BinaryWriter(networkStream, Encoding.UTF8);

                Users user = new Users();

                currentUser = binaryReader.ReadString();
                password = binaryReader.ReadString();
                email = binaryReader.ReadString();
                image = binaryReader.ReadString();

                user.Login = currentUser;
                user.Password = password;
                user.Email = email;
                user.Image = image;

                List<Users> usersFromDB = new List<Users>();
                using (chatEntities dataBase = new chatEntities())
                {
                    foreach (Users userFromDB in dataBase.Users)
                    {
                        usersFromDB.Add(userFromDB);
                    }
                }
                if(!usersFromDB.Any(x => x.Login == currentUser))
                {
                    program.AddUser(currentUser, email, password, image);
                    program.users.Add(currentUser, this);  
                    usersFromDB.Add(user);
                    Console.WriteLine($"{currentUser} is registered");
                    
                }
                if (usersFromDB.Any(x => x.Login == currentUser))
                {
                    if (password.Length > 3)
                    {                        
                        program.users.Add(currentUser, this);
                        usersFromDB.Add(user); 
                        Receiver();  
                    }
                    else
                        Console.WriteLine($"Wrong data given");
                }
                CloseConnection();
            }
            catch (Exception)
            {
                CloseConnection();
            }
        }
       
        void CloseConnection() 
        {
            try
            {
                program.users.Remove(currentUser);
                binaryReader.Close();
                binaryWriter.Close();
                networkStream.Close();
                client.Close();
                Console.WriteLine($"Connection ended at {DateTime.Now}");
            }
            catch (Exception) 
            {   }
        }
        
        void Receiver()  
        {
            Console.WriteLine($"{currentUser} logged in at {DateTime.Now}");
            try
            {
                while (client.Client.Connected)  
                {
                    int idFrom = -1, idTo = -1;

                    string to = binaryReader.ReadString();
                    string message = binaryReader.ReadString();

                    using (chatEntities dataBase = new chatEntities())
                    {
                        foreach (Users user in dataBase.Users)
                        {
                            if (user.Login == currentUser)
                                idFrom = user.Id;

                            if (user.Login == to)
                                idTo = user.Id;
                        }
                    }

                    if (program.users.TryGetValue(to, out Client recipient))
                    {
                        recipient.binaryWriter.Write(currentUser);
                        recipient.binaryWriter.Write(message);
                        recipient.binaryWriter.Flush();
                        Console.WriteLine($"{currentUser} sent a message to {to} at {DateTime.Now}");
                        if (idFrom != -1 && idTo != -1)
                            program.SaveMessage(idFrom, idTo, DateTime.Now, message);
                    }
                    else
                        Console.WriteLine("Client does not exist");
                }
            }
            catch (IOException)
            {   }

            Console.WriteLine($"{currentUser} logged out at {DateTime.Now}");
        }

    }
}   
