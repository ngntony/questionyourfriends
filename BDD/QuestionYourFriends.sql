USE [master]
GO
/****** Object:  Database [QuestionYourFriends]    Script Date: 06/08/2011 21:13:33 ******/
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
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'qyf')
DROP LOGIN [qyf]
GO
CREATE LOGIN [qyf] WITH PASSWORD=N'root', DEFAULT_DATABASE=[QuestionYourFriends], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [QuestionYourFriends]
GO
/****** Object:  Table [dbo].[User]    Script Date: 06/08/2011 21:13:34 ******/
EXEC sp_changedbowner 'qyf'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fid] [bigint] NOT NULL,
	[credit_amount] [int] NOT NULL,
	[activated] [bit] NOT NULL,
	[login] [nvarchar](50) NULL,
	[passwd] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_User] UNIQUE NONCLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 06/08/2011 21:13:34 ******/
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
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transac]    Script Date: 06/08/2011 21:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transac](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[amount] [int] NOT NULL,
	[status] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[type] [int] NOT NULL,
	[questionId] [int] NULL,
 CONSTRAINT [PK_Transac] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_User_credit_amount]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_credit_amount]  DEFAULT ((0)) FOR [credit_amount]
GO
/****** Object:  Default [DF_User_activated]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_activated]  DEFAULT ((1)) FOR [activated]
GO
/****** Object:  Default [DF_Question_anom_price]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_anom_price]  DEFAULT ((0)) FOR [anom_price]
GO
/****** Object:  Default [DF_Question_private_price]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_private_price]  DEFAULT ((0)) FOR [private_price]
GO
/****** Object:  Default [DF_Question_undesirable]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_undesirable]  DEFAULT ((0)) FOR [undesirable]
GO
/****** Object:  Default [DF_Question_date_pub]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_date_pub]  DEFAULT (getdate()) FOR [date_pub]
GO
/****** Object:  Default [DF_Question_deleted]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_deleted]  DEFAULT ((0)) FOR [deleted]
GO
/****** Object:  Default [DF_Transac_amount]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Transac] ADD  CONSTRAINT [DF_Transac_amount]  DEFAULT ((0)) FOR [amount]
GO
/****** Object:  Default [DF_Transac_status]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Transac] ADD  CONSTRAINT [DF_Transac_status]  DEFAULT ((0)) FOR [status]
GO
/****** Object:  Default [DF_Transac_type]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Transac] ADD  CONSTRAINT [DF_Transac_type]  DEFAULT ((0)) FOR [type]
GO
/****** Object:  ForeignKey [FK_Question_Owner]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Owner] FOREIGN KEY([id_owner])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Owner]
GO
/****** Object:  ForeignKey [FK_Question_Receiver]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Receiver] FOREIGN KEY([id_receiver])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Receiver]
GO
/****** Object:  ForeignKey [FK_Transac_Question]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Transac]  WITH CHECK ADD  CONSTRAINT [FK_Transac_Question] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([id])
GO
ALTER TABLE [dbo].[Transac] CHECK CONSTRAINT [FK_Transac_Question]
GO
/****** Object:  ForeignKey [FK_Transac_User]    Script Date: 06/08/2011 21:13:34 ******/
ALTER TABLE [dbo].[Transac]  WITH CHECK ADD  CONSTRAINT [FK_Transac_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Transac] CHECK CONSTRAINT [FK_Transac_User]
GO
