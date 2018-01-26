-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductMovements]
	-- Add the parameters for the stored procedure here
	@ID INT,
	@From datetime,
	@To datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.ProductId, a.Barcode, a.Description, c.TransactionType, c.JobNumber, c.Quantity, c.UpdatedQuantity, c.DateStamp--b.Quantity AS 'TotalQuantity', c.DateStamp
    FROM Product AS a
    --LEFT JOIN (

    --SELECT loc.ProductId,  Sum(loc.Quantity) AS 'Quantity'
    --    FROM Location AS loc
    --    GROUP BY loc.ProductId)
    --AS b ON a.ProductId = b.ProductId
    INNER JOIN TransactionLog c
		ON c.Product = a.Description
	WHERE (a.ProductId = @ID) AND (c.DateStamp > @From) AND (c.DateStamp < @To)
	ORDER BY c.DateStamp DESC
END
