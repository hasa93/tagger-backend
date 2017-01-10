-- MySQL dump 10.16  Distrib 10.1.18-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tagger
-- ------------------------------------------------------
-- Server version	10.1.18-MariaDB

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
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(10) DEFAULT NULL,
  `branch_addr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'KOHUWALA','SOME_ADDRESS'),(2,'MAKOLA','SOME_ADDRESS');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_fname` varchar(15) DEFAULT NULL,
  `cust_lname` varchar(15) DEFAULT NULL,
  `cust_cat` char(4) DEFAULT NULL,
  `cust_contact` varchar(10) DEFAULT NULL,
  `cust_addr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Tom','Hagen','reg','0115559031','32, long island'),(5,'Amy','Johnson','REG','0774343457',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flags` (
  `cust_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  PRIMARY KEY (`cust_id`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (3,8),(3,17),(3,20),(6,2),(12,3);
/*!40000 ALTER TABLE `flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `branch_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `inflow` int(11) DEFAULT '0',
  `outflow` int(11) DEFAULT '0',
  PRIMARY KEY (`branch_id`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,3,800,0),(1,6,3400,0),(1,10,3200,0),(1,19,6000,0),(2,6,3500,0);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `invoice_total` float DEFAULT '0',
  `voucher_amount` float DEFAULT '0',
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (3,'2016-09-11 21:27:51',12000,0,1),(4,'2016-09-11 22:42:34',8600,0,1),(5,'2016-09-11 23:17:09',2500,0,1),(6,'2016-09-12 19:47:35',240,0,1),(7,'2016-09-12 19:55:50',1100,0,1),(8,'2016-09-12 19:58:02',1200,0,1),(9,'2016-09-13 11:56:25',1500,1000,1),(10,'2016-09-13 12:03:43',2700,1000,1),(11,'2016-09-13 22:10:55',9200,1000,1),(12,'2016-09-13 23:40:17',0,3500,1),(13,'2016-09-14 09:28:00',7600,0,1),(14,'2016-09-14 09:29:25',3800,0,1),(15,'2016-09-14 09:49:52',0,4500,1);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logins` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(16) DEFAULT NULL,
  `passwd` varchar(40) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `cust_id` int(11) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `token_expiry` varchar(13) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `fk_StaffLogin` (`staff_id`),
  KEY `fk_CustLogin` (`cust_id`),
  CONSTRAINT `fk_CustLogin` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_StaffLogin` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (1,'codon@baby','4e77aed011c838c1d67b38b807f7ee48a89ef35a',2,NULL,NULL,NULL,NULL),(35,'hafzar@baby','117323acb9171bef2efe3a8e1d587391297224a1',34,NULL,NULL,NULL,NULL),(36,'malithsen@baby','17618f01a3a21b911c925bcb525a1d21abd30673',35,NULL,'b23b34c14be2ea13b7ecdef495a95270aaaef0618a519e226b','1483891454262','jogeggbert@gmail.com'),(37,'jhl@baby','b0399d2029f64d445bd131ffaa399a42d2f8e7dc',36,NULL,'469a337b605488f7d6afd7a313c13d75c9bc9c9d8e0ae7ee86','1483891596661','hasanga.charaka@gmail.com'),(38,'hamid@baby','fadc37572648d56762d47b309e6f78c02e5b9626',8,NULL,'5107e72ab6b6107bd5504e76fd42ac7fe60511621cc8001dcb','1484026258711','hashan.nilupul@gmail.com');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(100) DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `prod_cat` char(4) DEFAULT NULL,
  `arr_date` date DEFAULT NULL,
  `age_range` varchar(5) DEFAULT 'ANY',
  `discontinued` tinyint(1) DEFAULT '0',
  `returnable` tinyint(1) DEFAULT '0',
  `prod_image` varchar(100) DEFAULT NULL,
  `prod_desc` mediumtext,
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'Navy Blue Top',4300,'CLTH','2016-09-04','ANY',0,0,'dress-one.jpg',NULL),(3,'RC Drone 4Q',12500,'TOYS','2016-09-04','ANY',1,1,'dress-two.jpg',NULL),(4,'Boys bright tshirts',1300,'CLOT','2016-09-01','ANY',0,0,'dress-one.jpg',NULL),(5,'Boys jersy pull on shorts',1200,'CLOT','2016-09-04','ANY',0,0,'dress-two.jpg',NULL),(6,'Boys heritage jersy',1300,'CLOT','2016-09-04','ANY',0,0,'dress-one.jpg',NULL),(7,'Camero baby logo crew suit',2200,'CLOT','2016-09-03','1Y-5Y',0,0,'dress-one.jpg',NULL),(8,'Adidas original baby boy t-shirt',5400,'CLOT','2016-08-17','ANY',0,0,'2a61450e67b9f79e6413f343f3752fdafa531485.jpg','Casual wear for both genders with hoody'),(9,'Boys denim shorts',1300,'CLOT','2016-09-04','ANY',0,0,'dress-one.jpg',NULL),(10,'Boys tops',1100,'CLOT','2016-09-04','ANY',0,0,'dress-one.jpg',NULL),(11,'Graco Baby Breeze Stroller',42,'OTHE','2016-09-01','ANY',0,0,'dress-one.jpg',NULL),(12,'Varsity Puffer',2471.96,'CLOT','2016-09-01','5Y-9Y',0,0,'dress-one.jpg',NULL),(17,'Auburn teen shirts - long sleeves',2342.89,'CLOT','2016-10-30','9Y-12',0,0,'dress-one.jpg',NULL),(18,'Gk Pacifier',550,'SNTR','2016-12-04','6M-1Y',0,0,'1be05795f27a48c09296ed467433df840d6ba2e8.jpg','Ultimate cry stopper!'),(19,'Hubba Hubba',500,'FEED','2017-01-07','6M-1Y',0,0,'4b2f3b8c129e5ca20576579ac0e959fe57cf2966.jpg','');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `cust_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `prod_rating` int(5) DEFAULT NULL,
  PRIMARY KEY (`cust_id`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (3,4,3),(3,8,4),(3,16,3),(3,20,4);
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_records`
--

DROP TABLE IF EXISTS `sales_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales_records` (
  `product_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`invoice_id`),
  KEY `fk_InvoiceId` (`invoice_id`),
  CONSTRAINT `fk_InvoiceId` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_ProductId` FOREIGN KEY (`product_id`) REFERENCES `products` (`prod_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_records`
--

LOCK TABLES `sales_records` WRITE;
/*!40000 ALTER TABLE `sales_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_type` char(3) DEFAULT NULL,
  `staff_fname` varchar(15) DEFAULT NULL,
  `staff_lname` varchar(15) DEFAULT NULL,
  `staff_contact` varchar(10) DEFAULT 'N/A',
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_BranchKey` (`branch_id`),
  CONSTRAINT `fk_BranchKey` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (2,'mgr','Michael','Coroleone','0115559031',1),(4,'csh','John','Langdon','N/A',1),(6,'csh','Nathan','Kowalski','0115559031',1),(7,'csh','Harlem','Channing','0115559031',1),(8,'mgr','Hamid','Kazmi','N/A',2),(9,'csh','Enid','Litsnikov','0112500988',1),(10,'csh','John','Spitzer','N/A',1),(21,'csh','Sam','Hawkings','0725893836',1),(22,'csh','Madura','Herath','0765432187',1),(23,'csh','Thushara','Sandekalum',NULL,1),(24,'mgr','Vito','Coroleone','0115559031',1),(25,'csh','Vin','Petrol',NULL,1),(26,'csh','Sam','Norton',NULL,1),(27,'csh','Ernest','Hemingway',NULL,1),(28,'csh','Elijah','Wood',NULL,1),(29,'csh','Amy','Collingridge',NULL,1),(30,'csh','Pasan','Missaka',NULL,1),(31,'csh','Fred','Jenkins',NULL,1),(32,'csh','Tikiri','Muney','0779938401',NULL),(33,'csh','Alejandro','Rojas','0123456780',NULL),(34,'mgr','Hamid','Afzar','0771111111',2),(35,'csh','Malith','Senaweera','0771111111',1),(36,'csh','John','Langdon','0123456789',1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_map`
--

DROP TABLE IF EXISTS `tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_map` (
  `tag_uid` varchar(16) NOT NULL,
  `prod_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`tag_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_map`
--

LOCK TABLES `tag_map` WRITE;
/*!40000 ALTER TABLE `tag_map` DISABLE KEYS */;
INSERT INTO `tag_map` VALUES ('04046012F94881',5),('04206012F94881',4),('04396012F94881',4),('53918F01',1),('668E86AB',6),('7334F401',2),('840F9535',5),('85B7DF52',3),('A43DEF',21);
/*!40000 ALTER TABLE `tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucher` (
  `vouch_id` int(11) NOT NULL AUTO_INCREMENT,
  `issued_branch` int(11) DEFAULT NULL,
  `vouch_amount` decimal(7,2) DEFAULT NULL,
  `issue_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exp_date` date DEFAULT NULL,
  `cust_contact` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`vouch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (7,1,5000.00,'2016-09-13 17:41:35','2016-09-20','0774343457'),(9,1,2500.00,'2016-09-13 17:48:07','2016-09-20','0774343457'),(11,NULL,3500.00,'2016-09-13 18:03:03','2016-09-20','0774343457'),(12,2,5200.00,'2016-11-20 05:00:26','2017-01-05','0774343457'),(15,1,2500.00,'2016-11-20 05:27:25','2016-11-27','0774343457'),(16,1,5400.00,'2016-11-20 05:35:28','2016-11-27','0774343457'),(17,1,5000.00,'2016-11-20 05:38:34','2016-11-27','0774343457'),(18,1,5000.00,'2016-11-20 05:39:48','2016-11-27','0774343457'),(19,1,5400.00,'2016-11-20 05:41:17','2016-11-27','0774343457'),(21,1,5500.00,'2016-11-20 05:42:08','2016-11-27','0115559031'),(22,1,5400.00,'2016-11-20 05:42:51','2016-11-27','0115559031'),(23,1,2300.00,'2016-11-20 05:44:02','2016-11-27','0115559031'),(24,1,5400.00,'2016-11-20 05:44:43','2016-11-27','0115559031'),(25,1,5600.00,'2016-11-20 05:47:07','2016-11-27','0115559031'),(27,1,2300.00,'2016-11-20 05:56:32','2016-11-27','0115559031'),(28,1,4500.00,'2016-11-20 06:03:21','2016-11-27','0115559031'),(29,1,3500.00,'2016-11-20 06:04:31','2016-11-27','0115559031'),(30,1,3400.00,'2016-11-20 06:15:54','2016-11-27','0115559031'),(31,1,2500.00,'2016-12-06 16:41:34','2016-12-13',NULL),(32,1,3000.00,'2016-12-06 16:42:36','2016-12-13','0774343457');
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-10 10:26:13
