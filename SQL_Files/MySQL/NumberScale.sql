-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `NumberScale`

CREATE TABLE IF NOT EXISTS `NumberScale`
(
 `Scale_Id`          int NOT NULL AUTO_INCREMENT ,
 `Base_Illion_Short` int NOT NULL ,
 `Base_Illion_Long`  int NOT NULL ,
 `Base`              int NOT NULL ,
 `Exponent`          int NOT NULL ,
 `Short_Scale_Name`  varchar(1000) NOT NULL ,
 `Long_Scale_Name_1` varchar(1000) NOT NULL ,
 `Long_Scale_Name_2` varchar(1000) NOT NULL ,
 `SI_Symbol`         varchar(20) NULL ,

PRIMARY KEY (`Scale_Id`)
);