START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_class_final_status;
CREATE TABLE IF NOT EXISTS coned_offering_class_final_status (
  id SERIAL,
  short_description VARCHAR(15) NOT NULL,
  long_description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(short_description),
  UNIQUE(long_description)
)
ENGINE = InnoDB
;
insert ignore coned_offering_class_final_status (short_description,long_description) values
("CANCELED","Class was canceled"),
("RAN NO CE","Class ran but no CE was requested"),
("RAN","Class ran and CE was requested")
;
COMMIT