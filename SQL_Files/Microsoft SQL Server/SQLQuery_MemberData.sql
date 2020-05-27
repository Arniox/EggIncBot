-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [MemberData]

CREATE TABLE [MemberData]
(
 [DataId]      int NOT NULL ,
 [LevelsId]    int NOT NULL ,
 [StatsId]     int NOT NULL ,
 [PreistigeId] int NOT NULL ,


 CONSTRAINT [PK_MemberData] PRIMARY KEY CLUSTERED ([DataId] ASC),
 CONSTRAINT [FK_120] FOREIGN KEY ([PreistigeId])  REFERENCES [PrestigeData]([PreistigeId]),
 CONSTRAINT [FK_38] FOREIGN KEY ([LevelsId])  REFERENCES [Levels]([LevelsId]),
 CONSTRAINT [FK_49] FOREIGN KEY ([StatsId])  REFERENCES [Stats]([StatsId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_120] ON [MemberData] 
 (
  [PreistigeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_38] ON [MemberData] 
 (
  [LevelsId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_49] ON [MemberData] 
 (
  [StatsId] ASC
 )

GO