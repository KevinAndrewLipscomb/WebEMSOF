-- phpMyAdmin SQL Dump
-- version 2.7.0-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: db4free.org
-- Generation Time: Apr 11, 2006 at 03:02 AM
-- Server version: 5.0.20
-- PHP Version: 5.0.3
-- 
-- Database: `kalipso`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `county_code_name_map`
-- 

CREATE TABLE county_code_name_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `county_dictated_appropriation`
-- 

CREATE TABLE county_dictated_appropriation (
  id smallint(5) unsigned NOT NULL auto_increment,
  region_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  service_id smallint(5) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY service_id (service_id),
  KEY region_dictated_appropriation_id (region_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `county_user`
-- 

CREATE TABLE county_user (
  id tinyint(3) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `eligible_provider_equipment_list`
-- 

CREATE TABLE eligible_provider_equipment_list (
  `code` smallint(5) unsigned NOT NULL,
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

-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request_detail`
-- 

CREATE TABLE emsof_request_detail (
  master_id bigint(20) unsigned NOT NULL,
  equipment_code smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) unsigned NOT NULL,
  status_code tinyint(3) unsigned NOT NULL,
  priority smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (master_id,priority),
  KEY equipment_code (equipment_code),
  KEY status_code (status_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request_master`
-- 

CREATE TABLE emsof_request_master (
  id bigint(20) unsigned NOT NULL auto_increment,
  county_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  fiscal_year_id smallint(5) unsigned NOT NULL,
  status_code tinyint(3) NOT NULL,
  `value` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY status_code (status_code),
  KEY fiscal_year_id (fiscal_year_id),
  KEY county_dictated_appropriation_id (county_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `fiscal_year`
-- 

CREATE TABLE fiscal_year (
  id smallint(5) unsigned NOT NULL auto_increment,
  designator char(6) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY designator (designator)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `fy_calendar`
-- 

CREATE TABLE fy_calendar (
  id smallint(5) unsigned NOT NULL auto_increment,
  fiscal_year_id smallint(5) unsigned NOT NULL,
  milestone_code smallint(5) unsigned NOT NULL,
  `when` datetime NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY fiscal_year_id (fiscal_year_id,milestone_code),
  KEY milestone_code (milestone_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `item_status_code_description_map`
-- 

CREATE TABLE item_status_code_description_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  description varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `milestone_code_name_map`
-- 

CREATE TABLE milestone_code_name_map (
  `code` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `region_code_name_map`
-- 

CREATE TABLE region_code_name_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `region_dictated_appropriation`
-- 

CREATE TABLE region_dictated_appropriation (
  id smallint(5) unsigned NOT NULL auto_increment,
  state_dictated_appropriation_id smallint(5) unsigned NOT NULL,
  county_code tinyint(3) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (id),
  KEY county_code (county_code),
  KEY state_dictated_appropriation_id (state_dictated_appropriation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `regional_staffer`
-- 

CREATE TABLE regional_staffer (
  id smallint(5) unsigned NOT NULL auto_increment,
  last_name varchar(63) NOT NULL,
  first_name varchar(63) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY last_name (last_name,first_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `regional_staffer_user`
-- 

CREATE TABLE regional_staffer_user (
  id smallint(5) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `request_status_code_description_map`
-- 

CREATE TABLE request_status_code_description_map (
  `code` tinyint(4) NOT NULL auto_increment,
  description varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `service`
-- 

CREATE TABLE service (
  id smallint(5) unsigned NOT NULL auto_increment,
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
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `service_user`
-- 

CREATE TABLE service_user (
  id smallint(5) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `state_dictated_appropriation`
-- 

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
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table `county_dictated_appropriation`
-- 
ALTER TABLE `county_dictated_appropriation`
  ADD CONSTRAINT county_dictated_appropriation_ibfk_4 FOREIGN KEY (region_dictated_appropriation_id) REFERENCES region_dictated_appropriation (id),
  ADD CONSTRAINT county_dictated_appropriation_ibfk_5 FOREIGN KEY (service_id) REFERENCES service (id);

-- 
-- Constraints for table `county_user`
-- 
ALTER TABLE `county_user`
  ADD CONSTRAINT county_user_ibfk_1 FOREIGN KEY (id) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `emsof_request_detail`
-- 
ALTER TABLE `emsof_request_detail`
  ADD CONSTRAINT emsof_request_detail_ibfk_10 FOREIGN KEY (master_id) REFERENCES emsof_request_master (id),
  ADD CONSTRAINT emsof_request_detail_ibfk_11 FOREIGN KEY (equipment_code) REFERENCES eligible_provider_equipment_list (`code`),
  ADD CONSTRAINT emsof_request_detail_ibfk_12 FOREIGN KEY (status_code) REFERENCES item_status_code_description_map (`code`);

-- 
-- Constraints for table `emsof_request_master`
-- 
ALTER TABLE `emsof_request_master`
  ADD CONSTRAINT emsof_request_master_ibfk_2 FOREIGN KEY (county_dictated_appropriation_id) REFERENCES county_dictated_appropriation (id),
  ADD CONSTRAINT emsof_request_master_ibfk_3 FOREIGN KEY (fiscal_year_id) REFERENCES fiscal_year (id),
  ADD CONSTRAINT emsof_request_master_ibfk_4 FOREIGN KEY (status_code) REFERENCES request_status_code_description_map (`code`);

-- 
-- Constraints for table `fy_calendar`
-- 
ALTER TABLE `fy_calendar`
  ADD CONSTRAINT fy_calendar_ibfk_2 FOREIGN KEY (milestone_code) REFERENCES milestone_code_name_map (`code`),
  ADD CONSTRAINT fy_calendar_ibfk_1 FOREIGN KEY (fiscal_year_id) REFERENCES fiscal_year (id);

-- 
-- Constraints for table `region_dictated_appropriation`
-- 
ALTER TABLE `region_dictated_appropriation`
  ADD CONSTRAINT region_dictated_appropriation_ibfk_12 FOREIGN KEY (state_dictated_appropriation_id) REFERENCES state_dictated_appropriation (id),
  ADD CONSTRAINT region_dictated_appropriation_ibfk_13 FOREIGN KEY (county_code) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `regional_staffer_user`
-- 
ALTER TABLE `regional_staffer_user`
  ADD CONSTRAINT regional_staffer_user_ibfk_1 FOREIGN KEY (id) REFERENCES regional_staffer (id);

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
