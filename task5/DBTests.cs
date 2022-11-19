using Microsoft.Data.SqlClient;
using System;
using System.Data;
using Xunit;

namespace TestForDB
{
    public class DBTests
    {
        const string connectionString = @"Server =DESKTOP-T9RA1MD\SQLEXPRESS; Database = messenger; Trusted_Connection = True;TrustServerCertificate=True;";
        string sqlExspressionUsers = "SELECT * FROM Users";
        string sqlExspressionMessages = "SELECT * FROM Messages";
        string sqlExspressionMessagesContent = "SELECT * FROM Messages_content";
        SqlConnection connection = new SqlConnection(connectionString);
        [Fact]
        public async void UserTableOutputTest1()
        {
            try
            {
                string expected = "login5632";
                string actual = "";
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoUser(connection, sqlExspressionUsers, 7);

                Assert.Equal(expected, actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }

        [Fact]
        public async void UserTableOutputTest2()
        {
            try
            {
                string actual;
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoUser(connection, sqlExspressionUsers, 1);
                Assert.Empty(actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }

        [Fact]
        public async void MessageTableOutput1()
        {
            try
            {
                string expected = "7 sent message to 11";
                string actual;
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoMessages(connection, sqlExspressionMessages, 56);
                Assert.Equal(expected, actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }

        [Fact]
        public async void MessageTableOutput2()
        {
            try
            {
                string actual;
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoMessages(connection, sqlExspressionMessages, 5);
                Assert.Empty(actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }

        [Fact]
        public async void MessagesContentTableOutput1()
        {
            try
            {
                string expected = "abc";
                string actual;
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoMessagesContent(connection, sqlExspressionMessagesContent, 6);
                Assert.Equal(expected, actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }

        [Fact]
        public async void MessagesContentTableOutput2()
        {
            try
            {
                string actual;
                await connection.OpenAsync();
                actual = task3.Program.ShowInfoMessagesContent(connection, sqlExspressionMessagesContent, 1);
                Assert.Empty(actual);
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    await connection.CloseAsync();
                }
            }
        }
    }
}
