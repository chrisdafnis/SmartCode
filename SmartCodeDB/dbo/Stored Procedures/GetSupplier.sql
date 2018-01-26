Create PROCEDURE [dbo].[GetSupplier]
	@SupplierId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * from [dbo].[Supplier]
	WHERE Id = @SupplierId;

END


