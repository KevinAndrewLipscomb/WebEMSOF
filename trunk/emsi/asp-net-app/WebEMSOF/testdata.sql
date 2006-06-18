-- $Id$
--
-- phpMyAdmin SQL Dump
-- version 2.6.4-pl4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jun 11, 2006 at 06:56 PM
-- Server version: 5.0.20
-- PHP Version: 4.4.2

SET FOREIGN_KEY_CHECKS=0;

SET AUTOCOMMIT=0;
START TRANSACTION;

-- 
-- Database: `emsidb`
-- 

-- 
-- Dumping data for table `county_user`
-- 

INSERT INTO `county_user` (`id`, `encoded_password`, `be_stale_password`, `password_reset_email_address`, `be_active`) VALUES 
(1, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(2, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(3, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(4, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(5, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(6, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(7, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(8, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(9, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1),
(10, sha('countypass'), 0, 'kevin.lipscomb@kvrs.org', 1);


-- 
-- Dumping data for table `fiscal_year`
-- 

INSERT INTO `fiscal_year` (`id`, `designator`) VALUES (2, 'FY0607');

-- 
-- Dumping data for table `fy_calendar`
-- 

INSERT INTO `fy_calendar` (`id`, `fiscal_year_id`, `milestone_code`, `value`) VALUES
(5, 2, 1, '2006-11-30 23:59:59'),
(6, 2, 2, '2007-01-31 23:59:59'),
(7, 2, 3, '2007-02-28 23:59:59'),
(8, 2, 4, '2007-05-31 23:59:59');

-- 
-- Dumping data for table `region_dictated_appropriation`
-- 

INSERT INTO `region_dictated_appropriation` (`id`, `state_dictated_appropriation_id`, `county_code`, `amount`, `service_to_county_submission_deadline`) VALUES 
(11, 2, 1, 97368.02, '2006-11-16 23:59:59'),
(12, 2, 2, 19578.02, '2006-11-16 23:59:59'),
(14, 2, 4, 35270.02, '2006-11-16 23:59:59'),
(15, 2, 5, 30140.02, '2006-11-16 23:59:59'),
(16, 2, 6, 13617.84, '2006-11-16 23:59:59'),
(17, 2, 7, 24329.02, '2006-11-16 23:59:59'),
(18, 2, 8, 16846.02, '2006-11-16 23:59:59'),
(19, 2, 9, 35959.02, '2006-11-16 23:59:59'),
(20, 2, 10, 52066.02, '2006-11-16 23:59:59');

-- 
-- Dumping data for table `regional_staffer`
-- 

INSERT INTO `regional_staffer` (`id`, `region_code`, `last_name`, `first_name`) VALUES 
(1, 1, 'McElree', 'Tom'),
(2, 1, 'Cameron', 'Amos P'),
(3, 1, 'Arrington', 'Gloria'),
(4, 1, 'Brown', 'Jessika');

--
-- Dumping data for table `regional_staffer_role`
--

INSERT INTO `regional_staffer_role` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 2, 5),
(4, 3, 4),
(5, 4, 3);

--
-- Dumping data for table `regional_staffer_user`
--

INSERT INTO `regional_staffer_user` (`id`, `encoded_password`, `be_stale_password`, `password_reset_email_address`, `be_active`) VALUES
(1, sha('regionpass'), 0, 'finances@kvrs.org', 1),
(2, sha('regionpass'), 0, 'finances@kvrs.org', 1),
(3, sha('regionpass'), 0, 'finances@kvrs.org', 1),
(4, sha('regionpass'), 0, 'finances@kvrs.org', 1);

-- 
-- Dumping data for table `service`
-- 

INSERT INTO `service` (`id`, `county_code`, `affiliate_num`, `name`, `be_qrs`, `be_bls_amb`, `be_als_amb`, `be_als_squad`, `be_air_amb`, `be_rescue`, `address_line_1`, `address_line_2`, `city`, `zip_code`, `federal_tax_id_num`, `contact_person_name`, `contact_person_phone_num`, `be_valid_profile`) VALUES 
(1, 1, '00001', 'Baldwin', 1, 1, 1, 1, 0, 1, '123 Baldwin Way', '', 'Baldwin', '15444', '852741963', 'Curt Neill', '4125554444', 1),
(2, 1, '00002', 'RossWestview', 1, 1, 1, 1, 0, 1, '100 Ross Way', '', 'Westview', '16543', '500555500', 'Contact Person', '4125005555', 1),
(3, 10, '00003', 'Mutual Aid', 0, 0, 0, 0, 0, 0, '', '', NULL, '', '', '', '', 0),
(4, 5, '00004', 'Fayette', 0, 0, 0, 0, 0, 0, '', '', NULL, '', '', '', '', 0),
(5, 1, '00005', 'Seneca Area', 1, 1, 1, 1, 0, 0, '1815 Main Street', '', 'Sharpsburg', '15221', '160165160', 'Anthony Cuda', '4121600165', 1),
(6, 1, '00006', 'EMSI QRS', 1, 0, 0, 0, 0, 0, '221 Penn Ave', 'Suite 2500', 'Wilkinsburg', '15221', '404404404', 'Tom McElree', '4122427322', 1),
(7, 9, '00007', 'RostraverWestnewton', 0, 0, 1, 0, 0, 0, '321 Rostraver Way', '', 'Westnewton', '55122', '975312468', 'Ross W. Newton', '7249997777', 1),
(8, 1, '00008', 'Lower Valley', 1, 1, 1, 1, 0, 0, '123 Lower Valley Rd', '', 'Lower Valley', '12345', '098765432', 'Mister Valley', '4123456789', 1),
(9, 1, '00009', 'Foxwall', 0, 0, 0, 0, 0, 0, '', '', NULL, '', '', '', '', 0),
(10, 1, '00010', 'Pittsburgh', 0, 0, 1, 0, 0, 1, '123 Pittsburgh EMS Way', '', 'Pittsburgh', '15206', '666489712', 'Doug Garretson', '4123330911', 1);

-- 
-- Dumping data for table `service_user`
-- 

INSERT INTO `service_user` (`id`, `encoded_password`, `be_stale_password`, `password_reset_email_address`, `be_active`) VALUES 
(1, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(2, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(3, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(4, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(5, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(6, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(7, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(8, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(9, sha('servicepass'), 0, 'infotech@kvrs.org', 1),
(10, sha('servicepass'), 0, 'infotech@kvrs.org', 1);

-- 
-- Dumping data for table `state_dictated_appropriation`
-- 

INSERT INTO `state_dictated_appropriation` (`id`, `region_code`, `fiscal_year_id`, `amount`) VALUES 
(2, 1, 2, 350172.02);

SET FOREIGN_KEY_CHECKS=1;

COMMIT;