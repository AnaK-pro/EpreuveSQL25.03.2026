CREATE PROCEDURE [dbo].[Sp_LoginUser]
    @Email    VARCHAR(320),
    @Password VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Salt          UNIQUEIDENTIFIER;
    DECLARE @StoredHash    VARCHAR(32);

    SELECT @Salt = [Salt], @StoredHash = [Password]
    FROM [dbo].[User]
    WHERE [Email] = @Email;

    IF @Salt IS NULL
    BEGIN
        RAISERROR('Email ou mot de passe incorrect.', 16, 1);
        RETURN;
    END

    DECLARE @HashedPassword VARCHAR(64) = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @Password + CAST(@Salt AS VARCHAR(36))), 2);

    IF @HashedPassword <> @StoredHash
    BEGIN
        RAISERROR('Email ou mot de passe incorrect.', 16, 1);
        RETURN;
    END

    SELECT
        u.[UserId],
        u.[Email],
        e.[EmployeeId],
        e.[Firstname],
        e.[Lastname],
        e.[IsProjectManager]
    FROM [dbo].[User] u
    INNER JOIN [dbo].[Link] l ON l.[UserId] = u.[UserId]
    INNER JOIN [dbo].[Employee] e ON e.[EmployeeId] = l.[EmployeeId]
    WHERE u.[Email] = @Email;
END