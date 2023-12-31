/****** Object:  Table [worker].[WorkerFireDepartment]    Script Date: 11/4/2020 1:41:06 PM ******/
CREATE TABLE [worker].[WorkerFireDepartment](
	[WorkerID] [varchar](40) NOT NULL,
	[StudyCode] [varchar](50) NOT NULL,
	[FireDepartmentID] [varchar](20) NOT NULL,
	[HQState] [varchar](10) NOT NULL,
	[StartYear] [int] NOT NULL,
	[StopYear] [int] NULL,
	[NameOther] [varchar](100) NULL,
	[FireDepTypeCode] [varchar](20) NULL,
	[FireDepTypeCodeOther] [varchar](100) NULL,
	[FireDepJurisdictionCodeOther] [varchar](20) NULL,
	[IsPresent] [bit] NULL,
	[WorkStatusCode] [varchar](50) NULL,
	[WorkStatusCodeOther] [varchar](50) NULL,
	[LastUpdateDate] [datetime] NULL,
	[LastUpdatedBy] [varchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL,
 CONSTRAINT [PK_WorkerFireDepartment] PRIMARY KEY CLUSTERED 
(
	[WorkerID] ASC,
	[StudyCode] ASC,
	[FireDepartmentID] ASC,
	[HQState] ASC,
	[StartYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [worker].[WorkerFireDepartment] ADD  CONSTRAINT [DF_WorkerDepartment_LastUpdateDate]  DEFAULT (getdate()) FOR [LastUpdateDate]
GO
ALTER TABLE [worker].[WorkerFireDepartment] ADD  CONSTRAINT [DF_WorkerDepartment_LastUpdatedBy]  DEFAULT (suser_sname()) FOR [LastUpdatedBy]
GO
ALTER TABLE [worker].[WorkerFireDepartment] ADD  CONSTRAINT [DF_WorkerDepartment_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [worker].[WorkerFireDepartment] ADD  CONSTRAINT [DF_WorkerDepartment_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
ALTER TABLE [worker].[WorkerFireDepartment]  WITH CHECK ADD  CONSTRAINT [FK_WorkerFireDepartment_Worker] FOREIGN KEY([WorkerID], [StudyCode])
REFERENCES [worker].[Worker] ([WorkerID], [StudyCode])
GO
ALTER TABLE [worker].[WorkerFireDepartment] CHECK CONSTRAINT [FK_WorkerFireDepartment_Worker]
GO
/****** Object:  Trigger [worker].[WorkerFireDepartmentLastUpdated]    Script Date: 11/4/2020 1:41:15 PM ******/
CREATE TRIGGER [worker].[WorkerFireDepartmentLastUpdated]
    ON [worker].[WorkerFireDepartment]
    FOR UPDATE, INSERT
    AS BEGIN
           UPDATE Worker.WorkerFireDepartment
           SET    LastUpdateDate = getdate(),
                  LastUpdatedBy  = suser_name()
           FROM   inserted AS i
                  INNER JOIN
                  Worker.WorkerFireDepartment AS a
                  ON i.WorkerID = a.WorkerID and
				     i.StudyCode = a.StudyCode and
					 i.FireDepartmentID = a.FireDepartmentID and
					 i.HQState = a.HQState  and
					 i.StartYear = a.StartYear;
       END
GO
ALTER TABLE [worker].[WorkerFireDepartment] ENABLE TRIGGER [WorkerFireDepartmentLastUpdated]
GO
