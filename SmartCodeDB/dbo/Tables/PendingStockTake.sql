CREATE TABLE [dbo].[PendingStockTake] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [ProductId]    INT          NOT NULL,
    [LocationId]   INT          NOT NULL,
    [Barcode]      VARCHAR (15) NOT NULL,
    [QuantityInDB] INT          NOT NULL,
    [QuantityInST] INT          NOT NULL,
    [Datestamp]    DATETIME     NULL,
    CONSTRAINT [PK__PendingStockTakeId] PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Location] ([Id]),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
);

