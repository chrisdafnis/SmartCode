CREATE PROCEDURE [dbo].[GetPendingStockTakes]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT pst.Id, pst.ProductId, loc.Id as LocationId, loc.LocationCode, pst.Barcode, loc.Quantity, pst.QuantityInST, pst.DateStamp
	from [dbo].[PendingStockTake] pst
    inner join [dbo].[Location]  loc
    on pst.LocationId = loc.Id
	ORDER BY pst.DateStamp desc
                              
END


