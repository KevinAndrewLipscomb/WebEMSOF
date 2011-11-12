START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_class_final_status;
CREATE TABLE IF NOT EXISTS coned_offering_class_final_status (
  id SERIAL,
  description VARCHAR(15) NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = InnoDB
;
insert ignore coned_offering_class_final_status (description) values
("CANCELED"),
("RAN NO CE"),
("RAN")
;
COMMIT