START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_class_final_status_description;
CREATE TABLE IF NOT EXISTS coned_offering_class_final_status_description (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = InnoDB
;
insert ignore coned_offering_class_final_status_description (description) values
("Class was canceled"),
("Class ran but no CE was requested"),
("Class ran and CE was requested")
;
COMMIT