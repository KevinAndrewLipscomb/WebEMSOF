START TRANSACTION;

DROP TABLE IF EXISTS `epel_special_rule_map`;

DROP TABLE IF EXISTS special_rule;
CREATE TABLE IF NOT EXISTS special_rule
  (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(31) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX name(`name`)
  )
ENGINE = InnoDB;

insert special_rule (name) values
("UpTo2PerVehicle"),
("UpTo1PerVehicle"),
("UpTo5"),
("HasMedicalDirector"),
("UpTo1PerAmbulance");

CREATE TABLE IF NOT EXISTS `epel_special_rule_map` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `epel_code` SMALLINT(5) unsigned NOT NULL,
  `special_rule_id` INTEGER unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE  (`epel_code`,`special_rule_id`),
  KEY `special_rule_id` (`special_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `epel_special_rule_map`
  ADD CONSTRAINT `epel_special_rule_map_epel_code` FOREIGN KEY (`epel_code`) REFERENCES `eligible_provider_equipment_list` (`code`),
  ADD CONSTRAINT `epel_special_rule_map_special_rule_id` FOREIGN KEY (`special_rule_id`) REFERENCES `special_rule` (`id`);

--
-- Dumping data for table `role_member_map`
--

INSERT INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%(%2/%vehicle)%"
    and name = "UpTo2PerVehicle";
INSERT INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where ((description like "%(1/vehicle)%") or (description like "%Stairchair%") or (description like "%Vehicle safety monitoring system%"))
    and name = "UpTo1PerVehicle";
INSERT INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%(up to 5)%"
    and name = "UpTo5";
INSERT INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where ((description like "AED") or (description like "%Ventilator%"))
    and name = "HasMedicalDirector";
INSERT INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%Stretcher %"
    and name = "UpTo1PerAmbulance";

COMMIT