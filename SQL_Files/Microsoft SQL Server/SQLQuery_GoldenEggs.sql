-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [GoldenEggs]

CREATE TABLE [GoldenEggs]
(
 [GoldenEggsId] int NOT NULL ,
 [ScaleId]      int NOT NULL ,
 [Number]       int NULL ,


 CONSTRAINT [PK_GoldenEggs] PRIMARY KEY CLUSTERED ([GoldenEggsId] ASC),
 CONSTRAINT [FK_93] FOREIGN KEY ([ScaleId])  REFERENCES [NumberScale]([NumberId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_93] ON [GoldenEggs] 
 (
  [ScaleId] ASC
 )

GO