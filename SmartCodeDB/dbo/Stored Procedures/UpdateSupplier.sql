CREATE PROCEDURE [dbo].[UpdateSupplier]
	@SupplierId INT,
	@SupplierName NVARCHAR(20),
	@AddressLine1 NVARCHAR(30),
	@AddressLine2 NVARCHAR(30),
	@AddressLine3 NVARCHAR(30),
	@AddressLine4 NVARCHAR(30),
	@AddressLine5 NVARCHAR(30),
	@ContactNo NVARCHAR(20),
	@Email NVARCHAR(50),
	@WebSite NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[Supplier]
	SET SupplierName = @SupplierName,
	AddressLine1 = @AddressLine1,
	AddressLine2 = @AddressLine2,
	AddressLine3 = @AddressLine3,
	AddressLine4 = @AddressLine4,
	AddressLine5 = @AddressLine5,
	ContactNo = @ContactNo,
	Email = @Email,
	WebSite = @WebSite
	WHERE Id = @SupplierId;

END


