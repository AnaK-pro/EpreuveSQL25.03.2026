CREATE PROCEDURE [dbo].[Sp_GetAvailableEmployees]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.[EmployeeId],
        e.[Firstname],
        e.[Lastname],
        e.[Hiredate],
        e.[IsProjectManager]
    FROM [dbo].[Employee] e
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dbo].[TakePart] tp
        WHERE tp.[EmployeeId] = e.[EmployeeId]
          AND (tp.[EndDate] IS NULL OR tp.[EndDate] >= GETDATE())
    )
    ORDER BY e.[Lastname], e.[Firstname];
END