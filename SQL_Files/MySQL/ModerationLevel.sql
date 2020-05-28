-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `ModerationLevel`

CREATE TABLE IF NOT EXISTS `ModerationLevel`
(
 `ModLevel_Id` int NOT NULL ,
 `Name`        varchar(32) NOT NULL ,
 `Description` varchar(1000) NULL ,

PRIMARY KEY (`ModLevel_Id`)
);