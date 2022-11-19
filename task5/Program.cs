using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.Threading.Tasks;

namespace task3
{
    public class Program
    {

        public static string ShowInfoUser(SqlConnection connection, string sqlExpression, int inputID)
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = sqlExpression;
            SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
            mySqlDataAdapter.SelectCommand = command;
            DataSet myDataSet = new DataSet();
            Console.WriteLine("Retrieving rows from the Users table");
            string dataTableName = "Users";
            mySqlDataAdapter.Fill(myDataSet, dataTableName);
            DataTable myDataTable = myDataSet.Tables[dataTableName];

            string searchedLogin = "";
            foreach (DataRow myDataRow in myDataTable.Rows)
            {
                if((int)myDataRow["id"] == inputID)
                {
                    searchedLogin = myDataRow["login"].ToString();
                }    
                Console.WriteLine("----------------------");
                Console.WriteLine("id = " + myDataRow["id"]);
                Console.WriteLine("login = " + myDataRow["login"]);
                Console.WriteLine("password = " + myDataRow["password"]);
                Console.WriteLine("email = " + myDataRow["email"]);
                Console.WriteLine("date_of_birth = " + myDataRow["date_of_birth"]);
                Console.WriteLine("name = " + myDataRow["name"]);
                Console.WriteLine("phone_number = " + myDataRow["phone_number"]);
                Console.WriteLine("image = " + myDataRow["image"]);
                Console.WriteLine("----------------------");
            }
            return searchedLogin;
        }
        public static string ShowInfoMessages(SqlConnection connection, string sqlExpression, int inputID)
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = sqlExpression;
            SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
            mySqlDataAdapter.SelectCommand = command;
            DataSet myDataSet = new DataSet();
            Console.WriteLine("Retrieving rows from the Messages table");
            string dataTableName = "Messages";
            mySqlDataAdapter.Fill(myDataSet, dataTableName);
            DataTable myDataTable = myDataSet.Tables[dataTableName];
            string searchedUsers = "";
            foreach (DataRow myDataRow in myDataTable.Rows)
            {
                if((int)myDataRow["id"] == inputID)
                {
                    searchedUsers = $"{myDataRow["id_user_to"]} sent message to {myDataRow["id_user_from"]}";
                }
                Console.WriteLine("----------------------");
                Console.WriteLine("id = " + myDataRow["id"]);
                Console.WriteLine("id_user_to = " + myDataRow["id_user_to"]);
                Console.WriteLine("id_user_from = " + myDataRow["id_user_from"]);
                Console.WriteLine("created_time = " + myDataRow["created_time"]);
                Console.WriteLine("is_read = " + myDataRow["is_read"]);
                Console.WriteLine("----------------------");
            }
            return searchedUsers;
        }
        public static string ShowInfoMessagesContent(SqlConnection connection, string sqlExpression, int inputID)
        {
            SqlCommand command = connection.CreateCommand();
            command.CommandText = sqlExpression;
            SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
            mySqlDataAdapter.SelectCommand = command;
            DataSet myDataSet = new DataSet();
            Console.WriteLine("Retrieving rows from the Messages_content table");
            string dataTableName = "Messages_content";
            mySqlDataAdapter.Fill(myDataSet, dataTableName);
            DataTable myDataTable = myDataSet.Tables[dataTableName];
            string messageContent = "";
            foreach (DataRow myDataRow in myDataTable.Rows)
            {
                if((int)myDataRow["id"] == inputID)
                {
                    messageContent = myDataRow["content"].ToString();
                }    
                Console.WriteLine("----------------------");
                Console.WriteLine("id = " + myDataRow["id"]);
                Console.WriteLine("content = " + myDataRow["content"]);
                Console.WriteLine("----------------------");
            }
            return messageContent;
        }

        public static void InsertDataIntoUsers(SqlConnection connection, int rows)
        {
            Random random = new Random();
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = "@Date";
            parameter.SqlDbType = SqlDbType.Date;
            int counter = 0;
            for (int i = 0; i < rows; i++)
            {
                parameter.Value = $"{random.Next(1900, 2010)}/{random.Next(1, 13)}/{random.Next(1, 29)}";
                string sqlExpression = $"INSERT INTO Users (login, password, email, date_of_birth, name, phone_number, image) " +
                    $"VALUES ('login{random.Next(100,10000)}','password{random.Next(100, 10000)}', 'email{random.Next(100, 10000)}'," +
                    $" '{parameter.Value}', 'name{random.Next(100, 10000)}'," +
                    $" 'phone_number{random.Next(100, 10000)}', 'image{random.Next(100, 10000)}')";
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                int number = command.ExecuteNonQuery();
                counter = counter + 1;
                Console.WriteLine($"Rows added: {number}");
            }
            Console.WriteLine($"Rows added: {counter}");
        }
        public static void InsertDataIntoMessages(SqlConnection connection, int rows)
        {
            Random random = new Random();
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = "@Date";
            parameter.SqlDbType = SqlDbType.Date;
            int counter = 0;
            for (int i = 0; i < rows; i++)
            {
                parameter.Value = $"{random.Next(1900, 2010)}/{random.Next(1, 13)}/{random.Next(1, 29)}";

                string sqlExpression = $"INSERT INTO Messages (id_user_to, id_user_from, created_time) " +
                    $"VALUES ({random.Next(7,12)},{random.Next(7, 12)}, '{parameter.Value}')";
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                int number = command.ExecuteNonQuery();
                counter = counter + 1;
                Console.WriteLine($"Rows added: {number}");
            }
            Console.WriteLine($"Rows added: {counter}");
        }
        public static void InsertDataIntoMessagesContent(SqlConnection connection, int rows)
        {
            Random random = new Random();
            int counter = 0;
            for (int i = 0; i < rows; i++)
            {
                string sqlExpression = $"SET IDENTITY_INSERT Messages_content ON INSERT Messages_content(id, content)" +
                    $" VALUES({random.Next(6,8)}, 'random content{random.Next(100, 10000)}');" +
                    $"SET IDENTITY_INSERT Messages_content OFF";
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                int number = command.ExecuteNonQuery();
                counter = counter + 1;
                Console.WriteLine($"Rows added: {number}");
            }
            Console.WriteLine($"Rows added: {counter}");
        }
        static async Task Main(string[] args)
        {
            const string connectionString = @"Server =DESKTOP-T9RA1MD\SQLEXPRESS; Database = messenger; Trusted_Connection = True;TrustServerCertificate=True;";
            string sqlExspressionUsers = "SELECT * FROM Users";
            string sqlExspressionMessages = "SELECT * FROM Messages";
            string sqlExspressionMessagesContent = "SELECT * FROM Messages_content";
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                // Відкриваємо підключення
                await connection.OpenAsync();
                Console.WriteLine("Connection opened");
                //додавання нових даних
                //InsertDataIntoUsers(connection, 2);
                //InsertDataIntoMessages(connection, 2);
                //InsertDataIntoMessagesContent(connection, 2);

                string login;
                string showInfoMessagesOutput;
                string messageContent;
                login = ShowInfoUser(connection, sqlExspressionUsers, 7);
                showInfoMessagesOutput = ShowInfoMessages(connection, sqlExspressionMessages, 53);
                messageContent = ShowInfoMessagesContent(connection, sqlExspressionMessagesContent, 6);
                Console.WriteLine(login);
                Console.WriteLine(showInfoMessagesOutput);
                Console.WriteLine(showInfoMessagesOutput == "7 sent message to 11");
                Console.WriteLine(messageContent);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                // якщо підключення відкрито
                if (connection.State == ConnectionState.Open)
                {
                    // закриваємо підключення
                    await connection.CloseAsync();
                    Console.WriteLine("Connection closed...");
                }
            }
        }
    }
}
