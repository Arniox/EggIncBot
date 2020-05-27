-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `SoulEggs`

CREATE TABLE IF NOT EXISTS `SoulEggs`
(
 `Soul_Id`  int NOT NULL AUTO_INCREMENT ,
 `Scale_Id` int NOT NULL ,
 `Number`   int NULL ,

PRIMARY KEY (`Soul_Id`),
KEY `fkIdx_60` (`Scale_Id`),
CONSTRAINT `FK_60` FOREIGN KEY `fkIdx_60` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);