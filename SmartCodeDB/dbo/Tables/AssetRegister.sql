CREATE TABLE [dbo].[AssetRegister] (
    [Id]               INT           NOT NULL,
    [AssetNo]          VARCHAR (10)  NOT NULL,
    [AssetType]        VARCHAR (5)   NULL,
    [AssetDescription] VARCHAR (50)  NULL,
    [ValueNew]         FLOAT (53)    NULL,
    [PurchaseDate]     SMALLDATETIME NULL,
    [LifeSpan]         INT           NULL,
    [CheckFrequency]   INT           NULL,
    [NextCheckDate]    SMALLDATETIME NULL,
    [EnergyRating]     VARCHAR (4)   NULL,
    [CurrentLocation]  VARCHAR (16)  NULL
);

