-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `configure`

CREATE TABLE IF NOT EXISTS `configure`
(
 `Configure_Id` int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`     bigint NOT NULL ,
 `prefix`       varchar(10) NOT NULL ,
 `Guild_Name`   varchar(1000) NULL ,

PRIMARY KEY (`Configure_Id`, `Guild_Id`)
);