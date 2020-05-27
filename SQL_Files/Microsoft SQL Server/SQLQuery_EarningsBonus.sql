-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [EarningBonus]

CREATE TABLE [EarningBonus]
(
 [BonusId] int NOT NULL ,
 [ScaleId] int NOT NULL ,
 [Number]  int NULL ,


 CONSTRAINT [PK_EarningBonus] PRIMARY KEY CLUSTERED ([BonusId] ASC),
 CONSTRAINT [FK_114] FOREIGN KEY ([ScaleId])  REFERENCES [NumberScale]([NumberId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_114] ON [EarningBonus] 
 (
  [ScaleId] ASC
 )

GO