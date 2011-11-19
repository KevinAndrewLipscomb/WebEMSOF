START TRANSACTION
;
DROP TABLE IF EXISTS teaching_entity_level;
CREATE TABLE IF NOT EXISTS teaching_entity_level (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(description)
)
ENGINE = InnoDB
;
insert ignore teaching_entity_level (description) values
("1"),
("2"),
("3"),
("4"),
("Rescue"),
("BLS"),
("BLS and ALS"),
("ALS")
;
COMMIT