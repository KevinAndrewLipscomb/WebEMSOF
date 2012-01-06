START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_status
;
CREATE TABLE IF NOT EXISTS coned_offering_status (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(description)
)
ENGINE = InnoDB
;
insert ignore coned_offering_status (description) values
("NEEDS_CONED_SPONSOR_FINALIZATION"),
("NEEDS_REGIONAL_PROCESSING"),
("ARCHIVED")
;
COMMIT