-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Roles`

CREATE TABLE IF NOT EXISTS `Roles`
(
 `Role_Id`    int NOT NULL ,
 `Guild_Id`   bigint NOT NULL ,
 `UUID`       bigint NOT NULL ,
 `Role_Color` varchar(6) NULL ,

PRIMARY KEY (`Role_Id`)
);