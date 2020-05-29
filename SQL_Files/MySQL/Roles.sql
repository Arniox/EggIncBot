-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Roles`

CREATE TABLE IF NOT EXISTS `Roles`
(
 `Role_Id`    int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`   varchar(20) NOT NULL ,
 `UUID`       varchar(20) NOT NULL ,
 `Role_Color` varchar(6) NULL ,
 `Role_Name`  varchar(45) NULL ,

PRIMARY KEY (`Role_Id`)
);