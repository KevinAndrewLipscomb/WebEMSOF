START TRANSACTION;

update service
set be_distressed = TRUE
where name in ('Northwestern EMS','City of Pittsburgh Emergency Medical Services');

update county_dictated_appropriation
set match_level_id = 1
where id in (356,375,377);

update county_dictated_appropriation
set match_level_id = 2
where id = 419;

update county_dictated_appropriation
set match_level_id = 3
where id = 392;

COMMIT