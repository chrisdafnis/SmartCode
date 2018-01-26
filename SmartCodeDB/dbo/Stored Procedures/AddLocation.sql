

CREATE PROCEDURE [dbo].[AddLocation]
	@new_id INT OUTPUT,
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

		SELECT @new_id = SCOPE_IDENTITY()
		SELECT @new_id as LocationId	 
END


