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


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `LargeNumber`

CREATE TABLE IF NOT EXISTS `LargeNumber`
(
 `Number_Id` int NOT NULL AUTO_INCREMENT ,
 `Scale_Id`  int NOT NULL ,
 `Number`    int NULL ,

PRIMARY KEY (`Number_Id`),
KEY `fkIdx_201` (`Scale_Id`),
CONSTRAINT `FK_201` FOREIGN KEY `fkIdx_201` (`Scale_Id`) REFERENCES `NumberScale` (`Scale_Id`)
);


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
 `Golden_Eggs_Id` int NOT NULL ,

PRIMARY KEY (`Stats_Id`),
KEY `fkIdx_204` (`Earnings_Id`),
CONSTRAINT `FK_204` FOREIGN KEY `fkIdx_204` (`Earnings_Id`) REFERENCES `LargeNumber` (`Number_Id`),
KEY `fkIdx_207` (`Golden_Eggs_Id`),
CONSTRAINT `FK_207` FOREIGN KEY `fkIdx_207` (`Golden_Eggs_Id`) REFERENCES `LargeNumber` (`Number_Id`)
);


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
KEY `fkIdx_210` (`Soul_Eggs_Id`),
CONSTRAINT `FK_210` FOREIGN KEY `fkIdx_210` (`Soul_Eggs_Id`) REFERENCES `LargeNumber` (`Number_Id`),
KEY `fkIdx_213` (`Bonus_Id`),
CONSTRAINT `FK_213` FOREIGN KEY `fkIdx_213` (`Bonus_Id`) REFERENCES `LargeNumber` (`Number_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Roles`

CREATE TABLE IF NOT EXISTS `Roles`
(
 `Role_Id`    int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`   varchar(20) NOT NULL ,
 `UUID`       varchar(20) NOT NULL ,
 `Role_Color` varchar(6) NULL ,
 `Role_Name`  varchar(45) NULL ,

PRIMARY KEY (`Role_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Levels`

CREATE TABLE IF NOT EXISTS `Levels`
(
 `Levels_Id`      int NOT NULL AUTO_INCREMENT ,
 `LevelNumber`    int NOT NULL ,
 `Role_Id`        int NOT NULL ,
 `Restriction_Id` int NOT NULL ,

PRIMARY KEY (`Levels_Id`),
KEY `fkIdx_12` (`Role_Id`),
CONSTRAINT `FK_12` FOREIGN KEY `fkIdx_12` (`Role_Id`) REFERENCES `Roles` (`Role_Id`),
KEY `fkIdx_223` (`Restriction_Id`),
CONSTRAINT `FK_223` FOREIGN KEY `fkIdx_223` (`Restriction_Id`) REFERENCES `LargeNumber` (`Number_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `MembersData`

CREATE TABLE IF NOT EXISTS `MembersData`
(
 `Data_Id`     int NOT NULL AUTO_INCREMENT ,
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


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Members`

CREATE TABLE IF NOT EXISTS `Members`
(
 `Members_Id`  int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`    varchar(20) NOT NULL ,
 `UUID`        varchar(20) NOT NULL ,
 `Name`        varchar(32) NOT NULL ,
 `Nick_Name`   varchar(32) NULL ,
 `Member_Data` int NULL ,

PRIMARY KEY (`Members_Id`),
KEY `fkIdx_95` (`Member_Data`),
CONSTRAINT `FK_95` FOREIGN KEY `fkIdx_95` (`Member_Data`) REFERENCES `MembersData` (`Data_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `ContractCounters`

CREATE TABLE IF NOT EXISTS `ContractCounters`
(
 `ContractCountId` int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`        varchar(20) NOT NULL ,
 `Channel_Id`      varchar(20) NOT NULL ,
 `Message_Id`      varchar(20) NOT NULL ,
 `Status`          varchar(10) NOT NULL ,
 `Contract_Code`   varchar(1000) NULL ,
 `Ping_Role`       int NULL ,
 `Starter_Member`  int NULL ,

PRIMARY KEY (`ContractCountId`),
KEY `fkIdx_167` (`Ping_Role`),
CONSTRAINT `FK_167` FOREIGN KEY `fkIdx_167` (`Ping_Role`) REFERENCES `Roles` (`Role_Id`),
KEY `fkIdx_170` (`Starter_Member`),
CONSTRAINT `FK_170` FOREIGN KEY `fkIdx_170` (`Starter_Member`) REFERENCES `Members` (`Members_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `CountedMembers`

CREATE TABLE IF NOT EXISTS `CountedMembers`
(
 `Counted_Member_Id` int NOT NULL AUTO_INCREMENT ,
 `Members_Id`        int NOT NULL ,
 `Contract_Count_Id` int NOT NULL ,
 `Rater_Per_Hour`    int NOT NULL ,
 `Total`             int NOT NULL ,
 `Tokens`            int NOT NULL ,

PRIMARY KEY (`Counted_Member_Id`),
KEY `fkIdx_178` (`Members_Id`),
CONSTRAINT `FK_178` FOREIGN KEY `fkIdx_178` (`Members_Id`) REFERENCES `Members` (`Members_Id`),
KEY `fkIdx_181` (`Contract_Count_Id`),
CONSTRAINT `FK_181` FOREIGN KEY `fkIdx_181` (`Contract_Count_Id`) REFERENCES `ContractCounters` (`ContractCountId`),
KEY `fkIdx_216` (`Rater_Per_Hour`),
CONSTRAINT `FK_216` FOREIGN KEY `fkIdx_216` (`Rater_Per_Hour`) REFERENCES `LargeNumber` (`Number_Id`),
KEY `fkIdx_219` (`Total`),
CONSTRAINT `FK_219` FOREIGN KEY `fkIdx_219` (`Total`) REFERENCES `LargeNumber` (`Number_Id`)
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Channels`

CREATE TABLE IF NOT EXISTS `Channels`
(
 `Channel_Id`   int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`     varchar(20) NOT NULL ,
 `UUID`         varchar(20) NOT NULL ,
 `Channel_Name` varchar(45) NULL ,

PRIMARY KEY (`Channel_Id`)
);


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


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `ModControl`

CREATE TABLE IF NOT EXISTS `ModControl`
(
 `Mod_Id`                int NOT NULL AUTO_INCREMENT ,
 `ModLevel_Id`           int NOT NULL ,
 `Stats_Update_Max_Diff` float NULL ,
 `Stats_Trusted_Role`    int NULL ,
 `Mod_Approval_Chat`     int NULL ,
 `Moderator_Role`        int NULL ,
 `Stats_Post_Channel`    int NULL ,

PRIMARY KEY (`Mod_Id`),
KEY `fkIdx_126` (`Stats_Trusted_Role`),
CONSTRAINT `FK_126` FOREIGN KEY `fkIdx_126` (`Stats_Trusted_Role`) REFERENCES `Roles` (`Role_Id`),
KEY `fkIdx_136` (`Mod_Approval_Chat`),
CONSTRAINT `FK_136` FOREIGN KEY `fkIdx_136` (`Mod_Approval_Chat`) REFERENCES `Channels` (`Channel_Id`),
KEY `fkIdx_139` (`ModLevel_Id`),
CONSTRAINT `FK_139` FOREIGN KEY `fkIdx_139` (`ModLevel_Id`) REFERENCES `ModerationLevel` (`ModLevel_Id`),
KEY `fkIdx_145` (`Moderator_Role`),
CONSTRAINT `FK_145` FOREIGN KEY `fkIdx_145` (`Moderator_Role`) REFERENCES `Roles` (`Role_Id`),
KEY `fkIdx_158` (`Stats_Post_Channel`),
CONSTRAINT `FK_158` FOREIGN KEY `fkIdx_158` (`Stats_Post_Channel`) REFERENCES `Channels` (`Channel_Id`),
 CONSTRAINT `CK_Moderation_Level` CHECK ( ModLevel_Id!=(0) AND ((ModLevel_Id=(1) AND Stats_Update_Max_Diff IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(2) AND Stats_Trusted_Role IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(3) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(4) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL)) OR ModLevel_Id=(0) )
);


-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `Configure`

CREATE TABLE IF NOT EXISTS `Configure`
(
 `Configure_Id` int NOT NULL AUTO_INCREMENT ,
 `Guild_Id`     varchar(20) NOT NULL ,
 `Prefix`       varchar(10) NOT NULL ,
 `Guild_Name`   varchar(1000) NULL ,
 `Mod_Id`       int NOT NULL ,

PRIMARY KEY (`Configure_Id`, `Guild_Id`),
KEY `fkIdx_142` (`Mod_Id`),
CONSTRAINT `FK_142` FOREIGN KEY `fkIdx_142` (`Mod_Id`) REFERENCES `ModControl` (`Mod_Id`)
);


