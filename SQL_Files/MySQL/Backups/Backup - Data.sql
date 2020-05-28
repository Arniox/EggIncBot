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
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `configure`
--

LOCK TABLES `configure` WRITE;
/*!40000 ALTER TABLE `configure` DISABLE KEYS */;
INSERT INTO `configure` VALUES (1,'442278074134822923','e-','The Kennel',1),(2,'579242534086377472','e-','Friends',2),(3,'668106312080556034','e-','beans',3),(4,'713733412254384149','e-','Aqa Street, New Mexico',4),(5,'671181556202733600','e-','Vulcan Esports',5);
/*!40000 ALTER TABLE `configure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `earningsbonus`
--

LOCK TABLES `earningsbonus` WRITE;
/*!40000 ALTER TABLE `earningsbonus` DISABLE KEYS */;
/*!40000 ALTER TABLE `earningsbonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `goldeneggs`
--

LOCK TABLES `goldeneggs` WRITE;
/*!40000 ALTER TABLE `goldeneggs` DISABLE KEYS */;
/*!40000 ALTER TABLE `goldeneggs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `levelrestriction`
--

LOCK TABLES `levelrestriction` WRITE;
/*!40000 ALTER TABLE `levelrestriction` DISABLE KEYS */;
/*!40000 ALTER TABLE `levelrestriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `levels`
--

LOCK TABLES `levels` WRITE;
/*!40000 ALTER TABLE `levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lifetimeearnings`
--

LOCK TABLES `lifetimeearnings` WRITE;
/*!40000 ALTER TABLE `lifetimeearnings` DISABLE KEYS */;
/*!40000 ALTER TABLE `lifetimeearnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `membersdata`
--

LOCK TABLES `membersdata` WRITE;
/*!40000 ALTER TABLE `membersdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `membersdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `modcontrol`
--

LOCK TABLES `modcontrol` WRITE;
/*!40000 ALTER TABLE `modcontrol` DISABLE KEYS */;
INSERT INTO `modcontrol` VALUES (1,0,NULL,NULL,NULL,NULL),(2,0,NULL,NULL,NULL,NULL),(3,0,NULL,NULL,NULL,NULL),(4,0,NULL,NULL,NULL,NULL),(5,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `modcontrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `moderationlevel`
--

LOCK TABLES `moderationlevel` WRITE;
/*!40000 ALTER TABLE `moderationlevel` DISABLE KEYS */;
INSERT INTO `moderationlevel` VALUES (0,'None','Anyone can update their stats in a specified channel. Default mode. Use this if you fully trust your community.'),(1,'Light','Auto moderation by the bot. The bot will check your stats history and see if there\'s an unusually high jump in stats. This moderation level requires you specifiy a max difference value. Use this if you somewhat trust your community.'),(2,'Medium','Members with a specified trusted role can update their stats freely, but everyone else needs manual moderation approval in a specified moderation approval chat. Requires a trusted role and approval chat to be set. Use this if you have a large community with only a select few trusted members.'),(3,'Heavy','All members need moderation approval for their stat updates. Stat updates are sent to a specified moderation approval chat. Requires an approval chat to be set. Use this if you have a large community and no trusted members.'),(4,'Restrictive','Only allow manual moderation approved stat updates. The bot will not process any data, and will directly send the stat screenshot to a specified moderation approval chat. Moderators then have to manually update the member\'s stats. Requires a moderator role and moderation approval chat to be set.');
/*!40000 ALTER TABLE `moderationlevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `numberscale`
--

LOCK TABLES `numberscale` WRITE;
/*!40000 ALTER TABLE `numberscale` DISABLE KEYS */;
INSERT INTO `numberscale` VALUES (1,1,1,10,6,'Million','Million','Million','M'),(2,2,1,10,9,'Billion','Thousand Million','Milliard','B'),(3,3,2,10,12,'Trillion','Billion','Billion','T'),(4,4,2,10,15,'Quadrillion','Thousand Billion','Billiard','q'),(5,5,3,10,18,'Quintillion','Trillion','Trillion','Q'),(6,6,3,10,21,'Sextillion','Thousand Trillion','Trilliard','s'),(7,7,4,10,24,'Septillion','Quadrillion','Quadrillion','S'),(8,8,4,10,27,'Octillion','Thousand Quadrillion','Quadrilliard','o'),(9,9,5,10,30,'Nonillion','Quintillion','Quintillion','N'),(10,10,5,10,33,'Decillion','Thousand quintillion','Quintilliard','d'),(11,11,6,10,36,'Undecillion','Sextillion','Sextillion','U'),(12,12,6,10,39,'Duodecillion','Thousand sextillion','Sextilliard','D'),(13,13,7,10,42,'Tredecillion','Septillion','Septillion','Td'),(14,14,7,10,45,'Quattuordecillion','Thousand septillion','Septilliard','qd'),(15,15,8,10,48,'Quindecillion','Octillion','Octillion','Qd'),(16,16,8,10,51,'Sedecillion','Thousand octillion','Octilliard','sd'),(17,17,9,10,54,'Septendecillion','Nonillion','Nonillion','Sd'),(18,18,9,10,57,'Octodecillion','Thousand nonillion','Nonilliard','Od'),(19,19,10,10,60,'Novendecillion','Decillion','Decillion','Nd'),(20,20,10,10,63,'Vigintillion','Thousand decillion','Decilliard','V'),(21,21,11,10,66,'Unvigintillion','Undecillion','Undecillion','uV'),(22,22,11,10,69,'Duovigintillion','Thousand undecillion','Undecilliard','dV'),(23,23,12,10,72,'Tresvigintillion','Duodecillion','Duodecillion','tV'),(24,24,12,10,75,'Quattuorvigintillion','Thousand duodecillion','Duodecilliard','qV'),(25,25,13,10,78,'Quinvigintillion','Tredecillion','Tredecillion','QV'),(26,26,13,10,81,'Sesvigintillion','Thousand tredecillion','Tredecilliard','sV'),(27,27,14,10,84,'Septemvigintillion','Quattuordecillion','Quattuordecillion','SV'),(28,28,14,10,87,'Octovigintillion','Thousand quattuordecillion','Quattuordecilliard','OV'),(29,29,15,10,90,'Novemvigintillion','Quindecillion','Quindecillion','NV'),(30,30,15,10,93,'Trigintillion','Thousand quindecillion','Quindecilliard','tT'),(31,31,16,10,96,'Untrigintillion','Sedecillion','Sedecillion','uT'),(32,32,16,10,99,'Duotrigintillion','Thousand sedecillion','Sedecilliard','dT'),(33,33,17,10,102,'Trestrigintillion','Septendecillion','Septendecillion','TT'),(34,34,17,10,105,'Quattuortrigintillion','Thousand septendecillion','Septendecilliard','qT'),(35,35,18,10,108,'Quintrigintillion','Octodecillion','Octodecillion','QT'),(36,36,18,10,111,'Sestrigintillion','Thousand octodecillion','Octodecilliard','sT'),(37,37,19,10,114,'Septentrigintillion','Novendecillion','Novendecillion','ST'),(38,38,19,10,117,'Octotrigintillion','Thousand novendecillion','Novendecilliard','OT'),(39,39,20,10,120,'Noventrigintillion','Vigintillion','Vigintillion','NT'),(40,40,20,10,123,'Quadragintillion','Thousand vigintillion','Vigintilliard','qI'),(41,50,25,10,153,'Quinquagintillion','Thousand quinvigintillion','Quinvigintilliard','QI'),(42,60,30,10,183,'Sexagintillion','Thousand trigintillion','Trigintilliard','sI'),(43,70,35,10,213,'Septuagintillion','Thousand quintrigintillion','Quintrigintilliard','SI'),(44,80,40,10,243,'Octogintillion','Thousand quadragintillion','Quadragintilliard','OI'),(45,90,45,10,273,'Nonagintillion','Thousand quinquadragintillion','Quinquadragintilliard','NI'),(46,100,50,10,303,'Centillion','Thousand quinquagintillion','Quinquagintilliard','C'),(47,101,51,10,306,'Uncentillion','Unquinquagintillion','Unquinquagintillion','ALOT'),(48,110,55,10,333,'Decicentillion','Thousand quinquinquagintillion','Quinquinquagintilliard','ALOT'),(49,111,56,10,336,'Undecicentillion','Sesquinquagintillion','Sesquinquagintillion','ALOT'),(50,120,60,10,363,'Viginticentillion','Thousand sexagintillion','Sexagintilliard','ALOT'),(51,121,61,10,366,'Unviginticentillion','Unsexagintillion','Unsexagintillion','ALOT'),(52,130,65,10,393,'Trigintacentillion','Thousand quinsexagintillion','Quinsexagintilliard','ALOT'),(53,140,70,10,423,'Quadragintacentillion','Thousand septuagintillion','Septuagintilliard','ALOT'),(54,150,75,10,453,'Quinquagintacentillion','Thousand quinseptuagintillion','Quinseptuagintilliard','ALOT'),(55,160,80,10,483,'Sexagintacentillion','Thousand octogintillion','Octogintilliard','ALOT'),(56,170,85,10,513,'Septuagintacentillion','Thousand quinoctogintillion','Quinoctogintilliard','ALOT'),(57,180,90,10,543,'Octogintacentillion','Thousand nonagintillion','Nonagintilliard','ALOT'),(58,190,95,10,573,'Nonagintacentillion','Thousand quinnonagintillion','Quinnonagintilliard','ALOT'),(59,200,100,10,603,'Ducentillion','Thousand centillion','Centilliard','ALOT'),(60,300,150,10,903,'Trecentillion','Thousand quinquagintacentillion','Quinquagintacentilliard','ALOT'),(61,400,200,10,1203,'Quadringentillion','Thousand ducentillion','Ducentilliard','ALOT'),(62,500,250,10,1503,'Quingentillion','Thousand quinquagintaducentillion','Quinquagintaducentilliard','ALOT'),(63,600,300,10,1803,'Sescentillion','Thousand trecentillion','Trecentilliard','ALOT'),(64,700,350,10,2103,'Septingentillion','Thousand quinquagintatrecentillion','Quinquagintatrecentilliard','ALOT'),(65,800,400,10,2403,'Octingentillion','Thousand quadringentillion','Quadringentilliard','ALOT'),(66,900,450,10,2703,'Nongentillion','Thousand quinquagintaquadringentillion','Quinquagintaquadringentilliard','ALOT'),(67,1000,500,10,3003,'Millinillion','Thousand quingentillion','Quingentilliard','ALOT');
/*!40000 ALTER TABLE `numberscale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `prestigedata`
--

LOCK TABLES `prestigedata` WRITE;
/*!40000 ALTER TABLE `prestigedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `prestigedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `souleggs`
--

LOCK TABLES `souleggs` WRITE;
/*!40000 ALTER TABLE `souleggs` DISABLE KEYS */;
/*!40000 ALTER TABLE `souleggs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2020-05-28 22:09:15
