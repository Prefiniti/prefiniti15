-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: webware_cms
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

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
-- Table structure for table `file_associations`
--

DROP TABLE IF EXISTS `file_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_associations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `assoc_type` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `releasable` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=777 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_associations`
--

LOCK TABLES `file_associations` WRITE;
/*!40000 ALTER TABLE `file_associations` DISABLE KEYS */;
INSERT INTO `file_associations` VALUES (776,816,0,'Plat',1290,1);
/*!40000 ALTER TABLE `file_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_types`
--

DROP TABLE IF EXISTS `file_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `typename` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_types`
--

LOCK TABLES `file_types` WRITE;
/*!40000 ALTER TABLE `file_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `map_associations`
--

DROP TABLE IF EXISTS `map_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_associations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) unsigned NOT NULL,
  `subdivision_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `map_associations`
--

LOCK TABLES `map_associations` WRITE;
/*!40000 ALTER TABLE `map_associations` DISABLE KEYS */;
INSERT INTO `map_associations` VALUES (1,58,28),(2,58,122),(3,58,111),(4,58,84),(5,218,144),(6,252,294),(7,253,294);
/*!40000 ALTER TABLE `map_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_entries`
--

DROP TABLE IF EXISTS `playlist_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) unsigned NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_entries`
--

LOCK TABLES `playlist_entries` WRITE;
/*!40000 ALTER TABLE `playlist_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `playlist_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlists`
--

LOCK TABLES `playlists` WRITE;
/*!40000 ALTER TABLE `playlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_files`
--

DROP TABLE IF EXISTS `site_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `basedir` varchar(255) NOT NULL,
  `subdir` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `creation_date` datetime NOT NULL,
  `SWFUploadFileID` varchar(255) DEFAULT NULL,
  `om_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=812 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_files`
--

LOCK TABLES `site_files` WRITE;
/*!40000 ALTER TABLE `site_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_files`
--

DROP TABLE IF EXISTS `user_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `basedir` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` text NOT NULL,
  `access_level` int(10) unsigned NOT NULL DEFAULT '1',
  `CreateID` varchar(45) DEFAULT NULL,
  `SWFUploadFileID` varchar(255) DEFAULT NULL,
  `last_access` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1333 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_files`
--

LOCK TABLES `user_files` WRITE;
/*!40000 ALTER TABLE `user_files` DISABLE KEYS */;
INSERT INTO `user_files` VALUES (1312,'profile_images','john-hard.jpg','2018-07-11 12:01:16',724,'john-hard.jpg',1,NULL,NULL,'2018-07-11 12:01:16'),(1313,'profile_images','anthony.jpg','2018-07-11 15:16:18',725,'anthony.jpg',1,NULL,NULL,'2018-07-11 15:16:18'),(1314,'profile_images','jesse.jpg','2018-07-11 15:26:09',734,'jesse.jpg',1,NULL,NULL,'2018-07-11 15:26:09'),(1315,'profile_images','1214358155_757_FT0_truck_002.jpg','2018-07-12 20:40:16',724,'1214358155_757_FT0_truck_002.jpg',1,NULL,NULL,'2018-07-12 20:40:16'),(1316,'project_files','employees-view.png','2018-07-13 12:09:31',724,'employees-view.png',1,NULL,NULL,'2018-07-13 12:09:31'),(1317,'profile_images','add-location-1.png','2018-07-13 12:15:43',724,'add-location-1.png',1,NULL,NULL,'2018-07-13 12:15:43'),(1318,'project_files','create-project-dialog.png','2018-07-13 12:15:52',724,'create-project-dialog.png',1,NULL,NULL,'2018-07-13 12:15:52'),(1319,'project_files','employees-view1.png','2018-07-13 12:16:03',724,'employees-view1.png',1,NULL,NULL,'2018-07-13 12:16:03'),(1320,'project_files','new-message-view.png','2018-07-13 12:16:17',724,'new-message-view.png',1,NULL,NULL,'2018-07-13 12:16:17'),(1321,'project_files','Roscoe_Arbuckle.jpg','2018-07-13 12:17:57',724,'Roscoe_Arbuckle.jpg',1,NULL,NULL,'2018-07-13 12:17:57'),(1322,'project_files','aardvark instrumental.mp3','2018-07-13 12:19:33',724,'aardvark instrumental.mp3',1,NULL,NULL,'2018-07-13 12:19:33'),(1323,'project_files','buick.jpg','2018-07-13 15:39:28',724,'buick.jpg',1,NULL,NULL,'2018-07-13 15:39:28'),(1324,'project_files','22729008_2117735671585514_1460957723141466479_n.jpg','2018-07-13 15:40:33',724,'22729008_2117735671585514_1460957723141466479_n.jpg',1,NULL,NULL,'2018-07-13 15:40:33'),(1325,'project_files','amtn.png','2018-07-13 15:41:59',724,'amtn.png',1,NULL,NULL,'2018-07-13 15:41:59'),(1326,'project_files','77buickCarbInfo.pdf','2018-07-13 15:43:33',724,'77buickCarbInfo.pdf',1,NULL,NULL,'2018-07-13 15:43:33'),(1327,'project_files','amu.txt','2018-07-13 15:44:54',724,'amu.txt',1,NULL,NULL,'2018-07-13 15:44:54'),(1328,'project_files','blocks.txt','2018-07-13 15:54:53',724,'blocks.txt',1,NULL,NULL,'2018-07-13 15:54:53'),(1329,'project_files','miri_story.txt','2018-07-13 20:45:53',724,'miri_story.txt',1,NULL,NULL,'2018-07-13 20:45:53'),(1330,'project_files','.gitconfig','2018-07-15 10:34:54',724,'.gitconfig',1,NULL,NULL,'2018-07-15 10:34:54'),(1331,'profile_images','john-square.jpg','2018-07-17 16:19:30',892,'john-square.jpg',1,NULL,NULL,'2018-07-17 16:19:30'),(1332,'profile_images','john-square.jpg','2018-07-17 16:53:18',895,'john-square.jpg',1,NULL,NULL,'2018-07-17 16:53:18');
/*!40000 ALTER TABLE `user_files` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-18 17:21:05
