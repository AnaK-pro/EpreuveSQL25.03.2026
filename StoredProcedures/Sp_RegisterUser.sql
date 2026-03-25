CREATE PROCEDURE [dbo].[sp_RegisterUser]
    @Firstname  VARCHAR(64),
    @Lastname   VARCHAR(64),
    @Hiredate   DATE,
    @Email      VARCHAR(320),
    @Password   VARCHAR(32)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Email] = @Email)
    BEGIN
        RAISERROR('Un compte avec cet email existe déjà.', 16, 1);
        RETURN;
    END

    DECLARE @NewEmployeeId UNIQUEIDENTIFIER = NEWID();
    DECLARE @NewUserId     UNIQUEIDENTIFIER = NEWID();
    DECLARE @Salt          UNIQUEIDENTIFIER = NEWID();
    DECLARE @HashedPassword VARCHAR(256)    = CONVERT(VARCHAR(256), HASHBYTES('SHA2_256', @Password + CAST(@Salt AS VARCHAR(36))), 2);

    INSERT INTO [dbo].[Employee] ([EmployeeId], [Firstname], [Lastname], [Hiredate], [IsProjectManager])
    VALUES (@NewEmployeeId, @Firstname, @Lastname, @Hiredate, 0);

    INSERT INTO [dbo].[User] ([UserId], [Email], [Password], [Salt])
    VALUES (@NewUserId, @Email, @HashedPassword, @Salt);

    INSERT INTO [dbo].[Link] ([UserId], [EmployeeId])
    VALUES (@NewUserId, @NewEmployeeId);

    SELECT @NewUserId AS [UserId], @NewEmployeeId AS [EmployeeId];
END