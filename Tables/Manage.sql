CREATE TABLE [dbo].[Manage]
( [ProjectId] UNIQUEIDENTIFIER NOT NULL,
  [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
  CONSTRAINT [PK_Manage] PRIMARY KEY ([ProjectId], [EmployeeId])
)
