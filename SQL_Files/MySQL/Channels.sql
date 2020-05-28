-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Channels`

CREATE TABLE IF NOT EXISTS `Channels`
(
 `Channel_Id`   int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`     varchar(20) NOT NULL ,
 `UUID`         varchar(20) NOT NULL ,
 `Channel_Name` varchar(45) NULL ,

PRIMARY KEY (`Channel_Id`)
);