-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [PrestigeData]

CREATE TABLE [PrestigeData]
(
 [PreistigeId]    int NOT NULL ,
 [Legendary_Eggs] int NULL ,
 [SoulEggsId]     int NOT NULL ,
 [BonusId]        int NOT NULL ,


 CONSTRAINT [PK_PrestigeData] PRIMARY KEY CLUSTERED ([PreistigeId] ASC),
 CONSTRAINT [FK_107] FOREIGN KEY ([SoulEggsId])  REFERENCES [SoulEggs]([SoulEggsId]),
 CONSTRAINT [FK_117] FOREIGN KEY ([BonusId])  REFERENCES [EarningBonus]([BonusId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_107] ON [PrestigeData] 
 (
  [SoulEggsId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_117] ON [PrestigeData] 
 (
  [BonusId] ASC
 )

GO