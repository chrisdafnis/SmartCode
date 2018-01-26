-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchProducts]
	-- Add the parameters for the stored procedure here
	@SearchParam NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Barcode]
      ,[Description]
      ,[BinLocation] as 'Bin Location'
      ,[FullDescription]
      ,[SupplierId]
      ,[SupplierCode]
      ,[Quantity]
      ,[UnitOfMeasure]
      ,[UnitPrice]
  FROM [dbo].[Product]
  WHERE [Barcode] like @SearchParam OR [Description] like @SearchParam OR [BinLocation] like @SearchParam OR [FullDescription] like @SearchParam
END
