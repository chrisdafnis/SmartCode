CREATE PROCEDURE [dbo].[GetProductDetails]
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

    SELECT a.ProductId, b.Quantity
    FROM Product AS a
    LEFT JOIN (

    SELECT loc.ProductId,  Sum(loc.Quantity) AS 'quantity'
        FROM Location AS loc
        GROUP BY loc.ProductId)

    AS b ON a.ProductId = b.ProductId
    WHERE (a.ProductId = @ID)
    

	--SELECT pr.ProductId, pr.Description, pr.Barcode, loc.LocationCode, loc.Quantity
	--from [dbo].Product pr
 --   inner join [dbo].Location loc
 --   on loc.ProductId = pr.ProductId
	--where pr.ProductId = @ID
	--order by pr.Barcode
	
	--from pr in db.Products
 --                    join loc in db.Locations on pr.ProductId equals loc.ProductId
 --                    join sup in db.Suppliers on pr.SupplierId equals sup.Id
 --                    select new { pr.ProductId, pr.Barcode , pr.Description , pr.BinLocation, pr.FullDescription, sup.SupplierName, pr.SupplierCode, pr.Quantity, pr.UnitOfMeasure, pr.UnitPrice 
                              
END



