CREATE TABLE [dbo].[Product] (
    [ProductId]       INT          IDENTITY (1, 1) NOT NULL,
    [Barcode]         VARCHAR (15) NOT NULL,
    [Description]     VARCHAR (30) NULL,
    [BinLocation]     VARCHAR (5)  NULL,
    [FullDescription] VARCHAR (50) NULL,
    [SupplierId]      INT          NULL,
    [SupplierCode]    VARCHAR (25) NULL,
    [Quantity]        INT          NOT NULL,
    [UnitOfMeasure]   VARCHAR (5)  NULL,
    [UnitPrice]       FLOAT (53)   NULL,
    CONSTRAINT [PK__ProductId] PRIMARY KEY CLUSTERED ([ProductId] ASC),
    FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Supplier] ([Id])
);

