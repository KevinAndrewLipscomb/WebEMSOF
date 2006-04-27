-- MySQL dump 10.10
--
-- Host: localhost    Database: emsidb
-- ------------------------------------------------------
-- Server version	5.0.20a-nt

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
-- Table structure for table `county_code_name_map`
--

DROP TABLE IF EXISTS `county_code_name_map`;
CREATE TABLE `county_code_name_map` (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `county_code_name_map`
--


/*!40000 ALTER TABLE `county_code_name_map` DISABLE KEYS */;
LOCK TABLES `county_code_name_map` WRITE;
INSERT INTO `county_code_name_map` VALUES (1,'Allegheny'),(2,'Armstrong'),(3,'Beaver'),(4,'Butler'),(5,'Fayette'),(6,'Greene'),(7,'Indiana'),(8,'Lawrence'),(9,'Washington'),(10,'Westmoreland');
UNLOCK TABLES;
/*!40000 ALTER TABLE `county_code_name_map` ENABLE KEYS */;

--
-- Table structure for table `county_dictated_appropriation`
--

DROP TABLE IF EXISTS `county_dictated_appropriation`;
CREATE TABLE `county_dictated_appropriation` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `region_dictated_appropriation_id` smallint(5) unsigned NOT NULL,
  `service_id` smallint(5) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `service_id` (`service_id`),
  KEY `region_dictated_appropriation_id` (`region_dictated_appropriation_id`),
  CONSTRAINT `county_dictated_appropriation_ibfk_6` FOREIGN KEY (`region_dictated_appropriation_id`) REFERENCES `region_dictated_appropriation` (`id`),
  CONSTRAINT `county_dictated_appropriation_ibfk_7` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `county_dictated_appropriation`
--


/*!40000 ALTER TABLE `county_dictated_appropriation` DISABLE KEYS */;
LOCK TABLES `county_dictated_appropriation` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `county_dictated_appropriation` ENABLE KEYS */;

--
-- Table structure for table `county_user`
--

DROP TABLE IF EXISTS `county_user`;
CREATE TABLE `county_user` (
  `id` tinyint(3) unsigned NOT NULL,
  `encoded_password` char(40) default NULL,
  `be_stale_password` tinyint(1) NOT NULL default '1',
  `password_reset_email_address` varchar(255) NOT NULL,
  `be_active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  CONSTRAINT `county_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `county_code_name_map` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `eligible_provider_equipment_list`
--

DROP TABLE IF EXISTS `eligible_provider_equipment_list`;
CREATE TABLE `eligible_provider_equipment_list` (
  `code` smallint(5) unsigned NOT NULL,
  `description` varchar(127) NOT NULL,
  `life_expectancy_years` tinyint(3) unsigned default NULL,
  `be_eligible_als_amb` tinyint(1) NOT NULL,
  `be_eligible_als_squad` tinyint(1) NOT NULL,
  `be_eligible_bls_amb` tinyint(1) NOT NULL,
  `be_eligible_qrs` tinyint(1) NOT NULL,
  `allowable_cost` decimal(10,2) unsigned NOT NULL,
  `funding_level_nonrural` decimal(10,2) unsigned NOT NULL,
  `funding_level_rural` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eligible_provider_equipment_list`
--


/*!40000 ALTER TABLE `eligible_provider_equipment_list` DISABLE KEYS */;
LOCK TABLES `eligible_provider_equipment_list` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `eligible_provider_equipment_list` ENABLE KEYS */;

--
-- Table structure for table `emsof_request_detail`
--

DROP TABLE IF EXISTS `emsof_request_detail`;
CREATE TABLE `emsof_request_detail` (
  `master_id` bigint(20) unsigned NOT NULL,
  `equipment_code` smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) unsigned NOT NULL,
  `status_code` tinyint(3) unsigned NOT NULL,
  `priority` smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (`master_id`,`priority`),
  KEY `equipment_code` (`equipment_code`),
  KEY `status_code` (`status_code`),
  CONSTRAINT `emsof_request_detail_ibfk_10` FOREIGN KEY (`master_id`) REFERENCES `emsof_request_master` (`id`),
  CONSTRAINT `emsof_request_detail_ibfk_11` FOREIGN KEY (`equipment_code`) REFERENCES `eligible_provider_equipment_list` (`code`),
  CONSTRAINT `emsof_request_detail_ibfk_12` FOREIGN KEY (`status_code`) REFERENCES `item_status_code_description_map` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emsof_request_detail`
--


/*!40000 ALTER TABLE `emsof_request_detail` DISABLE KEYS */;
LOCK TABLES `emsof_request_detail` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `emsof_request_detail` ENABLE KEYS */;

--
-- Table structure for table `emsof_request_master`
--

DROP TABLE IF EXISTS `emsof_request_master`;
CREATE TABLE `emsof_request_master` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `county_dictated_appropriation_id` int(10) unsigned NOT NULL,
  `status_code` tinyint(3) NOT NULL default '1',
  `value` decimal(10,2) unsigned NOT NULL default '0.00',
  PRIMARY KEY  (`id`),
  KEY `status_code` (`status_code`),
  KEY `county_dictated_appropriation_id` (`county_dictated_appropriation_id`),
  CONSTRAINT `emsof_request_master_ibfk_12` FOREIGN KEY (`county_dictated_appropriation_id`) REFERENCES `county_dictated_appropriation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `emsof_request_master_ibfk_13` FOREIGN KEY (`status_code`) REFERENCES `request_status_code_description_map` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emsof_request_master`
--


/*!40000 ALTER TABLE `emsof_request_master` DISABLE KEYS */;
LOCK TABLES `emsof_request_master` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `emsof_request_master` ENABLE KEYS */;

--
-- Table structure for table `fiscal_year`
--

DROP TABLE IF EXISTS `fiscal_year`;
CREATE TABLE `fiscal_year` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `designator` char(6) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `designator` (`designator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fiscal_year`
--


/*!40000 ALTER TABLE `fiscal_year` DISABLE KEYS */;
LOCK TABLES `fiscal_year` WRITE;
INSERT INTO `fiscal_year` VALUES (1,'FY0506'),(2,'FY0607');
UNLOCK TABLES;
/*!40000 ALTER TABLE `fiscal_year` ENABLE KEYS */;

--
-- Table structure for table `fy_calendar`
--

DROP TABLE IF EXISTS `fy_calendar`;
CREATE TABLE `fy_calendar` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `fiscal_year_id` smallint(5) unsigned NOT NULL,
  `milestone_code` smallint(5) unsigned NOT NULL,
  `value` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `fiscal_year_id` (`fiscal_year_id`,`milestone_code`),
  KEY `milestone_code` (`milestone_code`),
  CONSTRAINT `fy_calendar_ibfk_1` FOREIGN KEY (`fiscal_year_id`) REFERENCES `fiscal_year` (`id`),
  CONSTRAINT `fy_calendar_ibfk_2` FOREIGN KEY (`milestone_code`) REFERENCES `milestone_code_name_map` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fy_calendar`
--


/*!40000 ALTER TABLE `fy_calendar` DISABLE KEYS */;
LOCK TABLES `fy_calendar` WRITE;
INSERT INTO `fy_calendar` VALUES
   (1,1,1,'2005-11-30 23:59:59'),
   (2,1,2,'2006-01-31 23:59:59'),
   (3,1,3,'2006-02-28 23:59:59'),
   (4,1,4,'2006-05-31 23:59:59'),
   (5,2,1,'2006-11-30 23:59:59'),
   (6,2,2,'2007-01-31 23:59:59'),
   (7,2,3,'2007-02-28 23:59:59'),
   (8,2,4,'2007-05-31 23:59:59');
UNLOCK TABLES;
/*!40000 ALTER TABLE `fy_calendar` ENABLE KEYS */;

--
-- Table structure for table `item_status_code_description_map`
--

DROP TABLE IF EXISTS `item_status_code_description_map`;
CREATE TABLE `item_status_code_description_map` (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `description` varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_status_code_description_map`
--


/*!40000 ALTER TABLE `item_status_code_description_map` DISABLE KEYS */;
LOCK TABLES `item_status_code_description_map` WRITE;
INSERT INTO `item_status_code_description_map` VALUES
   (1,'Not yet approved'),
   (2,'NO invoice on file at regional council'),
   (3,'Invoice on file at regional council'),
   (4,'NO canceled check on file at regional council'),
   (5,'Canceled check on file at regional council');
UNLOCK TABLES;
/*!40000 ALTER TABLE `item_status_code_description_map` ENABLE KEYS */;

--
-- Table structure for table `milestone_code_name_map`
--

DROP TABLE IF EXISTS `milestone_code_name_map`;
CREATE TABLE `milestone_code_name_map` (
  `code` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `milestone_code_name_map`
--


/*!40000 ALTER TABLE `milestone_code_name_map` DISABLE KEYS */;
LOCK TABLES `milestone_code_name_map` WRITE;
INSERT INTO `milestone_code_name_map` VALUES 
   (1,'emsof-county-dictated-appropriation-deadline'),
   (2,'emsof-service-purchase-completion-deadline'),
   (3,'emsof-service-invoice-submission-deadline'),
   (4,'emsof-service-canceled-check-submission-deadline');
UNLOCK TABLES;
/*!40000 ALTER TABLE `milestone_code_name_map` ENABLE KEYS */;

--
-- Table structure for table `region_code_name_map`
--

DROP TABLE IF EXISTS `region_code_name_map`;
CREATE TABLE `region_code_name_map` (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `region_code_name_map`
--


/*!40000 ALTER TABLE `region_code_name_map` DISABLE KEYS */;
LOCK TABLES `region_code_name_map` WRITE;
INSERT INTO `region_code_name_map` VALUES
   (1,'EMSI');
UNLOCK TABLES;
/*!40000 ALTER TABLE `region_code_name_map` ENABLE KEYS */;

--
-- Table structure for table `region_dictated_appropriation`
--

DROP TABLE IF EXISTS `region_dictated_appropriation`;
CREATE TABLE `region_dictated_appropriation` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `state_dictated_appropriation_id` smallint(5) unsigned NOT NULL,
  `county_code` tinyint(3) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `county_code` (`county_code`),
  KEY `state_dictated_appropriation_id` (`state_dictated_appropriation_id`),
  CONSTRAINT `region_dictated_appropriation_ibfk_12` FOREIGN KEY (`state_dictated_appropriation_id`) REFERENCES `state_dictated_appropriation` (`id`),
  CONSTRAINT `region_dictated_appropriation_ibfk_13` FOREIGN KEY (`county_code`) REFERENCES `county_code_name_map` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `regional_staffer`
--

DROP TABLE IF EXISTS `regional_staffer`;
CREATE TABLE `regional_staffer` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `last_name` varchar(63) NOT NULL,
  `first_name` varchar(63) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `last_name` (`last_name`,`first_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regional_staffer`
--


/*!40000 ALTER TABLE `regional_staffer` DISABLE KEYS */;
LOCK TABLES `regional_staffer` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `regional_staffer` ENABLE KEYS */;

--
-- Table structure for table `regional_staffer_user`
--

DROP TABLE IF EXISTS `regional_staffer_user`;
CREATE TABLE `regional_staffer_user` (
  `id` smallint(5) unsigned NOT NULL,
  `encoded_password` char(40) default NULL,
  `be_stale_password` tinyint(1) NOT NULL default '1',
  `password_reset_email_address` varchar(255) NOT NULL,
  `be_active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  CONSTRAINT `regional_staffer_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `regional_staffer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `regional_staffer_user`
--


/*!40000 ALTER TABLE `regional_staffer_user` DISABLE KEYS */;
LOCK TABLES `regional_staffer_user` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `regional_staffer_user` ENABLE KEYS */;

--
-- Table structure for table `request_status_code_description_map`
--

DROP TABLE IF EXISTS `request_status_code_description_map`;
CREATE TABLE `request_status_code_description_map` (
  `code` tinyint(4) NOT NULL auto_increment,
  `description` varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `request_status_code_description_map`
--


/*!40000 ALTER TABLE `request_status_code_description_map` DISABLE KEYS */;
LOCK TABLES `request_status_code_description_map` WRITE;
INSERT INTO `request_status_code_description_map` VALUES
   (1,'Not started'),
   (2,'Not finished'),
   (3,'Waiting for county approval'),
   (4,'Waiting for regional compliance check'),
   (5,'Waiting for regional executive director approval'),
   (6,'Waiting to be submitted to DOH'),
   (7,'Waiting for DOH approval'),
   (8,'Waiting for invoices'),
   (9,'Waiting for canceled checks'),
   (10,'Reimbursement check has been issued'),
   (11,'Rejected'),
   (12,'Withdrawn by service');
UNLOCK TABLES;
/*!40000 ALTER TABLE `request_status_code_description_map` ENABLE KEYS */;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `affiliate_num` char(5) NOT NULL,
  `name` varchar(127) NOT NULL,
  `be_qrs` tinyint(1) NOT NULL default '0',
  `be_bls_amb` tinyint(1) NOT NULL default '0',
  `be_als_amb` tinyint(1) NOT NULL default '0',
  `be_als_squad` tinyint(1) NOT NULL default '0',
  `be_air_amb` tinyint(1) NOT NULL default '0',
  `be_rescue` tinyint(1) NOT NULL default '0',
  `address_line_1` varchar(127) default '',
  `address_line_2` varchar(127) default '',
  `city` varchar(127) default NULL,
  `zip_code` varchar(9) default '',
  `federal_tax_id_num` varchar(9) default '',
  `contact_person_name` varchar(127) default '',
  `contact_person_phone_num` varchar(10) default '',
  `be_valid_profile` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `affiliate_num` (`affiliate_num`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `service_user`
--

DROP TABLE IF EXISTS `service_user`;
CREATE TABLE `service_user` (
  `id` smallint(5) unsigned NOT NULL,
  `encoded_password` char(40) default NULL,
  `be_stale_password` tinyint(1) NOT NULL default '1',
  `password_reset_email_address` varchar(255) NOT NULL,
  `be_active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  CONSTRAINT `service_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `state_dictated_appropriation`
--

DROP TABLE IF EXISTS `state_dictated_appropriation`;
CREATE TABLE `state_dictated_appropriation` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `region_code` tinyint(3) unsigned NOT NULL,
  `fiscal_year_id` smallint(5) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fiscal_year_id` (`fiscal_year_id`),
  KEY `region_code` (`region_code`),
  CONSTRAINT `state_dictated_appropriation_ibfk_1` FOREIGN KEY (`region_code`) REFERENCES `region_code_name_map` (`code`),
  CONSTRAINT `state_dictated_appropriation_ibfk_2` FOREIGN KEY (`fiscal_year_id`) REFERENCES `fiscal_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

