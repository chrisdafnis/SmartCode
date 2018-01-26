-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePendingStockTake]
	@Id INT,
	@ProductId INT,
	@Barcode NVARCHAR(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM PendingStockTake
	WHERE Id = @Id AND ProductId = @ProductId AND Barcode = @Barcode

END