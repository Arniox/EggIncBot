-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `EarningsBonus`

CREATE TABLE IF NOT EXISTS `EarningsBonus`
(
 `Bonus_Id` int NOT NULL ,
 `Scale_Id` int NOT NULL ,
 `Number`   int NULL ,

PRIMARY KEY (`Bonus_Id`),
KEY `fkIdx_70` (`Scale_Id`),
CONSTRAINT `FK_70` FOREIGN KEY `fkIdx_70` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);