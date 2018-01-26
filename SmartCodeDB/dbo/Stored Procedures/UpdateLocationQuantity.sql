-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.UpdateLocationQuantity
	-- Add the parameters for the stored procedure here
	@LocationId INT,
	@ProductId INT,
	@Quantity INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.Location
		SET Quantity = @Quantity
	WHERE Id = @LocationId AND ProductId = @ProductId
END
