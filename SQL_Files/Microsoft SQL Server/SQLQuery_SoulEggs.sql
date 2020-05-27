-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [SoulEggs]

CREATE TABLE [SoulEggs]
(
 [SoulEggsId] int NOT NULL ,
 [ScaleId]    int NOT NULL ,
 [Number]     int NULL ,


 CONSTRAINT [PK_SoulEggs] PRIMARY KEY CLUSTERED ([SoulEggsId] ASC),
 CONSTRAINT [FK_104] FOREIGN KEY ([ScaleId])  REFERENCES [NumberScale]([NumberId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_104] ON [SoulEggs] 
 (
  [ScaleId] ASC
 )

GO