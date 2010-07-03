select service.name as service
 , county_code_name_map.name as county
 , @allocation := county_dictated_appropriation.amount as allocation
 , @reimbursement := IF(status_code not in (11,12,16),emsof_request_master.actual_value,0) as reimbursement
 , FORMAT(@allocation - @reimbursement,2) as amount_returned
from fiscal_year
  join state_dictated_appropriation
    on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation
    on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation
    on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join emsof_request_master
    on (emsof_request_master.id=county_dictated_appropriation.id)
  join service
    on (service.id=county_dictated_appropriation.service_id)
  join county_code_name_map
    on (county_code_name_map.code=region_dictated_appropriation.county_code)
where fiscal_year.designator = "FY0910"
order by service.name