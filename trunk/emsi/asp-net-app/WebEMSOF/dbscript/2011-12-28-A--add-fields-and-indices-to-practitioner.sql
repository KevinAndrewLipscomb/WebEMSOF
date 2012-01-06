START TRANSACTION
;
ALTER TABLE `practitioner`
  ADD COLUMN `residence_county_code` TINYINT UNSIGNED NULL  AFTER `regional_council_code`
,
  CHANGE COLUMN `level_id` `level_id` BIGINT(20) UNSIGNED NOT NULL  AFTER `middle_initial`
,
  ADD CONSTRAINT `practitioner_residence_county_code` FOREIGN KEY (`residence_county_code` ) REFERENCES `county_code_name_map` (`code` )
,
  DROP INDEX `certification_number`
,
  ADD UNIQUE INDEX `certification_number` (`certification_number` ASC, `birth_date` ASC)
,
  DROP INDEX `last_name`
,
  ADD INDEX `last_name` (`last_name` ASC, `first_name` ASC, `middle_initial` ASC)
,
  DROP INDEX `level_id`
,
  ADD INDEX `level_id` (`level_id` ASC)
,
  ADD INDEX `residence_county_code` (`residence_county_code` ASC)
,
  DROP INDEX `id`
;
COMMIT