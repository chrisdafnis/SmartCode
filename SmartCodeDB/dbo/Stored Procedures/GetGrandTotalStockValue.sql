-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGrandTotalStockValue]
	-- Add the parameters for the stored procedure here
	@GrandTotal FLOAT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET FMTONLY OFF;

    -- Insert statements for procedure here

	if OBJECT_ID('#Temp') is not null
	BEGIN
		drop TABLE #Temp
	END

	SELECT *
	INTO #Temp
	FROM
	(SELECT DISTINCT  [ProductId]
		  ,[Barcode]
		  ,[Description]
		  ,[UnitOfMeasure]
		  ,[Quantity]
		  ,[UnitPrice]
		  ,sum([Quantity]*[UnitPrice]) as [Total]
	  
	  FROM [SmartCode].[dbo].[Product]
	  Group by [ProductId],[Barcode]
		  ,[Description]
		  ,[UnitOfMeasure],[Quantity]
		  ,[UnitPrice]) AS x

	SET @GrandTotal=(select sum(Total) as GrandTotal
		from #Temp )

	RETURN @GrandTotal
END
