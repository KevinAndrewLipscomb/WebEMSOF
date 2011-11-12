START TRANSACTION
;
DROP TABLE IF EXISTS coned_offering_document_status;
CREATE TABLE IF NOT EXISTS coned_offering_document_status (
  id SERIAL,
  description CHAR(1) NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = InnoDB
;
insert ignore coned_offering_document_status (description) values
("R"),
("F"),
("C")
;
COMMIT