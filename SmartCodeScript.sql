USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sqluser]    Script Date: 05/05/2017 12:27:03 ******/
CREATE LOGIN [sqluser] WITH PASSWORD=N'LBpLfdQJMtysSQpL8shu0u2uJo5VIPVi8PWmukywcac=', DEFAULT_DATABASE=[SmartCode], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [sqluser] DISABLE
GO
USE [SmartCode]
GO

/****** Object:  User [sqluser]    Script Date: 05/05/2017 12:27:24 ******/
CREATE USER [sqluser] FOR LOGIN [sqluser] WITH DEFAULT_SCHEMA=[db_owner]
GO
/****** Object:  Database [SmartCode]    Script Date: 05/05/2017 12:24:56 ******/
CREATE DATABASE [SmartCode]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\sc.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'sc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\sc_log.ldf' , SIZE = 5056KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SmartCode] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmartCode].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmartCode] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SmartCode] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SmartCode] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SmartCode] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SmartCode] SET ARITHABORT OFF 
GO
ALTER DATABASE [SmartCode] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SmartCode] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SmartCode] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SmartCode] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SmartCode] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SmartCode] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SmartCode] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SmartCode] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SmartCode] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SmartCode] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SmartCode] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SmartCode] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SmartCode] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SmartCode] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SmartCode] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SmartCode] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SmartCode] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SmartCode] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SmartCode] SET  MULTI_USER 
GO
ALTER DATABASE [SmartCode] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SmartCode] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SmartCode] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SmartCode] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SmartCode]
GO
/****** Object:  User [sqluser]    Script Date: 05/05/2017 12:24:56 ******/
CREATE USER [sqluser] FOR LOGIN [sqluser] WITH DEFAULT_SCHEMA=[db_owner]
GO
ALTER ROLE [db_owner] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [sqluser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [sqluser]
GO
/****** Object:  Table [dbo].[AssetRegister]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssetRegister](
	[Id] [int] NOT NULL,
	[AssetNo] [varchar](10) NOT NULL,
	[AssetType] [varchar](5) NULL,
	[AssetDescription] [varchar](50) NULL,
	[ValueNew] [float] NULL,
	[PurchaseDate] [smalldatetime] NULL,
	[LifeSpan] [int] NULL,
	[CheckFrequency] [int] NULL,
	[NextCheckDate] [smalldatetime] NULL,
	[EnergyRating] [varchar](4) NULL,
	[CurrentLocation] [varchar](16) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Location]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[LocationCode] [varchar](10) NULL,
	[Barcode] [varchar](15) NULL,
	[Quantity] [int] NOT NULL,
	[LocationType] [varchar](4) NULL,
 CONSTRAINT [PK__LocationId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PendingStockTake]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PendingStockTake](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
	[Barcode] [varchar](15) NOT NULL,
	[QuantityInDB] [int] NOT NULL,
	[QuantityInST] [int] NOT NULL,
	[Datestamp] [datetime] NULL,
 CONSTRAINT [PK__PendingStockTakeId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Barcode] [varchar](15) NOT NULL,
	[Description] [varchar](30) NULL,
	[BinLocation] [varchar](5) NULL,
	[FullDescription] [varchar](50) NULL,
	[SupplierId] [int] NULL,
	[SupplierCode] [varchar](25) NULL,
	[Quantity] [int] NOT NULL,
	[UnitOfMeasure] [varchar](5) NULL,
	[UnitPrice] [float] NULL,
 CONSTRAINT [PK__ProductId] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Security]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Security](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[UserLevel] [nvarchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Supplier](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [varchar](20) NULL,
	[AddressLine1] [varchar](30) NULL,
	[AddressLine2] [varchar](30) NULL,
	[AddressLine3] [varchar](30) NULL,
	[AddressLine4] [varchar](30) NULL,
	[AddressLine5] [varchar](30) NULL,
	[ContactNo] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[WebSite] [varchar](50) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionLog]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product] [varchar](30) NOT NULL,
	[Barcode] [varchar](15) NOT NULL,
	[TransactionType] [varchar](3) NULL,
	[Quantity] [int] NULL,
	[UpdatedQuantity] [int] NULL,
	[JobNumber] [varchar](21) NULL,
	[DateStamp] [datetime] NULL,
	[NewLocation] [varchar](10) NULL,
	[PreviousLocation] [varchar](10) NULL,
 CONSTRAINT [PK__TransactId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[PendingStockTake]  WITH CHECK ADD FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[PendingStockTake]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Supplier] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[GetAllProductDetails]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllProductDetails]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT pr.ProductId, pr.Barcode , pr.Description , pr.BinLocation, pr.FullDescription, sup.SupplierName, pr.SupplierCode, b.Quantity, pr.UnitOfMeasure, pr.UnitPrice
    FROM Product AS pr
	INNER JOIN Supplier AS sup on pr.SupplierId = sup.Id

    LEFT JOIN (

        SELECT loc.ProductId, Sum(loc.Quantity) AS 'Quantity'
        FROM location AS loc
		GROUP BY loc.ProductId)

    AS b ON pr.ProductId = b.ProductId
    ORDER BY pr.ProductId ASC
END



GO
/****** Object:  StoredProcedure [dbo].[GetAllTransactionHistory]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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


GO
/****** Object:  StoredProcedure [dbo].[GetGrandTotalStockValue]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetPendingStockTakes]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPendingStockTakes]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT pst.Id, pst.ProductId, loc.Id as LocationId, loc.LocationCode, pst.Barcode, loc.Quantity, pst.QuantityInST, pst.DateStamp
	from [dbo].[PendingStockTake] pst
    inner join [dbo].[Location]  loc
    on pst.LocationId = loc.Id
	ORDER BY pst.DateStamp desc
                              
END


GO
/****** Object:  StoredProcedure [dbo].[GetProduct]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetProduct]
	@ProductId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * from [dbo].[Product]
	WHERE ProductId = @ProductId;

END


GO
/****** Object:  StoredProcedure [dbo].[GetProductDetails]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductDetails]
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

    SELECT a.ProductId, b.Quantity
    FROM Product AS a
    LEFT JOIN (

    SELECT loc.ProductId,  Sum(loc.Quantity) AS 'quantity'
        FROM Location AS loc
        GROUP BY loc.ProductId)

    AS b ON a.ProductId = b.ProductId
    WHERE (a.ProductId = @ID)
    

	--SELECT pr.ProductId, pr.Description, pr.Barcode, loc.LocationCode, loc.Quantity
	--from [dbo].Product pr
 --   inner join [dbo].Location loc
 --   on loc.ProductId = pr.ProductId
	--where pr.ProductId = @ID
	--order by pr.Barcode
	
	--from pr in db.Products
 --                    join loc in db.Locations on pr.ProductId equals loc.ProductId
 --                    join sup in db.Suppliers on pr.SupplierId equals sup.Id
 --                    select new { pr.ProductId, pr.Barcode , pr.Description , pr.BinLocation, pr.FullDescription, sup.SupplierName, pr.SupplierCode, pr.Quantity, pr.UnitOfMeasure, pr.UnitPrice 
                              
END



GO
/****** Object:  StoredProcedure [dbo].[GetProductMovements]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetSupplier]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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


GO
/****** Object:  StoredProcedure [dbo].[GetTotalStockValue]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[GetTransactions]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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


GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUser]
	@UserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * from [dbo].[Security]
	WHERE UserId = @UserId;

END


GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertProduct]
	@new_id INT OUTPUT,
	@Barcode NVARCHAR(15),
	@Description NVARCHAR(30),
	@BinLocation NVARCHAR(5),
	@FullDescription NVARCHAR(50),
	@SupplierId INT,
	@SupplierCode NVARCHAR(25),
	@Quantity INT,
	@UnitOfMeasure NVARCHAR(5),
	@UnitPrice FLOAT
AS
BEGIN
	SET NOCOUNT ON;

		INSERT INTO [Product]
			   ([Barcode]
			   ,[Description]
			   ,[BinLocation]
			   ,[FullDescription]
			   ,[SupplierId]
			   ,[SupplierCode]
			   ,[Quantity]
			   ,[UnitOfMeasure]
			   ,[UnitPrice])
		VALUES
			   (@Barcode
			   ,@Description
			   ,@BinLocation
			   ,@FullDescription
			   ,@SupplierId
			   ,@SupplierCode
			   ,@Quantity
			   ,@UnitOfMeasure
			   ,@UnitPrice)
		
		SELECT @new_id = SCOPE_IDENTITY()
		SELECT @new_id as ProductId	   

END



GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Insert_User 'Mudassar2', '12345', 'mudassar@aspsnippets.com'
CREATE PROCEDURE [dbo].[InsertUser]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@UserLevel NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

		INSERT INTO [Security]
			   ([Username]
			   ,[Password]
			   ,[UserLevel]
			   ,[CreatedDate])
		VALUES
			   (@Username
			   ,@Password
			   ,@UserLevel
			   ,GETDATE())
		
		SELECT SCOPE_IDENTITY() -- UserId			   

END



GO
/****** Object:  StoredProcedure [dbo].[SearchProducts]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[SearchSuppliers]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[SearchUsers]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[UpdateLocationQuantity]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLocationQuantity]
	-- Add the parameters for the stored procedure here
	@LocationId INT,
	@ProductId INT,
	@Quantity INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.Location
		SET Quantity = @Quantity
	WHERE Id = @LocationId AND ProductId = @ProductId
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateProduct]
	@ProductId INT,
	@Barcode NVARCHAR(15),
	@Description NVARCHAR(30),
	@BinLocation NVARCHAR(5),
	@FullDescription NVARCHAR(50),
	@SupplierId INT,
	@SupplierCode NVARCHAR(25),
	@Quantity INT,
	@UnitOfMeasure NVARCHAR(5),
	@UnitPrice FLOAT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[Product]
	SET Barcode = @Barcode,
		Description = @Description,
		BinLocation = @BinLocation,
		FullDescription = @FullDescription,
		SupplierId = @SupplierId,
		SupplierCode = @SupplierCode,
		Quantity = @Quantity,
		UnitOfMeasure = @UnitOfMeasure,
		UnitPrice = @UnitPrice
	WHERE ProductId = @ProductId;

END


GO
/****** Object:  StoredProcedure [dbo].[UpdateSupplier]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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


GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUser]
	@UserId INT,
	@Username NVARCHAR(20),
	@Password NVARCHAR(20),
	@UserLevel NVARCHAR(20),
	@CreatedDate DATETIME,
	@LastLoginDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[Security]
	SET @Username = @Username, 
		Password = @Password, 
		UserLevel = @UserLevel,
		CreatedDate = @CreatedDate,
		LastLoginDate = @LastLoginDate
	WHERE UserId = @UserId;

END


GO
/****** Object:  StoredProcedure [dbo].[ValidateUser]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateUser]
	@Username NVARCHAR(20),
	@Password NVARCHAR(20)
AS
BEGIN
	--SET NOCOUNT ON;
	SELECT UserId, UserName, Password FROM [Security]
	WHERE Username = @Username AND Password = @Password
END



GO
/****** Object:  StoredProcedure [dbo].[WriteTransaction]    Script Date: 05/05/2017 12:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WriteTransaction]
	-- Add the parameters for the stored procedure here
	@id INT,
	@description NVARCHAR(30),
    @barcode nvarchar(15),
    @transactiontype NVARCHAR(3),
    @quantity INT,
	@jobnumber NVARCHAR(21),
	@newlocation NVARCHAR(10),
	@previouslocation NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @updatequantity as INT

    -- Insert statements for procedure here
	SET @updatequantity = (SELECT Sum(loc.Quantity) 
        FROM Location AS loc
		WHERE (loc.ProductId = @ID))

	--IF (@transactiontype = 'OUT')
	--	SET @updatequantity = (@updatequantity - @quantity)
	--ELSE IF (@transactiontype = 'DEL')
	--	SET @updatequantity = 0
	--ELSE IF (@transactiontype = 'ADP')
	--	SET @updatequantity = @quantity
	--ELSE IF (@transactiontype = 'STU')
	--	SET @updatequantity = @quantity
	--ELSE IF (@transactiontype = 'IN')
	--	SET @updatequantity = (@updatequantity + @quantity)
	--ELSE IF (@transactiontype = 'BK')
	--	SET @updatequantity = (@updatequantity + @quantity)
	--ELSE IF (@transactiontype = 'MOV')
	--	SET @updatequantity =  @quantity
	--ELSE IF (@transactiontype = 'STP')
	--	SET @updatequantity =  @quantity
	--ELSE IF (@transactiontype = 'STU')
	--	SET @updatequantity = @quantity

	INSERT INTO TransactionLog
		(
		Product,
		Barcode,
		TransactionType,
		Quantity,
		UpdatedQuantity,
		JobNumber,
		DateStamp,
		NewLocation,
		PreviousLocation
		)
	VALUES
		(
		@description, 
		@barcode, 
		@transactiontype, 
		@quantity,
		@updatequantity,
		@jobnumber,
		CURRENT_TIMESTAMP,
		@newlocation,
		@previouslocation
		)
END

GO
USE [master]
GO
ALTER DATABASE [SmartCode] SET  READ_WRITE 
GO
