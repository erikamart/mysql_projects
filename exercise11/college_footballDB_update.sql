CREATE DATABASE  IF NOT EXISTS `college_football` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `college_football`;
-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: college_football
-- ------------------------------------------------------
-- Server version	5.5.52-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `Player_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Team` varchar(45) NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Rush_Receive_Rk` int(11) DEFAULT '0',
  `Rushing_Avg` decimal(10,0) DEFAULT '0',
  `Rushing_TD` int(11) DEFAULT '0',
  `Receiving_Avg` decimal(10,0) DEFAULT '0',
  `Receiving_TD` int(11) DEFAULT '0',
  PRIMARY KEY (`Player_ID`),
  KEY `Team_idx` (`Team`),
  KEY `Rec_TD_idx` (`Receiving_TD`),
  CONSTRAINT `players_fk_Team` FOREIGN KEY (`Team`) REFERENCES `teams` (`Team_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'MIG','De\'Veon','Smith',1,5,10,4,0),(2,'MIG','Chirs','Evans',2,7,3,15,0),(3,'PNS','Saquon','Barkley',1,6,14,17,2),(4,'PNS','Trace','McSorley',2,3,6,0,0),(5,'OHS','Mike','Weber',1,6,8,5,0),(6,'OHS','J.T.','Barrett',2,4,8,0,0),(7,'TAM','Trayveon','Williams',1,7,7,5,0),(8,'TAM','Keith','Ford',2,5,5,25,0),(9,'TEN','Joshua','Dobbs',1,5,9,4,1),(10,'TEN','Jalen','Hurd',2,4,3,8,2),(11,'LSU','Leonard','Fournette',1,7,8,10,0),(12,'LSU','Derrius','Guice',2,8,10,16,0),(13,'NEB','Terrel','Newby',1,5,7,9,1),(14,'NEB','Tommy','Armstrong Jr',2,5,8,0,0),(15,'USC','Ronald','Jones',1,6,10,8,1),(16,'USC','Justin','Davis',2,6,2,8,0),(17,'GEO','Nick','Chubb',1,5,6,17,1),(18,'GEO','Sony','Michel',2,5,2,6,0),(19,'CLA','Soso','Jamabo',1,4,3,12,0),(20,'CLA','Nate','Starks',2,3,1,4,0);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coaches` (
  `Coach_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Team_ID` varchar(4) NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Yrs_on_Team` int(11) DEFAULT '0',
  `Winning_Pct` int(11) DEFAULT '0',
  `Salary` bigint(20) DEFAULT '0',
  `Bowl_Wins` int(11) DEFAULT '0',
  `Bowl_Losses` int(11) DEFAULT '0',
  PRIMARY KEY (`Coach_ID`),
  KEY `Win_idx` (`Winning_Pct`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
INSERT INTO `coaches` VALUES (1,'MIG','Jim','Harbaugh',1,77,9004000,1,0),(2,'PNS','James','Franklin',2,54,4700000,1,1),(3,'OHS','Urban','Meyer',4,93,6094800,3,1),(4,'TAM','Kevin','Sumlin',4,69,5000000,3,1),(5,'TEN','Butch','Jones',3,55,4110000,2,0),(6,'LSU','Les','Miles',11,77,4385567,7,4),(7,'NEB','Mike','Riley',2,63,2800000,1,0),(8,'USC','Clay','Helton',3,67,0,1,1),(9,'GEO','Kirby','Smart',1,64,3753600,0,0),(10,'CLA','Jim','Mora',5,64,3450000,2,2);
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `Team_ID` varchar(4) NOT NULL,
  `Coach` int(11) NOT NULL AUTO_INCREMENT,
  `Team_Name` varchar(45) DEFAULT NULL,
  `Stadium` varchar(45) DEFAULT NULL,
  `Stadium_Size` mediumint(9) DEFAULT '0',
  `Conference` varchar(45) DEFAULT NULL,
  `Budget` bigint(20) DEFAULT '0',
  `Record_of_128` int(11) DEFAULT '0',
  PRIMARY KEY (`Team_ID`),
  KEY `Record_idx` (`Record_of_128`),
  KEY `fk_teams_1_idx` (`Coach`),
  CONSTRAINT `teams_fk_Coach_ID` FOREIGN KEY (`Coach`) REFERENCES `coaches` (`Coach_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES ('CLA',1,'UCLA','Rose Bowl',92542,'Pac 12',96000000,85),('GEO',2,'Georgia','Sanford Stadium',92756,'SEC',77000000,42),('LSU',3,'LSU','Tiger Stadium',102321,'SEC',86000000,53),('MIG',4,'Michigan','Big House',107601,'Big Ten',157000000,3),('NEB',5,'Nebraska','Memorial Stadium',90000,'Big Ten',103000000,8),('OHS',6,'Ohio State','Horse Shoe',104944,'Big Ten',145200000,3),('PNS',7,'Penn State','Beaver Stadium',106572,'Big Ten',120000000,8),('TAM',8,'Texas A&M','Kyle Field',102733,'Big 12',109000000,23),('TEN',9,'Tennessee','Neyland Stadium',102455,'SEC',94000000,23),('USC',10,'USC','Coliseum',93607,'Pac 12',105000000,23);
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-05  4:41:37
