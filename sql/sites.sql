-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: sites
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
-- Table structure for table `association_types`
--

DROP TABLE IF EXISTS `association_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `association_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `association_type` int(11) NOT NULL,
  `association_type_name` varchar(255) NOT NULL,
  `permission_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `association_types`
--

LOCK TABLES `association_types` WRITE;
/*!40000 ALTER TABLE `association_types` DISABLE KEYS */;
INSERT INTO `association_types` VALUES (1,0,'Customer',1),(2,1,'Employee',2),(3,2,'Friend',0);
/*!40000 ALTER TABLE `association_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_events`
--

DROP TABLE IF EXISTS `billing_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_date` datetime NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  `event_type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_events`
--

LOCK TABLES `billing_events` WRITE;
/*!40000 ALTER TABLE `billing_events` DISABLE KEYS */;
INSERT INTO `billing_events` VALUES (2,'2008-02-13 16:28:58',1,'ORDER'),(3,'2008-02-14 10:16:01',1,'ORDER'),(4,'2008-02-15 15:10:45',1,'ORDER'),(5,'2008-02-16 12:19:01',1,'ORDER'),(6,'2008-02-19 09:13:46',1,'ORDER'),(7,'2008-02-20 13:30:09',1,'ORDER'),(8,'2008-02-21 10:36:38',1,'ORDER'),(9,'2008-02-21 12:10:51',1,'ORDER'),(10,'2008-02-21 12:29:32',1,'ORDER'),(11,'2008-02-22 13:34:59',1,'ORDER'),(12,'2008-02-26 09:16:13',1,'ORDER'),(13,'2008-02-27 13:44:42',1,'ORDER'),(14,'2008-02-27 16:22:30',7,'ORDER'),(15,'2008-02-28 18:41:41',1,'ORDER'),(16,'2008-02-28 23:28:03',1,'ORDER'),(17,'2008-03-04 13:53:54',1,'ORDER'),(18,'2008-03-04 16:08:47',1,'ORDER'),(19,'2008-03-05 12:09:14',1,'ORDER'),(20,'2008-03-05 13:04:19',1,'ORDER'),(21,'2008-03-05 15:41:17',1,'ORDER'),(22,'2008-03-10 13:40:42',1,'ORDER'),(23,'2008-03-10 15:39:48',1,'ORDER'),(24,'2008-03-11 11:48:19',1,'ORDER'),(25,'2008-03-12 16:36:54',1,'ORDER'),(26,'2008-03-14 16:28:51',1,'ORDER'),(27,'2008-03-14 16:41:44',1,'ORDER'),(28,'2008-03-17 10:29:33',1,'ORDER'),(29,'2008-03-17 10:53:39',1,'ORDER'),(30,'2008-03-19 16:47:10',1,'ORDER'),(31,'2008-03-19 17:13:02',1,'ORDER'),(32,'2008-03-20 11:17:32',1,'ORDER'),(33,'2008-03-24 12:14:10',1,'ORDER'),(34,'2008-03-24 17:50:51',1,'ORDER'),(35,'2008-03-25 15:50:47',1,'ORDER'),(36,'2008-03-25 15:55:01',1,'ORDER'),(37,'2008-03-25 22:29:02',1,'ORDER'),(38,'2008-03-25 22:31:09',1,'ORDER'),(39,'2008-03-25 22:33:41',1,'ORDER'),(40,'2008-03-25 22:34:34',1,'ORDER'),(41,'2008-03-25 22:41:19',1,'ORDER'),(42,'2008-03-25 22:46:18',1,'ORDER'),(43,'2008-03-25 23:14:54',1,'ORDER'),(44,'2008-03-25 23:17:37',1,'ORDER'),(45,'2008-03-25 23:40:11',1,'ORDER'),(46,'2008-03-26 14:11:36',1,'ORDER'),(47,'2008-03-28 12:58:49',1,'ORDER'),(48,'2008-03-31 19:02:07',1,'ORDER'),(49,'2008-04-02 13:12:39',1,'ORDER'),(50,'2008-04-05 14:18:21',1,'ORDER'),(51,'2008-04-08 10:50:49',1,'ORDER'),(52,'2008-04-08 14:43:56',1,'ORDER'),(53,'2008-04-15 09:11:40',1,'ORDER'),(54,'2008-04-18 01:35:08',8,'ORDER'),(55,'2008-04-22 12:30:09',1,'ORDER'),(56,'2008-04-22 22:17:43',1,'ORDER'),(57,'2008-04-24 08:18:03',1,'ORDER'),(58,'2008-04-24 08:29:39',1,'ORDER'),(59,'2008-04-25 08:03:20',0,'ORDER'),(60,'2008-04-25 08:08:52',1,'ORDER'),(61,'2008-04-25 08:55:15',1,'ORDER'),(62,'2008-04-25 08:57:44',1,'ORDER'),(63,'2008-04-30 06:22:59',1,'ORDER'),(64,'2008-05-01 10:43:11',1,'ORDER'),(65,'2008-05-01 18:57:50',1,'ORDER'),(66,'2008-05-01 19:17:44',1,'ORDER'),(67,'2008-05-01 19:57:00',1,'ORDER'),(68,'2008-05-06 12:36:53',1,'ORDER'),(69,'2008-05-06 14:39:03',1,'ORDER'),(70,'2008-05-07 15:27:01',1,'ORDER'),(71,'2008-05-08 14:26:03',1,'ORDER'),(72,'2008-05-08 17:22:31',1,'ORDER'),(73,'2008-05-09 10:55:51',1,'ORDER'),(74,'2008-05-16 12:41:07',1,'ORDER'),(75,'2008-05-20 15:46:20',1,'ORDER'),(76,'2008-05-23 09:14:51',1,'ORDER'),(77,'2008-05-23 12:46:12',1,'ORDER'),(78,'2008-06-03 09:10:34',1,'ORDER'),(79,'2008-06-03 15:34:52',1,'ORDER'),(80,'2008-06-03 15:36:00',1,'ORDER'),(81,'2008-06-03 15:38:03',1,'ORDER'),(82,'2008-06-03 15:45:32',1,'ORDER'),(83,'2008-06-03 15:50:30',1,'ORDER'),(84,'2008-06-03 16:03:13',1,'ORDER'),(85,'2008-06-04 10:11:24',1,'ORDER'),(86,'2008-06-04 11:08:19',1,'ORDER'),(87,'2008-06-04 12:07:19',1,'ORDER'),(88,'2008-06-09 11:40:52',11,'ORDER'),(89,'2008-06-09 13:16:37',1,'ORDER'),(90,'2008-06-09 17:21:12',12,'ORDER'),(91,'2008-06-11 11:14:01',11,'ORDER'),(92,'2008-06-12 14:28:26',1,'ORDER'),(93,'2008-06-12 16:17:11',1,'ORDER'),(94,'2008-06-13 10:06:23',1,'ORDER'),(95,'2008-06-17 10:40:14',11,'ORDER'),(96,'2008-06-17 23:40:35',1,'ORDER'),(97,'2008-06-18 08:44:55',11,'ORDER'),(98,'2008-06-18 15:32:28',11,'ORDER'),(99,'2008-06-19 16:15:53',17,'ORDER'),(100,'2008-06-20 14:40:44',11,'ORDER'),(101,'2008-06-25 09:15:41',17,'ORDER'),(102,'2008-06-25 17:49:45',1,'ORDER'),(103,'2008-06-27 10:03:11',1,'ORDER'),(104,'2008-06-30 16:48:02',1,'ORDER'),(105,'2008-06-30 17:02:37',1,'ORDER'),(106,'2008-07-01 09:26:15',11,'ORDER'),(107,'2008-07-02 07:54:17',1,'ORDER'),(108,'2008-07-02 08:20:07',11,'ORDER'),(109,'2008-07-07 15:40:00',11,'ORDER'),(110,'2008-07-08 18:11:56',11,'ORDER'),(111,'2008-07-10 12:55:33',11,'ORDER'),(112,'2008-07-11 16:22:13',1,'ORDER'),(113,'2008-07-14 09:42:24',1,'ORDER'),(114,'2008-07-17 11:31:11',1,'ORDER'),(115,'2008-07-18 09:19:10',1,'ORDER'),(116,'2008-07-25 14:32:13',1,'ORDER'),(117,'2008-07-25 15:59:42',1,'ORDER'),(118,'2008-07-25 16:05:05',1,'ORDER'),(119,'2008-07-28 09:19:52',6,'ORDER'),(120,'2008-07-30 13:39:24',1,'ORDER'),(121,'2008-08-05 11:02:18',1,'ORDER'),(122,'2008-08-05 16:09:38',1,'ORDER'),(123,'2008-08-05 16:37:32',1,'ORDER'),(124,'2008-08-06 13:59:15',1,'ORDER'),(125,'2008-08-08 18:27:33',1,'ORDER'),(126,'2008-08-11 11:11:53',1,'ORDER'),(127,'2008-08-13 04:00:54',1,'ORDER'),(128,'2008-08-13 04:08:07',1,'ORDER'),(129,'2008-08-20 12:08:11',1,'ORDER'),(130,'2008-08-20 23:18:21',1,'ORDER'),(131,'2008-08-25 09:38:36',1,'ORDER'),(132,'2008-08-28 10:31:08',1,'ORDER'),(133,'2008-08-28 10:48:13',1,'ORDER'),(134,'2008-08-28 11:26:18',1,'ORDER'),(135,'2008-09-02 10:05:34',1,'ORDER'),(136,'2008-09-02 12:33:07',1,'ORDER'),(137,'2008-09-12 13:18:35',1,'ORDER'),(138,'2008-09-16 22:19:22',1,'ORDER'),(139,'2008-09-17 11:28:30',1,'ORDER'),(140,'2008-09-17 13:47:11',1,'ORDER'),(141,'2008-09-22 14:27:00',1,'ORDER'),(142,'2008-09-22 14:39:20',1,'ORDER'),(143,'2008-09-23 15:40:38',1,'ORDER'),(144,'2008-09-24 19:55:49',1,'ORDER'),(145,'2008-09-26 14:08:11',1,'ORDER'),(146,'2008-09-26 14:55:44',1,'ORDER'),(147,'2008-09-26 14:59:21',1,'ORDER'),(148,'2008-10-01 11:31:12',1,'ORDER'),(149,'2008-10-01 12:53:06',1,'ORDER'),(150,'2008-10-01 15:00:06',1,'ORDER'),(151,'2008-10-01 16:22:06',1,'ORDER'),(152,'2008-10-01 19:23:04',1,'ORDER'),(153,'2008-10-07 15:55:45',1,'ORDER'),(154,'2008-10-08 12:09:36',1,'ORDER'),(155,'2008-10-08 12:10:30',1,'ORDER'),(156,'2008-10-14 10:11:13',1,'ORDER'),(157,'2008-10-20 10:44:48',1,'ORDER'),(158,'2008-10-28 14:03:46',1,'ORDER'),(159,'2008-10-28 14:06:52',1,'ORDER'),(160,'2008-11-11 11:25:56',1,'ORDER'),(161,'2008-11-13 10:31:17',1,'ORDER'),(162,'2008-11-17 12:10:37',1,'ORDER'),(163,'2008-11-18 12:28:42',1,'ORDER'),(164,'2008-11-26 09:20:59',1,'ORDER'),(165,'2008-12-03 12:10:49',1,'ORDER'),(166,'2008-12-16 11:16:52',1,'ORDER'),(167,'2008-12-18 09:32:14',1,'ORDER'),(168,'2008-12-18 10:12:01',1,'ORDER'),(169,'2008-12-22 12:05:33',1,'ORDER'),(170,'2009-01-02 09:49:01',1,'ORDER'),(171,'2009-01-07 14:02:16',1,'ORDER'),(172,'2009-01-08 10:59:50',1,'ORDER'),(173,'2009-01-08 11:03:22',1,'ORDER'),(174,'2009-01-12 10:28:14',1,'ORDER'),(175,'2009-01-12 12:41:07',1,'ORDER'),(176,'2009-01-15 16:18:57',1,'ORDER'),(177,'2009-01-16 15:21:59',1,'ORDER'),(178,'2009-01-21 11:26:40',1,'ORDER'),(179,'2009-01-22 11:13:51',1,'ORDER'),(180,'2009-02-04 16:01:30',1,'ORDER'),(181,'2009-02-04 16:13:01',1,'ORDER'),(182,'2009-02-04 16:31:47',1,'ORDER'),(183,'2009-02-04 16:37:35',1,'ORDER'),(184,'2009-02-05 07:16:56',1,'ORDER'),(185,'2009-02-12 14:38:43',1,'ORDER'),(186,'2009-02-25 12:27:18',1,'ORDER'),(187,'2009-03-02 13:38:20',1,'ORDER'),(188,'2009-03-02 13:41:58',1,'ORDER'),(189,'2009-03-02 16:23:00',1,'ORDER'),(190,'2009-03-03 10:53:13',1,'ORDER'),(191,'2009-03-10 11:12:26',1,'ORDER'),(192,'2009-03-17 11:17:01',1,'ORDER'),(193,'2009-03-17 17:24:26',1,'ORDER'),(194,'2009-03-19 15:21:18',1,'ORDER'),(195,'2009-03-19 15:27:49',1,'ORDER'),(196,'2009-03-19 16:32:24',1,'ORDER'),(197,'2009-03-25 15:57:50',1,'ORDER'),(198,'2009-03-26 13:59:57',1,'ORDER'),(199,'2009-04-07 21:46:59',1,'ORDER'),(200,'2009-04-07 21:47:03',1,'ORDER'),(201,'2009-04-14 11:29:27',1,'ORDER'),(202,'2009-04-16 11:41:32',1,'ORDER'),(203,'2009-04-29 12:37:46',1,'ORDER'),(204,'2009-04-29 14:43:36',1,'ORDER'),(205,'2009-05-11 11:00:36',1,'ORDER'),(206,'2009-05-11 20:16:07',1,'ORDER'),(207,'2009-05-13 15:37:57',1,'ORDER'),(208,'2009-05-14 11:40:54',1,'ORDER'),(209,'2009-05-15 10:42:18',1,'ORDER'),(210,'2009-05-19 16:22:46',1,'ORDER'),(211,'2009-05-20 10:34:27',1,'ORDER'),(212,'2009-05-22 14:14:45',1,'ORDER'),(213,'2009-05-22 14:19:55',1,'ORDER'),(214,'2009-05-22 14:42:08',1,'ORDER'),(215,'2009-05-28 10:52:57',1,'ORDER'),(216,'2009-05-29 09:08:08',1,'ORDER'),(217,'2009-06-01 10:35:54',1,'ORDER'),(218,'2009-06-02 15:09:20',1,'ORDER'),(219,'2009-06-05 12:38:09',1,'ORDER'),(220,'2009-06-10 12:44:14',1,'ORDER'),(221,'2009-06-10 13:06:00',1,'ORDER'),(222,'2009-06-15 09:20:22',1,'ORDER'),(223,'2009-06-19 12:31:34',1,'ORDER'),(224,'2009-06-23 14:07:17',1,'ORDER'),(225,'2009-06-26 09:18:35',1,'ORDER'),(226,'2009-06-30 11:40:50',1,'ORDER'),(227,'2009-07-01 09:39:36',1,'ORDER'),(228,'2009-07-03 13:51:05',1,'ORDER'),(229,'2009-07-17 08:41:38',1,'ORDER'),(230,'2009-07-17 12:53:32',1,'ORDER'),(231,'2009-07-20 11:02:18',1,'ORDER'),(232,'2009-07-21 12:12:04',1,'ORDER'),(233,'2009-07-21 14:53:20',1,'ORDER'),(234,'2009-07-28 01:52:34',1,'ORDER'),(235,'2009-08-02 23:01:24',1,'ORDER'),(236,'2009-08-10 11:16:15',1,'ORDER'),(237,'2009-08-10 11:28:13',1,'ORDER'),(238,'2009-08-13 11:49:55',5,'ORDER'),(239,'2009-08-13 12:18:06',5,'ORDER'),(240,'2009-08-14 16:39:50',1,'ORDER'),(241,'2009-08-15 14:31:23',5,'ORDER'),(242,'2009-08-24 10:46:03',1,'ORDER'),(243,'2009-08-27 09:11:59',1,'ORDER'),(244,'2009-08-27 09:16:59',1,'ORDER'),(245,'2009-09-01 16:04:23',1,'ORDER'),(246,'2009-09-03 14:19:18',1,'ORDER'),(247,'2009-09-03 14:23:39',1,'ORDER'),(248,'2009-09-03 18:22:03',1,'ORDER'),(249,'2009-09-04 00:14:40',5,'ORDER'),(250,'2009-09-09 09:28:51',1,'ORDER'),(251,'2009-09-09 15:51:22',8,'ORDER'),(252,'2009-09-10 15:34:32',1,'ORDER'),(253,'2009-09-10 15:35:12',1,'ORDER'),(254,'2009-09-15 12:46:28',1,'ORDER'),(255,'2009-09-17 13:44:42',1,'ORDER'),(256,'2009-09-22 09:00:31',1,'ORDER'),(257,'2009-09-24 10:39:32',1,'ORDER'),(258,'2009-09-25 11:19:27',1,'ORDER'),(259,'2009-10-13 11:02:49',1,'ORDER'),(260,'2009-10-20 11:35:21',1,'ORDER'),(261,'2009-10-21 08:29:18',1,'ORDER'),(262,'2009-10-26 12:04:31',1,'ORDER'),(263,'2009-10-29 18:25:52',1,'ORDER'),(264,'2009-11-04 13:40:31',1,'ORDER'),(265,'2009-11-04 16:37:05',1,'ORDER'),(266,'2009-11-04 16:39:17',1,'ORDER'),(267,'2009-11-05 14:20:56',1,'ORDER'),(268,'2009-11-12 12:29:41',1,'ORDER'),(269,'2009-11-13 11:11:36',1,'ORDER'),(270,'2009-11-13 12:21:23',1,'ORDER'),(271,'2009-11-16 14:53:10',1,'ORDER'),(272,'2009-11-16 17:22:24',1,'ORDER'),(273,'2009-11-17 11:04:49',1,'ORDER'),(274,'2009-11-17 15:38:06',1,'ORDER'),(275,'2009-11-17 15:51:35',1,'ORDER'),(276,'2009-11-17 16:08:31',1,'ORDER'),(277,'2009-11-17 16:24:39',1,'ORDER'),(278,'2009-11-17 16:32:16',1,'ORDER'),(279,'2009-11-17 16:41:25',1,'ORDER'),(280,'2009-11-17 17:37:02',1,'ORDER'),(281,'2009-11-17 17:48:00',1,'ORDER'),(282,'2009-11-17 17:57:45',1,'ORDER'),(283,'2009-11-17 18:10:31',1,'ORDER'),(284,'2009-11-17 18:17:16',1,'ORDER'),(285,'2009-11-17 18:47:16',1,'ORDER'),(286,'2009-11-17 18:59:12',1,'ORDER'),(287,'2009-11-17 19:06:20',1,'ORDER'),(288,'2009-11-17 19:12:28',1,'ORDER'),(289,'2009-11-17 19:17:21',1,'ORDER'),(290,'2009-11-17 19:23:45',1,'ORDER'),(291,'2009-11-17 19:30:26',1,'ORDER'),(292,'2009-11-18 16:33:24',1,'ORDER'),(293,'2009-11-18 16:43:22',1,'ORDER'),(294,'2009-11-19 11:56:12',1,'ORDER'),(295,'2009-11-24 16:40:19',1,'ORDER'),(296,'2009-12-04 17:25:54',1,'ORDER'),(297,'2009-12-16 17:31:49',1,'ORDER'),(298,'2009-12-28 16:56:28',1,'ORDER'),(299,'2010-01-04 16:37:59',1,'ORDER'),(300,'2010-01-07 17:05:00',1,'ORDER'),(301,'2010-01-11 14:43:08',1,'ORDER'),(302,'2010-01-20 12:11:52',5,'ORDER'),(303,'2010-01-26 10:41:34',1,'ORDER'),(304,'2010-01-27 19:21:18',1,'ORDER'),(305,'2010-01-27 19:37:46',1,'ORDER'),(306,'2010-02-02 08:17:52',1,'ORDER'),(307,'2010-02-02 10:31:28',1,'ORDER'),(308,'2010-02-03 08:08:47',1,'ORDER'),(309,'2010-02-04 10:10:43',1,'ORDER'),(310,'2010-02-15 12:08:53',5,'ORDER'),(311,'2010-02-16 11:27:00',1,'ORDER'),(312,'2010-02-23 11:09:20',1,'ORDER'),(313,'2010-02-25 14:43:59',1,'ORDER'),(314,'2010-02-25 14:44:17',1,'ORDER'),(315,'2010-03-12 14:07:11',1,'ORDER'),(316,'2010-03-15 14:35:52',1,'ORDER'),(317,'2010-03-18 11:04:49',1,'ORDER'),(318,'2010-03-18 17:51:17',1,'ORDER'),(319,'2010-03-23 11:33:22',1,'ORDER'),(320,'2010-03-25 15:45:48',1,'ORDER'),(321,'2010-03-30 11:26:51',1,'ORDER'),(322,'2010-04-01 09:51:32',1,'ORDER'),(323,'2010-04-01 10:18:56',1,'ORDER'),(324,'2010-04-05 11:54:53',15,'ORDER'),(325,'2010-04-05 12:04:16',15,'ORDER'),(326,'2010-04-14 13:42:04',1,'ORDER'),(327,'2010-04-14 13:46:42',1,'ORDER'),(328,'2010-04-28 08:55:54',1,'ORDER'),(329,'2010-04-29 10:02:17',1,'ORDER'),(330,'2010-04-29 16:06:16',19,'ORDER'),(331,'2010-05-05 12:50:33',19,'ORDER'),(332,'2010-05-05 12:53:17',19,'ORDER'),(333,'2010-05-14 14:48:05',1,'ORDER'),(334,'2010-05-14 14:50:36',1,'ORDER');
/*!40000 ALTER TABLE `billing_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_plans`
--

DROP TABLE IF EXISTS `billing_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(45) NOT NULL,
  `base_rate` float NOT NULL,
  `max_employees` bigint(20) unsigned NOT NULL,
  `orders_included` bigint(20) unsigned NOT NULL,
  `price_per_order` float NOT NULL,
  `price_per_employee` float NOT NULL,
  `gis_included` tinyint(3) unsigned NOT NULL,
  `gis_price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_plans`
--

LOCK TABLES `billing_plans` WRITE;
/*!40000 ALTER TABLE `billing_plans` DISABLE KEYS */;
INSERT INTO `billing_plans` VALUES (1,'Level I',125,5,0,10,5,0,50),(2,'Level II',215,20,0,10,5,1,25),(3,'Level III',325,40,0,10,5,1,0),(4,'Timesheets',45,5,0,2,5,0,0);
/*!40000 ALTER TABLE `billing_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `assoc_id` bigint(20) NOT NULL,
  `company_name` varchar(45) NOT NULL,
  `notes` text,
  PRIMARY KEY (`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_entries`
--

DROP TABLE IF EXISTS `department_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_entries`
--

LOCK TABLES `department_entries` WRITE;
/*!40000 ALTER TABLE `department_entries` DISABLE KEYS */;
INSERT INTO `department_entries` VALUES (2,3,724),(6,1,735),(8,5,724),(11,5,725),(13,3,725),(16,6,724),(17,6,732),(18,7,732),(19,7,724),(21,8,24),(22,8,104),(24,9,104),(28,10,6),(29,11,21),(31,12,725),(33,13,734),(34,14,734),(35,14,24),(36,15,24),(39,9,734),(40,16,104),(41,17,725),(42,17,104),(43,17,734),(45,18,782),(46,18,787),(47,19,784),(48,19,785),(49,20,786),(50,21,725),(51,21,733),(53,1,7),(55,25,808),(56,26,34),(57,10,725),(58,28,740),(59,31,732),(60,30,732),(61,33,808),(62,27,847),(63,34,724),(65,34,725),(67,19,868),(68,12,752),(69,35,752),(70,17,724),(71,17,752),(72,36,814),(73,37,724);
/*!40000 ALTER TABLE `department_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_events`
--

DROP TABLE IF EXISTS `department_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `event_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_events`
--

LOCK TABLES `department_events` WRITE;
/*!40000 ALTER TABLE `department_events` DISABLE KEYS */;
INSERT INTO `department_events` VALUES (1,'Order Placed','WF_ORDER_PLACED'),(2,'Order Processed','WF_ORDER_PROCESSED'),(3,'RFP Placed','WF_RFP_PLACED'),(4,'RFP Approved','WF_RFP_APPROVED'),(5,'RFP Declined','WF_RFP_DECLINED'),(6,'Order Reversed','WF_ORDER_REVERSED'),(7,'Timesheet Created','TC_TIMESHEET_CREATED'),(8,'Timesheet Edited','TC_TIMESHEET_EDITED'),(9,'Timesheet Signed','TC_TIMESHEET_SIGNED'),(10,'Timesheet Approved','TC_TIMESHEET_APPROVED'),(11,'Timesheet Deleted','TC_TIMESHEET_DELETED'),(12,'Timesheet Reversed','TC_TIMESHEET_REVERSED'),(13,'Project Status Changed','WF_PROJECT_STATUS_CHANGED'),(14,'File Staged','CMS_FILE_STAGED'),(15,'Project Edited','WF_PROJECT_EDITED'),(16,'File Associated with Project','CMS_FILE_ASSOCIATED'),(17,'File Removed from Staging','CMS_FILE_DELETED'),(18,'File Released to Customer','CMS_FILE_RELEASED'),(19,'RFP Posted','WF_RFP_POSTED'),(20,'Missing Timesheet Reminder','TC_MISSING_TS');
/*!40000 ALTER TABLE `department_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) unsigned NOT NULL,
  `manager_id` bigint(20) unsigned DEFAULT NULL,
  `department_name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,735,'Accounting'),(3,1,724,'Software Development'),(4,5,733,'Technical Support'),(5,5,724,'Development'),(7,6,724,'Add Department'),(8,1,104,'Field Crew 1 (James & Tom)'),(9,1,104,'Field Crew 2 (Jesse & Tom)'),(10,1,725,'Administration'),(11,1,21,'Research'),(12,1,752,'Anthony Gutierrez'),(13,1,734,'Jesse Gutierrez'),(14,1,734,'Field Crew 3 (James & Jesse)'),(15,1,24,'James Provencio'),(16,1,104,'Tom Moore'),(17,1,725,'Center Line Core'),(18,8,787,'Management'),(19,8,784,'Front Office'),(20,8,786,'Nursing'),(21,1,733,'Public Relations'),(25,11,808,'guy garza'),(26,12,34,'Steve Pacheco'),(27,17,NULL,'Shop'),(28,17,740,'Office'),(29,17,NULL,'Survey Supplies'),(30,16,NULL,'Finance'),(31,16,732,'Production'),(32,6,NULL,'test'),(33,1,808,'Drafting'),(34,1,725,'Test'),(35,1,752,'Hannah Gutierrez'),(36,15,814,'Management'),(37,19,724,'Development'),(38,20,NULL,'Test'),(39,20,NULL,'Foop');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `assoc_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `application_date` datetime DEFAULT NULL,
  `hire_date` datetime DEFAULT NULL,
  `termination_date` datetime DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `application` text,
  `resume` text,
  `notes` text,
  `employment_status` varchar(45) NOT NULL DEFAULT 'Active',
  `wage_basis` varchar(20) DEFAULT NULL,
  `wage` double NOT NULL DEFAULT '0',
  `payroll_frequency` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`assoc_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`assoc_id`) REFERENCES `site_associations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,0,NULL),(33,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,0,NULL),(52,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,0,NULL),(57,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active',NULL,0,NULL),(344,'2010-04-01 00:00:00','2010-04-01 00:00:00',NULL,'Chief Executive Officer','                                                \r\n                                            ','                                                \r\n                                            ','                                                \r\n                                            ','Active','Hourly',80,'Per Job'),(346,'2018-07-05 00:00:00','2018-07-05 00:00:00',NULL,'Chief Executive Officer','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','Active','Salaried',100000,'Biweekly'),(347,'2018-07-05 00:00:00','2018-07-05 00:00:00',NULL,'Chief Technology Officer','                                                \r\n                                            ','                                                \r\n                                            ','                                                \r\n                                            ','Active','Hourly',80,'Biweekly'),(348,NULL,NULL,NULL,'Photogrammetry Technician','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','                                                                                                                                                \r\n                                            \r\n                                            \r\n                                            ','Active','Hourly',0,'Weekly'),(352,'2015-04-15 00:00:00','2015-04-15 00:00:00',NULL,'Chief Technology Officer','                                                \r\n                                            ','                                                \r\n                                            ','                                                \r\n                                            ','Active','Hourly',95000,'Biweekly'),(390,'2015-04-01 00:00:00','2015-04-01 00:00:00',NULL,'Chief Executive Officer','','','','Active','Salaried',0,'Biweekly');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_entries`
--

DROP TABLE IF EXISTS `event_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_entries`
--

LOCK TABLES `event_entries` WRITE;
/*!40000 ALTER TABLE `event_entries` DISABLE KEYS */;
INSERT INTO `event_entries` VALUES (53,5,2,5),(54,6,16,6),(55,6,17,6),(56,6,18,6),(57,6,14,6),(58,6,10,6),(59,6,7,6),(60,6,11,6),(61,6,8,6),(62,6,12,6),(63,6,9,6),(64,6,1,6),(65,6,2,6),(66,6,6,6),(67,6,15,6),(68,6,13,6),(69,6,4,6),(70,6,5,6),(71,6,3,6),(109,18,18,8),(110,19,18,8),(113,18,1,8),(114,18,2,8),(115,19,1,8),(117,18,6,8),(118,18,15,8),(121,18,5,8),(122,18,3,8),(123,19,3,8),(124,19,4,8),(125,18,4,8),(128,13,2,1),(130,25,1,11),(131,25,3,11),(132,25,4,11),(133,25,18,11),(134,26,1,12),(135,28,18,17),(136,28,11,17),(137,28,1,17),(138,28,2,17),(139,28,15,17),(140,28,4,17),(141,28,3,17),(142,28,5,17),(144,31,16,16),(145,31,17,16),(146,30,18,16),(148,31,1,16),(149,31,2,16),(150,31,6,16),(151,31,15,16),(152,31,13,16),(153,31,4,16),(154,31,5,16),(155,31,3,16),(156,31,19,16),(157,30,10,16),(158,30,7,16),(159,30,11,16),(160,30,8,16),(161,30,12,16),(162,30,9,16),(163,31,14,16),(165,12,16,1),(166,12,17,1),(167,12,18,1),(168,12,14,1),(175,12,1,1),(176,12,2,1),(177,12,6,1),(178,12,15,1),(180,12,4,1),(181,12,5,1),(182,12,3,1),(187,18,7,8),(194,3,20,1),(195,18,9,8),(196,36,1,15),(197,36,3,15),(198,36,19,15),(199,36,5,15),(200,36,4,15),(201,36,13,15),(202,36,15,15),(203,36,6,15),(204,36,2,15),(207,36,7,15),(208,36,18,15),(209,36,16,15);
/*!40000 ALTER TABLE `event_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `industry_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industries`
--

LOCK TABLES `industries` WRITE;
/*!40000 ALTER TABLE `industries` DISABLE KEYS */;
INSERT INTO `industries` VALUES (1,'Land Survey'),(2,'Medical'),(3,'Retail'),(4,'Restaurant'),(5,'Groceries'),(6,'Delivery'),(7,'Software'),(8,'CAD Drafting'),(9,'Civil Engineering'),(10,'Advertising'),(11,'Music'),(12,'Entertainment'),(13,'Woodworking'),(14,'Social Profile');
/*!40000 ALTER TABLE `industries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_entries`
--

DROP TABLE IF EXISTS `permission_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `assoc_id` bigint(20) unsigned NOT NULL,
  `perm_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `perm_id` (`perm_id`),
  KEY `assoc_id` (`assoc_id`),
  CONSTRAINT `permission_entries_ibfk_1` FOREIGN KEY (`perm_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_entries_ibfk_2` FOREIGN KEY (`assoc_id`) REFERENCES `site_associations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5011 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_entries`
--

LOCK TABLES `permission_entries` WRITE;
/*!40000 ALTER TABLE `permission_entries` DISABLE KEYS */;
INSERT INTO `permission_entries` VALUES (233,23,16),(236,23,32),(237,23,23),(238,23,22),(239,23,21),(243,23,34),(244,23,35),(248,23,17),(312,25,16),(313,25,34),(314,25,35),(315,25,17),(316,25,18),(317,25,19),(318,25,36),(439,23,18),(440,23,19),(466,23,13),(467,23,15),(468,23,20),(469,23,12),(470,23,14),(471,23,43),(472,23,41),(473,23,42),(474,23,38),(475,23,39),(476,23,37),(477,23,36),(478,23,5),(479,23,2),(480,23,27),(481,23,4),(482,23,26),(483,23,3),(484,23,25),(485,23,28),(486,23,1),(488,23,24),(489,23,30),(490,23,31),(491,23,7),(492,23,9),(493,23,8),(494,23,10),(495,23,11),(496,23,40),(497,23,6),(498,23,29),(513,23,33),(660,52,16),(661,52,7),(662,52,29),(663,52,40),(664,52,6),(665,52,15),(666,52,13),(667,52,20),(674,52,34),(675,52,35),(727,52,11),(728,52,8),(729,52,9),(730,52,31),(731,52,30),(733,52,14),(735,52,32),(736,52,23),(737,52,43),(738,52,22),(739,52,41),(740,52,21),(741,52,42),(742,52,38),(743,52,39),(744,52,37),(745,52,36),(746,52,18),(747,52,19),(748,52,17),(749,52,5),(750,52,2),(751,52,27),(752,52,4),(753,52,26),(754,52,3),(756,52,28),(757,52,1),(758,52,33),(759,57,16),(760,57,7),(761,57,29),(762,57,40),(763,57,6),(3161,33,16),(3162,33,15),(3163,33,20),(3164,33,13),(3165,33,12),(3166,33,14),(3167,33,46),(3168,33,32),(3169,33,23),(3170,33,22),(3171,33,41),(3172,33,21),(3173,33,42),(3174,33,38),(3175,33,39),(3176,33,37),(3177,33,34),(3178,33,35),(3179,33,36),(3180,33,18),(3181,33,19),(3182,33,17),(3183,33,5),(3184,33,2),(3185,33,27),(3186,33,4),(3187,33,26),(3188,33,3),(3189,33,25),(3190,33,28),(3191,33,1),(3192,33,33),(3193,33,24),(3194,33,30),(3195,33,31),(3196,33,45),(3197,33,7),(3198,33,9),(3199,33,8),(3200,33,44),(3201,33,10),(3202,33,11),(3203,33,40),(3204,33,6),(3205,33,29),(4018,52,48),(4037,52,52),(4038,52,51),(4039,52,50),(4040,52,49),(4068,57,12),(4069,57,14),(4070,57,13),(4071,57,20),(4072,57,46),(4073,57,32),(4074,57,23),(4075,57,43),(4076,57,22),(4077,57,41),(4078,57,21),(4079,57,42),(4080,57,52),(4081,57,51),(4082,57,50),(4083,57,49),(4084,57,38),(4085,57,39),(4086,57,37),(4087,57,34),(4088,57,35),(4089,57,36),(4090,57,18),(4091,57,47),(4092,57,19),(4093,57,17),(4094,57,5),(4095,57,2),(4096,57,27),(4097,57,4),(4098,57,26),(4099,57,3),(4100,57,25),(4101,57,28),(4102,57,1),(4103,57,33),(4104,57,24),(4105,57,30),(4106,57,31),(4107,57,45),(4108,57,9),(4109,57,8),(4110,57,44),(4111,57,10),(4112,57,11),(4113,57,48),(4114,57,15),(4611,344,16),(4612,344,12),(4613,344,13),(4614,344,14),(4615,344,19),(4616,344,20),(4617,344,25),(4618,344,26),(4619,344,33),(4620,344,34),(4621,344,35),(4622,344,17),(4623,344,41),(4624,344,1),(4625,344,2),(4626,344,3),(4627,344,4),(4628,344,24),(4629,344,37),(4630,344,42),(4631,344,7),(4632,344,29),(4633,344,40),(4634,344,6),(4635,344,15),(4636,344,48),(4637,344,11),(4638,344,10),(4639,344,44),(4640,344,8),(4641,344,9),(4642,344,45),(4643,344,31),(4644,344,30),(4645,344,28),(4646,344,27),(4647,344,5),(4648,344,47),(4649,344,18),(4650,344,36),(4651,344,39),(4652,344,38),(4653,344,49),(4654,344,50),(4655,344,51),(4656,344,52),(4657,344,21),(4658,344,22),(4659,344,43),(4660,344,23),(4661,344,32),(4662,344,46),(4667,23,46),(4668,23,52),(4669,23,51),(4670,23,50),(4671,23,49),(4672,23,47),(4673,23,44),(4674,23,45),(4675,23,48),(4676,346,16),(4677,347,16),(4678,347,34),(4680,347,35),(4681,346,34),(4682,346,35),(4683,346,12),(4684,346,13),(4685,346,14),(4686,346,20),(4687,347,20),(4688,347,14),(4689,347,13),(4691,347,15),(4692,346,15),(4693,346,46),(4694,346,32),(4695,346,23),(4696,346,43),(4697,346,22),(4698,346,41),(4699,346,21),(4700,346,42),(4701,346,52),(4702,346,51),(4703,346,50),(4704,346,49),(4705,346,38),(4706,346,39),(4707,346,37),(4708,346,36),(4709,346,18),(4710,346,47),(4711,346,19),(4712,346,17),(4713,346,5),(4714,346,2),(4715,346,27),(4716,346,4),(4717,346,26),(4718,346,3),(4719,346,25),(4720,346,1),(4721,346,28),(4722,346,33),(4723,346,24),(4724,346,30),(4725,346,31),(4726,346,45),(4727,346,7),(4728,346,9),(4729,346,8),(4730,346,44),(4731,346,10),(4732,346,11),(4733,346,40),(4734,346,6),(4735,346,29),(4736,346,48),(4737,347,46),(4738,347,32),(4739,347,23),(4740,347,43),(4741,347,22),(4742,347,41),(4743,347,21),(4744,347,42),(4745,347,52),(4746,347,51),(4747,347,50),(4748,347,49),(4749,347,38),(4750,347,39),(4751,347,37),(4752,347,36),(4753,347,18),(4754,347,47),(4755,347,19),(4756,347,17),(4757,347,5),(4758,347,2),(4759,347,27),(4760,347,4),(4761,347,26),(4762,347,3),(4763,347,25),(4764,347,28),(4765,347,1),(4766,347,33),(4767,347,24),(4768,347,30),(4769,347,31),(4770,347,45),(4771,347,7),(4772,347,9),(4773,347,8),(4774,347,44),(4775,347,10),(4776,347,11),(4777,347,40),(4778,347,6),(4779,347,29),(4780,347,48),(4782,347,12),(4783,349,12),(4784,349,14),(4785,349,16),(4786,349,13),(4787,349,46),(4788,349,20),(4797,352,12),(4798,352,13),(4799,352,16),(4800,352,20),(4801,352,36),(4802,352,15),(4803,348,12),(4806,348,16),(4807,348,20),(4808,348,35),(4809,348,34),(4810,348,19),(4838,347,53),(4839,346,53),(4840,348,53),(4841,348,6),(4842,348,40),(4843,348,7),(4844,348,8),(4845,348,9),(4846,352,14),(4847,352,7),(4848,352,9),(4849,352,8),(4850,352,53),(4852,52,25),(4853,52,12),(4854,52,53),(4926,385,16),(4927,385,34),(4928,385,35),(4929,385,6),(4930,386,16),(4931,386,34),(4932,386,35),(4933,387,16),(4934,387,34),(4935,387,35),(4936,387,6),(4937,33,52),(4938,33,51),(4939,33,50),(4940,33,49),(4941,33,47),(4942,33,53),(4943,33,48),(4944,388,16),(4945,388,34),(4946,388,35),(4947,388,6),(4948,389,16),(4949,389,34),(4950,389,35),(4951,390,16),(4952,390,34),(4953,390,35),(4954,390,7),(4955,390,8),(4956,390,6),(4957,390,53),(4958,390,12),(4959,390,14),(4960,390,13),(4961,390,20),(4962,390,46),(4963,390,32),(4964,390,23),(4965,390,43),(4966,390,22),(4967,390,41),(4968,390,21),(4969,390,42),(4970,390,52),(4971,391,16),(4972,391,34),(4973,391,35),(4974,391,6),(4975,392,16),(4976,392,34),(4977,392,35),(4978,393,16),(4979,393,34),(4980,393,35),(4981,393,6),(4982,394,16),(4983,394,34),(4984,394,35),(4985,395,16),(4986,395,34),(4987,395,35),(4988,395,6),(4989,396,16),(4990,396,34),(4991,396,35),(4992,397,16),(4993,397,34),(4994,397,35),(4995,397,6),(4996,350,16),(4997,398,12),(4998,398,13),(4999,398,16),(5000,398,20),(5001,398,36),(5002,398,15),(5003,399,16),(5004,399,34),(5005,399,35),(5006,400,16),(5007,400,34),(5008,400,35),(5009,400,6),(5010,344,53);
/*!40000 ALTER TABLE `permission_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `perm_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'View Timesheet','TS_VIEW'),(2,'Create Timesheet','TS_CREATE'),(3,'Edit Timesheet','TS_EDIT'),(4,'Delete Timesheet','TS_DELETE'),(5,'Approve Timesheet','TS_APPROVE'),(6,'View Project','WF_VIEW'),(7,'Create Project','WF_CREATE'),(8,'Edit Project','WF_EDIT'),(9,'Delete Project','WF_DELETE'),(10,'Process Order','WF_PROCESSORDER'),(11,'Process RFP','WF_PROCESSRFP'),(12,'Create Member','AS_CREATE'),(13,'Edit Member','AS_EDIT'),(14,'Delete Member','AS_DELETE'),(15,'Site Maintainer','WW_SITEMAINTAINER'),(16,'Login','AS_LOGIN'),(17,'View Schedule','SC_VIEW'),(18,'Dispatch Crew','SC_DISPATCH'),(19,'Manage Crew','SC_MANAGECREW'),(20,'View Memberships','AS_VIEW'),(21,'Upload File','CM_UPLOAD'),(22,'Download File','CM_DOWNLOAD'),(23,'Delete File','CM_DELETE'),(24,'View Task Codes','TS_VIEW_TC'),(25,'Edit Task Codes','TS_EDIT_TC'),(26,'Delete Task Codes','TS_DELETE_TC'),(27,'Create Task Codes','TS_CREATE_TC'),(28,'Reverse Timesheet','TS_REVERSE'),(29,'View RFP','WF_VIEWRFP'),(30,'Assign Drafter','WF_ASSIGNDRAFTER'),(31,'Assign Surveyor','WF_ASSIGNSURVEYOR'),(32,'Browse Files','CM_BROWSE'),(33,'Timesheet Administrator','TS_VIEWALL'),(34,'View Mail Message','MA_VIEW'),(35,'Write Mail Message','MA_WRITE'),(36,'Create News Article','RSS_CREATE'),(37,'View Subdivision','GIS_VIEWSUBDIVISION'),(38,'Create Subdivision','GIS_CREATESUBDIVISION'),(39,'Edit Subdivision','GIS_EDITSUBDIVISION'),(40,'Search Projects','WF_SEARCH'),(41,'Stage Files to Site','CM_STAGE'),(42,'View Staged Files','CM_VIEW_STAGED'),(43,'Delete Staged Files','CM_DELETE_STAGED'),(44,'Manage Delinquent Accounts','WF_MANAGE_DELINQUENT'),(45,'Assign Project Manager','WF_ASSIGN_PROJECTMANAGER'),(46,'Associate File to GIS Map','CM_ASSOCIATE_MAP'),(47,'Global Scheduler','SC_GLOBAL_SCHEDULER'),(48,'Manage Product Catalog','WW_MANAGECATALOG'),(49,'Process Customer Payments','CT_PROCESSPAYMENTS'),(50,'Fulfill Orders','CT_FULFILLORDERS'),(51,'Deliver Orders','CT_DELIVERORDERS'),(52,'Close Orders','CT_CLOSEORDERS'),(53,'View Project Statistics','WF_VIEWSTATS');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_events`
--

DROP TABLE IF EXISTS `role_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_events` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_id` bigint(20) NOT NULL,
  `event_author` bigint(20) NOT NULL,
  `event_date` datetime NOT NULL,
  `event_type` varchar(45) NOT NULL,
  `event_description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_events`
--

LOCK TABLES `role_events` WRITE;
/*!40000 ALTER TABLE `role_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_associations`
--

DROP TABLE IF EXISTS `site_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_associations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  `assoc_type` smallint(5) unsigned NOT NULL,
  `conf_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_userid` (`user_id`),
  KEY `FK_siteid` (`site_id`),
  CONSTRAINT `site_associations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `webwarecl`.`users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `site_associations_ibfk_3` FOREIGN KEY (`site_id`) REFERENCES `sites` (`SiteID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_associations`
--

LOCK TABLES `site_associations` WRITE;
/*!40000 ALTER TABLE `site_associations` DISABLE KEYS */;
INSERT INTO `site_associations` VALUES (23,724,5,1,NULL),(25,734,5,0,'5A4FAF80-AD48-20DC-E82847D65D38791A'),(33,725,5,1,NULL),(52,724,6,1,'22DAAF2A-F32D-EEFE-AD21704B2346FECC'),(57,725,6,1,'6A7A3319-02CD-0939-205CE4BC84A5D3B8'),(344,724,19,1,'4B21C5DD-19B9-CB32-B7688C5B25A9511E'),(346,725,20,1,NULL),(347,724,20,1,NULL),(348,734,20,1,NULL),(349,724,20,0,NULL),(350,725,20,0,NULL),(352,724,24,1,'1A88D311-A649-45C9-9F10C52B879AF0EE'),(385,724,5,0,'02DF98DF-0210-44E6-8418A55AD86E5B47'),(386,910,5,0,'DC9AD5B6-405C-44B8-940AD2E073530A20'),(387,910,5,0,'D453BD05-8B35-4514-8E9C211CCFCE60FF'),(388,725,5,0,'D44C2A73-A77B-4AED-AD8E9A210FE038F0'),(389,911,5,0,'F8630DAB-1A8E-4632-91A5E539DAB52015'),(390,911,24,1,'CF94CCAA-C11C-4A3E-ADD23D645234B84F'),(391,725,6,0,'DE9A2EF1-8AED-440F-8F3A6A7BBA5C9D71'),(392,912,5,0,'85BBDC35-F1F0-433B-AC70A3A24E865BC6'),(393,912,5,0,'8EB0CCB3-F83D-4C88-AE6A0F3277167A51'),(394,913,5,0,'B67CF63A-B9F6-4C4B-BD75E7BA7E4C5455'),(395,913,5,0,'97AD1BFD-84A7-41B6-BB46A491B4FB612A'),(396,914,5,0,'789920C3-E3B5-4FAA-AFDBAFBBE5D7B48A'),(397,914,20,0,'A9BFA064-FD55-4FD8-846F9D1A22806F6E'),(398,725,25,1,'40F68C2E-9671-4230-91461779CB31F9D3'),(399,915,5,0,'4D57A6CA-C1C0-457D-9AFD6FC3BB17462C'),(400,915,19,0,'0A22FEF0-8518-46F9-A904D61FCCD3CC6C');
/*!40000 ALTER TABLE `site_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_ratings`
--

DROP TABLE IF EXISTS `site_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_ratings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `site_id` bigint(20) unsigned NOT NULL,
  `rating_date` datetime NOT NULL,
  `rating_value` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_ratings`
--

LOCK TABLES `site_ratings` WRITE;
/*!40000 ALTER TABLE `site_ratings` DISABLE KEYS */;
INSERT INTO `site_ratings` VALUES (1,724,1,'2007-12-19 22:36:36',6),(2,725,1,'2007-12-19 22:46:28',10),(4,725,5,'2007-12-19 22:55:59',10),(5,724,5,'2007-12-19 23:01:26',5),(7,725,6,'2007-12-21 12:27:12',7),(8,735,1,'2007-12-27 11:13:25',10),(9,724,6,'2008-01-01 16:59:22',9),(10,732,6,'2008-01-01 17:56:40',10),(11,754,6,'2008-01-02 15:59:05',10),(12,732,1,'2008-01-09 16:29:05',8),(13,725,7,'2008-03-11 15:54:09',10),(14,774,5,'2008-03-24 19:02:13',10),(15,733,5,'2008-04-04 10:37:25',10),(16,733,1,'2008-04-04 10:37:43',10),(17,725,8,'2008-04-07 12:02:49',10),(18,725,12,'2008-06-09 15:41:21',8),(19,725,11,'2008-06-09 16:19:06',10),(20,724,16,'2008-06-10 16:14:50',10),(21,732,16,'2008-08-07 15:24:26',10),(22,724,17,'2008-12-07 10:47:23',10),(23,740,17,'2009-01-14 21:35:31',10),(24,784,8,'2009-05-28 17:18:30',10),(25,752,1,'2009-11-07 20:59:00',10);
/*!40000 ALTER TABLE `site_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `SiteID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SiteName` text NOT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `logo_file_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned NOT NULL,
  `enabled` tinyint(3) unsigned NOT NULL,
  `summary` text,
  `about` text,
  `mission_statement` text,
  `vision_statement` text,
  `slogan` text,
  `billing_plan` bigint(20) unsigned DEFAULT NULL,
  `conf_id` varchar(45) DEFAULT NULL,
  `salestax_rate` float NOT NULL DEFAULT '0',
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `website` varchar(45) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `sales_email` varchar(255) DEFAULT NULL,
  `billing_email` varchar(255) DEFAULT NULL,
  `facebook_handle` varchar(255) DEFAULT NULL,
  `twitter_handle` varchar(255) DEFAULT NULL,
  `instagram_handle` varchar(255) DEFAULT NULL,
  `linkedin_handle` varchar(255) DEFAULT NULL,
  `youtube_handle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SiteID`),
  KEY `logo_file_id` (`logo_file_id`),
  CONSTRAINT `sites_ibfk_1` FOREIGN KEY (`logo_file_id`) REFERENCES `webware_cms`.`user_files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (5,'Geodigraph Social',NULL,NULL,724,1,'Prefiniti is a comprehensive business management and social networking tool developed to help companies gain an edge in a market place with standards that are driven by larger corporations.','<p>Prefiniti is a new type of web-based software developed by the owner of a land survey company in Las Cruces, New Mexico, and his friend in software design. Our first product was a basic web-based ordering system created in one afternoon for  the survey firm. From that beginning, Prefiniti evolved into its present form.</p>\r\n<p>Prefiniti provides business owners and their employees the opportunity to work more efficiently, allowing them to reach their full potential. Our pledge is to make that as easy as possible.</p>','','','Many problems... one solution.',1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Test Site',NULL,NULL,724,1,'','','','','',1,NULL,7.125,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,'Coherent Logic Development',NULL,NULL,724,1,'','','','','Solutions//Everywhere',NULL,'4B21C5DD-19B9-CB32-B7688C5B25A9511E',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'Geodigraph Software','GIS Software Development',NULL,725,1,'','                    \r\n                ','                    \r\n                ','                    \r\n                ','',NULL,NULL,0,'425 S. Telshor Blvd., Ste C202','Las Cruces','NM','88011','5755209542','','https://www.geodigraph.com/software','info@geodigraph.com','sales@geodigraph.com','billing@geodigraph.com','','','','',''),(24,'Fourth Watch BCS Inc.',NULL,NULL,724,1,NULL,NULL,NULL,NULL,NULL,NULL,'CAA2DFBD-A386-4B7D-BB21915069B67912',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'Geodigraph Survey',NULL,NULL,725,1,NULL,NULL,NULL,NULL,NULL,NULL,'8C79EB41-7E4E-457E-BEC317C424FE4ED4',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-27 15:46:31
