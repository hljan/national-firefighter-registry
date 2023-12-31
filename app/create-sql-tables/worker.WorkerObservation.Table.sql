/****** Object:  Table [worker].[WorkerObservation]    Script Date: 11/4/2020 1:40:53 PM ******/
CREATE TABLE [worker].[WorkerObservation](
	[StudyCode] [varchar](50) NOT NULL,
	[Period] [varchar](50) NOT NULL,
	[EventId] [varchar](50) NOT NULL,
	[StandardizedCode] [varchar](200) NOT NULL,
	[WorkerID] [varchar](40) NOT NULL,
	[DateCollected] [varchar](10) NOT NULL,
	[TimeCollected] [varchar](12) NOT NULL,
	[UCUMCode] [varchar](20) NULL,
	[UnitsMeasureOriginal] [varchar](20) NULL,
	[ObservationResultTypeCode] [varchar](20) NULL,
	[ObservationResultValueNumeric] [decimal](15, 5) NULL,
	[ObservationResultValueChar] [varchar](50) NULL,
	[ObservationLowValueNumeric] [decimal](15, 5) NULL,
	[ObservationHighValueNumeric] [decimal](15, 5) NULL,
	[ObservationRangeAlpha] [varchar](200) NULL,
	[ObservationRangeLowNumeric] [decimal](15, 5) NULL,
	[ObservationRangeHighNumeric] [decimal](15, 5) NULL,
	[ObservationResultStatusCode] [varchar](20) NULL,
	[DateOfService] [date] NULL,
	[DateOrdered] [date] NULL,
	[CollectionSite] [varchar](200) NULL,
	[Comments] [varchar](2000) NULL,
	[ImportCode] [varchar](2500) NULL,
	[SourceFile] [varchar](2500) NULL,
	[LastUpdateDate] [datetime] NULL,
	[LastUpdatedBy] [varchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL,
 CONSTRAINT [PK_WorkerLabTest] PRIMARY KEY CLUSTERED 
(
	[StudyCode] ASC,
	[Period] ASC,
	[EventId] ASC,
	[StandardizedCode] ASC,
	[WorkerID] ASC,
	[DateCollected] ASC,
	[TimeCollected] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [worker].[WorkerObservation] ADD  CONSTRAINT [DF_WorkerLabTest_LastUpdateDate]  DEFAULT (getdate()) FOR [LastUpdateDate]
GO
ALTER TABLE [worker].[WorkerObservation] ADD  CONSTRAINT [DF_WorkerLabTest_LastUpdatedBy]  DEFAULT (suser_sname()) FOR [LastUpdatedBy]
GO
ALTER TABLE [worker].[WorkerObservation] ADD  CONSTRAINT [DF_WorkerLabTest_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [worker].[WorkerObservation] ADD  CONSTRAINT [DF_WorkerLabTest_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
/****** Object:  Trigger [worker].[WorkerObservationLastUpdated]    Script Date: 11/4/2020 1:41:16 PM ******/
create TRIGGER [worker].[WorkerObservationLastUpdated]
    ON [worker].[WorkerObservation]
    FOR UPDATE, INSERT
    AS BEGIN
           UPDATE Worker.WorkerObservation
           SET    LastUpdateDate = getdate(),
                  LastUpdatedBy  = suser_name()
           FROM   inserted AS i
                  INNER JOIN
                  Worker.WorkerObservation AS a
                  ON i.StudyCode = a.StudyCode
                     AND i.Period = a.Period
                     AND i.EventId = a.EventId
                     AND i.StandardizedCode = a.StandardizedCode
                     AND i.WorkerId = a.WorkerId
                     AND i.DateCollected = a.DateCollected
                     AND i.TimeCollected = a.TimeCollected;
       END
GO
ALTER TABLE [worker].[WorkerObservation] ENABLE TRIGGER [WorkerObservationLastUpdated]
GO
