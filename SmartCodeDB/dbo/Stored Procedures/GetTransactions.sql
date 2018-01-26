CREATE PROCEDURE [dbo].[GetTransactions]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT tr.Product, tr.Barcode, tr.TransactionType, tr.Quantity, tr.JobNumber, tr.DateStamp
	from [dbo].[TransactionLog] tr
    ORDER BY tr.DateStamp desc
                              
END


