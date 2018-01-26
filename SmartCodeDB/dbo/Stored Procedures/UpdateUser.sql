CREATE PROCEDURE [dbo].[UpdateUser]
	@UserId INT,
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@UserLevel NVARCHAR(20),
	@CreatedDate DATETIME,
	@LastLoginDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[Security]
	SET @Username = @Username, 
		Password = @Password, 
		UserLevel = @UserLevel,
		CreatedDate = @CreatedDate,
		LastLoginDate = @LastLoginDate
	WHERE UserId = @UserId;

END


