-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchSuppliers]
	-- Add the parameters for the stored procedure here
	@SearchParam NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [SupplierName]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[AddressLine5]
      ,[ContactNo]
      ,[Email]
      ,[WebSite]
  FROM [dbo].[Supplier]
  WHERE [SupplierName] like @SearchParam 
	OR [AddressLine1] like @SearchParam 
	OR [AddressLine2] like @SearchParam 
	OR [AddressLine3] like @SearchParam
	OR [AddressLine4] like @SearchParam
	OR [AddressLine5] like @SearchParam
	OR [ContactNo] like @SearchParam
	OR [Email] like @SearchParam
	OR [WebSite] like @SearchParam
END
