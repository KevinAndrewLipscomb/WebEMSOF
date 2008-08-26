START TRANSACTION;

DROP TABLE IF EXISTS charter_kind;
CREATE TABLE IF NOT EXISTS charter_kind (
  id SERIAL,
  description VARCHAR(127) NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = InnoDB;

insert charter_kind set description = 'Non-profit corporation (includes most Volunteer Fire Departments)';
insert charter_kind set description = 'Municipally-owned EMS';
insert charter_kind set description = 'Municipally-owned Fire';
insert charter_kind set description = 'Other Fire';
insert charter_kind set description = 'Joint-municipality authority';
insert charter_kind set description = 'Hospital';
insert charter_kind set description = 'Industrial';
insert charter_kind set description = 'Private for-profit';
insert charter_kind set description = 'Other';

COMMIT