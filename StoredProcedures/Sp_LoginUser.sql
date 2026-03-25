CREATE PROCEDURE [dbo].[Sp_LoginUser]
    @Email    VARCHAR(320),
    @Password VARBINARY(32)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Salt          UNIQUEIDENTIFIER;
    DECLARE @StoredHash    VARBINARY(32);

    SELECT @Salt = [Salt], @StoredHash = [Password]
    FROM [dbo].[User]
    WHERE [Email] = @Email;

    IF @Salt IS NULL
    BEGIN
        RAISERROR('Email ou mot de passe incorrect.', 16, 1);
        RETURN;
    END

    DECLARE @HashedPassword VARBINARY(32) = HASHBYTES('SHA2_256', @Password + CAST(@Salt AS VARCHAR(36)));

    IF @HashedPassword <> @StoredHash
    BEGIN
        RAISERROR('Email ou mot de passe incorrect.', 16, 1);
        RETURN;
    END

    SELECT
        u.[UserId],
        u.[Email],
        e.[EmployeeId],
        e.[FirstName],
        e.[LastName],
        e.[IsProjectManager]
    FROM [dbo].[User] u
    INNER JOIN [dbo].[Link] l ON l.[UserId] = u.[UserId]
    INNER JOIN [dbo].[Employee] e ON e.[EmployeeId] = l.[EmployeeId]
    WHERE u.[Email] = @Email;
END