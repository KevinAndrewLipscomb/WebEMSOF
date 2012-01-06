START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_roster
;
CREATE TABLE IF NOT EXISTS `coned_offering_roster`
  (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT
  ,
    `coned_offering_class_id` BIGINT UNSIGNED NOT NULL
  ,
    `practitioner_id` BIGINT UNSIGNED NOT NULL
  ,
    `instructor_hours` DECIMAL(5,1) UNSIGNED NULL
  ,
    PRIMARY KEY (`id`)
  ,
    UNIQUE INDEX `coned_offering_class_id` (`coned_offering_class_id` ASC, `practitioner_id` ASC)
  ,
    UNIQUE INDEX `practitoner_id` (`practitioner_id` ASC, `coned_offering_class_id` ASC)
  ,
    CONSTRAINT `coned_offering_roster_coned_offering_class_id`
      FOREIGN KEY (`coned_offering_class_id` )
      REFERENCES `coned_offering` (`class_id` )
  ,
    CONSTRAINT `coned_offering_roster_practitioner_id`
      FOREIGN KEY (`practitioner_id` )
      REFERENCES `practitioner` (`id` )
  )
;
COMMIT