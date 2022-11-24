namespace InstantMessengerServer
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Net.Sockets;
    using System.Text;
    using System.Threading;
    using ChatServer;

    public class Client
    {
        private readonly Program program;
        private TcpClient client;
        private NetworkStream networkStream;
        private BinaryReader binaryReader;
        private BinaryWriter binaryWriter;

        private string currentUser;
        private string password;
        private string email;
        private string image;
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public Client(Program program, TcpClient client)
        {
            this.program = program;
            this.client = client;
            new Thread(new ThreadStart(this.CreateConnention)).Start();
        }

        private void CreateConnention()
        {
            try
            {
                log.Info($"New connection at {DateTime.Now}");
                this.networkStream = this.client.GetStream();

                this.binaryReader = new BinaryReader(this.networkStream, Encoding.UTF8);
                this.binaryWriter = new BinaryWriter(this.networkStream, Encoding.UTF8);

                Users user = new Users();

                this.currentUser = this.binaryReader.ReadString();
                this.password = this.binaryReader.ReadString();
                this.email = this.binaryReader.ReadString();
                this.image = this.binaryReader.ReadString();

                user.Login = this.currentUser;
                user.Password = this.password;
                user.Email = this.email;
                user.Image = this.image;

                List<Users> usersFromDB = new List<Users>();
                using (chatEntities dataBase = new chatEntities())
                {
                    foreach (Users userFromDB in dataBase.Users)
                    {
                        usersFromDB.Add(userFromDB);
                    }
                }

                if (!usersFromDB.Any(x => x.Login == this.currentUser))
                {
                    this.program.AddUser(this.currentUser, this.email, this.password, this.image);
                    this.program.Users.Add(this.currentUser, this);
                    usersFromDB.Add(user);
                    log.Debug($"{this.currentUser} is registered");
                }

                if (usersFromDB.Any(x => x.Login == this.currentUser))
                {
                    if (this.password.Length > 3)
                    {
                        this.program.Users.Add(this.currentUser, this);
                        usersFromDB.Add(user);
                        this.Receiver();
                    }
                    else
                    {
                        log.Debug($"Wrong data given");
                    }
                }

                this.CloseConnection();
            }
            catch (Exception ex)
            {
                log.Error("Error in creating connection", ex);
                this.CloseConnection();
            }
        }

        private void CloseConnection()
        {
            try
            {
                this.program.Users.Remove(this.currentUser);
                this.binaryReader.Close();
                this.binaryWriter.Close();
                this.networkStream.Close();
                this.client.Close();
                log.Debug($"Connection ended at {DateTime.Now}");
            }
            catch (Exception ex)
            {
                log.Error("Error in closing connection", ex);
            }
        }

        private void Receiver()
        {
            log.Debug($"{this.currentUser} logged in at {DateTime.Now}");
            try
            {
                while (this.client.Client.Connected)
                {
                    int idFrom = -1, idTo = -1;

                    string to = this.binaryReader.ReadString();
                    string message = this.binaryReader.ReadString();

                    using (chatEntities dataBase = new chatEntities())
                    {
                        foreach (Users user in dataBase.Users)
                        {
                            if (user.Login == this.currentUser)
                            {
                                idFrom = user.Id;
                            }

                            if (user.Login == to)
                            {
                                idTo = user.Id;
                            }
                        }
                    }

                    if (this.program.Users.TryGetValue(to, out Client recipient))
                    {
                        recipient.binaryWriter.Write(this.currentUser);
                        recipient.binaryWriter.Write(message);
                        recipient.binaryWriter.Flush();
                        log.Debug($"{this.currentUser} sent a message to {to} at {DateTime.Now}");
                        if (idFrom != -1 && idTo != -1)
                        {
                            this.program.SaveMessage(idFrom, idTo, DateTime.Now, message);
                        }
                    }
                    else
                    {
                        log.Debug("Client does not exist");
                    }
                }
            }
            catch (IOException ex)
            {
                log.Error("Error in receiving method", ex);
            }

            log.Debug($"{this.currentUser} logged out at {DateTime.Now}");
        }
    }
}
