-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `PrestigeData`

CREATE TABLE IF NOT EXISTS `PrestigeData`
(
 `Prestige_Id`    int NOT NULL AUTO_INCREMENT ,
 `Legendary_Eggs` int NULL ,
 `Soul_Eggs_Id`   int NOT NULL ,
 `Bonus_Id`       int NOT NULL ,

PRIMARY KEY (`Prestige_Id`),
KEY `fkIdx_63` (`Soul_Eggs_Id`),
CONSTRAINT `FK_63` FOREIGN KEY `fkIdx_63` (`Soul_Eggs_Id`) REFERENCES `SoulEggs` (`Soul_Id`),
KEY `fkIdx_73` (`Bonus_Id`),
CONSTRAINT `FK_73` FOREIGN KEY `fkIdx_73` (`Bonus_Id`) REFERENCES `EarningsBonus` (`Bonus_Id`)
);