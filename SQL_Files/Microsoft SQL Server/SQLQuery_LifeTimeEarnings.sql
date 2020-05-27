-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [LifeTimeEarnings]

CREATE TABLE [LifeTimeEarnings]
(
 [EarningsId] int NOT NULL ,
 [ScaleId]    int NOT NULL ,
 [Number]     int NULL ,


 CONSTRAINT [PK_LifeTimeEarnings] PRIMARY KEY CLUSTERED ([EarningsId] ASC),
 CONSTRAINT [FK_80] FOREIGN KEY ([ScaleId])  REFERENCES [NumberScale]([NumberId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_80] ON [LifeTimeEarnings] 
 (
  [ScaleId] ASC
 )

GO