START TRANSACTION;

insert ignore milestone_code_name_map set name = "emsof-service-annual-survey-submission-deadline";

insert ignore fy_calendar set fiscal_year_id = 6
 , milestone_code = (select code from milestone_code_name_map where name = "emsof-service-annual-survey-submission-deadline")
 , value = "2010-10-08 23:59:59";

COMMIT