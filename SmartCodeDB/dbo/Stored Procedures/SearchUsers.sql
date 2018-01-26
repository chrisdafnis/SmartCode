-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchUsers]
	-- Add the parameters for the stored procedure here
	@SearchParam NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Username]
      ,[Password]
      ,[UserLevel]
      ,[CreatedDate]
      ,[LastLoginDate]
  FROM [dbo].[Security]
  WHERE [Username] like @SearchParam 
	OR [UserLevel] like @SearchParam 
END
