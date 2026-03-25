CREATE PROCEDURE [dbo].[Sp_IsProjectManager]
    @EmployeeId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.[EmployeeId],
        e.[FirstName],
        e.[LastName],
        e.[IsProjectManager]
    FROM [dbo].[Employee] e
    WHERE e.[EmployeeId] = @EmployeeId;
END