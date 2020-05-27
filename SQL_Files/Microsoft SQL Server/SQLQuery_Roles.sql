-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Roles]

CREATE TABLE [Roles]
(
 [RoleId]     int NOT NULL ,
 [Guild_Id]   bigint NOT NULL ,
 [UUID]       bigint NOT NULL ,
 [Role_Color] nvarchar(6) NOT NULL ,


 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId] ASC)
);
GO