CREATE TABLE [dbo].[TransactionLog] (
    [Id]               INT          IDENTITY (1, 1) NOT NULL,
    [Product]          VARCHAR (30) NOT NULL,
    [Barcode]          VARCHAR (15) NOT NULL,
    [TransactionType]  VARCHAR (3)  NULL,
    [Quantity]         INT          NULL,
    [UpdatedQuantity]  INT          NULL,
    [JobNumber]        VARCHAR (21) NULL,
    [DateStamp]        DATETIME     NULL,
    [NewLocation]      VARCHAR (10) NULL,
    [PreviousLocation] VARCHAR (10) NULL,
    CONSTRAINT [PK__TransactId] PRIMARY KEY CLUSTERED ([Id] ASC)
);

