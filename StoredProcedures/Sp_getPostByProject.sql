CREATE PROCEDURE [dbo].[Sp_GetPostsByProject]
    @RequesterId UNIQUEIDENTIFIER,
    @ProjectId   UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM [dbo].[TakePart]
        WHERE [EmployeeId] = @RequesterId AND [ProjectId] = @ProjectId
    )
    AND NOT EXISTS (
        SELECT 1 FROM [dbo].[Manage]
        WHERE [EmployeeId] = @RequesterId AND [ProjectId] = @ProjectId
    )
    BEGIN
        RAISERROR('Accès refusé à ce projet.', 16, 1);
        RETURN;
    END

    SELECT
        p.[PostId],
        p.[Subject],
        p.[Content],
        p.[SendDate],
        e.[EmployeeId],
        e.[Firstname],
        e.[Lastname]
    FROM [dbo].[Post] p
    INNER JOIN [dbo].[Concern] c  ON c.[PostId]     = p.[PostId]
    INNER JOIN [dbo].[Write]   w  ON w.[PostId]     = p.[PostId]
    INNER JOIN [dbo].[Employee] e ON e.[EmployeeId] = w.[EmployeeId]
    WHERE c.[ProjectId] = @ProjectId
    ORDER BY p.[SendDate] DESC;
END