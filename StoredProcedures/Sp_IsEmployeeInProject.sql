CREATE PROCEDURE [dbo].[Sp_IsEmployeeInProject]
    @EmployeeId UNIQUEIDENTIFIER,
    @ProjectId  UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM [dbo].[TakePart]
        WHERE [EmployeeId] = @EmployeeId
          AND [ProjectId]  = @ProjectId
    )
        SELECT 1 AS [IsMember];
    ELSE
        SELECT 0 AS [IsMember];
END