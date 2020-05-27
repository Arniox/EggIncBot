-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Levels`

CREATE TABLE IF NOT EXISTS `Levels`
(
 `Levels_Id`      int NOT NULL ,
 `LevelNumber`    int NOT NULL ,
 `Role_Id`        int NOT NULL ,
 `Restriction_Id` int NOT NULL ,

PRIMARY KEY (`Levels_Id`),
KEY `fkIdx_105` (`Restriction_Id`),
CONSTRAINT `FK_105` FOREIGN KEY `fkIdx_105` (`Restriction_Id`) REFERENCES `LevelRestriction` (`Restriction_Id`),
KEY `fkIdx_12` (`Role_Id`),
CONSTRAINT `FK_12` FOREIGN KEY `fkIdx_12` (`Role_Id`) REFERENCES `Roles` (`Role_Id`)
);