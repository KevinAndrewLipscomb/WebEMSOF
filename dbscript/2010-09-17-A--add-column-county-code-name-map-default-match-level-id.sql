START TRANSACTION;

alter table county_code_name_map
  add column default_match_level_id TINYINT UNSIGNED NOT NULL DEFAULT "1",
  add key default_match_level_id (default_match_level_id),
  add constraint county_default_match_level_id foreign key (default_match_level_id) references match_level (id);

update county_code_name_map
set default_match_level_id =
  (
  select match_level_id
  from region_dictated_appropriation
  where county_code = code and state_dictated_appropriation_id = 6
  );

COMMIT