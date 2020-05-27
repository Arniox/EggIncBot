-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Members]

CREATE TABLE [Members]
(
 [MemberId]    int NOT NULL ,
 [Guild_Id]    bigint NOT NULL ,
 [UUID]        bigint NOT NULL ,
 [Name]        nvarchar(32) NOT NULL ,
 [Nick_Name]   nvarchar(32) NULL ,
 [Member_Data] int NOT NULL ,


 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED ([MemberId] ASC),
 CONSTRAINT [FK_123] FOREIGN KEY ([Member_Data])  REFERENCES [MemberData]([DataId])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_123] ON [Members] 
 (
  [Member_Data] ASC
 )

GO