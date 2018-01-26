

CREATE PROCEDURE [dbo].[InsertProduct]
	@new_id INT OUTPUT,
	@Barcode NVARCHAR(15),
	@Description NVARCHAR(30),
	@BinLocation NVARCHAR(5),
	@FullDescription NVARCHAR(50),
	@SupplierId INT,
	@SupplierCode NVARCHAR(25),
	--@Quantity INT,
	@UnitOfMeasure NVARCHAR(5),
	@UnitPrice FLOAT
AS
BEGIN
	SET NOCOUNT ON;

		INSERT INTO [Product]
			   ([Barcode]
			   ,[Description]
			   ,[BinLocation]
			   ,[FullDescription]
			   ,[SupplierId]
			   ,[SupplierCode]
			   ,[Quantity]
			   ,[UnitOfMeasure]
			   ,[UnitPrice])
		VALUES
			   (@Barcode
			   ,@Description
			   ,@BinLocation
			   ,@FullDescription
			   ,@SupplierId
			   ,@SupplierCode
			   ,0
			   ,@UnitOfMeasure
			   ,@UnitPrice)

		SELECT @new_id = SCOPE_IDENTITY()
		SELECT @new_id as ProductId	 
END


