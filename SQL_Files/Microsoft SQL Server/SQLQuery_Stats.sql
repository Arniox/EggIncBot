-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Stats]

CREATE TABLE [Stats]
(
 [StatsId]      int NOT NULL ,
 [OoM]          int NULL ,
 [Prestiges]    int NULL ,
 [Drones]       int NULL ,
 [Elite_Drones] int NULL ,
 [EarningsId]   int NOT NULL ,
 [GoldenEggsId] int NOT NULL ,


 CONSTRAINT [PK_Stats] PRIMARY KEY CLUSTERED ([StatsId] ASC),
 CONSTRAINT [FK_84] FOREIGN KEY ([EarningsId])  REFERENCES [LifeTimeEarnings]([EarningsId]),
 CONSTRAINT [FK_96] FOREIGN KEY ([GoldenEggsId])  REFERENCES [GoldenEggs]([GoldenEggsId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_84] ON [Stats] 
 (
  [EarningsId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_96] ON [Stats] 
 (
  [GoldenEggsId] ASC
 )

GO