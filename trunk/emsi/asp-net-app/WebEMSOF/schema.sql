-- phpMyAdmin SQL Dump
-- version 2.7.0-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: db4free.org
-- Generation Time: Mar 26, 2006 at 10:01 PM
-- Server version: 5.0.19
-- PHP Version: 5.0.3
-- 
-- Database: `kalipso`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `county_code_name_map`
-- 

CREATE TABLE county_code_name_map (
  `code` tinyint(4) NOT NULL auto_increment,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_request`
-- 

CREATE TABLE emsof_request (
  id bigint(20) unsigned NOT NULL auto_increment,
  emsof_sponsorship_id smallint(5) unsigned NOT NULL,
  fiscal_year_id smallint(5) unsigned NOT NULL,
  status_code tinyint(3) NOT NULL,
  `value` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY  (emsof_sponsorship_id,fiscal_year_id),
  UNIQUE KEY id (id),
  KEY status_code (status_code),
  KEY fiscal_year_id (fiscal_year_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_sponsorship`
-- 

CREATE TABLE emsof_sponsorship (
  id smallint(5) unsigned NOT NULL auto_increment,
  affiliate_num char(5) NOT NULL,
  county_code tinyint(4) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY affiliate_num_2 (affiliate_num,county_code),
  KEY county_code (county_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `emsof_sponsorship_webemsof_account`
-- 

CREATE TABLE emsof_sponsorship_webemsof_account (
  emsof_sponsorship_id smallint(5) unsigned NOT NULL,
  encoded_password char(40) default NULL,
  be_stale_password tinyint(1) NOT NULL default '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (emsof_sponsorship_id)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `request_status_code_description_map`
-- 

CREATE TABLE request_status_code_description_map (
  `code` tinyint(4) NOT NULL auto_increment,
  description varchar(63) NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `response_agency_profile`
-- 

CREATE TABLE response_agency_profile (
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
  PRIMARY KEY  (affiliate_num),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table `emsof_request`
-- 
ALTER TABLE `emsof_request`
  ADD CONSTRAINT emsof_request_ibfk_10 FOREIGN KEY (fiscal_year_id) REFERENCES fiscal_year (id),
  ADD CONSTRAINT emsof_request_ibfk_11 FOREIGN KEY (status_code) REFERENCES request_status_code_description_map (`code`),
  ADD CONSTRAINT emsof_request_ibfk_9 FOREIGN KEY (emsof_sponsorship_id) REFERENCES emsof_sponsorship (id);

-- 
-- Constraints for table `emsof_sponsorship`
-- 
ALTER TABLE `emsof_sponsorship`
  ADD CONSTRAINT emsof_sponsorship_ibfk_1 FOREIGN KEY (affiliate_num) REFERENCES response_agency_profile (affiliate_num),
  ADD CONSTRAINT emsof_sponsorship_ibfk_2 FOREIGN KEY (county_code) REFERENCES county_code_name_map (`code`);

-- 
-- Constraints for table `emsof_sponsorship_webemsof_account`
-- 
ALTER TABLE `emsof_sponsorship_webemsof_account`
  ADD CONSTRAINT emsof_sponsorship_webemsof_account_ibfk_1 FOREIGN KEY (emsof_sponsorship_id) REFERENCES emsof_sponsorship (id);
