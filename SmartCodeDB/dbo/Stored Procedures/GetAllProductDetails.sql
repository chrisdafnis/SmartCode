CREATE PROCEDURE [dbo].[GetAllProductDetails]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT pr.ProductId, pr.Barcode , pr.Description , pr.BinLocation, pr.FullDescription, sup.SupplierName, pr.SupplierCode, b.Quantity, pr.UnitOfMeasure, pr.UnitPrice
    FROM Product AS pr
	INNER JOIN Supplier AS sup on pr.SupplierId = sup.Id

    LEFT JOIN (

        SELECT loc.ProductId, Sum(loc.Quantity) AS 'Quantity'
        FROM location AS loc
		GROUP BY loc.ProductId)

    AS b ON pr.ProductId = b.ProductId
    ORDER BY pr.ProductId ASC
END



