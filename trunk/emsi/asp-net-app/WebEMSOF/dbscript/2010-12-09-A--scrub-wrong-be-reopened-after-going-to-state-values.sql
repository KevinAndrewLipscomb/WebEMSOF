START TRANSACTION
;
update emsof_request_master
  join county_dictated_appropriation
    on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)
  join region_dictated_appropriation
    on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)
  join state_dictated_appropriation
    on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)
  join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)
set be_reopened_after_going_to_state = FALSE
where be_reopened_after_going_to_state
  and fiscal_year.designator = "FY1011"
;
COMMIT