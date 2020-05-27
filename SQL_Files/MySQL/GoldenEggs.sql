-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `GoldenEggs`

CREATE TABLE IF NOT EXISTS `GoldenEggs`
(
 `Gold_Id`  int NOT NULL AUTO_INCREMENT ,
 `Scale_Id` int NOT NULL ,
 `Number`   int NULL ,

PRIMARY KEY (`Gold_Id`),
KEY `fkIdx_49` (`Scale_Id`),
CONSTRAINT `FK_49` FOREIGN KEY `fkIdx_49` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);