-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `configure`

CREATE TABLE IF NOT EXISTS `configure`
(
 `Configure_Id` int NOT NULL AUTO_INCREMENT ,
 `prefix`       varchar(10) NOT NULL ,
 `Guild_Id`     bigint NOT NULL ,

PRIMARY KEY (`Configure_Id`, `Guild_Id`)
);