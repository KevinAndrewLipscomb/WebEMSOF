DROP TABLE IF EXISTS practitioner;
CREATE TABLE IF NOT EXISTS practitioner (
  id SERIAL,
  last_name VARCHAR(31) NOT NULL,
  first_name VARCHAR(31) NOT NULL,
  middle_initial CHAR(1) NOT NULL,
  certification_number CHAR(6) NOT NULL,
  level_id BIGINT UNSIGNED NOT NULL,
  regional_council_code TINYINT UNSIGNED NOT NULL,
  birth_date DATE,
  be_stale BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY(id),
  UNIQUE (certification_number,last_name,first_name,middle_initial,level_id,regional_council_code),
  INDEX (last_name,first_name,middle_initial,certification_number),
  INDEX (level_id,last_name,first_name,middle_initial,certification_number),
  INDEX (regional_council_code)
)
ENGINE = InnoDB;
ALTER TABLE `practitioner`
  ADD CONSTRAINT `practitioner_level_id` FOREIGN KEY (`level_id` ) REFERENCES `practitioner_level` (`id` ),
  ADD CONSTRAINT `practitioner_regional_council_code` FOREIGN KEY (`regional_council_code` ) REFERENCES `region_code_name_map` (`code` );
