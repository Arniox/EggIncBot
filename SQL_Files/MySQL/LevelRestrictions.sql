-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `LevelRestriction`

CREATE TABLE IF NOT EXISTS `LevelRestriction`
(
 `Restriction_Id` int NOT NULL ,
 `Scale_Id`       int NOT NULL ,
 `Number`         int NOT NULL ,

PRIMARY KEY (`Restriction_Id`),
KEY `fkIdx_102` (`Scale_Id`),
CONSTRAINT `FK_102` FOREIGN KEY `fkIdx_102` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);