-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Stats`

CREATE TABLE IF NOT EXISTS `Stats`
(
 `Stats_Id`       int NOT NULL AUTO_INCREMENT ,
 `OoM`            int NULL ,
 `Prestiges`      int NULL ,
 `Drones`         int NULL ,
 `Elite_Drones`   int NULL ,
 `Earnings_Id`    int NOT NULL ,
 `Golden_Eggs_id` int NOT NULL ,

PRIMARY KEY (`Stats_Id`),
KEY `fkIdx_42` (`Earnings_Id`),
CONSTRAINT `FK_42` FOREIGN KEY `fkIdx_42` (`Earnings_Id`) REFERENCES `LifeTimeEarnings` (`Earnings_Id`),
KEY `fkIdx_76` (`Golden_Eggs_id`),
CONSTRAINT `FK_76` FOREIGN KEY `fkIdx_76` (`Golden_Eggs_id`) REFERENCES `GoldenEggs` (`Gold_Id`)
);