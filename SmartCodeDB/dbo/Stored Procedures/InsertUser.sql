CREATE PROCEDURE [dbo].[InsertUser]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@UserLevel NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

		INSERT INTO [Security]
			   ([Username]
			   ,[Password]
			   ,[UserLevel]
			   ,[CreatedDate])
		VALUES
			   (@Username
			   ,@Password
			   ,@UserLevel
			   ,GETDATE())
		
		SELECT SCOPE_IDENTITY() -- UserId			   

END



