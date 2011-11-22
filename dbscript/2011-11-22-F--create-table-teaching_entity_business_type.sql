START TRANSACTION
;
DROP TABLE IF EXISTS teaching_entity_business_type
;
CREATE TABLE IF NOT EXISTS teaching_entity_business_type (
  id SERIAL,
  description VARCHAR(63) NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(description)
)
ENGINE = InnoDB
;
insert ignore teaching_entity_business_type (description) values
("Education"),
("Hospital"),
("Ambulance Service"),
("QRS"),
("Other"),
("Vocational/Technical School"),
("(placeholder 7)"),
("Community College"),
("2 yr Post-High School"),
("4 yr College"),
("Training Institute (independant of others listed)"),
("Fire Department (non-ambulance)")
;
COMMIT