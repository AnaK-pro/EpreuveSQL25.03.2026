CREATE PROCEDURE [dbo].[sp_AddEmployeeToProject]
    @EmployeeId UNIQUEIDENTIFIER,
    @ProjectId  UNIQUEIDENTIFIER,
    @StartDate  DATE = NULL,
    @EndDate    DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Employee] WHERE [EmployeeId] = @EmployeeId)
    BEGIN
        RAISERROR('Employé introuvable.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Project] WHERE [ProjectId] = @ProjectId)
    BEGIN
        RAISERROR('Projet introuvable.', 16, 1);
        RETURN;
    END

  
    IF EXISTS (
        SELECT 1 FROM [dbo].[TakePart]
        WHERE [EmployeeId] = @EmployeeId
          AND ([EndDate] IS NULL OR [EndDate] >= GETDATE())
    )
    BEGIN
        RAISERROR('Cet employée est déjà affectée à un projet.', 16, 1);
        RETURN;
    END

    INSERT INTO [dbo].[TakePart] ([EmployeeId], [ProjectId], [StartDate], [EndDate])
    VALUES (@EmployeeId, @ProjectId, ISNULL(@StartDate, GETDATE()), @EndDate);
END