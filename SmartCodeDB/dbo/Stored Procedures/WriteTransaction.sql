-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WriteTransaction]
	-- Add the parameters for the stored procedure here
	@id INT,
	@description NVARCHAR(30),
    @barcode nvarchar(15),
    @transactiontype NVARCHAR(3),
    @quantity INT,
	@jobnumber NVARCHAR(21),
	@newlocation NVARCHAR(10),
	@previouslocation NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @updatequantity as INT

    -- Insert statements for procedure here
	SET @updatequantity = (SELECT Sum(loc.Quantity) 
        FROM Location AS loc
		WHERE (loc.ProductId = @ID))

	--IF (@transactiontype = 'OUT')
	--	SET @updatequantity = (@updatequantity - @quantity)
	--ELSE IF (@transactiontype = 'DEL')
	--	SET @updatequantity = 0
	--ELSE IF (@transactiontype = 'ADP')
	--	SET @updatequantity = @quantity
	--ELSE IF (@transactiontype = 'STU')
	--	SET @updatequantity = @quantity
	--ELSE IF (@transactiontype = 'IN')
	--	SET @updatequantity = (@updatequantity + @quantity)
	--ELSE IF (@transactiontype = 'BK')
	--	SET @updatequantity = (@updatequantity + @quantity)
	--ELSE IF (@transactiontype = 'MOV')
	--	SET @updatequantity =  @quantity
	--ELSE IF (@transactiontype = 'STP')
	--	SET @updatequantity =  @quantity
	--ELSE IF (@transactiontype = 'STU')
	--	SET @updatequantity = @quantity

	INSERT INTO TransactionLog
		(
		Product,
		Barcode,
		TransactionType,
		Quantity,
		UpdatedQuantity,
		JobNumber,
		DateStamp,
		NewLocation,
		PreviousLocation
		)
	VALUES
		(
		@description, 
		@barcode, 
		@transactiontype, 
		@quantity,
		@updatequantity,
		@jobnumber,
		CURRENT_TIMESTAMP,
		@newlocation,
		@previouslocation
		)
END
