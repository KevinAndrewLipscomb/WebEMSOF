START TRANSACTION;


-- --------------------------------------------------------

--
-- Table structure for table `indicator_equipment_quantities`
--

DROP TABLE IF EXISTS `indicator_equipment_quantities`;
CREATE TABLE IF NOT EXISTS `indicator_equipment_quantities` (
  `fiscal_year_id` smallint unsigned NOT NULL,
  `description` varchar(127) NOT NULL,
  `quantity` INTEGER unsigned NOT NULL,
  PRIMARY KEY  (`fiscal_year_id`,`description`),
  KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for table `indicator_equipment_quantities`
--
ALTER TABLE `indicator_equipment_quantities`
  ADD CONSTRAINT `indicator_equipment_quantities_fiscal_year_id` FOREIGN KEY `fiscal_year_id` (`fiscal_year_id`) REFERENCES `fiscal_year` (`id`),
  ADD CONSTRAINT `indicator_equipment_quantities_description` FOREIGN KEY `description` (`description`) REFERENCES `eligible_provider_equipment_list` (`description`);


COMMIT