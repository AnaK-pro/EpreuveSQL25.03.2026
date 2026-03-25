CREATE TABLE [dbo].[TakePart]
(
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    [ProjectId]  UNIQUEIDENTIFIER NOT NULL,
    [StartDate]  DATE             NOT NULL DEFAULT GETDATE(),
    [EndDate]    DATE             NULL,
    CONSTRAINT [PK_TakePart] PRIMARY KEY ([EmployeeId], [ProjectId])
)