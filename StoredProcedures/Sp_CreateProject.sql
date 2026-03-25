CREATE PROCEDURE [dbo].[Sp_CreateProject]
    @ManagerId   UNIQUEIDENTIFIER,
    @Name        VARCHAR(256),
    @Description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Employee] WHERE [EmployeeId] = @ManagerId AND [IsProjectManager] = 1)
    BEGIN
        RAISERROR('Seul un chef de projet peut créer un projet.', 16, 1);
        RETURN;
    END

    DECLARE @NewProjectId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Project] ([ProjectId], [Name], [Description])
    VALUES (@NewProjectId, @Name, @Description);

    INSERT INTO [dbo].[Manage] ([EmployeeId], [ProjectId])
    VALUES (@ManagerId, @NewProjectId);

    SELECT @NewProjectId AS [ProjectId];
END