CREATE PROCEDURE [dbo].[GetAllTransactionHistory]
	@Barcode VARCHAR(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--IF @Barcode <> null
		SELECT tr.Product, tr.Barcode, tr.TransactionType, tr.Quantity, tr.JobNumber, tr.NewLocation, tr.PreviousLocation, tr.DateStamp
		from [dbo].[TransactionLog] tr
		WHERE tr.Barcode = @Barcode
		ORDER BY tr.DateStamp desc
	--ELSE
		--SELECT tr.Product, tr.Barcode, tr.TransactionType, tr.Quantity, tr.JobNumber, tr.DateStamp
		--from [dbo].[TransactionLog] tr
		--ORDER BY tr.DateStamp desc
                              
END


