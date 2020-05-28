-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `configure`

CREATE TABLE IF NOT EXISTS `configure`
(
 `Configure_Id` int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`     varchar(20) NOT NULL ,
 `Prefix`       varchar(10) NOT NULL ,
 `Guild_Name`   varchar(1000) NULL ,
 `Mod_Id`       int NOT NULL ,

PRIMARY KEY (`Configure_Id`, `Guild_Id`),
KEY `fkIdx_142` (`Mod_Id`),
CONSTRAINT `FK_142` FOREIGN KEY `fkIdx_142` (`Mod_Id`) REFERENCES `ModControl` (`Mod_Id`)
);