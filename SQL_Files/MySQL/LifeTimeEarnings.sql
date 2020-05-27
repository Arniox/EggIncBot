-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `LifeTimeEarnings`

CREATE TABLE IF NOT EXISTS `LifeTimeEarnings`
(
 `Earnings_Id` int NOT NULL ,
 `Scale_Id`    int NOT NULL ,
 `Number`      int NULL ,

PRIMARY KEY (`Earnings_Id`),
KEY `fkIdx_39` (`Scale_Id`),
CONSTRAINT `FK_39` FOREIGN KEY `fkIdx_39` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);