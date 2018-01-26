CREATE TABLE [dbo].[Supplier] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [SupplierName] VARCHAR (20) NULL,
    [AddressLine1] VARCHAR (30) NULL,
    [AddressLine2] VARCHAR (30) NULL,
    [AddressLine3] VARCHAR (30) NULL,
    [AddressLine4] VARCHAR (30) NULL,
    [AddressLine5] VARCHAR (30) NULL,
    [ContactNo]    VARCHAR (20) NULL,
    [Email]        VARCHAR (50) NULL,
    [WebSite]      VARCHAR (50) NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([Id] ASC)
);

