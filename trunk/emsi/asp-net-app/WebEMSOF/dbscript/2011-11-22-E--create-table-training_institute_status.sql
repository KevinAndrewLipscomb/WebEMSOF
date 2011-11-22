START TRANSACTION
;
DROP TABLE IF EXISTS training_institute_status
;
CREATE TABLE IF NOT EXISTS training_institute_status (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(description)
)
ENGINE = InnoDB
;
insert ignore training_institute_status (description) values
("Full"),
("(placeholder 2)"),
("Suspended"),
("(placeholder 4)"),
("Did not renew")
;
COMMIT