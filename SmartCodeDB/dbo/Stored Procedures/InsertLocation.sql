

CREATE PROCEDURE [dbo].[InsertLocation]
	@ProductId INT,
	@LocationCode NVARCHAR(5),
	@Barcode NVARCHAR(15),
	@Quantity INT,
	@LocationType NVARCHAR(4)
AS
BEGIN
	SET NOCOUNT ON;

		INSERT INTO [Location]
			   ([ProductId]
			   ,[LocationCode]
			   ,[Barcode]
			   ,[Quantity]
			   ,[LocationType])
		VALUES
			   (@ProductId
			   ,@LocationCode
			   ,@Barcode
			   ,@Quantity
			   ,@LocationType) 
END


