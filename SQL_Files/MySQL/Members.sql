-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Members`

CREATE TABLE IF NOT EXISTS `Members`
(
 `Members_Id`  int NOT NULL AUTO_INCREMENT ,
 `bigint`      varchar(20) NOT NULL ,
 `UUID`        varchar(20) NOT NULL ,
 `Name`        varchar(32) NOT NULL ,
 `Nick_Name`   varchar(32) NULL ,
 `Member_Data` int NOT NULL ,

PRIMARY KEY (`Members_Id`),
KEY `fkIdx_95` (`Member_Data`),
CONSTRAINT `FK_95` FOREIGN KEY `fkIdx_95` (`Member_Data`) REFERENCES `MembersData` (`Data_Id`)
);