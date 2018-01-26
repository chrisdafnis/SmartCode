CREATE TABLE [dbo].[Location] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [ProductId]    INT          NOT NULL,
    [LocationCode] VARCHAR (10) NULL,
    [Barcode]      VARCHAR (15) NULL,
    [Quantity]     INT          NOT NULL,
    [LocationType] VARCHAR (4)  NULL,
    CONSTRAINT [PK__LocationId] PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
);

