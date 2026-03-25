CREATE TABLE [dbo].[TakePart]
(
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    [ProjectId]  UNIQUEIDENTIFIER NOT NULL,
    [StartDate]  DATETIME         NOT NULL DEFAULT GETDATE(),
    [EndDate]    DATETIME         NULL,
    CONSTRAINT [PK_TakePart] PRIMARY KEY ([EmployeeId], [ProjectId])
)