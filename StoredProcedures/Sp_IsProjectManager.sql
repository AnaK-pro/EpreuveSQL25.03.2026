CREATE PROCEDURE [dbo].[Sp_IsProjectManager]
    @EmployeeId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.[EmployeeId],
        e.[Firstname],
        e.[Lastname],
        e.[IsProjectManager]
    FROM [dbo].[Employee] e
    WHERE e.[EmployeeId] = @EmployeeId;
END