USE [master]
GO
/****** Object:  Database [collect2000]    Script Date: 12/9/2015 5:04:09 PM ******/
CREATE DATABASE [collect2000]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'collect2000', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\collect2000.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'collect2000_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\collect2000_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [collect2000] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [collect2000].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [collect2000] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [collect2000] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [collect2000] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [collect2000] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [collect2000] SET ARITHABORT OFF 
GO
ALTER DATABASE [collect2000] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [collect2000] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [collect2000] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [collect2000] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [collect2000] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [collect2000] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [collect2000] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [collect2000] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [collect2000] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [collect2000] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [collect2000] SET  DISABLE_BROKER 
GO
ALTER DATABASE [collect2000] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [collect2000] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [collect2000] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [collect2000] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [collect2000] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [collect2000] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [collect2000] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [collect2000] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [collect2000] SET  MULTI_USER 
GO
ALTER DATABASE [collect2000] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [collect2000] SET DB_CHAINING OFF 
GO
ALTER DATABASE [collect2000] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [collect2000] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [collect2000]
GO
/****** Object:  User [IISAPPPOOL]    Script Date: 12/9/2015 5:04:09 PM ******/
CREATE USER [IISAPPPOOL] FOR LOGIN [IIS APPPOOL\ASP.NET v4.0] WITH DEFAULT_SCHEMA=[db_owner]
GO
/****** Object:  Schema [ERCTasks]    Script Date: 12/9/2015 5:04:10 PM ******/
CREATE SCHEMA [ERCTasks]
GO
/****** Object:  StoredProcedure [dbo].[USP_AddAssignment]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_AddAssignment]
(
	@Task_ID	INT,
	@AssignedToUserName	VARCHAR(256),
	@Task_Comment		VARCHAR(500),
	@AssignedByUsername VARCHAR(256) = NULL
)
AS
BEGIN
IF EXISTS(SELECT * FROM ERC_Tasks WHERE Task_ID = @Task_ID)
	BEGIN
		INSERT INTO ERC_TaskAssignment(SubTask_ID, AssignedToUsername, AssignedByUsername, Task_Comment) 
		SELECT SubTask_ID, @AssignedToUserName, @AssignedByUsername, @Task_Comment FROM  ERC_SubTasks WHERE Task_ID = @Task_ID 

		UPDATE ERC_Tasks SET TaskAssignedBy = @AssignedByUsername, TaskAssignedTo = @AssignedToUserName WHERE Task_ID = @Task_ID
	END

END

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteTask]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_DeleteTask]
(
	@Task_ID			INT
)
AS
BEGIN

 DELETE FROM ERC_SubTasks WHERE Task_ID = @Task_ID
 
	DELETE FROM ERC_Tasks 	WHERE Task_ID = @Task_ID		
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[USP_EditTask]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_EditTask]
(
	@Task_ID			INT,
	@Task_Title	VARCHAR(500),
	@Task_Description	VARCHAR(MAX),
	@Task_DueDate		DATETIME,	
	@Task_Status		INT,
	@StartDate			DATETIME = NULL
	
)
AS
BEGIN
	UPDATE ERC_Tasks SET 
		Task_Title = @Task_Title,
		Task_Description = @Task_Description,
		Task_DueDate = @Task_DueDate,
		Task_Status = @Task_Status,
		StartDate = @StartDate
	WHERE Task_ID = @Task_ID
END


GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllSubTaskByID]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_GetAllSubTaskByID]
(
        @Task_ID int
)
AS
BEGIN
        SELECT DISTINCT
        tt.Task_ID,
        tt.SubTask_ID,
        tt.Task_Title,
        tt.Task_Description,
        tt.Task_DueDate TaskDueDate,
        (SELECT TOP 1 AssignedToUsername FROM ERC_TaskAssignment WHERE SubTask_ID = tt.SubTask_ID ORDER BY SubTask_ID DESC)  AssignedTo,
        (SELECT TOP 1 AssignedByUsername FROM ERC_TaskAssignment WHERE SubTask_ID = tt.SubTask_ID ORDER BY SubTask_ID DESC)  AssignedBy,

        tt.CreatedDate,
        tt.Task_Status,
        tt.StartDate

        FROM ERC_SubTasks tt WITH(NOLOCK)
        WHERE tt.Task_ID = @Task_ID
END

GO
/****** Object:  Table [ERCTasks].[Description]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ERCTasks].[Description](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NULL,
	[AdminId] [int] NULL,
	[TaskDesc] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Description_CreatedDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Description] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ERCTasks].[MeetingHistory]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ERCTasks].[MeetingHistory](
	[UserId] [int] NOT NULL,
	[MeetingDescription] [varchar](max) NOT NULL,
	[MeetingDate] [datetime] NOT NULL CONSTRAINT [DF_MeetingHistory_MeetingDate]  DEFAULT (getdate()),
	[NextScheduledMeeting] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ERCTasks].[SLALog]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ERCTasks].[SLALog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[SLAMet] [bit] NOT NULL CONSTRAINT [DF_SLALog_SLAMet]  DEFAULT ((0)),
	[SubmittedByUserId] [int] NOT NULL,
	[SubmittedTime] [datetime2](7) NOT NULL,
	[Created] [date] NOT NULL CONSTRAINT [DF_SLALog_Created]  DEFAULT (getdate()),
 CONSTRAINT [PK_SLALog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ERCTasks].[Tags]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [ERCTasks].[Tags](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[tag] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ERCTasks].[TaskAdminUsers]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ERCTasks].[TaskAdminUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AdminUserId] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ERCTasks].[Tasks]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ERCTasks].[Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[TaskDesc] [varchar](max) NOT NULL,
	[TaskDueDate] [datetime2](7) NULL,
	[TaskDueHour] [int] NULL,
	[TaskDueMinutes] [int] NULL,
	[RecurrencePattern] [varchar](128) NULL,
	[RecurrenceBusinessDayStep] [int] NOT NULL,
	[TaskName] [varchar](512) NOT NULL,
	[Customer] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Tasks_CreatedDate]  DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ERCTasks].[TaskTags]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ERCTasks].[TaskTags](
	[TagId] [int] NOT NULL,
	[TaskId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ERCTasks].[TaskUsers]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ERCTasks].[TaskUsers](
	[UserId] [int] NOT NULL,
	[TaskId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ERCTasks].[UserCredential]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ERCTasks].[UserCredential](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](200) NULL,
	[Password] [varchar](200) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_UserCredential] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [ERCTasks].[Users]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [ERCTasks].[Users](
	[UserId] [int] NOT NULL,
	[UserRole] [varchar](128) NOT NULL CONSTRAINT [DF_Users_UserRole]  DEFAULT ('user'),
	[UserName] [varchar](128) NOT NULL,
	[DisplayName] [varchar](128) NOT NULL,
	[Email] [varchar](256) NOT NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_Users_CreatedDate]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[V_GetAllSubTaskByID]    Script Date: 12/9/2015 5:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_GetAllSubTaskByID]
AS
	SELECT DISTINCT
	tt.Task_ID ID,
	tt.SubTask_ID,
	tt.Task_Title,
	tt.Task_Description,	
	tt.Task_DueDate TaskDueDate,
	(SELECT TOP 1 AssignedToUsername  FROM ERC_TaskAssignment WHERE Task_ID   = tt.Task_ID ORDER BY Assignment_ID DESC  ) AssignedTo,
	tt.CreatedDate,
	tt.Task_Status,
	tt.StartDate,
	(((DATEDIFF(D, tt.StartDate, GETDATE())*100)/(DATEDIFF(D, tt.StartDate, tt.Task_DueDate)))) PercentComplete
	FROM ERC_Tasks tt WITH(NOLOCK)

GO
SET IDENTITY_INSERT [ERCTasks].[Description] ON 

INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (1, 1025, 0, N'asd sadsad sadsad sad s', CAST(N'2015-12-03 16:39:42.050' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2, 1026, 1, N'asdsadas', CAST(N'2015-12-03 16:45:40.020' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (3, 1025, 1, N'asd sadsad sadsad sad s sa das sadsadsa dsadsadsadsa dsadasdsa sad sasdsa sads adsad sadsad sad sadds da asdsasa dsa dsaas', CAST(N'2015-12-03 16:59:44.037' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (4, 1025, 1, N'asd sadsad sadsad sad s sa das sadsadsa dsadsadsadsa dsadasdsa sad sasdsa sads adsad', CAST(N'2015-12-03 17:02:51.340' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (5, 1025, 1, N'TRESemmé India brings to you hairstyles from the Cannes Film Festival, presented by Yahoo Red Carpet Studio!', CAST(N'2015-12-03 17:06:11.700' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (1002, 1025, 1, N'TRESemmé India brings to you hairstyles from the Cannes Film Festival, presented by Yahoo Red Carpet Studio! sanyoggg', CAST(N'2015-12-03 20:43:17.683' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (1003, 1025, 1, N'ttttt', CAST(N'2015-12-03 20:47:02.677' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (1004, 1025, 1, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate as Russia reels from an', CAST(N'2015-12-03 20:48:29.097' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (1005, 1026, 2, N'asdsadas vikas', CAST(N'2015-12-03 21:00:26.417' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2002, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the', CAST(N'2015-12-04 16:03:43.583' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2003, 1007, 1, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customers need to', CAST(N'2015-12-04 16:03:49.683' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2004, 1, 1, N'asdsad sasad', CAST(N'2015-12-04 16:03:54.643' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2005, 1011, 1, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I', CAST(N'2015-12-04 16:10:49.970' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2006, 1025, 1, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate as Russia reels from and sanyog', CAST(N'2015-12-04 17:04:27.087' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2007, 1025, 1, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate.', CAST(N'2015-12-04 17:22:20.333' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2008, 1, 1, N'asdsad sasad', CAST(N'2015-12-04 19:05:30.897' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2009, 1, 1, N'asdsad sasad', CAST(N'2015-12-04 19:32:53.753' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2010, 1024, 1, N'RP Singh couldn’t rev up much from the track that had a greenish tinge but didn’t throw up any noteworthy movement off it. At least, neither Singh nor Rush Kalaria managed any. Singh knew the morning session was his only', CAST(N'2015-12-04 20:47:27.967' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2011, 1012, 1, N'Eagle-eyed, the instructor surveyed Gaza''s latest crop of would-be ballerinas. Fifty girls aged five to eight are now enrolled in the', CAST(N'2015-12-04 20:47:53.227' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2012, 1012, 1, N'Eagle-eyed, the instructor surveyed Gaza''s latest crop of would-be ballerinas. Fifty girls aged five to eight are now enrolled in the pank', CAST(N'2015-12-04 21:35:37.663' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2013, 1012, 1, N'Eagle-eyed, the instructor surveyed Gaza''s latest crop of would-be ballerinas. Fifty girls aged five to eight are now enrolled in the pankaj', CAST(N'2015-12-04 21:35:50.597' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2014, 1025, 1, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate.
hbkklk', CAST(N'2015-12-04 22:22:41.860' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2015, 1025, 1005, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate.
hbkklk dhjhkgf', CAST(N'2015-12-04 22:25:18.397' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2016, 3027, 1, N'A powerful Indian politician was ridiculed on Sunday over her role in deadly floods that have swept through her southern Tamil Nadu state, as frustration mounts over the disaster. Thousands of residents have been rescued in Tamil Nadu since record rains last week worsened flooding that has claimed nearly 300 lives across the state since November 9. The international airport in the state capital Chennai reopened on Sunday days after most of the city of more than four million was left underwater, knocking out power and phone networks.
AFP', CAST(N'2015-12-07 17:13:45.870' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2017, 1007, 1, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customers need to', CAST(N'2015-12-07 19:43:39.620' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2018, 1007, 1, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customers need to', CAST(N'2015-12-07 19:43:50.573' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2019, 1011, 1, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I', CAST(N'2015-12-07 19:44:09.253' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2020, 1011, 1, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I', CAST(N'2015-12-07 19:44:20.257' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2021, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the', CAST(N'2015-12-07 19:54:05.820' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2022, 2026, 1005, N'ha le lu ya', CAST(N'2015-12-07 20:15:38.600' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2023, 1024, 1, N'RP Singh couldn’t rev up much from the track that had a greenish tinge but didn’t throw up any noteworthy movement off it. At least, neither Singh nor Rush Kalaria managed any. Singh knew the morning session was his only', CAST(N'2015-12-07 20:25:56.483' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2024, 1006, 1, N'asdfsdfds', CAST(N'2015-12-07 21:26:53.147' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2025, 1006, 1, N'asdfsdfds', CAST(N'2015-12-07 21:44:29.867' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2026, 1020, 1, N'sadsa sad ad sad sa', CAST(N'2015-12-04 22:29:22.260' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2027, 1020, 1, N'sadsa sad ad sad sa', CAST(N'2015-12-04 22:29:29.200' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2028, 1011, 1, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I have', CAST(N'2015-12-04 22:29:42.820' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2029, 1011, 1, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I have a', CAST(N'2015-12-04 22:31:22.350' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2030, 1006, 1, N'asdfsdfds', CAST(N'2015-12-07 23:12:37.653' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2031, 1006, 1, N'asdfsdfds', CAST(N'2015-12-07 23:16:54.863' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2032, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters', CAST(N'2015-12-07 23:19:40.857' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2033, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters', CAST(N'2015-12-07 23:20:22.980' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2034, 3027, 1, N'A powerful Indian politician was ridiculed on Sunday over her role in deadly floods that have swept through her southern Tamil Nadu state, as frustration mounts over the disaster. Thousands of residents have been rescued in Tamil Nadu since record rains last week worsened flooding that has claimed nearly 300 lives across the state since November 9. The international airport in the state capital Chennai reopened on Sunday days after most of the city of more than four million was left underwater, knocking out power and phone networks.
AFP', CAST(N'2015-12-08 17:11:39.533' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2035, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters', CAST(N'2015-12-08 17:21:29.670' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2036, 1009, 2, N'Many stars have been in limelight for indirectly misbehaving with their fans, one such incident has happened with Govinda', CAST(N'2015-12-08 20:36:01.147' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2037, 1009, 2, N'Many stars have been in limelight for indirectly misbehaving with their fans, one such incident has happened with Govinda', CAST(N'2015-12-08 20:36:13.287' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2038, 1009, 2, N'Many stars have been in limelight for indirectly misbehaving with their fans, one such incident has happened with Govinda', CAST(N'2015-12-08 21:24:49.187' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2039, 1007, 1, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customers need to SANY', CAST(N'2015-12-08 21:33:50.173' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2040, 1007, 1, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customers', CAST(N'2015-12-08 21:37:26.287' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2041, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of thee', CAST(N'2015-12-09 15:20:20.353' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2042, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the FDSFDSFSD sfdsf dsf sd', CAST(N'2015-12-09 15:59:08.290' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2043, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations', CAST(N'2015-12-09 16:00:13.900' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2044, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the ad', CAST(N'2015-12-09 16:01:22.770' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2045, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of', CAST(N'2015-12-09 16:04:23.793' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2046, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the F', CAST(N'2015-12-09 16:06:02.867' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2047, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the Fa', CAST(N'2015-12-09 16:06:30.097' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2048, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the Fan', CAST(N'2015-12-09 16:09:06.103' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2049, 1010, 1, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the Fann', CAST(N'2015-12-09 16:09:27.837' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2050, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters.sa', CAST(N'2015-12-09 16:13:44.160' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2051, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters.saa', CAST(N'2015-12-09 16:18:22.480' AS DateTime))
INSERT [ERCTasks].[Description] ([id], [TaskId], [AdminId], [TaskDesc], [CreatedDate]) VALUES (2052, 1006, 1, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters.saas', CAST(N'2015-12-09 16:19:44.680' AS DateTime))
SET IDENTITY_INSERT [ERCTasks].[Description] OFF
INSERT [ERCTasks].[MeetingHistory] ([UserId], [MeetingDescription], [MeetingDate], [NextScheduledMeeting]) VALUES (2, N'Discussion on call making efficiency', CAST(N'2015-11-30 21:18:26.647' AS DateTime), CAST(N'2015-11-20 22:30:36.237' AS DateTime))
INSERT [ERCTasks].[MeetingHistory] ([UserId], [MeetingDescription], [MeetingDate], [NextScheduledMeeting]) VALUES (3, N'discussion on achieving recovery targets with in fixed time period', CAST(N'2015-11-30 21:19:02.223' AS DateTime), CAST(N'2015-11-20 22:30:36.237' AS DateTime))
INSERT [ERCTasks].[MeetingHistory] ([UserId], [MeetingDescription], [MeetingDate], [NextScheduledMeeting]) VALUES (4, N'discussion on practises to employ for better quality of call making', CAST(N'2015-11-30 21:19:41.880' AS DateTime), CAST(N'2015-11-20 22:30:36.237' AS DateTime))
INSERT [ERCTasks].[MeetingHistory] ([UserId], [MeetingDescription], [MeetingDate], [NextScheduledMeeting]) VALUES (5, N'discussion on verbal challenges faced by callers', CAST(N'2015-11-30 21:21:21.450' AS DateTime), CAST(N'2015-11-20 22:30:36.237' AS DateTime))
SET IDENTITY_INSERT [ERCTasks].[SLALog] ON 

INSERT [ERCTasks].[SLALog] ([Id], [TaskId], [SLAMet], [SubmittedByUserId], [SubmittedTime], [Created]) VALUES (1, 1, 1, 1, CAST(N'2015-11-27 18:38:40.0200000' AS DateTime2), CAST(N'2015-11-27' AS Date))
SET IDENTITY_INSERT [ERCTasks].[SLALog] OFF
SET IDENTITY_INSERT [ERCTasks].[Tags] ON 

INSERT [ERCTasks].[Tags] ([TagId], [tag]) VALUES (1, N'Hello')
INSERT [ERCTasks].[Tags] ([TagId], [tag]) VALUES (5, N'hi')
SET IDENTITY_INSERT [ERCTasks].[Tags] OFF
SET IDENTITY_INSERT [ERCTasks].[Tasks] ON 

INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1, N'asdsad sasad', NULL, 23, 53, N'Daily', 1, N'Is a positive integer or bigint expression', N'Nokia', CAST(N'2015-12-04 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2, N'New Delhi, Nov. 20 (ANI): The Bharatiya Janata Party (BJP) on Friday lashed out at Congress vice president Rahul Gandhi over his ''56-inch chest'' and ''lackeys'' remark and warned the latter', NULL, 23, 53, N'Daily', 1, N'BJP warns Rahul about using words like ''chamcha'', ''sycophants''', N'', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (3, N'Issue Tracker', CAST(N'2015-11-25 00:00:00.0000000' AS DateTime2), 23, 54, N'Weekly', 2, N'Issue Tracker', N'ERC', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1003, N'this is regarding timely collection', CAST(N'2015-11-30 00:00:00.0000000' AS DateTime2), 22, 42, N'Weekly', 2, N'My new TAsk', N'vikas', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1004, N'essential task', CAST(N'2015-12-15 00:00:00.0000000' AS DateTime2), 22, 15, N'Monthly', 3, N'prime task', N'', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1005, N'A weighted task', CAST(N'2015-11-30 00:00:00.0000000' AS DateTime2), 23, 15, N'Daily', 3, N'Task boss', N'abc company', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1006, N'NEW DELHI/ALMATY (Reuters) - An earthquake measuring 7.2 magnitude struck Tajikistan on Monday, shaking buildings as far away as the Indian capital of New Delhi and in Pakistan, the U.S. Geological Survey and witnesses said. A spokesman for Tajikistan''s Emergencies Committee said it had no information so far on any casualties or damage from the quake. The quake did not affect Russian military bases in Tajikistan, RIA news agency reported, citing Russia''s defence ministry.
Reuters.saas', CAST(N'2015-12-09 00:00:00.0000000' AS DateTime2), 23, 45, N'Daily', 1, N'sanyog task', N'Samsung', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1007, N'OnePlus has tied up with refurbishing website ReGlobe to introduce an exchange and buyback offer on old smartphones. It will offer invites for the new OnePlus 2, OnePlus X under the scheme. The offer is valid only till December 31, 2015 and customerss', CAST(N'2015-12-09 00:00:00.0000000' AS DateTime2), 23, 58, N'Daily', 1, N'Get OnePlus phones on buyback scheme', N'I-Phone', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1008, N'A sedan, an eatery on Pakmodia Street and tenancy rights to a property in Matunga, once owned by underworld don Dawood Ibrahim, will go for auction on December 9. The auction to be carried out by a private firm under the Smugglers & Foreign Exchange Manipulators (Forfeiture of Properties) Act 1976 will be the second time that some of his properties in Mumbai go under the hammer. Four more properties in Nani Daman will be auctioned too.
The Indian Express', NULL, 24, 58, N'Daily', 1, N'Dawood’s properties set to go under the hammer next week', N'HERO', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1009, N'Many stars have been in limelight for indirectly misbehaving with their fans, one such incident has happened with Govinda', CAST(N'2015-12-19 00:00:00.0000000' AS DateTime2), 23, 58, N'Daily', 1, N'Supreme Court Ordered Govinda To Apologize To The Fan He Slapped In 2008', N'India Times', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1010, N'New Delhi, Dec.1 (ANI): Railway engineers from across the country gathered at the Jantar Mantar area of central Delhi on Tuesday to voice their objections to the recommendations of the Fann', CAST(N'2015-12-13 00:00:00.0000000' AS DateTime2), 23, 58, N'Daily', 1, N'Railway engineers condemn 7th Pay Commission, present 27 demands', N'Railways', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1011, N'Karachi: Former Pakistan captain and batting great, Javed Miandad believes that the Pakistan Cricket Board (PCB) should tread carefully while dealing with the Indian cricket board (BCCI) over the planned bilateral series in December. “I have a', CAST(N'2015-12-31 00:00:00.0000000' AS DateTime2), 23, 58, N'Daily', 1, N'Javed Miandad warns PCB to be wary of BCCI’s commitments', N'Cricket', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1012, N'Eagle-eyed, the instructor surveyed Gaza''s latest crop of would-be ballerinas. Fifty girls aged five to eight are now enrolled in the pankaj', NULL, 23, 56, N'Daily', 1, N'Pirouettes and plenty of pink at Gaza''s only ballet school', N'Pirouettes', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1013, N'New Delhi, Nov 30 (IANS) Carmaker Maruti Suzuki India on Monday said dual airbags and anti-lock braking system (ABS) are now available as an option across its Celerio variant of cars, including the base version.
IANS India Private Limited/Yahoo India News', NULL, 23, 57, N'Daily', 1, N'Maruti Suzuki now offers ABS, airbags in Celerio', N'Maruti', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1014, N'Former British Prime Minister Margaret Thatcher is the most influential woman of the past 200 years, according to a survey of Britons published on Tuesday which showed men place a higher value on political influence than women do', NULL, 23, 58, N'Daily', 1, N'Britons vote Thatcher most influential woman of past 200 years', N'Britons', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1019, N'dsf dsfdsassad sd sad sa', NULL, 23, 58, N'Daily', 1, N'sdsdfsdf', N'World4', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1020, N'sadsa sad ad sad sa', NULL, 23, 58, N'Daily', 1, N'sasadasdas', N'World5', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1021, N'ads sads adasdasd', NULL, 23, 58, N'Daily', 1, N'asd ssad sad sadsad', N'Vikas World6', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1022, N'asd sad sadsadsa dsad', NULL, 23, 58, N'Daily', 1, N'sada sad sadsa sa', N'Vikas World7', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1023, N'sadsa sadsa sadsa dsa sadsad sad', NULL, 23, 58, N'Daily', 1, N'dsfs dsfd sfsd f', N'Vikas World8', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1024, N'RP Singh couldn’t rev up much from the track that had a greenish tinge but didn’t throw up any noteworthy movement off it. At least, neither Singh nor Rush Kalaria managed any. Singh knew the morning session was his only', CAST(N'2015-12-09 00:00:00.0000000' AS DateTime2), 23, 58, N'Daily', 1, N'Ranji Trophy 2015-16: Twin tons spell trouble for Gujarat', N'Cricket', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1015, N'New Delhi, Dec 1 (IANS) Millions of people across the globe are risking their lives this year to reach Karbala, in Iraq, to mark "Chehlum" - the 40th day after the death of Imam Hussain - even as threats from terror group Islamic State (IS) loom large. Also known as Arbaeen, the Shia Muslim religious observance is being seen as a statement of defiance in the face of the IS militant group which has grown in strength from year to year. The Sunni-Shia split in Islam happened after the death of Prophet Muhammad in 632 AD, leading to a dispute over succession, although both the groups consider the Quran to be divine The Arbaeen is the world''s largest annual gathering and far exceeds the number of visitors to Mecca for the Haj -- which draws around two million devouts.
IANS India Private Limited/Yahoo India News', NULL, 23, 58, N'Daily', 1, N'World''s largest annual pilgrimage on in Iraq despite threat of IS attacks', N'World', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1016, N'asdas s sadas ad asdsad sad', NULL, 23, 58, N'Daily', 1, N'sadasdsada', N'World1', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1017, N'asdsadsad sadsa', NULL, 23, 58, N'Daily', 1, N'sdasadsada', N'Woeld2', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1018, N'asdsad sa sasad sad', NULL, 23, 58, N'Daily', 1, N'fsdfsdfds fsd', N'World3', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1025, N'President Vladimir Putin on Thursday called on lawmakers to extend an amnesty for people who illegally spirited funds out of the country and improve the business climate.
hbkklk dhjhkgf', NULL, NULL, NULL, N'Daily', 1, N'Get the (IM)PERFECT chic look from the Red Carpet', N'Test', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (1026, N'asdsadas vikas', NULL, NULL, NULL, N'Daily', 1, N'test', N'asdasd', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2025, N'important task high priority', CAST(N'2015-12-15 00:00:00.0000000' AS DateTime2), 24, 17, N'Daily', 1, N'vaishaki bumper', N'sdfsdf', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2026, N'ha le lu ya', CAST(N'2015-12-07 00:00:00.0000000' AS DateTime2), 24, 59, N'Daily', 1, N'new Eternal life', N'sdfdsf', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2027, N'itna time kahan hai', CAST(N'2015-12-23 00:00:00.0000000' AS DateTime2), 24, 18, N'Daily', 1, N'mehu', N'sdfdsf', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2028, N'sdfsdfds', CAST(N'2015-12-23 00:00:00.0000000' AS DateTime2), 23, 17, N'Daily', 1, N'nadeem', N'sdfsdf', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (2029, N'sdffugyugh', CAST(N'2015-12-24 00:00:00.0000000' AS DateTime2), 24, 17, N'Daily', 1, N'hamilton', N'sdfdsf', CAST(N'2015-11-30 00:00:00.000' AS DateTime))
INSERT [ERCTasks].[Tasks] ([TaskId], [TaskDesc], [TaskDueDate], [TaskDueHour], [TaskDueMinutes], [RecurrencePattern], [RecurrenceBusinessDayStep], [TaskName], [Customer], [CreatedDate]) VALUES (3027, N'A powerful Indian politician was ridiculed on Sunday over her role in deadly floods that have swept through her southern Tamil Nadu state, as frustration mounts over the disaster. Thousands of residents have been rescued in Tamil Nadu since record rains last week worsened flooding that has claimed nearly 300 lives across the state since November 9. The international airport in the state capital Chennai reopened on Sunday days after most of the city of more than four million was left underwater, knocking out power and phone networks.
AFP', CAST(N'2015-12-09 00:00:00.0000000' AS DateTime2), NULL, NULL, N'Daily', 1, N'Top India politician faces criticism over deadly floods', N'India politician', CAST(N'2015-12-07 17:13:44.600' AS DateTime))
SET IDENTITY_INSERT [ERCTasks].[Tasks] OFF
INSERT [ERCTasks].[TaskTags] ([TagId], [TaskId]) VALUES (1, 1)
INSERT [ERCTasks].[TaskTags] ([TagId], [TaskId]) VALUES (5, 1025)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (123, 1)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (123, 2)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 3)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (4, 1)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1003)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (4, 1003)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (5, 1007)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1004)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (5, 1)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (4, 1006)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1005)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (5, 1005)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1007)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 1008)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (5, 1013)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (2, 1009)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1020)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1010)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1021)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 0)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (2, 1023)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1011)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (3, 1024)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1026)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 2025)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (3, 1012)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (2, 1026)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 2026)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 2027)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 2028)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1005, 2029)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 3027)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1006)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (5, 1014)
INSERT [ERCTasks].[TaskUsers] ([UserId], [TaskId]) VALUES (1, 1015)
SET IDENTITY_INSERT [ERCTasks].[UserCredential] ON 

INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (1, N'Sanyogk', N'sanyog', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (2, N'vikas', N'viku', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (3, N'pakaj', N'vikuasdsad', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (4, N'ravik', N'ravik', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (5, N'Anil123', N'anil123', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (1005, N'vishals', N'vishals', 1)
INSERT [ERCTasks].[UserCredential] ([Id], [UserName], [Password], [isActive]) VALUES (1006, N'Vinodk', N'vinodk', 1)
SET IDENTITY_INSERT [ERCTasks].[UserCredential] OFF
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (1, N'admin', N'Sanyogk', N'Sanyog Kumar', N'sanyogseo@gmail.com', CAST(N'2015-11-20 22:30:36.237' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (2, N'user', N'vikas', N'Vikas Pathani', N'viku@gmail.com', CAST(N'2015-11-20 22:40:45.087' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (3, N'user', N'pakaj', N'pankajk', N'punkaj@gmail.com', CAST(N'2015-11-20 22:48:38.960' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (4, N'user', N'ravik', N'ravi kumar', N'ravi@kk.com', CAST(N'2015-11-23 18:21:18.100' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (5, N'user', N'Anil123', N'Anil Sharma', N'anil@gmail.com', CAST(N'2015-11-24 21:54:44.597' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (1005, N'manager', N'vishals', N'Vishal sharma', N'Vishal@gmail.com', CAST(N'2015-12-01 16:52:11.137' AS DateTime))
INSERT [ERCTasks].[Users] ([UserId], [UserRole], [UserName], [DisplayName], [Email], [CreatedDate]) VALUES (1006, N'user', N'Vinodk', N'Vinod Kumar', N'vinod@gmail.com', CAST(N'2015-12-07 21:23:01.600' AS DateTime))
ALTER TABLE [ERCTasks].[MeetingHistory]  WITH CHECK ADD  CONSTRAINT [FK_MeetingHistory_UserCredential] FOREIGN KEY([UserId])
REFERENCES [ERCTasks].[UserCredential] ([Id])
GO
ALTER TABLE [ERCTasks].[MeetingHistory] CHECK CONSTRAINT [FK_MeetingHistory_UserCredential]
GO
ALTER TABLE [ERCTasks].[TaskAdminUsers]  WITH CHECK ADD  CONSTRAINT [FK_TaskAdminUsers_UserCredential] FOREIGN KEY([AdminUserId])
REFERENCES [ERCTasks].[UserCredential] ([Id])
GO
ALTER TABLE [ERCTasks].[TaskAdminUsers] CHECK CONSTRAINT [FK_TaskAdminUsers_UserCredential]
GO
ALTER TABLE [ERCTasks].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserCredential] FOREIGN KEY([UserId])
REFERENCES [ERCTasks].[UserCredential] ([Id])
GO
ALTER TABLE [ERCTasks].[Users] CHECK CONSTRAINT [FK_Users_UserCredential]
GO
USE [master]
GO
ALTER DATABASE [collect2000] SET  READ_WRITE 
GO
