START TRANSACTION
;
DROP TABLE IF EXISTS coned_sponsor_status
;
CREATE TABLE IF NOT EXISTS coned_sponsor_status (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(description)
)
ENGINE = InnoDB
;
insert ignore coned_sponsor_status (description) values
("Approved"),
("Not Approved"),
("Provisional"),
("Inactive"),
("Expired"),
("Withdrawn")
;
COMMIT