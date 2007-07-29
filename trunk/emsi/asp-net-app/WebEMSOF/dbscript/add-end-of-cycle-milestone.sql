START TRANSACTION;

ALTER TABLE milestone_code_name_map ADD UNIQUE INDEX name (`name`);

insert milestone_code_name_map
set name = 'emsof-end-of-cycle';

insert fy_calendar
set fiscal_year_id = 2,
  milestone_code = (select code from milestone_code_name_map where name = 'emsof-end-of-cycle'),
  `value` = '2007-06-30 23:59:59';

COMMIT