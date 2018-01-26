Create PROCEDURE [dbo].[GetProduct]
	@ProductId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * from [dbo].[Product]
	WHERE ProductId = @ProductId;

END


