USE [DFSE_FRB_WORKER]
GO
/****** Object:  Table [worker].[Worker]    Script Date: 11/4/2020 1:40:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [worker].[Worker](
	[WorkerID] [varchar](30) NOT NULL,
	[StudyCode] [varchar](50) NOT NULL,
	[GenderCode] [varchar](20) NULL,
	[EthnicityCode] [varchar](20) NULL,
	[StatusCode] [nvarchar](1) NULL,
	[CurrentResidentialStreet] [varchar](500) NULL,
	[CurrentResidentialCity] [varchar](50) NULL,
	[CurrentResidentialStateProv] [varchar](50) NULL,
	[CurrentResidentialPostalCode] [varchar](10) NULL,
	[CurrentResidentialCountry] [varchar](50) NULL,
	[BirthDate]  AS (case when isdate(((([Birthyear]+'-')+[BirthMonth])+'-')+[BirthDay])=(1) then CONVERT([date],((([Birthyear]+'-')+[BirthMonth])+'-')+[BirthDay],(111))  end),
	[BirthMonth] [varchar](2) NULL,
	[BirthDay] [varchar](2) NULL,
	[Birthyear] [varchar](4) NULL,
	[BirthPlaceCountry] [varchar](50) NULL,
	[BirthPlaceCity] [varchar](50) NULL,
	[BirthPlaceStateProv] [varchar](50) NULL,
	[LastObservedDate]  AS (case when isdate(((([LastObservedyear]+'-')+[LastObservedMonth])+'-')+[LastObservedDay])=(1) then CONVERT([date],((([LastObservedyear]+'-')+[LastObservedMonth])+'-')+[LastObservedDay],(111))  end),
	[LastObservedMonth] [varchar](2) NULL,
	[LastObservedDay] [varchar](2) NULL,
	[LastObservedyear] [varchar](4) NULL,
	[SSN] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastNameAlias] [varchar](50) NULL,
	[FirstNameAlias] [varchar](50) NULL,
	[MiddleNameAlias] [varchar](50) NULL,
	[Site] [varchar](50) NULL,
	[DiagnosedWithCancer] [bit] NULL,
	[DiagnosedWithCancerStateProv] [varchar](50) NULL,
	[PrimaryEmailAddress] [varchar](300) NULL,
	[OptInEmails] [bit] NULL,
	[MobilePhoneNumber] [varchar](15) NULL,
	[OptInTextMessages] [bit] NULL,
	[Comments] [varchar](1000) NULL,
	[IdmsID] [int] NULL,
	[ImportCode] [varchar](2500) NULL,
	[SourceFile] [varchar](2500) NULL,
	[LastUpdateDate] [datetime] NULL,
	[LastUpdatedBy] [varchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL,
 CONSTRAINT [PK_Worker] PRIMARY KEY CLUSTERED 
(
	[WorkerID] ASC,
	[StudyCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [worker].[Worker] ADD  CONSTRAINT [DF_Worker_LastUpdateDate]  DEFAULT (getdate()) FOR [LastUpdateDate]
GO
ALTER TABLE [worker].[Worker] ADD  CONSTRAINT [DF_Worker_LastUpdatedBy]  DEFAULT (suser_sname()) FOR [LastUpdatedBy]
GO
ALTER TABLE [worker].[Worker] ADD  CONSTRAINT [DF_Worker_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [worker].[Worker] ADD  CONSTRAINT [DF_Worker_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
ALTER TABLE [worker].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Worker_AdministrativeGender] FOREIGN KEY([GenderCode])
REFERENCES [vs].[AdministrativeGender] ([GenderCode])
GO
ALTER TABLE [worker].[Worker] CHECK CONSTRAINT [FK_Worker_AdministrativeGender]
GO
ALTER TABLE [worker].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Ethnicity] FOREIGN KEY([EthnicityCode])
REFERENCES [vs].[Ethnicity] ([EthnicityCode])
GO
ALTER TABLE [worker].[Worker] CHECK CONSTRAINT [FK_Worker_Ethnicity]
GO
ALTER TABLE [worker].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Study] FOREIGN KEY([StudyCode])
REFERENCES [dbo].[Study] ([StudyCode])
GO
ALTER TABLE [worker].[Worker] CHECK CONSTRAINT [FK_Worker_Study]
GO
/****** Object:  Trigger [worker].[WorkerLastUpdated]    Script Date: 11/4/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [worker].[WorkerLastUpdated]
    ON [worker].[Worker]
    FOR UPDATE, INSERT
    AS BEGIN
           UPDATE Worker.Worker
           SET    LastUpdateDate = getdate(),
                  LastUpdatedBy  = user_name()
           FROM   inserted AS i
                  INNER JOIN
                  Worker.Worker AS a
                  ON i.WorkerID = a.WorkerID
                     AND i.StudyCode = a.StudyCode;
       END
GO
ALTER TABLE [worker].[Worker] ENABLE TRIGGER [WorkerLastUpdated]
GO
