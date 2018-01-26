CREATE PROCEDURE [dbo].[ValidateUser]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	--SET NOCOUNT ON;
	SELECT UserId, UserName, Password FROM [Security]
	WHERE Username = @Username AND Password = @Password
END



