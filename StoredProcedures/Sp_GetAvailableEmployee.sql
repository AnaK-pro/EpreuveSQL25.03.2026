CREATE PROCEDURE [dbo].[Sp_GetAvailableEmployees]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.[EmployeeId],
        e.[FirstName],
        e.[LastName],
        e.[HireDate],
        e.[IsProjectManager]
    FROM [dbo].[Employee] e
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dbo].[TakePart] tp
        WHERE tp.[EmployeeId] = e.[EmployeeId]
          AND (tp.[EndDate] IS NULL OR tp.[EndDate] >= GETDATE())
    )
    ORDER BY e.[LastName], e.[FirstName];
END