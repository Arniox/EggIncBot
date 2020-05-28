CREATE DATABASE  IF NOT EXISTS `eggincbot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `eggincbot`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: eggincbot
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `Channel_Id` int NOT NULL AUTO_INCREMENT,
  `Guild_Id` varchar(20) NOT NULL,
  `UUID` varchar(20) NOT NULL,
  `Channel_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Channel_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configure`
--

DROP TABLE IF EXISTS `configure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configure` (
  `Configure_Id` int NOT NULL AUTO_INCREMENT,
  `Guild_Id` varchar(20) NOT NULL,
  `Prefix` varchar(10) NOT NULL,
  `Guild_Name` varchar(1000) DEFAULT NULL,
  `Mod_Id` int NOT NULL,
  PRIMARY KEY (`Configure_Id`,`Guild_Id`),
  KEY `fkIdx_142` (`Mod_Id`),
  CONSTRAINT `FK_142` FOREIGN KEY (`Mod_Id`) REFERENCES `modcontrol` (`Mod_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `earningsbonus`
--

DROP TABLE IF EXISTS `earningsbonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `earningsbonus` (
  `Bonus_Id` int NOT NULL AUTO_INCREMENT,
  `Scale_Id` int NOT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`Bonus_Id`),
  KEY `fkIdx_70` (`Scale_Id`),
  CONSTRAINT `FK_70` FOREIGN KEY (`Scale_Id`) REFERENCES `numberscale` (`Scale_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `goldeneggs`
--

DROP TABLE IF EXISTS `goldeneggs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goldeneggs` (
  `Gold_Id` int NOT NULL AUTO_INCREMENT,
  `Scale_Id` int NOT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`Gold_Id`),
  KEY `fkIdx_49` (`Scale_Id`),
  CONSTRAINT `FK_49` FOREIGN KEY (`Scale_Id`) REFERENCES `numberscale` (`Scale_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `levelrestriction`
--

DROP TABLE IF EXISTS `levelrestriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `levelrestriction` (
  `Restriction_Id` int NOT NULL AUTO_INCREMENT,
  `Scale_Id` int NOT NULL,
  `Number` int NOT NULL,
  PRIMARY KEY (`Restriction_Id`),
  KEY `fkIdx_102` (`Scale_Id`),
  CONSTRAINT `FK_102` FOREIGN KEY (`Scale_Id`) REFERENCES `numberscale` (`Scale_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `levels`
--

DROP TABLE IF EXISTS `levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `levels` (
  `Levels_Id` int NOT NULL AUTO_INCREMENT,
  `LevelNumber` int NOT NULL,
  `Role_Id` int NOT NULL,
  `Restriction_Id` int NOT NULL,
  PRIMARY KEY (`Levels_Id`),
  KEY `fkIdx_105` (`Restriction_Id`),
  KEY `fkIdx_12` (`Role_Id`),
  CONSTRAINT `FK_105` FOREIGN KEY (`Restriction_Id`) REFERENCES `levelrestriction` (`Restriction_Id`),
  CONSTRAINT `FK_12` FOREIGN KEY (`Role_Id`) REFERENCES `roles` (`Role_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lifetimeearnings`
--

DROP TABLE IF EXISTS `lifetimeearnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lifetimeearnings` (
  `Earnings_Id` int NOT NULL AUTO_INCREMENT,
  `Scale_Id` int NOT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`Earnings_Id`),
  KEY `fkIdx_39` (`Scale_Id`),
  CONSTRAINT `FK_39` FOREIGN KEY (`Scale_Id`) REFERENCES `numberscale` (`Scale_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `Members_Id` int NOT NULL AUTO_INCREMENT,
  `bigint` varchar(20) NOT NULL,
  `UUID` varchar(20) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Nick_Name` varchar(32) DEFAULT NULL,
  `Member_Data` int NOT NULL,
  PRIMARY KEY (`Members_Id`),
  KEY `fkIdx_95` (`Member_Data`),
  CONSTRAINT `FK_95` FOREIGN KEY (`Member_Data`) REFERENCES `membersdata` (`Data_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `membersdata`
--

DROP TABLE IF EXISTS `membersdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membersdata` (
  `Data_Id` int NOT NULL AUTO_INCREMENT,
  `Level_Id` int NOT NULL,
  `Stats_Id` int NOT NULL,
  `Prestige_Id` int NOT NULL,
  PRIMARY KEY (`Data_Id`),
  KEY `fkIdx_79` (`Level_Id`),
  KEY `fkIdx_82` (`Stats_Id`),
  KEY `fkIdx_85` (`Prestige_Id`),
  CONSTRAINT `FK_79` FOREIGN KEY (`Level_Id`) REFERENCES `levels` (`Levels_Id`),
  CONSTRAINT `FK_82` FOREIGN KEY (`Stats_Id`) REFERENCES `stats` (`Stats_Id`),
  CONSTRAINT `FK_85` FOREIGN KEY (`Prestige_Id`) REFERENCES `prestigedata` (`Prestige_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modcontrol`
--

DROP TABLE IF EXISTS `modcontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modcontrol` (
  `Mod_Id` int NOT NULL AUTO_INCREMENT,
  `ModLevel_Id` int NOT NULL,
  `Stats_Update_Max_Diff` bigint DEFAULT NULL,
  `Stats_Trusted_Role` int DEFAULT NULL,
  `Mod_Approval_Chat` int DEFAULT NULL,
  `Moderator_Role` int DEFAULT NULL,
  PRIMARY KEY (`Mod_Id`),
  KEY `fkIdx_126` (`Stats_Trusted_Role`),
  KEY `fkIdx_136` (`Mod_Approval_Chat`),
  KEY `fkIdx_139` (`ModLevel_Id`),
  KEY `fkIdx_145` (`Moderator_Role`),
  CONSTRAINT `FK_126` FOREIGN KEY (`Stats_Trusted_Role`) REFERENCES `roles` (`Role_Id`),
  CONSTRAINT `FK_136` FOREIGN KEY (`Mod_Approval_Chat`) REFERENCES `channels` (`Channel_Id`),
  CONSTRAINT `FK_139` FOREIGN KEY (`ModLevel_Id`) REFERENCES `moderationlevel` (`ModLevel_Id`),
  CONSTRAINT `FK_145` FOREIGN KEY (`Moderator_Role`) REFERENCES `roles` (`Role_Id`),
  CONSTRAINT `CK_Moderation_Level` CHECK ((((`ModLevel_Id` <> 0) and (((`ModLevel_Id` = 1) and (`Stats_Update_Max_Diff` is not null) and (`Mod_Approval_Chat` is not null) and (`Moderator_Role` is not null)) or ((`ModLevel_Id` = 2) and (`Stats_Trusted_Role` is not null) and (`Mod_Approval_Chat` is not null) and (`Moderator_Role` is not null)) or ((`ModLevel_Id` = 3) and (`Mod_Approval_Chat` is not null) and (`Moderator_Role` is not null)) or ((`ModLevel_Id` = 4) and (`Mod_Approval_Chat` is not null) and (`Moderator_Role` is not null)))) or (`ModLevel_Id` = 0)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moderationlevel`
--

DROP TABLE IF EXISTS `moderationlevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderationlevel` (
  `ModLevel_Id` int NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ModLevel_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `numberscale`
--

DROP TABLE IF EXISTS `numberscale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `numberscale` (
  `Scale_Id` int NOT NULL AUTO_INCREMENT,
  `Base_Illion_Short` int NOT NULL,
  `Base_Illion_Long` int NOT NULL,
  `Base` int NOT NULL,
  `Exponent` int NOT NULL,
  `Short_Scale_Name` varchar(1000) NOT NULL,
  `Long_Scale_Name_1` varchar(1000) NOT NULL,
  `Long_Scale_Name_2` varchar(1000) NOT NULL,
  `SI_Symbol` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Scale_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prestigedata`
--

DROP TABLE IF EXISTS `prestigedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestigedata` (
  `Prestige_Id` int NOT NULL AUTO_INCREMENT,
  `Legendary_Eggs` int DEFAULT NULL,
  `Soul_Eggs_Id` int NOT NULL,
  `Bonus_Id` int NOT NULL,
  PRIMARY KEY (`Prestige_Id`),
  KEY `fkIdx_63` (`Soul_Eggs_Id`),
  KEY `fkIdx_73` (`Bonus_Id`),
  CONSTRAINT `FK_63` FOREIGN KEY (`Soul_Eggs_Id`) REFERENCES `souleggs` (`Soul_Id`),
  CONSTRAINT `FK_73` FOREIGN KEY (`Bonus_Id`) REFERENCES `earningsbonus` (`Bonus_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Role_Id` int NOT NULL AUTO_INCREMENT,
  `Guild_Id` varchar(20) NOT NULL,
  `UUID` varchar(20) NOT NULL,
  `Role_Color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`Role_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `souleggs`
--

DROP TABLE IF EXISTS `souleggs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `souleggs` (
  `Soul_Id` int NOT NULL AUTO_INCREMENT,
  `Scale_Id` int NOT NULL,
  `Number` int DEFAULT NULL,
  PRIMARY KEY (`Soul_Id`),
  KEY `fkIdx_60` (`Scale_Id`),
  CONSTRAINT `FK_60` FOREIGN KEY (`Scale_Id`) REFERENCES `numberscale` (`Scale_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `Stats_Id` int NOT NULL AUTO_INCREMENT,
  `OoM` int DEFAULT NULL,
  `Prestiges` int DEFAULT NULL,
  `Drones` int DEFAULT NULL,
  `Elite_Drones` int DEFAULT NULL,
  `Earnings_Id` int NOT NULL,
  `Golden_Eggs_id` int NOT NULL,
  PRIMARY KEY (`Stats_Id`),
  KEY `fkIdx_42` (`Earnings_Id`),
  KEY `fkIdx_76` (`Golden_Eggs_id`),
  CONSTRAINT `FK_42` FOREIGN KEY (`Earnings_Id`) REFERENCES `lifetimeearnings` (`Earnings_Id`),
  CONSTRAINT `FK_76` FOREIGN KEY (`Golden_Eggs_id`) REFERENCES `goldeneggs` (`Gold_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'eggincbot'
--

--
-- Dumping routines for database 'eggincbot'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-28 22:09:06
