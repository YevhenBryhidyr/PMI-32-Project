USE [master]
GO
/****** Object:  Database [messenger]    Script Date: 09.10.2022 0:33:42 ******/
CREATE DATABASE [messenger]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'messenger', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\messenger.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'messenger_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\messenger_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [messenger] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [messenger].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [messenger] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [messenger] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [messenger] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [messenger] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [messenger] SET ARITHABORT OFF 
GO
ALTER DATABASE [messenger] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [messenger] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [messenger] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [messenger] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [messenger] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [messenger] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [messenger] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [messenger] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [messenger] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [messenger] SET  DISABLE_BROKER 
GO
ALTER DATABASE [messenger] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [messenger] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [messenger] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [messenger] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [messenger] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [messenger] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [messenger] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [messenger] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [messenger] SET  MULTI_USER 
GO
ALTER DATABASE [messenger] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [messenger] SET DB_CHAINING OFF 
GO
ALTER DATABASE [messenger] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [messenger] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [messenger] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [messenger] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [messenger] SET QUERY_STORE = OFF
GO
USE [messenger]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 09.10.2022 0:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_user_to] [int] NOT NULL,
	[id_user_from] [int] NOT NULL,
	[created_time] [datetime] NOT NULL,
	[is_read] [bit] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages_content]    Script Date: 09.10.2022 0:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages_content](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Messages_content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09.10.2022 0:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[email] [nvarchar](max) NOT NULL,
	[date_of_birth] [date] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[phone_number] [nvarchar](50) NOT NULL,
	[image] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (6, 2, 3, CAST(N'2022-12-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (7, 2, 3, CAST(N'2022-12-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (9, 11, 11, CAST(N'1921-11-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (10, 7, 7, CAST(N'1901-05-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (11, 7, 7, CAST(N'1929-02-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (12, 7, 7, CAST(N'1996-09-06T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (13, 10, 11, CAST(N'1950-05-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (14, 10, 11, CAST(N'1960-08-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (15, 8, 10, CAST(N'1975-07-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (16, 11, 10, CAST(N'1930-05-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (17, 9, 7, CAST(N'1922-03-06T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (18, 10, 8, CAST(N'1992-08-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (19, 11, 7, CAST(N'1926-03-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (20, 8, 9, CAST(N'1998-10-25T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (21, 9, 9, CAST(N'1964-08-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (22, 8, 11, CAST(N'1913-02-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (23, 11, 7, CAST(N'1959-05-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (24, 9, 11, CAST(N'1926-03-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (25, 8, 10, CAST(N'2003-08-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (26, 8, 11, CAST(N'1955-11-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (27, 9, 7, CAST(N'1957-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (28, 11, 11, CAST(N'1963-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (29, 10, 11, CAST(N'1980-03-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (30, 11, 11, CAST(N'1991-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (31, 9, 9, CAST(N'1976-09-08T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (32, 10, 11, CAST(N'2006-06-07T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (33, 9, 9, CAST(N'1924-06-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (34, 11, 9, CAST(N'1903-06-07T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (35, 10, 8, CAST(N'1971-06-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (36, 9, 11, CAST(N'1980-12-13T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (37, 8, 8, CAST(N'2005-02-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (38, 11, 7, CAST(N'1990-03-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (39, 7, 10, CAST(N'1911-05-27T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (40, 8, 10, CAST(N'1928-01-06T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (41, 8, 7, CAST(N'1937-04-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (42, 7, 10, CAST(N'1924-08-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (43, 11, 11, CAST(N'2007-01-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (44, 8, 10, CAST(N'1906-09-22T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (45, 11, 8, CAST(N'1989-12-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (46, 11, 11, CAST(N'1934-07-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (47, 11, 9, CAST(N'1977-10-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (48, 8, 11, CAST(N'1969-05-13T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (49, 7, 7, CAST(N'1922-07-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (50, 7, 10, CAST(N'1908-09-02T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (51, 10, 11, CAST(N'1964-03-27T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (52, 7, 11, CAST(N'1937-01-27T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (53, 10, 9, CAST(N'1939-02-17T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (54, 10, 9, CAST(N'1966-04-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (55, 11, 10, CAST(N'1954-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Messages] ([id], [id_user_to], [id_user_from], [created_time], [is_read]) VALUES (56, 7, 11, CAST(N'1923-06-08T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages_content] ON 

INSERT [dbo].[Messages_content] ([id], [content]) VALUES (6, N'abc')
INSERT [dbo].[Messages_content] ([id], [content]) VALUES (7, N'abc')
SET IDENTITY_INSERT [dbo].[Messages_content] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (2, N'user1', N'password1', N'email1', CAST(N'2002-01-12' AS Date), N'name1', N'phone1', N'image1')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (3, N'user2', N'password2', N'email2', CAST(N'2002-01-12' AS Date), N'name2', N'phone2', N'image2')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (7, N'login5632', N'password7782', N'email7255', CAST(N'1962-02-22' AS Date), N'name9126', N'phone_number108', N'image6047')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (8, N'login4772', N'password4056', N'email3923', CAST(N'1968-05-02' AS Date), N'name8591', N'phone_number108', N'image6248')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (9, N'login2709', N'password5421', N'email605', CAST(N'1985-02-11' AS Date), N'name4627', N'phone_number1565', N'image7569')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (10, N'login6902', N'password2247', N'email5834', CAST(N'1992-03-14' AS Date), N'name9325', N'phone_number9366', N'image1052')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (11, N'login972', N'password4662', N'email8164', CAST(N'1999-05-14' AS Date), N'name7758', N'phone_number9625', N'image3069')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (12, N'login4095', N'password5484', N'email1294', CAST(N'1947-05-26' AS Date), N'name2400', N'phone_number8951', N'image9426')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (13, N'login6543', N'password8142', N'email1127', CAST(N'1969-02-14' AS Date), N'name905', N'phone_number9314', N'image4709')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (14, N'login2291', N'password9796', N'email1230', CAST(N'1931-06-06' AS Date), N'name5775', N'phone_number4061', N'image2888')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (15, N'login5564', N'password9101', N'email6889', CAST(N'1984-11-13' AS Date), N'name5840', N'phone_number327', N'image6089')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (16, N'login9100', N'password7658', N'email7409', CAST(N'1906-08-08' AS Date), N'name5381', N'phone_number1466', N'image2481')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (17, N'login2617', N'password3559', N'email4537', CAST(N'1905-10-16' AS Date), N'name2075', N'phone_number342', N'image319')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (18, N'login4634', N'password8655', N'email874', CAST(N'1934-05-06' AS Date), N'name7938', N'phone_number3365', N'image4774')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (19, N'login3331', N'password7828', N'email1362', CAST(N'1919-01-20' AS Date), N'name8396', N'phone_number9552', N'image3754')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (20, N'login2042', N'password3766', N'email2088', CAST(N'1961-06-25' AS Date), N'name5331', N'phone_number9373', N'image2905')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (21, N'login9818', N'password747', N'email2316', CAST(N'1949-03-15' AS Date), N'name8201', N'phone_number9150', N'image4991')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (22, N'login1933', N'password1261', N'email4392', CAST(N'1990-08-23' AS Date), N'name2735', N'phone_number3652', N'image1053')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (23, N'login4480', N'password4221', N'email4006', CAST(N'1961-09-01' AS Date), N'name882', N'phone_number6415', N'image5386')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (24, N'login9956', N'password9302', N'email9281', CAST(N'1917-02-01' AS Date), N'name7968', N'phone_number3466', N'image1280')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (25, N'login4655', N'password5130', N'email8677', CAST(N'2006-03-28' AS Date), N'name6371', N'phone_number239', N'image3647')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (26, N'login4392', N'password9307', N'email213', CAST(N'1962-05-11' AS Date), N'name1135', N'phone_number9722', N'image2248')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (27, N'login1185', N'password9035', N'email4331', CAST(N'1929-01-23' AS Date), N'name6929', N'phone_number6666', N'image8023')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (28, N'login8760', N'password3964', N'email7795', CAST(N'1951-10-19' AS Date), N'name3211', N'phone_number3052', N'image1740')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (29, N'login1553', N'password8109', N'email4081', CAST(N'1913-02-06' AS Date), N'name459', N'phone_number5169', N'image2689')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (30, N'login282', N'password8921', N'email9580', CAST(N'1917-09-06' AS Date), N'name7132', N'phone_number5293', N'image3374')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (31, N'login5535', N'password7725', N'email8463', CAST(N'1935-11-09' AS Date), N'name754', N'phone_number1775', N'image1939')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (32, N'login5997', N'password1281', N'email6355', CAST(N'1976-09-28' AS Date), N'name8473', N'phone_number9848', N'image8768')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (33, N'login3982', N'password826', N'email3966', CAST(N'1900-02-06' AS Date), N'name1741', N'phone_number5336', N'image9423')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (34, N'login7122', N'password1727', N'email8671', CAST(N'1967-06-27' AS Date), N'name4520', N'phone_number9894', N'image4454')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (35, N'login3730', N'password898', N'email6433', CAST(N'1996-07-10' AS Date), N'name2241', N'phone_number3515', N'image8216')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (36, N'login5564', N'password1808', N'email9072', CAST(N'1930-07-17' AS Date), N'name911', N'phone_number7078', N'image4072')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (37, N'login9009', N'password3893', N'email2489', CAST(N'1914-12-22' AS Date), N'name9040', N'phone_number4550', N'image7263')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (38, N'login1290', N'password1577', N'email1386', CAST(N'1927-12-15' AS Date), N'name2000', N'phone_number9709', N'image4197')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (39, N'login5648', N'password1841', N'email7311', CAST(N'1960-08-02' AS Date), N'name5750', N'phone_number8914', N'image9640')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (40, N'login406', N'password6311', N'email4649', CAST(N'1937-01-08' AS Date), N'name4699', N'phone_number3227', N'image660')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (41, N'login938', N'password4690', N'email6347', CAST(N'1972-12-06' AS Date), N'name9170', N'phone_number9680', N'image3693')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (42, N'login4775', N'password3664', N'email2099', CAST(N'1932-02-12' AS Date), N'name4974', N'phone_number5370', N'image754')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (43, N'login660', N'password3359', N'email4979', CAST(N'1939-07-22' AS Date), N'name2848', N'phone_number5678', N'image3912')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (44, N'login775', N'password6591', N'email8349', CAST(N'1949-03-10' AS Date), N'name825', N'phone_number5416', N'image9954')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (45, N'login4175', N'password6478', N'email2160', CAST(N'1924-06-05' AS Date), N'name3717', N'phone_number2859', N'image7376')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (46, N'login804', N'password5431', N'email1041', CAST(N'1960-11-20' AS Date), N'name3994', N'phone_number1149', N'image7483')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (47, N'login6978', N'password8090', N'email9011', CAST(N'1932-08-19' AS Date), N'name2535', N'phone_number4711', N'image7525')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (48, N'login5869', N'password4050', N'email8248', CAST(N'1900-03-14' AS Date), N'name2144', N'phone_number2734', N'image767')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (49, N'login5531', N'password6942', N'email600', CAST(N'1998-12-26' AS Date), N'name7602', N'phone_number7325', N'image6992')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (50, N'login2667', N'password6780', N'email5541', CAST(N'1974-05-20' AS Date), N'name965', N'phone_number7756', N'image9392')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (51, N'login2821', N'password1739', N'email1866', CAST(N'1938-07-19' AS Date), N'name4635', N'phone_number3632', N'image643')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (52, N'login8825', N'password8660', N'email2796', CAST(N'1925-12-14' AS Date), N'name373', N'phone_number5073', N'image1676')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (53, N'login5995', N'password9375', N'email864', CAST(N'1990-10-26' AS Date), N'name2119', N'phone_number5697', N'image957')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (54, N'login9504', N'password5003', N'email6293', CAST(N'1907-09-16' AS Date), N'name8855', N'phone_number8585', N'image7373')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (55, N'login7499', N'password995', N'email3410', CAST(N'1945-08-22' AS Date), N'name9956', N'phone_number5271', N'image7672')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (56, N'login8686', N'password6718', N'email9458', CAST(N'1973-07-06' AS Date), N'name3276', N'phone_number8650', N'image2391')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (57, N'login6495', N'password5468', N'email6695', CAST(N'1925-10-26' AS Date), N'name1890', N'phone_number779', N'image5781')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (58, N'login6680', N'password8616', N'email7973', CAST(N'1913-09-04' AS Date), N'name2797', N'phone_number1607', N'image848')
INSERT [dbo].[Users] ([id], [login], [password], [email], [date_of_birth], [name], [phone_number], [image]) VALUES (59, N'login1867', N'password6197', N'email9996', CAST(N'2003-01-23' AS Date), N'name8037', N'phone_number9741', N'image4703')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_is_read]  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users] FOREIGN KEY([id_user_to])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users1] FOREIGN KEY([id_user_from])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users1]
GO
ALTER TABLE [dbo].[Messages_content]  WITH CHECK ADD  CONSTRAINT [FK_Messages_content_Messages] FOREIGN KEY([id])
REFERENCES [dbo].[Messages] ([id])
GO
ALTER TABLE [dbo].[Messages_content] CHECK CONSTRAINT [FK_Messages_content_Messages]
GO
USE [master]
GO
ALTER DATABASE [messenger] SET  READ_WRITE 
GO
