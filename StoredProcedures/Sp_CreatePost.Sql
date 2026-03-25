CREATE PROCEDURE [dbo].[sp_CreatePost]
    @EmployeeId UNIQUEIDENTIFIER,
    @ProjectId  UNIQUEIDENTIFIER,
    @Subject    VARCHAR(256),
    @Content    NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM [dbo].[TakePart]
        WHERE [EmployeeId] = @EmployeeId AND [ProjectId] = @ProjectId
    )
    AND NOT EXISTS (
        SELECT 1 FROM [dbo].[Manage]
        WHERE [EmployeeId] = @EmployeeId AND [ProjectId] = @ProjectId
    )
    BEGIN
        RAISERROR('L''employé ne fait pas partie de ce projet.', 16, 1);
        RETURN;
    END

    DECLARE @NewPostId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Post] ([PostId], [Subject], [Content])
    VALUES (@NewPostId, @Subject, @Content);

    INSERT INTO [dbo].[Write] ([EmployeeId], [PostId])
    VALUES (@EmployeeId, @NewPostId);

    INSERT INTO [dbo].[Concern] ([PostId], [ProjectId])
    VALUES (@NewPostId, @ProjectId);

    SELECT @NewPostId AS [PostId];
END