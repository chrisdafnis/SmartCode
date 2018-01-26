-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTotalStockValue]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT  [ProductId]
      ,[Barcode]
      ,[Description]
      ,[UnitOfMeasure]
      ,[Quantity]
      ,[UnitPrice]
	  ,sum([Quantity]*[UnitPrice]) as [Total]
  FROM [SmartCode].[dbo].[Product]
  Group by [ProductId]
  ,[Barcode]
      ,[Description]
      ,[UnitOfMeasure],[Quantity]
      ,[UnitPrice]
END
