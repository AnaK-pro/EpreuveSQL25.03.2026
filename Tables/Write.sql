CREATE TABLE [dbo].[Write]
(
    [EmployeeId] UNIQUEIDENTIFIER NOT NULL,
    [PostId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Write] PRIMARY KEY ([EmployeeId], [PostId])
)
