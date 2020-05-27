-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `MembersData`

CREATE TABLE IF NOT EXISTS `MembersData`
(
 `Data_Id`     int NOT NULL ,
 `Level_Id`    int NOT NULL ,
 `Stats_Id`    int NOT NULL ,
 `Prestige_Id` int NOT NULL ,

PRIMARY KEY (`Data_Id`),
KEY `fkIdx_79` (`Level_Id`),
CONSTRAINT `FK_79` FOREIGN KEY `fkIdx_79` (`Level_Id`) REFERENCES `Levels` (`Levels_Id`),
KEY `fkIdx_82` (`Stats_Id`),
CONSTRAINT `FK_82` FOREIGN KEY `fkIdx_82` (`Stats_Id`) REFERENCES `Stats` (`Stats_Id`),
KEY `fkIdx_85` (`Prestige_Id`),
CONSTRAINT `FK_85` FOREIGN KEY `fkIdx_85` (`Prestige_Id`) REFERENCES `PrestigeData` (`Prestige_Id`)
);