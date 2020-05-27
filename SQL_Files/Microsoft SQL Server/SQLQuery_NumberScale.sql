-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [NumberScale]

CREATE TABLE [NumberScale]
(
 [NumberId]          int NOT NULL ,
 [Base_Illion_Short] int NOT NULL ,
 [Base_Illion_Long]  int NOT NULL ,
 [Base]              int NOT NULL ,
 [Exponent]          int NOT NULL ,
 [Short_Scale_Name]  nvarchar(max) NOT NULL ,
 [Long_Scale_Name_1] nvarchar(max) NOT NULL ,
 [Long_Scale_Name_2] nvarchar(max) NOT NULL ,


 CONSTRAINT [PK_NumberScale] PRIMARY KEY CLUSTERED ([NumberId] ASC)
);
GO