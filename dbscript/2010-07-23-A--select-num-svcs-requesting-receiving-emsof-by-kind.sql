--
-- Num AMBULANCE svcs *requesting* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE be_als_amb or be_bls_amb
  and fiscal_year.id = ?
  and emsof_request_master.status_code <> 12
--
-- Num QRS svcs *requesting* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE not (be_bls_amb or be_als_amb) and be_qrs
  and fiscal_year.id = ?
  and emsof_request_master.status_code <> 12
--
-- Num RESCUE svcs *requesting* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE not (be_bls_amb or be_als_amb or be_qrs) and be_rescue
  and fiscal_year.id = ?
  and emsof_request_master.status_code <> 12
--
-- Num AMBULANCE svcs *receiving* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE be_als_amb or be_bls_amb
  and fiscal_year.id = 5
  and emsof_request_master.status_code = 14
--
-- Num QRS svcs *receiving* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE not (be_bls_amb or be_als_amb) and be_qrs
  and fiscal_year.id = 5
  and emsof_request_master.status_code = 14
--
-- Num RESCUE svcs *receiving* EMSOF in specified FY
--
SELECT count(distinct service.id)
from fiscal_year
  join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)
  join region_dictated_appropriation on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)
  join county_dictated_appropriation on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)
  join service on (service.id=county_dictated_appropriation.service_id)
  join emsof_request_master on (emsof_request_master.id=county_dictated_appropriation.id)
WHERE not (be_bls_amb or be_als_amb or be_qrs) and be_rescue
  and fiscal_year.id = 5
  and emsof_request_master.status_code = 14
