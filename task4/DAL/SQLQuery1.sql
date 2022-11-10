
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/08/2022 13:48:40
-- Generated from EDMX file: C:\Users\user\Desktop\Chat1\Chat\ChatServer\ChatServer\Model2.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [chat];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Messages_UserFrom]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Messages] DROP CONSTRAINT [FK_Messages_UserFrom];
GO
IF OBJECT_ID(N'[dbo].[FK_Messages_UserTo]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Messages] DROP CONSTRAINT [FK_Messages_UserTo];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Messages]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Messages];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Messages'
CREATE TABLE [dbo].[Messages] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Id_user_to] int  NOT NULL,
    [Id_user_from] int  NOT NULL,
    [Created_at] datetime  NULL,
    [Message1] nvarchar(255)  NULL
);
GO

-- Creating table 'sysdiagrams'
CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Login] nvarchar(50)  NOT NULL,
    [Password] nvarchar(100)  NOT NULL,
    [Email] nvarchar(50)  NULL,
    [Image] nvarchar(50)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Messages'
ALTER TABLE [dbo].[Messages]
ADD CONSTRAINT [PK_Messages]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [diagram_id] in table 'sysdiagrams'
ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Id_user_from] in table 'Messages'
ALTER TABLE [dbo].[Messages]
ADD CONSTRAINT [FK_Messages_UserFrom]
    FOREIGN KEY ([Id_user_from])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Messages_UserFrom'
CREATE INDEX [IX_FK_Messages_UserFrom]
ON [dbo].[Messages]
    ([Id_user_from]);
GO

-- Creating foreign key on [Id_user_to] in table 'Messages'
ALTER TABLE [dbo].[Messages]
ADD CONSTRAINT [FK_Messages_UserTo]
    FOREIGN KEY ([Id_user_to])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Messages_UserTo'
CREATE INDEX [IX_FK_Messages_UserTo]
ON [dbo].[Messages]
    ([Id_user_to]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------