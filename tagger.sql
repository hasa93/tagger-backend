-- MySQL dump 10.16  Distrib 10.1.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tagger
-- ------------------------------------------------------
-- Server version	10.1.16-MariaDB

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Tom','Hagen','reg','0115559031','32, long island');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
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
  PRIMARY KEY (`login_id`),
  KEY `fk_StaffLogin` (`staff_id`),
  KEY `fk_CustLogin` (`cust_id`),
  CONSTRAINT `fk_CustLogin` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_StaffLogin` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (1,'codon@baby','b5c35f0e747e39007251c45ba4d54cef269e03d0',2,NULL),(3,'hagen@baby','d96c88ee0dd006414cee59ba9c2ef07174408f73',NULL,1),(4,'jhl@baby','6794d21b82ccbc26c3c80f0d4976a76ab0446ad7',4,NULL),(5,'kowalski@baby','f56f228a1bfbb14683b61a1e3b42f3eaa3c58d81',6,NULL),(6,'harlem@baby','a9b9f1fd61015b368e60e370d4a45629dc6c0b40',7,NULL);
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
  `age_range` varchar(5) DEFAULT NULL,
  `discontinued` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Gk Pacifier',120,'SNTR',NULL,NULL,0),(2,'Navy Blue Top',4300,'CLTH',NULL,NULL,0),(3,'RC Drone 4Q',12500,'TOYS',NULL,NULL,1),(4,'Boys bright tshirts',1300,'CLOT',NULL,NULL,0),(5,'Boys jersy pull on shorts',1200,'CLOT',NULL,NULL,0),(6,'Boys heritage jersy',1300,'CLOT',NULL,NULL,0),(7,'Adidas baby logo crew suit',2200,'CLOT',NULL,NULL,0),(8,'Adidas original baby boy t-shirt',1500,'CLOT',NULL,NULL,0),(9,'Boys denim shorts',1300,'CLOT',NULL,NULL,0),(10,'Boys tops',1100,'CLOT',NULL,NULL,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_records`
--

DROP TABLE IF EXISTS `purchase_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_records` (
  `purch_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` char(5) DEFAULT NULL,
  `cashier_id` char(5) DEFAULT NULL,
  `voucher_id` char(5) DEFAULT NULL,
  `prod_qty` int(3) DEFAULT NULL,
  PRIMARY KEY (`purch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_records`
--

LOCK TABLES `purchase_records` WRITE;
/*!40000 ALTER TABLE `purchase_records` DISABLE KEYS */;
INSERT INTO `purchase_records` VALUES (1,'00001',NULL,NULL,1),(2,'00002',NULL,NULL,2),(3,'00003',NULL,NULL,1),(4,'00001',NULL,NULL,1),(5,'00002',NULL,NULL,1);
/*!40000 ALTER TABLE `purchase_records` ENABLE KEYS */;
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
  `staff_contact` varchar(10) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_BranchKey` (`branch_id`),
  CONSTRAINT `fk_BranchKey` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (2,'mgr','Michael','Coroleone','0115559031',NULL),(4,'csh','John','Langdon',NULL,NULL),(6,'csh','Nathan','Kowalski','0115559031',NULL),(7,'csh','Harlem','Channing','0115559031',NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_map`
--

DROP TABLE IF EXISTS `tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_map` (
  `tag_uid` varchar(8) NOT NULL,
  `prod_id` char(5) DEFAULT NULL,
  PRIMARY KEY (`tag_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_map`
--

LOCK TABLES `tag_map` WRITE;
/*!40000 ALTER TABLE `tag_map` DISABLE KEYS */;
INSERT INTO `tag_map` VALUES ('53918F01','00001'),('7334F401','00002'),('85B7DF52','00003');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (3,1,1000.00,'2016-08-18 04:27:13','2016-10-30');
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

-- Dump completed on 2016-08-18 15:45:48
