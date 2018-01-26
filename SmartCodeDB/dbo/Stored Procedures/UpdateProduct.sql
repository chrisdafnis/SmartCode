
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateProduct]
	@ProductId INT,
	@Barcode NVARCHAR(15),
	@Description NVARCHAR(30),
	@BinLocation NVARCHAR(5),
	@FullDescription NVARCHAR(50),
	@SupplierId INT,
	@SupplierCode NVARCHAR(25),
	@Quantity INT,
	@UnitOfMeasure NVARCHAR(5),
	@UnitPrice FLOAT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[Product]
	SET Barcode = @Barcode,
		Description = @Description,
		BinLocation = @BinLocation,
		FullDescription = @FullDescription,
		SupplierId = @SupplierId,
		SupplierCode = @SupplierCode,
		Quantity = @Quantity,
		UnitOfMeasure = @UnitOfMeasure,
		UnitPrice = @UnitPrice
	WHERE ProductId = @ProductId;

	
	UPDATE dbo.Location
		SET [LocationCode] = @BinLocation
	WHERE ProductId = @ProductId 
END

