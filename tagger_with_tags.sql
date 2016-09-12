-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 10, 2016 at 07:40 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tagger`
--
CREATE DATABASE IF NOT EXISTS `tagger` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tagger`;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE IF NOT EXISTS `branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(10) DEFAULT NULL,
  `branch_addr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `branch_addr`) VALUES
(1, 'KOHUWALA', 'SOME_ADDRESS'),
(2, 'MAKOLA', 'SOME_ADDRESS');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_fname` varchar(15) DEFAULT NULL,
  `cust_lname` varchar(15) DEFAULT NULL,
  `cust_cat` char(4) DEFAULT NULL,
  `cust_contact` varchar(10) DEFAULT NULL,
  `cust_addr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cust_id`, `cust_fname`, `cust_lname`, `cust_cat`, `cust_contact`, `cust_addr`) VALUES
(1, 'Tom', 'Hagen', 'reg', '0115559031', '32, long island');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `branch_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`branch_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `invoice_total` float DEFAULT NULL,
  `voucher_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `invoice_date`, `invoice_total`, `voucher_id`, `branch_id`) VALUES
(1, '2016-09-02 10:18:05', 9000, 1, 1),
(2, '2016-09-04 09:10:17', 10000, 2, 2),
(4, '2016-09-05 10:38:04', 8500, 3, 1),
(5, '2016-09-06 09:32:14', 7500, 4, 2),
(6, '2016-09-08 10:18:29', 12000, 5, 1),
(7, '2016-09-09 10:12:12', 11000, 6, 2),
(8, '2016-09-10 11:10:17', 12500, 6, 1),
(9, '2016-09-09 10:12:26', 14500, 7, 2),
(10, '2016-09-10 14:25:12', 16200, 8, 2);

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE IF NOT EXISTS `logins` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(16) DEFAULT NULL,
  `passwd` varchar(40) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `cust_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `fk_StaffLogin` (`staff_id`),
  KEY `fk_CustLogin` (`cust_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`login_id`, `uname`, `passwd`, `staff_id`, `cust_id`) VALUES
(1, 'codon@baby', '7402411f9090581314be0304d5d1b9d95d6f4079', 2, NULL),
(3, 'hagen@baby', '4d5bb2d32024e62584022f82eb016d5f4634880b', NULL, 1),
(4, 'jhl@baby', '6794d21b82ccbc26c3c80f0d4976a76ab0446ad7', 4, NULL),
(5, 'kowalski@baby', 'f56f228a1bfbb14683b61a1e3b42f3eaa3c58d81', 6, NULL),
(6, 'harlem@baby', 'a9b9f1fd61015b368e60e370d4a45629dc6c0b40', 7, NULL),
(7, 'master@baby', '4f26aeafdb2367620a393c973eddbe8f8b846ebd', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(100) DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `prod_cat` char(4) DEFAULT NULL,
  `arr_date` date DEFAULT NULL,
  `age_range` varchar(5) DEFAULT 'ANY',
  `discontinued` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`prod_id`, `prod_name`, `unit_price`, `prod_cat`, `arr_date`, `age_range`, `discontinued`) VALUES
(1, 'Gk Pacifier', 120, 'SNTR', NULL, 'ANY', 0),
(2, 'Navy Blue Top', 4300, 'CLTH', NULL, 'ANY', 0),
(3, 'RC Drone 4Q', 12500, 'TOYS', NULL, 'ANY', 1),
(4, 'Boys bright tshirts', 1300, 'CLOT', NULL, 'ANY', 0),
(5, 'Boys jersy pull on shorts', 1200, 'CLOT', NULL, 'ANY', 0),
(6, 'Boys heritage jersy', 1300, 'CLOT', NULL, 'ANY', 0),
(7, 'Adidas baby logo crew suit', 2200, 'CLOT', NULL, 'ANY', 0),
(8, 'Adidas original baby boy t-shirt', 1500, 'CLOT', NULL, 'ANY', 0),
(9, 'Boys denim shorts', 1300, 'CLOT', NULL, 'ANY', 0),
(10, 'Boys tops', 1100, 'CLOT', NULL, 'ANY', 0),
(11, 'Graco Baby Breeze Stroller', 42, 'OTHE', '2016-09-01', 'ANY', 0),
(12, 'Varsity Puffer', 2471.96, 'CLOT', '2016-09-01', '5Y-9Y', 0),
(13, 'kk', 0, NULL, '2016-09-02', 'ANY', 0),
(14, 'Baby food feeder', 1500, 'Nurs', '2016-09-09', '1-5', 0),
(15, 'pack of 4 bibs', 1000, 'Nurs', '2016-09-06', '1-5', 0),
(16, 'pack of 2 bibs', 1200, 'Nurs', '2016-09-06', '1-5', 0),
(17, 'Baby spoon and fork(3 sets)', 1300, 'Nurs', '2016-09-09', '1-5', 0),
(18, 'Baby juice feeding', 1250, 'Nurs', '2016-09-08', '1-5', 0),
(19, 'Feeding bottle', 1300, 'Nurs', '2016-09-08', '1-5', 0),
(20, '2 pack of divided plate', 1000, 'Nurs', '2016-09-08', '1-5', 0),
(21, 'Racing toy car', 1500, 'toys', '2016-09-09', '5-9', 0),
(22, 'Fun school soft ball', 1200, 'toys', '2016-09-10', '5-9', 0),
(23, 'Jumping frogs', 1300, 'Toys', '2016-09-10', '5-9', 0),
(24, 'New born toy', 1850, 'toys', '2016-09-10', '5-9', 0),
(25, 'Baby giraffe rattle', 1250, 'toys', '2016-09-09', '5-9', 0),
(26, 'Inflatable hop ball', 1350, 'toys', '2016-09-11', '5-9', 0),
(27, 'Negy baby rattle ', 1500, 'toys', '2016-09-05', '5-9', 0),
(28, 'Kick and crawl gym', 1850, 'toys', '2016-09-06', '5-9', 0),
(29, 'smile squeezy ball', 1300, 'toys', '2016-09-08', '5-9', 0),
(30, 'Baby bath cap', 1200, 'clot', '2016-09-08', '1-5', 0),
(31, 'Kids night ware', 1500, 'clot', '2016-09-08', '1-5', 0),
(32, 'Baby girl dress ', 1300, 'clot', '2016-09-01', '1-5', 0),
(33, 'Baby blanket', 1500, 'clot', '2016-09-06', '1-5', 0),
(34, 'steeveless cotton baby romper', 1500, 'clot', '2016-08-31', '1-5', 0);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_type` char(3) DEFAULT NULL,
  `staff_fname` varchar(15) DEFAULT NULL,
  `staff_lname` varchar(15) DEFAULT NULL,
  `staff_contact` varchar(10) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_BranchKey` (`branch_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_type`, `staff_fname`, `staff_lname`, `staff_contact`, `branch_id`) VALUES
(2, 'mgr', 'Michael', 'Coroleone', '0115559031', NULL),
(4, 'csh', 'John', 'Langdon', NULL, NULL),
(6, 'csh', 'Nathan', 'Kowalski', '0115559031', NULL),
(7, 'csh', 'Harlem', 'Channing', '0115559031', NULL),
(8, 'mst', 'MASTER', NULL, NULL, NULL),
(9, 'mgr', 'thushara', 'sandakelum', '0772409410', 1),
(10, 'csh', 'pasan', 'korelege', '0714632339', 2),
(11, 'csh', 'Hasanga', 'somarathna', '0774310124', 2),
(12, 'csh', 'madura', 'herath', '0712345669', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tag_map`
--

CREATE TABLE IF NOT EXISTS `tag_map` (
  `tag_uid` varchar(8) NOT NULL,
  `prod_id` char(5) DEFAULT NULL,
  PRIMARY KEY (`tag_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tag_map`
--

INSERT INTO `tag_map` (`tag_uid`, `prod_id`) VALUES
('53918F01', '00001'),
('7334F401', '00002'),
('85B7DF52', '00003');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE IF NOT EXISTS `voucher` (
  `vouch_id` int(11) NOT NULL AUTO_INCREMENT,
  `issued_branch` int(11) DEFAULT NULL,
  `vouch_amount` decimal(7,2) DEFAULT NULL,
  `issue_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exp_date` date DEFAULT NULL,
  PRIMARY KEY (`vouch_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`vouch_id`, `issued_branch`, `vouch_amount`, `issue_date`, `exp_date`) VALUES
(3, 1, '1000.00', '2016-08-18 04:27:13', '2016-10-30'),
(4, NULL, '2000.00', '2016-08-18 18:09:08', '2016-08-29'),
(5, NULL, '5000.00', '2016-08-26 20:47:24', '2016-08-28'),
(6, NULL, '5600.00', '2016-09-03 04:23:08', '2016-09-04');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `logins`
--
ALTER TABLE `logins`
  ADD CONSTRAINT `fk_CustLogin` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_StaffLogin` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `fk_BranchKey` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
