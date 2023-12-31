USE [DFSE_FRB_WORKER]
GO
/****** Object:  Table [worker].[WorkerRace]    Script Date: 11/4/2020 1:40:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [worker].[WorkerRace](
	[WorkerID] [varchar](30) NOT NULL,
	[StudyCode] [varchar](50) NOT NULL,
	[RaceCode] [varchar](20) NOT NULL,
	[ImportCode] [varchar](2500) NULL,
	[SourceFile] [varchar](2500) NULL,
	[LastUpdateDate] [datetime] NULL,
	[LastUpdatedBy] [varchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL,
 CONSTRAINT [PK_WorkerRaceEthnicity] PRIMARY KEY CLUSTERED 
(
	[WorkerID] ASC,
	[StudyCode] ASC,
	[RaceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [worker].[WorkerRace] ADD  CONSTRAINT [DF_WorkerRace_LastUpdateDate]  DEFAULT (getdate()) FOR [LastUpdateDate]
GO
ALTER TABLE [worker].[WorkerRace] ADD  CONSTRAINT [DF_WorkerRace_LastUpdatedBy]  DEFAULT (suser_sname()) FOR [LastUpdatedBy]
GO
ALTER TABLE [worker].[WorkerRace] ADD  CONSTRAINT [DF_WorkerRace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [worker].[WorkerRace] ADD  CONSTRAINT [DF_WorkerRace_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
ALTER TABLE [worker].[WorkerRace]  WITH CHECK ADD  CONSTRAINT [FK_WorkerRace_Race] FOREIGN KEY([RaceCode])
REFERENCES [vs].[Race] ([RaceCode])
GO
ALTER TABLE [worker].[WorkerRace] CHECK CONSTRAINT [FK_WorkerRace_Race]
GO
ALTER TABLE [worker].[WorkerRace]  WITH CHECK ADD  CONSTRAINT [FK_WorkerRace_Worker] FOREIGN KEY([WorkerID], [StudyCode])
REFERENCES [worker].[Worker] ([WorkerID], [StudyCode])
GO
ALTER TABLE [worker].[WorkerRace] CHECK CONSTRAINT [FK_WorkerRace_Worker]
GO
/****** Object:  Trigger [worker].[WorkerRaceLastUpdated]    Script Date: 11/4/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [worker].[WorkerRaceLastUpdated]
    ON [worker].[WorkerRace]
    FOR UPDATE, INSERT
    AS BEGIN
           UPDATE worker.WorkerRace
           SET    LastUpdateDate = getdate(),
                  LastUpdatedBy  = user_name()
           FROM   inserted AS i
                  INNER JOIN
                  worker.WorkerRace AS a
                  ON i.WorkerID = a.WorkerID;
                    
       END


GO
ALTER TABLE [worker].[WorkerRace] ENABLE TRIGGER [WorkerRaceLastUpdated]
GO
