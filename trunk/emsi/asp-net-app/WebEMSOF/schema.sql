-- phpMyAdmin SQL Dump
-- version 2.7.0-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: db4free.org
-- Generation Time: Apr 28, 2006 at 11:26 PM
-- Server version: 5.0.20
-- PHP Version: 5.0.3

SET FOREIGN_KEY_CHECKS=0;
-- 
-- Database: `emsidb`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `county_code_name_map`
-- 

DROP TABLE IF EXISTS county_code_name_map;
CREATE TABLE IF NOT EXISTS county_code_name_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `county_code_name_map`
-- 

INSERT INTO county_code_name_map VALUES (1, 'Allegheny');
INSERT INTO county_code_name_map VALUES (2, 'Armstrong');
INSERT INTO county_code_name_map VALUES (3, 'Beaver');
INSERT INTO county_code_name_map VALUES (4, 'Butler');
INSERT INTO county_code_name_map VALUES (5, 'Fayette');
INSERT INTO county_code_name_map VALUES (6, 'Greene');
INSERT INTO county_code_name_map VALUES (7, 'Indiana');
INSERT INTO county_code_name_map VALUES (8, 'Lawrence');
INSERT INTO county_code_name_map VALUES (9, 'Washington');
INSERT INTO county_code_name_map VALUES (10, 'Westmoreland');

-- --------------------------------------------------------

-- 
-- Table structure for table `county_dictated_appropriation`
-- 

DROP TABLE IF EXISTS county_dictated_appropriation;
CREATE TABLE IF NOT EXISTS county_dictated_appropriation (
  id int(10) unsigned NOT NULL auto_increment,
  region_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  service_id smallint(5) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY service_id (service_id),
  KEY region_dictated_appropriation_id (region_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `county_dictated_appropriation`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `county_user`
-- 

DROP TABLE IF EXISTS county_user;
CREATE TABLE IF NOT EXISTS county_user (
  id tinyint(3) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `county_user`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `eligible_provider_equipment_list`
-- 

DROP TABLE IF EXISTS eligible_provider_equipment_list;
CREATE TABLE IF NOT EXISTS eligible_provider_equipment_list (
  `code` smallint(5) unsigned NOT NULL auto_increment,
  description varchar(127) NOT NULL,
  life_expectancy_years tinyint(3) unsigned default NULL,
  be_eligible_als_amb tinyint(1) NOT NULL,
  be_eligible_als_squad tinyint(1) NOT NULL,
  be_eligible_bls_amb tinyint(1) NOT NULL,
  be_eligible_qrs tinyint(1) NOT NULL,
  allowable_cost decimal(10,2) unsigned NOT NULL,
  funding_level_nonrural decimal(10,2) unsigned NOT NULL,
  funding_level_rural decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (`code`),
  KEY description (description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `eligible_provider_equipment_list`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request_detail`
-- 

DROP TABLE IF EXISTS emsof_request_detail;
CREATE TABLE IF NOT EXISTS emsof_request_detail (
  master_id bigint(20) unsigned NOT NULL,
  equipment_code smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) unsigned NOT NULL,
  status_code tinyint(3) unsigned NOT NULL,
  priority smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (master_id,priority),
  KEY equipment_code (equipment_code),
  KEY status_code (status_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `emsof_request_detail`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request_master`
-- 

DROP TABLE IF EXISTS emsof_request_master;
CREATE TABLE IF NOT EXISTS emsof_request_master (
  id bigint(20) unsigned NOT NULL auto_increment,
  county_dictated_appropriation_id int(10) unsigned NOT NULL,
  status_code tinyint(3) NOT NULL default '1',
  `value` decimal(10,2) unsigned NOT NULL default '0.00',
  PRIMARY KEY  (id),
  KEY status_code (status_code),
  KEY county_dictated_appropriation_id (county_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `emsof_request_master`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `fiscal_year`
-- 

DROP TABLE IF EXISTS fiscal_year;
CREATE TABLE IF NOT EXISTS fiscal_year (
  id smallint(5) unsigned NOT NULL auto_increment,
  designator char(6) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY designator (designator)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `fiscal_year`
-- 

INSERT INTO fiscal_year VALUES (1, 'FY0506');

-- --------------------------------------------------------

-- 
-- Table structure for table `fy_calendar`
-- 

DROP TABLE IF EXISTS fy_calendar;
CREATE TABLE IF NOT EXISTS fy_calendar (
  id smallint(5) unsigned NOT NULL auto_increment,
  fiscal_year_id smallint(5) unsigned NOT NULL,
  milestone_code smallint(5) unsigned NOT NULL,
  `value` datetime NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY fiscal_year_id (fiscal_year_id,milestone_code),
  KEY milestone_code (milestone_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `fy_calendar`
-- 

INSERT INTO fy_calendar VALUES (1, 1, 1, '2005-11-30 23:59:59');
INSERT INTO fy_calendar VALUES (2, 1, 2, '2006-01-31 23:59:59');
INSERT INTO fy_calendar VALUES (3, 1, 3, '2006-02-28 23:59:59');
INSERT INTO fy_calendar VALUES (4, 1, 4, '2006-05-31 23:59:59');

-- --------------------------------------------------------

-- 
-- Table structure for table `item_status_code_description_map`
-- 

DROP TABLE IF EXISTS item_status_code_description_map;
CREATE TABLE IF NOT EXISTS item_status_code_description_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  description varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `item_status_code_description_map`
-- 

INSERT INTO item_status_code_description_map VALUES (1, 'Not yet approved');
INSERT INTO item_status_code_description_map VALUES (2, 'NO invoice on file at regional council');
INSERT INTO item_status_code_description_map VALUES (3, 'Invoice on file at regional council');
INSERT INTO item_status_code_description_map VALUES (4, 'NO canceled check on file at regional council');
INSERT INTO item_status_code_description_map VALUES (5, 'Canceled check on file at regional council');

-- --------------------------------------------------------

-- 
-- Table structure for table `milestone_code_name_map`
-- 

DROP TABLE IF EXISTS milestone_code_name_map;
CREATE TABLE IF NOT EXISTS milestone_code_name_map (
  `code` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `milestone_code_name_map`
-- 

INSERT INTO milestone_code_name_map VALUES (1, 'emsof-county-dictated-appropriation-deadline');
INSERT INTO milestone_code_name_map VALUES (2, 'emsof-service-purchase-completion-deadline');
INSERT INTO milestone_code_name_map VALUES (3, 'emsof-service-invoice-submission-deadline');
INSERT INTO milestone_code_name_map VALUES (4, 'emsof-service-canceled-check-submission-deadline');

-- --------------------------------------------------------

-- 
-- Table structure for table `region_code_name_map`
-- 

DROP TABLE IF EXISTS region_code_name_map;
CREATE TABLE IF NOT EXISTS region_code_name_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `region_code_name_map`
-- 

INSERT INTO region_code_name_map VALUES (1, 'EMSI');

-- --------------------------------------------------------

-- 
-- Table structure for table `region_dictated_appropriation`
-- 

DROP TABLE IF EXISTS region_dictated_appropriation;
CREATE TABLE IF NOT EXISTS region_dictated_appropriation (
  id smallint(5) unsigned NOT NULL auto_increment,
  state_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  county_code tinyint(3) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY county_code (county_code),
  KEY state_dictated_appropriation_id (state_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `region_dictated_appropriation`
-- 

INSERT INTO region_dictated_appropriation VALUES (1,1,1,97368.00);
INSERT INTO region_dictated_appropriation VALUES (2,1,2,19578.00);
INSERT INTO region_dictated_appropriation VALUES (3,1,3,24998.00);
INSERT INTO region_dictated_appropriation VALUES (4,1,4,35270.00);
INSERT INTO region_dictated_appropriation VALUES (5,1,5,30140.00);
INSERT INTO region_dictated_appropriation VALUES (6,1,6,13618.00);
INSERT INTO region_dictated_appropriation VALUES (7,1,7,24329.00);
INSERT INTO region_dictated_appropriation VALUES (8,1,8,16846.00);
INSERT INTO region_dictated_appropriation VALUES (9,1,9,35959.00);
INSERT INTO region_dictated_appropriation VALUES (10,1,10,52066.00);

-- --------------------------------------------------------

-- 
-- Table structure for table `regional_staffer`
-- 

DROP TABLE IF EXISTS regional_staffer;
CREATE TABLE IF NOT EXISTS regional_staffer (
  id smallint(5) unsigned NOT NULL auto_increment,
  last_name varchar(63) NOT NULL,
  first_name varchar(63) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY last_name (last_name,first_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `regional_staffer`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `regional_staffer_user`
-- 

DROP TABLE IF EXISTS regional_staffer_user;
CREATE TABLE IF NOT EXISTS regional_staffer_user (
  id smallint(5) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `regional_staffer_user`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `request_status_code_description_map`
-- 

DROP TABLE IF EXISTS request_status_code_description_map;
CREATE TABLE IF NOT EXISTS request_status_code_description_map (
  `code` tinyint(4) NOT NULL auto_increment,
  description varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `request_status_code_description_map`
-- 

INSERT INTO request_status_code_description_map VALUES (1, 'Not started');
INSERT INTO request_status_code_description_map VALUES (2, 'Not finished');
INSERT INTO request_status_code_description_map VALUES (3, 'Waiting for county approval');
INSERT INTO request_status_code_description_map VALUES (4, 'Waiting for regional compliance check');
INSERT INTO request_status_code_description_map VALUES (5, 'Waiting for regional executive director approval');
INSERT INTO request_status_code_description_map VALUES (6, 'Waiting to be submitted to DOH');
INSERT INTO request_status_code_description_map VALUES (7, 'Waiting for DOH approval');
INSERT INTO request_status_code_description_map VALUES (8, 'Waiting for invoices');
INSERT INTO request_status_code_description_map VALUES (9, 'Waiting for canceled checks');
INSERT INTO request_status_code_description_map VALUES (10, 'Reimbursement check has been issued');
INSERT INTO request_status_code_description_map VALUES (11, 'Rejected');
INSERT INTO request_status_code_description_map VALUES (12, 'Withdrawn by service');

-- --------------------------------------------------------

-- 
-- Table structure for table `service`
-- 

DROP TABLE IF EXISTS service;
CREATE TABLE IF NOT EXISTS service (
  id smallint(5) unsigned NOT NULL auto_increment,
  county_code tinyint(3) unsigned NOT NULL,
  affiliate_num char(5) NOT NULL,
  `name` varchar(127) NOT NULL,
  be_qrs tinyint(1) NOT NULL default '0',
  be_bls_amb tinyint(1) NOT NULL default '0',
  be_als_amb tinyint(1) NOT NULL default '0',
  be_als_squad tinyint(1) NOT NULL default '0',
  be_air_amb tinyint(1) NOT NULL default '0',
  be_rescue tinyint(1) NOT NULL default '0',
  address_line_1 varchar(127) default '',
  address_line_2 varchar(127) default '',
  city varchar(127) default NULL,
  zip_code varchar(9) default '',
  federal_tax_id_num varchar(9) default '',
  contact_person_name varchar(127) default '',
  contact_person_phone_num varchar(10) default '',
  be_valid_profile tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (id),
  UNIQUE KEY affiliate_num (affiliate_num),
  KEY `name` (`name`),
  KEY county_code (county_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `service`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `service_user`
-- 

DROP TABLE IF EXISTS service_user;
CREATE TABLE IF NOT EXISTS service_user (
  id smallint(5) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `service_user`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `state_dictated_appropriation`
-- 

DROP TABLE IF EXISTS state_dictated_appropriation;
CREATE TABLE IF NOT EXISTS state_dictated_appropriation (
  id smallint(5) unsigned NOT NULL auto_increment,
  region_code tinyint(3) unsigned NOT NULL,
  fiscal_year_id smallint(5) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY fiscal_year_id (fiscal_year_id),
  KEY region_code (region_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `state_dictated_appropriation`
-- 

INSERT INTO state_dictated_appropriation VALUES (1,1,1,350172.00);

-- 
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table `county_dictated_appropriation`
-- 
ALTER TABLE `county_dictated_appropriation`
  ADD CONSTRAINT county_dictated_appropriation_ibfk_1 FOREIGN KEY (region_dictated_appropriation_id) REFERENCES region_dictated_appropriation (id),
  ADD CONSTRAINT county_dictated_appropriation_ibfk_2 FOREIGN KEY (service_id) REFERENCES service (id);

-- 
-- Constraints for table `county_user`
-- 
ALTER TABLE `county_user`
  ADD CONSTRAINT county_user_ibfk_1 FOREIGN KEY (id) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `emsof_request_detail`
-- 
ALTER TABLE `emsof_request_detail`
  ADD CONSTRAINT emsof_request_detail_ibfk_1 FOREIGN KEY (master_id) REFERENCES emsof_request_master (id),
  ADD CONSTRAINT emsof_request_detail_ibfk_2 FOREIGN KEY (equipment_code) REFERENCES eligible_provider_equipment_list (`code`),
  ADD CONSTRAINT emsof_request_detail_ibfk_3 FOREIGN KEY (status_code) REFERENCES item_status_code_description_map (`code`);

-- 
-- Constraints for table `emsof_request_master`
-- 
ALTER TABLE `emsof_request_master`
  ADD CONSTRAINT emsof_request_master_ibfk_1 FOREIGN KEY (county_dictated_appropriation_id) REFERENCES county_dictated_appropriation (id) ON DELETE CASCADE,
  ADD CONSTRAINT emsof_request_master_ibfk_2 FOREIGN KEY (status_code) REFERENCES request_status_code_description_map (`code`);

-- 
-- Constraints for table `fy_calendar`
-- 
ALTER TABLE `fy_calendar`
  ADD CONSTRAINT fy_calendar_ibfk_1 FOREIGN KEY (fiscal_year_id) REFERENCES fiscal_year (id),
  ADD CONSTRAINT fy_calendar_ibfk_2 FOREIGN KEY (milestone_code) REFERENCES milestone_code_name_map (`code`);

-- 
-- Constraints for table `region_dictated_appropriation`
-- 
ALTER TABLE `region_dictated_appropriation`
  ADD CONSTRAINT region_dictated_appropriation_ibfk_1 FOREIGN KEY (state_dictated_appropriation_id) REFERENCES state_dictated_appropriation (id),
  ADD CONSTRAINT region_dictated_appropriation_ibfk_2 FOREIGN KEY (county_code) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `regional_staffer_user`
-- 
ALTER TABLE `regional_staffer_user`
  ADD CONSTRAINT regional_staffer_user_ibfk_1 FOREIGN KEY (id) REFERENCES regional_staffer (id);

-- 
-- Constraints for table `service`
-- 
ALTER TABLE `service`
  ADD CONSTRAINT service_ibfk_1 FOREIGN KEY (county_code) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `service_user`
-- 
ALTER TABLE `service_user`
  ADD CONSTRAINT service_user_ibfk_1 FOREIGN KEY (id) REFERENCES service (id);

-- 
-- Constraints for table `state_dictated_appropriation`
-- 
ALTER TABLE `state_dictated_appropriation`
  ADD CONSTRAINT state_dictated_appropriation_ibfk_1 FOREIGN KEY (region_code) REFERENCES region_code_name_map (`code`),
  ADD CONSTRAINT state_dictated_appropriation_ibfk_2 FOREIGN KEY (fiscal_year_id) REFERENCES fiscal_year (id);

SET FOREIGN_KEY_CHECKS=1;
