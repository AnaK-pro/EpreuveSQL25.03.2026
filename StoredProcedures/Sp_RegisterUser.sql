CREATE PROCEDURE [dbo].[Sp_RegisterUser]
    @Email      VARCHAR(320),
    @Password   VARBINARY(32)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE [Email] = @Email)
    BEGIN
        RAISERROR('Un compte avec cet email existe déjà.', 16, 1);
        RETURN;
    END

    DECLARE @NewUserId      UNIQUEIDENTIFIER = NEWID();
    DECLARE @Salt           UNIQUEIDENTIFIER = NEWID();
    DECLARE @HashedPassword VARBINARY(32)    = HASHBYTES('SHA2_256', CAST(@Password AS NVARCHAR(64)) + CAST(@Salt AS NVARCHAR(36)));

    INSERT INTO [dbo].[User] ([UserId], [Email], [Password], [Salt])
    VALUES (@NewUserId, @Email, @HashedPassword, @Salt);

    SELECT @NewUserId AS [UserId];
END