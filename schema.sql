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
CREATE TABLE county_code_name_map (
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
CREATE TABLE county_dictated_appropriation (
  id int(10) unsigned NOT NULL auto_increment,
  region_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  service_id smallint(5) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  match_level_id tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (id),
  KEY service_id (service_id),
  KEY region_dictated_appropriation_id (region_dictated_appropriation_id),
  KEY match_level_id (match_level_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `county_dictated_appropriation`
--


-- --------------------------------------------------------

--
-- Table structure for table `county_user`
--

DROP TABLE IF EXISTS county_user;
CREATE TABLE county_user (
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
CREATE TABLE eligible_provider_equipment_list (
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

insert into eligible_provider_equipment_list
values
  (1,"EKG monitor/defibrillator w/pacer",5,1,1,0,0,12000,6000,7200),
  (2,"12 lead EKG",5,1,1,0,0,20000,10000,12000),
  (3,"AED",5,0,0,1,1,3500,1750,2100),
  (4,"Oxygen system parts",5,1,1,1,1,500,250,300),
  (5,"Capnography",3,1,1,0,0,3000,1500,1800),
  (6,"CPAP",5,1,1,0,0,900,450,540),
  (7,"Pulse oximeter",5,1,1,0,0,700,350,420),
  (8,"Nitrous oxide delivery system",5,1,1,0,0,2000,1000,1200),
  (9,"IV infusion pump",5,1,1,0,0,2000,1000,1200),
  (10,"Intubation, durable",5,1,1,0,0,600,300,360),
  (11,"Transtracheal jet insufflators",5,1,1,0,0,200,100,120),
  (12,"Splinting/immobilization devices",3,1,1,1,1,500,250,300),
  (13,"Stairchair",5,1,0,1,0,2000,1000,1200),
  (14,"Stretcher, primary",5,1,0,1,0,4000,2000,2400),
  (15,"Stretcher/chair combination",5,1,0,1,0,700,350,420),
  (16,"Suction, portable, battery operated",3,1,1,1,1,900,450,540),
  (17,"Ventilator, automatic",5,1,1,1,1,3000,1500,1800),
  (18,"Ambulance",null,1,0,1,0,33333.33,15000,20000),
  (19,"Squad/response vehicle",null,0,1,0,1,15000,7500,9000),
  (20,"Data collection software",null,1,1,1,1,1700,1700,1700),
  (21,"Data collection hardware",3,1,1,1,1,1500,750,900),
  (22,"Radio, mobile (up to 2/vehicle)",5,1,1,1,1,3000,1500,1800),
  (23,"Radio, portable (1/vehicle)",5,1,1,1,1,3000,1500,1800),
  (24,"Triage vest set",5,1,1,1,1,150,75,90),
  (25,"Triage system",5,1,1,1,1,500,250,300),
  (26,"Alerting (up to 5)",5,1,1,1,1,400,200,240),
  (27,"Vehicle safety monitoring system",5,1,1,1,1,3500,1750,2100),
  (28,"PPE/turnout gear",5,1,1,1,1,1200,600,720),
  (29,"Protective ballistic vest (over garment style)",5,1,1,1,1,1000,500,600),
  (30,"Traffic safety",5,1,1,1,1,500,250,300),
  (31,"Large patient moving/carrying device",10,1,1,1,1,300,150,180),
  (32,"SCBA (up to 2/licensed vehicle)",10,1,1,1,1,3000,1500,1800);


-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request_detail`
-- 

DROP TABLE IF EXISTS emsof_request_detail;
CREATE TABLE emsof_request_detail (
  master_id bigint(20) unsigned NOT NULL,
  equipment_code smallint(5) unsigned NOT NULL,
  make_model varchar(127) NOT NULL,
  place_kept varchar(127) NOT NULL,
  quantity smallint(5) unsigned NOT NULL,
  unit_cost decimal(10,2) unsigned NOT NULL,
  emsof_ante decimal(10,2) unsigned NOT NULL,
  status_code tinyint(3) unsigned NOT NULL default '1',
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
CREATE TABLE emsof_request_master (
  id bigint(20) unsigned NOT NULL auto_increment,
  county_dictated_appropriation_id int(10) unsigned NOT NULL,
  status_code tinyint(3) NOT NULL default '1',
  `value` decimal(10,2) unsigned NOT NULL default '0.00',
  num_items smallint(5) unsigned NOT NULL default '0',
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
CREATE TABLE fiscal_year (
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
CREATE TABLE fy_calendar (
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
CREATE TABLE item_status_code_description_map (
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
-- Table structure for table `match_level`
-- 

CREATE TABLE match_level (
  id tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(31) character set utf8 NOT NULL,
  factor decimal(3,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY factor (factor),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `match_level`
-- 

INSERT INTO match_level VALUES (1, 'Standard', 0.50);
INSERT INTO match_level VALUES (2, 'Rural', 0.60);
INSERT INTO match_level VALUES (3, 'Distressed', 1.00);

-- --------------------------------------------------------

-- 
-- Table structure for table `milestone_code_name_map`
-- 

DROP TABLE IF EXISTS milestone_code_name_map;
CREATE TABLE milestone_code_name_map (
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
CREATE TABLE region_code_name_map (
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
CREATE TABLE region_dictated_appropriation (
  id smallint(5) unsigned NOT NULL auto_increment,
  state_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  county_code tinyint(3) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  service_to_county_submission_deadline datetime default NULL,
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
CREATE TABLE regional_staffer (
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
CREATE TABLE regional_staffer_user (
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
CREATE TABLE request_status_code_description_map (
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
CREATE TABLE service (
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
CREATE TABLE service_user (
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
CREATE TABLE state_dictated_appropriation (
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
  ADD CONSTRAINT county_dictated_appropriation_ibfk_2 FOREIGN KEY (service_id) REFERENCES service (id),
  ADD CONSTRAINT county_dictated_appropriation_ibfk_3 FOREIGN KEY (match_level_id) REFERENCES match_level (id);

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
