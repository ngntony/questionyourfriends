USE [master]
GO
/****** Object:  Database [QuestionYourFriends]    Script Date: 05/19/2011 21:15:46 ******/
CREATE DATABASE [QuestionYourFriends]
GO
ALTER DATABASE [QuestionYourFriends] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuestionYourFriends].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuestionYourFriends] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [QuestionYourFriends] SET ANSI_NULLS OFF
GO
ALTER DATABASE [QuestionYourFriends] SET ANSI_PADDING OFF
GO
ALTER DATABASE [QuestionYourFriends] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [QuestionYourFriends] SET ARITHABORT OFF
GO
ALTER DATABASE [QuestionYourFriends] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [QuestionYourFriends] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [QuestionYourFriends] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [QuestionYourFriends] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [QuestionYourFriends] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [QuestionYourFriends] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [QuestionYourFriends] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [QuestionYourFriends] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [QuestionYourFriends] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [QuestionYourFriends] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [QuestionYourFriends] SET  DISABLE_BROKER
GO
ALTER DATABASE [QuestionYourFriends] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [QuestionYourFriends] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [QuestionYourFriends] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [QuestionYourFriends] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [QuestionYourFriends] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [QuestionYourFriends] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [QuestionYourFriends] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [QuestionYourFriends] SET  READ_WRITE
GO
ALTER DATABASE [QuestionYourFriends] SET RECOVERY FULL
GO
ALTER DATABASE [QuestionYourFriends] SET  MULTI_USER
GO
ALTER DATABASE [QuestionYourFriends] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [QuestionYourFriends] SET DB_CHAINING OFF
GO
USE [QuestionYourFriends]
GO
/****** Object:  Table [dbo].[User]    Script Date: 05/19/2011 21:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fid] [bigint] NOT NULL,
	[credit_amount] [int] NOT NULL,
	[activated] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transac]    Script Date: 05/19/2011 21:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transac](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fid] [bigint] NOT NULL,
	[amount] [int] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_Transac] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 05/19/2011 21:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_owner] [int] NOT NULL,
	[id_receiver] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[answer] [text] NULL,
	[anom_price] [int] NOT NULL,
	[private_price] [int] NOT NULL,
	[undesirable] [bit] NOT NULL,
	[date_pub] [datetime] NOT NULL,
	[date_answer] [datetime] NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Transac_User]    Script Date: 05/19/2011 21:15:47 ******/
ALTER TABLE [dbo].[Transac]  WITH CHECK ADD  CONSTRAINT [FK_Transac_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Transac] CHECK CONSTRAINT [FK_Transac_User]
GO
/****** Object:  ForeignKey [FK_Question_Owner]    Script Date: 05/19/2011 21:15:47 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Owner] FOREIGN KEY([id_owner])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Owner]
GO
/****** Object:  ForeignKey [FK_Question_Receiver]    Script Date: 05/19/2011 21:15:47 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Receiver] FOREIGN KEY([id_receiver])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Receiver]
GO
