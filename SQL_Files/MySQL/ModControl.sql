-- ****************** SqlDBM: MySQL ******************;
-- ***************************************************;


-- ************************************** `ModControl`

CREATE TABLE IF NOT EXISTS `ModControl`
(
 `Mod_Id`                int NOT NULL AUTO_INCREMENT ,
 `ModLevel_Id`           int NOT NULL ,
 `Stats_Update_Max_Diff` bigint NULL ,
 `Stats_Trusted_Role`    int NULL ,
 `Mod_Approval_Chat`     int NULL ,
 `Moderator_Role`        int NULL ,

PRIMARY KEY (`Mod_Id`),
KEY `fkIdx_126` (`Stats_Trusted_Role`),
CONSTRAINT `FK_126` FOREIGN KEY `fkIdx_126` (`Stats_Trusted_Role`) REFERENCES `Roles` (`Role_Id`),
KEY `fkIdx_136` (`Mod_Approval_Chat`),
CONSTRAINT `FK_136` FOREIGN KEY `fkIdx_136` (`Mod_Approval_Chat`) REFERENCES `Channels` (`Channel_Id`),
KEY `fkIdx_139` (`ModLevel_Id`),
CONSTRAINT `FK_139` FOREIGN KEY `fkIdx_139` (`ModLevel_Id`) REFERENCES `ModerationLevel` (`ModLevel_Id`),
KEY `fkIdx_145` (`Moderator_Role`),
CONSTRAINT `FK_145` FOREIGN KEY `fkIdx_145` (`Moderator_Role`) REFERENCES `Roles` (`Role_Id`),
 CONSTRAINT `CK_Moderation_Level` CHECK ( ModLevel_Id!=(0) AND ((ModLevel_Id=(1) AND Stats_Update_Max_Diff IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(2) AND Stats_Trusted_Role IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(3) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR (ModLevel_Id=(4) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL)) OR ModLevel_Id=(0) )
);