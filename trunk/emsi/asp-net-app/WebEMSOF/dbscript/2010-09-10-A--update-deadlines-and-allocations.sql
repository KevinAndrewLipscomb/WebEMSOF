START TRANSACTION;

update `fy_calendar`
set value = "2010-11-30 23:59:59"
where fiscal_year_id = (select id from fiscal_year where designator = "FY1011")
  and milestone_code = (select code from milestone_code_name_map where name = "emsof-county-dictated-appropriation-deadline");

update `fy_calendar`
set value = "2011-01-31 23:59:59"
where fiscal_year_id = (select id from fiscal_year where designator = "FY1011")
  and milestone_code = (select code from milestone_code_name_map where name = "emsof-service-purchase-completion-deadline");

update `fy_calendar`
set value = "2011-02-28 23:59:59"
where fiscal_year_id = (select id from fiscal_year where designator = "FY1011")
  and milestone_code = (select code from milestone_code_name_map where name = "emsof-service-invoice-submission-deadline");

update `fy_calendar`
set value = "2011-05-31 23:59:59"
where fiscal_year_id = (select id from fiscal_year where designator = "FY1011")
  and milestone_code = (select code from milestone_code_name_map where name = "emsof-service-canceled-check-submission-deadline");

update region_dictated_appropriation
set amount = "97699"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Allegheny");

update region_dictated_appropriation
set amount = "24484"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Armstrong");

update region_dictated_appropriation
set amount = "24022"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Beaver");

update region_dictated_appropriation
set amount = "40928"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Butler");

update region_dictated_appropriation
set amount = "31799"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Fayette");

update region_dictated_appropriation
set amount = "16503"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Greene");

update region_dictated_appropriation
set amount = "26933"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Indiana");

update region_dictated_appropriation
set amount = "17974"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Lawrence");

update region_dictated_appropriation
set amount = "36249"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Washington");

update region_dictated_appropriation
set amount = "53409"
 , service_to_county_submission_deadline = "2010-11-16 23:59:59"
where state_dictated_appropriation_id = (select id from state_dictated_appropriation where fiscal_year_id = (select id from fiscal_year where designator = "FY1011"))
  and county_code = (select code from county_code_name_map where name = "Westmoreland");

COMMIT