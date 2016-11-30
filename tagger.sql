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
INSERT INTO `customer` VALUES (1,'Tom','Hagen','reg','0115559031','32, long island'),(5,'Amy','Johnson','REG','amy@koheda',NULL);
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
  `prod_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (6,2),(12,3);
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
  `product_id` int(11) NOT NULL,
  `product_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`branch_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,1000),(1,3,400),(1,4,500),(2,5,5540);
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
  PRIMARY KEY (`login_id`),
  KEY `fk_StaffLogin` (`staff_id`),
  KEY `fk_CustLogin` (`cust_id`),
  CONSTRAINT `fk_CustLogin` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_StaffLogin` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (1,'codon@baby','7402411f9090581314be0304d5d1b9d95d6f4079',2,NULL,NULL,NULL),(3,'hagen@baby','403926033d001b5279df37cbbe5287b7c7c267fa',NULL,1,'375996df1c20bb05be5216fb79979e09ee86eb9d9c06106bda','1480578643385'),(4,'jhl@baby','6794d21b82ccbc26c3c80f0d4976a76ab0446ad7',4,NULL,NULL,NULL),(5,'kowalski@baby','403926033d001b5279df37cbbe5287b7c7c267fa',6,NULL,NULL,NULL),(6,'harlem@baby','a9b9f1fd61015b368e60e370d4a45629dc6c0b40',7,NULL,NULL,NULL),(7,'master@baby','4f26aeafdb2367620a393c973eddbe8f8b846ebd',NULL,NULL,NULL,NULL),(8,'enid@baby','a17b0df349245a2d8516dce05de86d7c7889cb2c',9,NULL,NULL,NULL),(9,'john@baby','e851ceec80c23cc168884d85b1f9b0251c07ad76',10,NULL,'97ae6d0a2a9094f4f7e4107172ba3144664e8d606822e93f7b','2147483647'),(20,'sam@baby','2c5dc58f48bd132b1eb3d309997965aadd606580',21,NULL,NULL,NULL),(21,'madura@baby','01f178b93aa694902c50dd682943f02a92483376',22,NULL,NULL,NULL),(22,'thushara@baby','a76ea889caa25201955ae27d15e7f5fe4c5aaf0a',23,NULL,NULL,NULL),(23,'don@baby','96d029b9830b7f04b48672c932276350598b3753',24,NULL,NULL,NULL),(24,'vin@baby','88eaa48ac5692719ed8b6b0e1056340912bf9798',25,NULL,NULL,NULL),(25,'sam@baby','2c5dc58f48bd132b1eb3d309997965aadd606580',26,NULL,NULL,NULL),(26,'ernest@baby','79f960352f93b150d47d0cbc488df95fc8285a4e',27,NULL,NULL,NULL),(27,'elijah@baby','8319978631a625bea6969b9e8e38be1c5268ab6a',28,NULL,NULL,NULL),(28,'amy@baby','060a7fa5bf698adf8c980eac539218ce7cdec9df',29,NULL,NULL,NULL),(29,'psn@baby','ea120f797e17e81c3b695b1b5a221da8bbcf2ae4',30,NULL,NULL,NULL),(30,'fred@baby','36bec0cca92affa5aff75428269869949b75256c',31,NULL,NULL,NULL),(32,'meamy','4c43663c4f6bea779af3d2a94d21afb7ec7f61ac',NULL,5,NULL,NULL),(33,'TikiriMuney','f7c3bc1d808e04732adf679965ccc34ca7ae3441',32,NULL,NULL,NULL),(34,'arojas','f4ddc0a77ecb5492773c081633aace30d1e677ee',33,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Gk Pacifier',120,'SNTR','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-three.jpg',NULL),(2,'Navy Blue Top',4300,'CLTH','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(3,'RC Drone 4Q',12500,'TOYS','2016-09-04','ANY',1,1,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-two.jpg',NULL),(4,'Boys bright tshirts',1300,'CLOT','2016-09-01','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(5,'Boys jersy pull on shorts',1200,'CLOT','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-two.jpg',NULL),(6,'Boys heritage jersy',1300,'CLOT','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(7,'Camero baby logo crew suit',2200,'CLOT','2016-09-03','1Y-5Y',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(8,'Adidas original baby boy t-shirt',5400,'CLOT','2016-08-19','6M-1Y',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(9,'Boys denim shorts',1300,'CLOT','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(10,'Boys tops',1100,'CLOT','2016-09-04','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(11,'Graco Baby Breeze Stroller',42,'OTHE','2016-09-01','ANY',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(12,'Varsity Puffer',2471.96,'CLOT','2016-09-01','5Y-9Y',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL),(17,'Auburn teen shirts - long sleeves',2342.89,'CLOT','2016-10-30','9Y-12',0,0,'/home/hasa93/Projects/Tagger/tagger-backend/thumbs/dress-one.jpg',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
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
INSERT INTO `sales_records` VALUES (1,6,2),(2,3,3),(2,4,2),(3,3,1),(4,5,1),(4,9,1),(4,11,4),(4,12,2),(4,13,4),(4,14,2),(4,15,2),(5,5,1),(5,8,1),(5,9,1),(5,10,2),(5,11,1),(5,13,2),(5,14,1),(5,15,1),(6,10,1),(10,7,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (2,'mgr','Michael','Coroleone','0115559031',1),(4,'csh','John','Langdon','N/A',1),(6,'csh','Nathan','Kowalski','0115559031',1),(7,'csh','Harlem','Channing','0115559031',1),(8,'mst','MASTER',NULL,'N/A',1),(9,'csh','Enid','Litsnikov','0112500988',1),(10,'csh','John','Spitzer','N/A',1),(21,'csh','Sam','Hawkings','0725893836',1),(22,'csh','Madura','Herath','0765432187',1),(23,'csh','Thushara','Sandekalum',NULL,1),(24,'mgr','Vito','Coroleone','0115559031',1),(25,'csh','Vin','Petrol',NULL,1),(26,'csh','Sam','Norton',NULL,1),(27,'csh','Ernest','Hemingway',NULL,1),(28,'csh','Elijah','Wood',NULL,1),(29,'csh','Amy','Collingridge',NULL,1),(30,'csh','Pasan','Missaka',NULL,1),(31,'csh','Fred','Jenkins',NULL,1),(32,'csh','Tikiri','Muney','0779938401',NULL),(33,'csh','Alejandro','Rojas','0123456780',NULL);
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
INSERT INTO `tag_map` VALUES ('04046012F94881',5),('04206012F94881',4),('04396012F94881',4),('53918F01',1),('668E86AB',6),('7334F401',2),('840F9535',5),('85B7DF52',3);
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
  PRIMARY KEY (`vouch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (7,1,5000.00,'2016-09-13 17:41:35','2016-09-20'),(9,1,2500.00,'2016-09-13 17:48:07','2016-09-20'),(11,NULL,3500.00,'2016-09-13 18:03:03','2016-09-20'),(12,2,5200.00,'2016-11-20 05:00:26','2017-01-05'),(15,1,2500.00,'2016-11-20 05:27:25','2016-11-27'),(16,1,5400.00,'2016-11-20 05:35:28','2016-11-27'),(17,1,5000.00,'2016-11-20 05:38:34','2016-11-27'),(18,1,5000.00,'2016-11-20 05:39:48','2016-11-27'),(19,1,5400.00,'2016-11-20 05:41:17','2016-11-27'),(21,1,5500.00,'2016-11-20 05:42:08','2016-11-27'),(22,1,5400.00,'2016-11-20 05:42:51','2016-11-27'),(23,1,2300.00,'2016-11-20 05:44:02','2016-11-27'),(24,1,5400.00,'2016-11-20 05:44:43','2016-11-27'),(25,1,5600.00,'2016-11-20 05:47:07','2016-11-27'),(27,1,2300.00,'2016-11-20 05:56:32','2016-11-27'),(28,1,4500.00,'2016-11-20 06:03:21','2016-11-27'),(29,1,3500.00,'2016-11-20 06:04:31','2016-11-27'),(30,1,3400.00,'2016-11-20 06:15:54','2016-11-27');
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

-- Dump completed on 2016-11-30 17:13:59
