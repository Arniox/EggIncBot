-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Levels]

CREATE TABLE [Levels]
(
 [LevelsId]          int NOT NULL ,
 [Level_Number]      int NOT NULL ,
 [Level_Restriction] bigint NOT NULL ,
 [RoleId]            int NOT NULL ,


 CONSTRAINT [PK_Levels] PRIMARY KEY CLUSTERED ([LevelsId] ASC),
 CONSTRAINT [FK_21] FOREIGN KEY ([RoleId])  REFERENCES [Roles]([RoleId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_21] ON [Levels] 
 (
  [RoleId] ASC
 )

GO