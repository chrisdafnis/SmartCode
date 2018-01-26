CREATE PROCEDURE [dbo].[GetUser]
	@UserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * from [dbo].[Security]
	WHERE UserId = @UserId;

END


