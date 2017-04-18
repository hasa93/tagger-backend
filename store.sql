-- MySQL dump 10.14  Distrib 5.5.53-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	5.5.53-MariaDB-1~trusty

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (3,'Amy','Kruger',NULL,'0774002454',NULL),(4,'Hasanga','Somaratne',NULL,'0774002453',NULL),(5,'Madura','Herath',NULL,'0712345678',NULL),(6,'Thushara','Sandakelum',NULL,'0772409410',NULL),(7,'Hashan','Munasinghe',NULL,'0712352648',NULL),(8,'Stan','Lee',NULL,'0772005239',NULL),(9,NULL,NULL,NULL,NULL,NULL),(10,'parasthu','mal',NULL,'0719067834',NULL);
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
  `prod_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`prod_id`,`cust_id`),
  KEY `fk_Cust_to_Flag` (`cust_id`),
  CONSTRAINT `fk_Cust_to_Flag` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (3,41),(6,41),(3,42),(3,43),(3,44),(5,44),(3,45),(3,46),(3,47),(3,48),(3,49),(3,50),(5,52),(3,54),(3,57),(6,57),(3,63),(5,63),(5,64),(3,65),(3,82),(5,82),(10,82),(7,85),(7,91),(3,93),(5,94),(7,95);
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
INSERT INTO `inventory` VALUES (1,1,0,0),(1,3,0,0),(1,4,0,0),(1,41,2346,0),(1,55,2,0),(1,59,2,0),(1,64,5000,0),(1,66,1,0),(1,67,1,0),(2,5,0,0);
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
  `invoice_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invoice_total` float DEFAULT '0',
  `voucher_amount` float DEFAULT '0',
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (3,'2016-09-11 21:27:51',12000,0,1),(4,'2016-09-11 22:42:34',8600,0,1),(5,'2016-09-11 23:17:09',2500,0,1),(6,'2016-09-12 19:47:35',240,0,1),(7,'2016-09-12 19:55:50',1100,0,1),(8,'2016-09-12 19:58:02',1200,0,1),(9,'2016-09-13 11:56:25',1500,1000,1),(10,'2016-09-13 12:03:43',2700,1000,1),(11,'2016-09-13 22:10:55',9200,1000,1),(12,'2016-09-13 23:40:17',0,3500,1),(13,'2016-09-14 09:28:00',7600,0,1),(14,'2016-09-14 09:29:25',3800,0,1),(15,'2016-09-14 09:49:52',0,4500,1),(16,'2017-01-10 15:26:58',3401.83,NULL,1),(17,'2017-01-10 15:35:44',565.8,5000,1),(18,'2017-01-10 15:58:54',4516.19,NULL,1),(19,'2017-01-10 16:20:11',18930.7,NULL,1),(20,'2017-01-10 16:21:58',8261.37,NULL,1),(21,'2017-01-11 04:54:39',31399.5,NULL,1),(22,'2017-01-11 04:55:39',20433.1,6000,1),(23,'2017-01-12 03:39:36',3246.72,NULL,1),(24,'2017-01-12 04:41:26',14698.8,4000,1),(25,'2017-01-12 09:53:38',12334.8,NULL,1),(26,'2017-01-12 15:23:50',7473.81,NULL,1),(27,'2017-01-13 14:38:49',5098.97,NULL,1),(28,'2017-01-13 19:33:43',7208.74,NULL,1),(29,'2017-01-14 04:25:29',17385.6,NULL,1),(30,'2017-01-14 04:28:46',6400,NULL,1),(31,'2017-01-14 04:36:13',19859.8,NULL,1),(32,'2017-01-14 10:05:17',17878.1,NULL,1),(33,'2017-01-14 10:06:07',12950.8,NULL,1),(34,'2017-01-14 10:10:37',8402.18,NULL,1),(35,'2017-01-15 06:22:07',8017.37,NULL,1),(36,'2017-01-15 08:21:43',6662.34,NULL,1),(37,'2017-01-15 08:26:31',8811.02,NULL,1),(38,'2017-01-15 10:05:46',6896.78,NULL,1),(39,'2017-01-15 11:13:13',7993.88,NULL,1),(40,'2017-01-15 14:53:03',11052.9,NULL,1),(41,'2017-01-15 17:38:44',8878.78,NULL,1),(42,'2017-01-15 17:40:10',NULL,6000,1),(43,'2017-01-16 05:01:57',4988.82,NULL,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (7,'master@baby','4f26aeafdb2367620a393c973eddbe8f8b846ebd',NULL,NULL,NULL,NULL,NULL),(36,'amy','da0cee525ea095cebd642feb98c0fe5678fb7db3',NULL,3,NULL,NULL,NULL),(97,'codon@baby','4e77aed011c838c1d67b38b807f7ee48a89ef35a',77,NULL,NULL,NULL,'jogeggbert@gmail.com'),(98,'don@baby','96d029b9830b7f04b48672c932276350598b3753',78,NULL,NULL,NULL,'jogeggbert@gmail.com'),(99,'john@baby','e851ceec80c23cc168884d85b1f9b0251c07ad76',79,NULL,NULL,NULL,'john@gmail.com'),(100,'amanda@baby','3bc7036a96e187978e28f9b60f85be4323315e88',80,NULL,NULL,NULL,'amanda89@gmail.com'),(101,'test','7c222fb2927d828af22f592134e8932480637c0d',81,NULL,NULL,NULL,'test@gmai.com'),(102,'hasa93','88c102faad4b6800b7d0c8162ebac3495fc84b12',NULL,4,NULL,NULL,NULL),(104,'madura','7c4a8d09ca3762af61e59520943dc26494f8941b',NULL,5,NULL,NULL,NULL),(107,'thusha','657f9839a5d028a7f458963c7d9a89e78ec5226e',NULL,6,NULL,NULL,NULL),(108,'sulo','7c222fb2927d828af22f592134e8932480637c0d',85,NULL,NULL,NULL,'sulo@gmail.com'),(109,'test1','caa70946d8da3b59d1e0e798712934907f004695',86,NULL,NULL,NULL,'test@gmail.com'),(112,'thusha@baby','7c222fb2927d828af22f592134e8932480637c0d',89,NULL,NULL,NULL,'thusha@gmail.com'),(114,'kasun','f7c3bc1d808e04732adf679965ccc34ca7ae3441',91,NULL,NULL,NULL,'kasun@gmail.com'),(115,'malithsen@baby','a1e8c24841cacc6fd6d41ba18d074e8ce11262a8',92,NULL,NULL,NULL,'malithsen@gmail.com'),(117,'sammy@baby','de280fe52f96cc486ca37b9db6f8b8d39116c660',94,NULL,NULL,NULL,'sammy@gmail.com'),(120,'sulo@baby','8f7e50035827b4e8931bcb58e92935abbc756a06',97,NULL,NULL,NULL,'sulo@yahoo.com'),(121,'Hashan','7c4a8d09ca3762af61e59520943dc26494f8941b',NULL,7,NULL,NULL,NULL),(122,'jsmith@baby','1bcae987794f542036408eba9efe2559f6b907f2',98,NULL,NULL,NULL,'js@gmail.com'),(123,'jderulo@baby','89140821fbc905219235ccec8bd8d88e2e6f4837',99,NULL,NULL,NULL,'jderulo@gmail.com'),(124,'nj@baby','ec265c790fd886190f2026275e9f0c6a5efe53dd',100,NULL,NULL,NULL,'nj@gmail.com'),(125,'kllk','7c222fb2927d828af22f592134e8932480637c0d',101,NULL,NULL,NULL,'klklk'),(127,'ben@baby','c3377940877a8c976c99ba58fd41ae0c2ec95a36',103,NULL,NULL,NULL,'ben@baby.com'),(128,'mad@baby','b9d402982b78ca75cdaa928987d2cababf6ffba6',104,NULL,NULL,NULL,'mad@gmail.com'),(130,'test0','7c222fb2927d828af22f592134e8932480637c0d',106,NULL,NULL,NULL,'test@gmail.com'),(131,'pasan@baby','7c222fb2927d828af22f592134e8932480637c0d',107,NULL,NULL,NULL,'pasan@gmail.com'),(132,'ishara','a7d579ba76398070eae654c30ff153a4c273272a',108,NULL,NULL,NULL,'ishara@gmail.com'),(133,'hashan123','7c222fb2927d828af22f592134e8932480637c0d',109,NULL,NULL,NULL,'hashan@baby'),(134,'hasa@baby','c1b09cc11dc198a689c91f708a344d076879e3c8',110,NULL,NULL,NULL,'hasanga@gmail.com'),(135,'stan','b54ae7893982d10f03c27dbc889098ce04898c8b',NULL,8,NULL,NULL,NULL),(136,'mad','40bd001563085fc35165329ea1ff5c5ecbdbbeef',NULL,9,NULL,NULL,NULL),(137,'japan','40bd001563085fc35165329ea1ff5c5ecbdbbeef',NULL,10,NULL,NULL,NULL);
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
  `prod_cat` varchar(20) DEFAULT NULL,
  `arr_date` date DEFAULT NULL,
  `age_range` varchar(5) DEFAULT 'ANY',
  `discontinued` tinyint(1) DEFAULT '0',
  `returnable` tinyint(1) DEFAULT '0',
  `prod_image` varchar(100) DEFAULT NULL,
  `prod_desc` mediumtext,
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (41,'V Tech Drop And Go Dump Truck',1630.15,'Toys','2017-01-08','6M-1Y',0,0,'9d63df88dcffcd3c7133555eef25737fb5ee4df7.jpg','Learning is tons of fun with the Drop and Go Dump Truck by VTech. Drop a colorful rock into the top of this cute toy dump truck, and watch it tumble into the bucket. Your little one will learn numbers as the interactive truck counts each rock. Once the rocks are in the bucket, push or pull the truck along to see the rocks rumble inside. Then, lift the hinged bucket to unload the rocks and start again while developing motor skills. The dump truck also includes 3 colorful buttons that play melodies, phrases and teach tools and colors. Requires 2 AAA batteries (batteries included for demo purposes only; new batteries recommended for regular use). Intended for ages 6 months to 3 years.'),(42,'VTech Busy Learners Activity Cube',2058.82,'Toys','2017-01-07','6M-1Y',0,0,'fa7c482eb952d7d1fe5e4e1ca05868cffc762c81.jpg','Exploration and fun is around every corner with the Busy Learner’s Activity Cube by VTech. Featuring five sides to explore, this play cube attracts your baby’s attention and encourages imaginative play with music, light-up buttons, colors and more. Shape and animal buttons introduce animal names, animal sounds, and shapes. Press and slide musical instrument buttons introduce instrument names, sounds, and colors. Sliding, spinning blocks promote interaction and fine motor skill development. This interactive cube also plays fun sounds when it\'s moved. Plays 25 sing-along songs and melodies.'),(43,'Baby Einstein Musical toy',800,'Bathing and Skin Car','2016-12-08','1Y-5Y',1,0,'8432e71b1d22d0a99f0046f893e858763f75e65d.jpg','Volume Control The colorful and easy to grasp Caterpillar handle ensures that baby can take along tunes anywhere Off, Low and High volume switch'),(44,'Infant Optics DXR-8 Video Baby Monito',2409.44,'Bathing and Skin Car','2016-12-31','1Y-5Y',1,0,'bd05d1e76bf669a49240054ab210dd4ef2e22b38.jpg','First-ever monitor with interchangeable optical lens capability - allowing you to customize viewing angle and zoom Large 3.5 inches full color LCD display in sleek, compact unit with retractable antenna, with sound-activated LED display'),(45,'OXO Tot Silicone Tub Drain Stopper- Aqua',1203.21,'Bathing and Skin Car','2017-01-01','6M-1Y',0,0,'7975b8b026a3b2b9bf615fd4983ef8de381c2e2b.jpg','Seals drain to fill tub with water Suction cup secures Stopper to tub floor Suction cup can be used to store stopper when not in use'),(46,'Pro Tec Extended Life Humidifier Wicking…',2590.15,'Bathing and Skin Car','2017-01-03','1Y-5Y',0,0,'50b50309a609a6ea6ed308f1808e95707e1d1057.jpg','Protec WF2 Extended Life Replacement Humidifier Filter Formerly Kaz WF2 Extended Life Replacement Humidifier Filter'),(47,'Kolcraft Cloud Plus Lightweight Stroller,…',7529.5,'Strollers','2017-01-04','6M-1Y',0,0,'c1ce6029c1553b748ef03e8d040c5e064efee312.jpg','Polyester Imported Travel-friendly stroller-under 12 pounds with compact fold;3-tier extended canopy for maximum UV coverage Multi position reclining seat offers 5-point safety restraint system and accommodates child to 50 pounds;Convenient one-hand and self-standing fold'),(48,'Kolcraft Cloud Umbrella Stroller - Spring',4362.59,'Strollers','2017-01-04','6M-1Y',0,0,'90e2b672c677328d4f0f8640ba1a34fbb04a1168.jpg','Extended sun canopy and rear hood provide more sun coverage than most umbrella strollers. Cool-climate roll-up exposes mesh for increased air circulation &creates a head rest.'),(49,'Baby Jogger Glider Board, Black',8811.02,'Strollers','2017-01-05','6M-1Y',0,0,'c0da110e0b18494a2c12aed73d84d10d444b22c2.jpg','Plastic Imported Compatible with the baby jogger city series and summit single and double models Telescoping brackets are length adjustable Glider board stows against stroller frame when not in use'),(50,'BEST STROLLER ORGANIZER',4516.19,'Strollers','2017-01-06','6M-1Y',0,0,'10bc4eccbe995e25cc039fae499c1fa0df5f838e.jpg','TAKE EVERYTHING YOU NEED WITH YOU! As a mom, we understand you have a lot of “stuff” to cart around for you and your sweet babies— toys, sippy cups, books, keys, phones, drinks, snacks, diapers, etc… We created the ultimate Stroller Organizer just for you, to help make your walks around town, trips to the airport, and shopping excursions easier! Have everything you need in one easy-to-find spot with our Ethan & Emma deluxe stroller organizer!'),(51,'Pampers Swaddlers Diapers Economy Pack…',4983.02,'Gifts','2017-01-04','6M-1Y',0,0,'be255942aebc35067baebd30787366e601eecf68.jpg','Pampers Blankie Soft comfort and protection Pampers Swaddlers diapers are the #1 Choice of US Hospitals (based on sales of the newborn hospital diaper)'),(52,'Playtex Diaper Genie Refills for Diaper…',2540.45,'Furniture','2017-01-05','6M-1Y',1,0,'fc7cb8f090ca5483fbdaa7751c4a1748e484877f.jpg','BUILT DURABLE, the Odor Lock refill features 7 layers that work together to help lock in diaper odors & messes Works with Diaper Genie Elite, Essentials and \"Mini\" Diaper Pails Each refill holds up to 270 newborn diapers'),(53,'Munchkin Diaper Pail 7 Layer Lavender…',2554.01,'Furniture','2017-01-07','6M-1Y',1,0,'9997c1c81f437ce09776623ace57639ea2057a3c.jpg','Lavender-scented bags 20 pack (holds up to 600 diapers) Fits ALL Munchkin Diaper Pails'),(54,'VTech Drop and Go Dump Truck',1500,'Gifts','2017-01-17','6M-1Y',1,0,'6210c338e6e9d497796acc62c2024e6d93c34561.PNG','Drop a colorful rock into the top of this cheerful dump truck toy and watch it tumble into the bucket to learn numbers. Once the rocks are in the bucket, the push toy or pull toy can be moved along to see the rocks rumble around inside. Learning toy develops motor skills by lifting the hinged bucket to unload the rocks and start again; a great early education toy for toddlers. Toddler toy truck includes 3 colorful buttons that play melodies, phrases and teach tools and colors.'),(55,'Jute Storage Bin',2853.68,'Gifts','2017-01-09','6M-1Y',0,0,'ea44267c2feac0742c575bbfa99247768b1b1cc9.jpg','IMPORTANT: 17\"LONG x 13\"WIDE x 10\"HIGH- perfect stand alone basket SAVE SPACE: Storage Baskets fold to 2\" in height for easy storage.Wire-framed for stability.'),(56,'Fisher-Price Rattle and Rock Maracas Musical Toy',748.43,'Gifts','2017-01-03','6M-1Y',0,0,'d26af64c8793a36294968e489ef90123d237679a.jpg','Features soft pom-pom bottoms for easy grip Colorful beads with rattle sounds will delight babies Just the right size for little hands Helps strengthen baby\'s sensory skills & gross motor skills'),(57,'Aveeno BabyGift Set',2407.93,'Gifts','2017-01-05','1Y-5Y',0,0,'05016d0a92be01b58e0bf8890211ad0a27172600.jpg','Plastic Made in USA Contains the essential products mom needs to start a bath routine for baby, with a bonus for mom Packaged in a beautiful, reusable basket Discover Nature\'s Secret for baby\'s healthy skin Discover Natural\'s Secret for Baby\'s Healthy Skin'),(58,'Cherokee Girls\' Jacket',1275,'Clothes','2017-01-09','1Y-5Y',1,0,'f1091790f7e266f8e6bce9181403a23d41b22ad7.jpg','100% Cotton Normal wash'),(59,'Girls Jeans',1254,'Clothes','2017-01-06','1Y-5Y',0,0,'0e062ca7467871b6268c43ab1155d52d8e9be116.jpg',NULL),(60,'United Colors of Benetton Girls\' T-Shirt',2990,'Clothes','2017-01-05','1Y-5Y',0,0,'73f0104d47d35996b673a06bf68d5444bee49ca4.jpg','100% Cotton Round neck Long sleeve Normal wash, use mild detergent, dry in shade'),(61,'Medium Gumball Bank',4000,'Gifts','2017-01-06','1Y-5Y',0,0,'0d420dde687d3240e9851b80539a3e6f6bf228df.PNG','Carousel door; easy lift top keeps gumballs off the floor. Flexible dispensing; accepts pennies, nickles, dimes and quarters or, set it for plain dispensing. Gumballs not included.'),(62,'VTech Go! Go! Smart Wheels Park and Learn Deluxe Garage',5000,'Gifts','2017-01-14','1Y-5Y',0,0,'b859caac520c7ed595d2ccebf12c7929ac29b850.PNG','Enhance your child\'s creativity with Go! Go! Smart Wheels toddler toys; kids build their own interactive toy car garage and race vehicles around for maximum fun. Roll SmartPoint tow truck over 9 SmartPoint locations to hear different phrases, music or fun sound effects; includes 7 interchangeable track pieces.'),(63,'VTech Turn and Learn Driver',1200,'Gifts','2017-01-17','1Y-5Y',0,0,'0ac7a8d3e851acf5963d25455e09c36b8501d547.PNG','Your little one will love pretending to drive using the steering wheel toy that causes the cute dog character to move back and forth. Press the five colorful buttons on the learning toy and your child will be introduced to different animals and vehicles; great early education toy. The fun baby car toy design encourages imaginative play with a traffic light, a signal lever that triggers fun sounds and music; gear shifter that pushes and pulls to introduce opposites.'),(64,'Marvel Boys\' T-Shirt',3200,'Clothes','2017-01-04','1Y-5Y',0,0,'375a08710928c8c52b3e9ca90a02896c3c394b00.jpg','100% Cotton Round neck Half sleeve Machine wash cold, do not iron on print'),(65,'Cherokee Boys\' Sweatshirt',2150,'Clothes','2017-01-05','5Y-9Y',0,0,'a81837d9f68ef40d1c501a79e9dfc3353b8b28f5.jpg','100% Cotton Long sleeve Normal wash'),(66,'new',10000,NULL,'2017-01-09','ANY',0,0,'thumbs/default.png',NULL),(67,'new chair',10000,NULL,'2017-12-07','1Y-5Y',1,0,'thumbs/default.png',NULL),(68,'test',1500,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(69,'test123',123,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(70,'test2',2000,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(71,'test2',2000,NULL,NULL,NULL,1,0,'thumbs/default.png',NULL),(72,'test23',1000,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(73,'test2',45454,NULL,NULL,NULL,1,0,'thumbs/default.png',NULL),(74,'test2',8949470,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(75,'test',10000,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(76,'testnew',100,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(77,'test',20000,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(78,'test',1200,NULL,'2017-01-10','ANY',1,0,'thumbs/default.png',NULL),(79,'Girl beauty dress',2400,NULL,'2017-01-09','ANY',0,0,'e5bbcc4de04acc723ddb45dbe18babc9c3a190f2.jpg','Suitable for fun events'),(80,'walampuri',1600,NULL,'2017-01-12','ANY',1,0,'thumbs/default.png','Makes you rich'),(81,'boys tshirt',1400,NULL,'2017-01-12','ANY',0,0,'thumbs/default.png','Full cotton'),(82,'Nuby Octopus Hoopla Bathtime Fun Toys, Purple',1052.9,'Toys','2017-01-13','6M-1Y',0,0,'ee38bf236156f08f23d73d58e03a3e6d27363e5d.jpg','Nuby\'s BPA Free Octopus Floating Bath Toy is a fun and interactive toy to make bath time more enjoyable. The cute and engaging toy comes with one floating octopus and three rings to toss on the octopus’ tentacles. It helps to develop hand-eye coordination and stimulate your baby’s senses. This toy provides endless fun in the bath or pool!'),(83,'Girl\'s flower t-shirt',1245,NULL,'2017-01-13','ANY',0,0,'de60e4c81c579b04789a32be452ed36cbc03d13f.jpg',NULL),(84,'Yellow sunglass',1800,'Other','2017-01-13','1Y-5Y',0,0,'c7b47931d4e8038ffd5251e490a8749dc3f3a338.jpg',NULL),(85,'boys jursey',2300,'Clothes','2017-01-15','1Y-5Y',0,0,'5ad18adf4058d51503f5b248b08bbd1b43f924f3.jpg','A sports king in the making! Make your kid stand out among his peers!'),(86,'baby cart',2500,'Furniture','2017-01-15','6M-1Y',1,0,'ce283c10e82cbc485969e6cf73b7163df07ee177.jpg','Keep your kid in your view all the time! Don\'t let them run away'),(87,'baby cart',2500,'Furniture','2017-01-15','6M-1Y',0,0,'26468ac9f65ed8ae73623f9ab1c64688eeb68427.jpg','Keep your kid in your view all the time! Don\'t let them run away'),(88,'blue slippers',600,'Clothes','2017-01-15','6M-1Y',1,0,'3c24e4f726028b4c430e816b75bfff39549102b3.jpg',NULL),(89,'Wooden baby high chair',8000,'Furniture','2017-01-15','6M-1Y',0,0,'dea7571281a12fd1a301b1e24caf8f67bda39260.jpg','customizable chair with optional seat cover, wrap around bentwood bucket seat. This chair can grow with your child'),(90,'Urban changing table',6800,'Furniture','2017-01-15','6M-1Y',0,0,'d429639c43d8984c5358c1c991822c7c16b0d357.jpg','Get baby ready each day at the Urban Changing Table, which features two open shelves below the changing area to keep diapers, wipes, clothing and other items within easy reach. A comfortable changing pad helps keep baby comfy, and safety rails surround the changing area for added safet'),(91,'Solid Wood Chairs, Set of 2',5500,'Furniture','2017-01-15','1Y-5Y',0,0,'79b54f31c61cfecf6869b71b4f0a3dbe10003405.jpg','These two easy-to-assemble hardwood Chairs have an 11-inch seat height that\'s comfy for kids plus durable solid-wood pieces and a reinforced, tip-resistant design that parents can feel confident about too.'),(92,'baby pack',6500,'Gifts','2017-01-15','6M-1Y',0,0,'782c35dad2487591332342a79b0e50cbdc6a2fd1.jpg',NULL),(93,'10 inch Husky - Gray and White',780,'Toys','2017-01-15','1Y-5Y',0,0,'33fd51cf5de3e2d891d78c616b7e33d578111f90.jpg','A cold-weather cutie is thrilled to come trotting into your house! This 10 inch Plush Husky from Toys \'R\' Us Plush, a Toys \'R\' Us exclusive, has soft gray and white fur, crystal blue eyes and a fuzzy long tail. Best of all? He\'s a fantastic snuggler!'),(94,'Thomas & Friends TrackMaster Over-Under Tidmouth Bridge',2247.3,'Toys','2017-01-15','1Y-5Y',0,0,'9df0e58f30c3f53fa5d846154f8ef3667cd2509e.jpg','Kids can build their Thomas & Friends motorized railway bigger and add elevation with the Over-Under Tidmouth Bridge from Fisher-Price. When children attach this expansion pack to other TrackMaster train sets, they can send theirr toy trains racing over, under, and around. The bridge features guardrails, a gantry, and a cool Great Race sign, so it\'s perfect for exciting racing adventures. Kids can experience a world of engaging, imaginative play as they build their own really unique railway full of Really Useful Engines! (TrackMaster motorized toy trains sold separately and subject to availability).'),(95,'Sky Viper M500 Remote Control Nano Drone - 2.4 GHz Green/Black',3596.58,'Toys','2017-01-15','5Y-9Y',0,0,'8f157ccb4c52498872fccadbdb19226115c9407a.jpg','Fourth generation M500 Nano Drone is updated with all new Flight Assist Features including Auto Launch, Auto Hover and Auto Land! Flight Assist features leverage avionics technology for performance, precision and stability to make learning easy for those new to the world of drones. This palm-sized drone is perfect for flying indoors but is sturdy enough for the great outdoors. Perform one-touch stunts like left and right barrel rolls and flips in 4 directions. Choose Manual Altitude for complete control of stunt maneuvers or Auto Hover for hands free altitude control. Viper Flight Plus firmware - commonly used in racing drones - results in a fast, stable, and easy to control experience. M500 Nano Drone is small enough to fit anywhere and smart enough to fly everywhere! Major performance Plus micro-size!'),(96,'Dream Along Mobile',5000,'Gifts','2017-01-15','6M-1Y',0,0,'8580a462c0c234c7d7575c96d589c429d0f1251c.jpg','Birth & up. Babies will be entertained watching 4 engaging characters as they float overhead. The mobile also has 15 minutes of soothing music to help baby fall asleep. Mobile attaches easily and securely to the crib. The base can be detached to be used as a musical crib toy. Uses 3 C batteries (not included).'),(97,'Infant 3Dlite Convenience Stroller, Tropical Green',8500,'Strollers','2017-01-15','6M-1Y',0,0,'2b9712f655065fbf59f146a4cbc0cab9e4749c5e.jpg','The award winning 3Dlite features an innovative air-light aluminum frame which makes it super lightweight to carry and push - yet durable enough to stand the test of time! With its open design, you can easily access the large storage basket or recline almost flat which is ideal for on-the-go naps or diaper changes! Going for a sunny day stroll? The canopy features a pop out visor that protects baby from sun’s harmful rays – 99.9 percent to be exact – and with the included cup holder there’s even a place for your water (or iced coffee).'),(98,'Daily Diaper Cream',1100,'Bathing and Skin Car','2017-01-15','6M-1Y',0,0,'d9ba16364a0722de85b1ff467a6665d9ff68e458.jpg','All of the products are naturally scented with calming lavender and chamomile fragrance; are Gluten, Phthalate, Sulfate, Petrolatum and Paraben Free; and are made in the USA. Daily Diaper Cream is a soothing ointment that calms and cools diaper rash and nourishes sensitive diaper area. It provides a barrier on the skin to help keep moisture away.'),(99,'Autum Breeze Strollers',6000,'Other','2017-01-15','1Y-5Y',1,0,'thumbs/default.png',NULL),(100,'Seagul Sweater',2500,'Other','2017-01-15','6M-1Y',1,0,'thumbs/default.png',NULL),(101,'Johnson & Johnson Vanilla Oatmeal Lotion',750,'Bathing and Skin Car','2017-01-15','ANY',0,0,'af0a03d051cbd86174eb979d420fef294d6caf67.png','Non-greasy and fast absorbing, Johnson\'s Vanilla Oatmeal Baby Lotion in 27 ounce size moisturizes for 24 hours and helps maintain skin\'s natural moisture.'),(102,'Baby bar soap',350,'Bathing and Skin Car','2017-01-15','ANY',0,0,'bb29795b12df1b27205d102df49cb15f772df748.jpg','This hypoallergenic baby bar gently cleans baby\'s face and body without drying or irritating skin like regular soap can. Dermatologist tested to be mild enough for use on the most delicate skin - even newborns. pH-balanced formula.'),(103,'Friends StarLily, My Magical Unicorn',1750,'Toys','2017-01-16','1Y-5Y',0,0,'bec777fd524faa12f74bceff1aa4a47c42ad18dc.jpg','Get ready for all kinds of magical adventures with StarLily! Pet, hug, and hold her, and watch as she flutters her beautiful, delicate wings and her horn flashes in different colors to match her mood. Her front leg moves; she sits, stands, and lies down; and she can even move when she hears music. StarLily also has a beautiful mane and tail -- and she loves it when they\'re braided so they look extra fancy.'),(104,'Next Steps Table and 2 Chairs Set',8300,'Furniture','2017-01-16','5Y-9Y',0,0,'0335be43c78da0f95cff3b2920c182281bdd2d52.jpg','Give your child a play space that\'s sized just for him or her with this Babies\'R\'Us Next Steps Table and Chairs Set in Gray. The 22\" high table is at the right height for arts and crafts projects, puzzles, snacks and more. If a friend is over to play, they can both enjoy a seat in the included chairs. After the playdate, you can easily clean up crumbs, spills and art supplies thanks to the set\'s wipe-clean finish.'),(105,'Lil Luxuries Whirlpool Spa & Shower',2800,'Bathing and Skin Car','2017-01-16','6M-1Y',0,0,'c18459f41b75087df76bff4f007cec155fc14795.jpg','Pamper your little one at bath time with the Summer Infant Lil\' Luxuries Whirlpool, Bubbling Spa and Shower in the Green style. The large, insulated tub offers a clean, modern design and is double walled to keep your baby\'s bathwater warm. A motorized water jet creates bubbles and vibrations to provide a fun, soothing spa effect, while an ergonomic shower handle helps make it easy to gently shower your baby.'),(106,'sale baby',1400,'Clothes','2017-01-16','1Y-5Y',0,0,'38768769f59ab3e2353d3358375866263a6224bc.jpg',NULL),(107,'baby jeans',1500,'Clothes','2017-01-16','5Y-9Y',0,0,'15e6f7bb16473b547bf1efb1f2ab4563b45867a1.jpg',NULL),(108,'baby purple cart',12500,'Strollers','2017-01-16','6M-1Y',0,0,'65439241ef58aaefa7408585d46a21b4243907bd.jpg',NULL),(109,'Antilop High Chair',2300,'Furniture','2017-01-16','1Y-5Y',1,0,'e35847155a2e76c8e6a0f1211564948f41cdd808.JPG','Sit Sit'),(110,'antilop high chair',2900,'Furniture','2017-01-16','6M-1Y',0,0,'bc204d020cc12f873b872e667fcc85235bde787b.JPG',NULL),(111,'Boys black tshirt',1000,'Clothes','2017-01-16','1Y-5Y',0,0,'thumbs/default.png',NULL),(112,'Boys blue tshirt',1000,'Clothes','2017-01-16','1Y-5Y',1,0,'thumbs/default.png',NULL),(113,'Boys blue tshirt',1000,'Clothes','2017-01-16','1Y-5Y',0,0,'thumbs/default.png',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `cust_id` int(11) NOT NULL DEFAULT '0',
  `prod_id` int(11) NOT NULL DEFAULT '0',
  `prod_rating` int(5) DEFAULT NULL,
  PRIMARY KEY (`cust_id`,`prod_id`),
  KEY `fk_ProdId` (`prod_id`),
  CONSTRAINT `fk_CustId` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (3,41,4),(3,42,4),(3,43,3),(3,44,3),(3,46,2),(3,48,4),(3,49,5),(3,51,5),(3,52,3),(3,53,3),(3,54,1),(3,57,3),(3,58,3),(3,59,3),(3,62,3),(3,63,3),(3,65,1),(3,82,3),(3,89,3),(3,93,1),(3,95,4),(4,41,1),(4,46,3),(4,89,2),(4,94,3),(4,95,3),(4,97,2),(5,44,4),(5,52,3),(5,63,4),(5,64,3),(5,93,2),(5,94,2),(6,41,4),(6,57,3),(7,85,2),(7,91,3),(7,95,5);
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
INSERT INTO `sales_records` VALUES (41,26,2),(41,34,1),(42,43,1),(43,16,1),(43,23,4),(43,26,2),(44,28,1),(44,31,1),(44,34,1),(44,35,1),(44,36,1),(45,17,1),(45,24,1),(45,25,3),(46,16,1),(46,19,1),(46,26,1),(46,33,5),(47,19,1),(47,21,3),(47,24,1),(48,17,1),(48,25,2),(48,31,4),(48,34,1),(48,41,1),(49,19,1),(49,21,1),(49,22,3),(49,37,1),(50,18,1),(50,41,1),(51,24,2),(52,29,4),(53,20,1),(53,28,1),(53,32,7),(55,20,2),(55,27,1),(56,27,3),(56,28,3),(57,29,3),(57,35,1),(62,40,2),(64,30,2),(64,35,1),(64,36,1),(65,39,1),(65,43,1),(79,42,1),(82,36,1),(82,38,1),(82,40,1),(93,43,1),(94,38,1),(94,39,1),(95,38,1),(95,39,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (77,'mgr','Hamid','Karzai','jogeggbert',1),(78,'mgr','Elijah','Wood','jogeggbert',2),(79,'csh','John','Langdon','0773456789',1),(80,'csh','Amanda','Todd','0778912345',1),(81,'csh','test','test1','0772005001',1),(85,'csh','sulo','mad','0772409410',1),(86,'csh','test','test','0771234567',1),(89,'csh','Thushara','Sandakelum','0772409410',1),(91,'csh','kasun','lakmal','0712345678',1),(92,'csh','Malith','Senaweera','0123456789',1),(94,'csh','Sameera','Vithanage','0112400954',1),(97,'csh','Sulochana','Kodithuwakku','0771123412',1),(98,'csh','John','Smith','0112344563',1),(99,'csh','Jason','Derulo','0112345671',1),(100,'csh','Nasty','Jacob','0773212454',1),(101,'csh','dlfad','fad','0123456789',1),(103,'csh','Benjamin','Franklin','0123456780',1),(104,'csh','Madura','Herath','0778912345',1),(106,'csh','test0','test1','0774125897',1),(107,'csh','pasan','rathnayaka','0772409410',1),(108,'csh','ishara','asiri','0772409415',1),(109,'csh','Hashan','madusanka','0778965321',1),(110,'csh','Hasanga','Somarathna','0772409410',1);
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
INSERT INTO `tag_map` VALUES ('',48),('04046012F94881',5),('04206012F94881',4),('04396012F94881',46),('53918F01',48),('668E86AB',93),('7334F401',65),('840F9535',42),('85B7DF52',54);
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (4,1,3200.00,'2017-01-10 10:13:01','2017-01-17','0771234321'),(8,1,5000.00,'2017-01-12 09:26:42','2017-01-19','0771234321'),(9,1,3000.00,'2017-01-12 15:03:00','2017-01-19',NULL),(11,1,5000.00,'2017-01-13 11:06:43','2017-01-20','0779938401'),(12,1,5000.00,'2017-01-13 14:39:09','2017-01-21',NULL),(13,1,5000.00,'2017-01-14 03:37:26','2017-01-21',NULL),(14,1,600.00,'2017-01-14 03:39:22','2017-01-21',NULL),(15,1,3000.00,'2017-01-14 10:05:28','2017-01-21','0774002453'),(17,2,5000.00,'2017-01-14 10:34:24','2017-01-21','0774002454'),(19,1,5000.00,'2017-01-15 07:46:30','2017-01-22','0712352648'),(20,1,6000.00,'2017-01-15 11:15:37','2017-01-22','0712352648'),(21,1,5000.00,'2017-01-15 14:53:31','2017-01-22','0774002453'),(22,1,5000.00,'2017-01-15 15:07:57','2017-01-22','0712352648'),(23,1,2000.00,'2017-01-15 15:08:21','2017-12-22','0712352648'),(24,1,1500.00,'2017-01-15 15:08:34','2017-01-22','0774002454'),(26,1,4000.00,'2017-01-15 17:40:39','2017-01-22','0774002453'),(27,1,2000.00,'2017-01-15 20:20:03','2017-01-22','0774002454'),(30,1,7000.00,'2017-01-16 05:02:22','2017-01-23','0712345678');
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

-- Dump completed on 2017-01-17  5:36:19
