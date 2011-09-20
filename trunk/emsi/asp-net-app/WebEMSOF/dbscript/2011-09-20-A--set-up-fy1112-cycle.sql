START TRANSACTION;

insert fy_calendar (fiscal_year_id,milestone_code,`value`) VALUES
((select id from fiscal_year where designator = 'FY1112'),1,'2011-11-30 23:59:59'),
((select id from fiscal_year where designator = 'FY1112'),2,'2012-01-31 23:59:59'),
((select id from fiscal_year where designator = 'FY1112'),3,'2012-02-29 23:59:59'),
((select id from fiscal_year where designator = 'FY1112'),4,'2012-05-31 23:59:59'),
((select id from fiscal_year where designator = 'FY1112'),5,'2012-06-30 23:59:59');

insert region_dictated_appropriation (state_dictated_appropriation_id,county_code,amount,service_to_county_submission_deadline,match_level_id) VALUES
((select max(id) from state_dictated_appropriation),1,97699,'2011-11-15 23:59:59',1),
((select max(id) from state_dictated_appropriation),2,24484,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),3,24022,'2011-11-15 23:59:59',1),
((select max(id) from state_dictated_appropriation),4,40928,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),5,31799,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),6,16503,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),7,26933,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),8,17974,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),9,36249,'2011-11-15 23:59:59',2),
((select max(id) from state_dictated_appropriation),10,53409,'2011-11-15 23:59:59',1);

INSERT eligible_provider_equipment_list (fiscal_year_id,description,life_expectancy_years,be_eligible_als_amb,be_eligible_als_squad,be_eligible_bls_amb,be_eligible_qrs,allowable_cost,funding_level_nonrural,funding_level_rural) VALUES
((select id from fiscal_year where designator = 'FY1112'), 'EKG monitor/defibrillator w/pacer', 5, 1, 1, 0, 0, 12000.00, 6000.00, 7200.00),
((select id from fiscal_year where designator = 'FY1112'), '12 lead EKG', 5, 1, 1, 0, 0, 20000.00, 10000.00, 12000.00),
((select id from fiscal_year where designator = 'FY1112'), 'AED', 5, 0, 0, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY1112'), 'AED trainer', 5, 0, 0, 1, 1, 400.00, 200.00, 240.00),
((select id from fiscal_year where designator = 'FY1112'), 'Oxygen system parts', 5, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY1112'), 'Capnography', 3, 1, 1, 0, 0, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY1112'), 'CPAP', 5, 1, 1, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY1112'), 'Pulse oximeter', 5, 1, 1, 1, 1, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY1112'), 'Nitrous oxide delivery system', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY1112'), 'IV infusion pump', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY1112'), 'Intubation, durable', 5, 1, 1, 0, 0, 600.00, 300.00, 360.00),
((select id from fiscal_year where designator = 'FY1112'), 'Transtracheal jet insufflators', 5, 1, 1, 0, 0, 200.00, 100.00, 120.00),
((select id from fiscal_year where designator = 'FY1112'), 'Splinting/immobilization devices', 3, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY1112'), 'Stairchair 300 lb capacity', 3, 1, 0, 1, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY1112'), 'Stairchair 500 lb capacity', 5, 1, 0, 1, 0, 2650.00, 1325.00, 1590.00),
((select id from fiscal_year where designator = 'FY1112'), 'Stretcher 300 lb capacity', 5, 1, 0, 1, 0, 4000.00, 2000.00, 2400.00),
((select id from fiscal_year where designator = 'FY1112'), 'Stretcher 700 lb capacity', 5, 1, 0, 1, 0, 11500.00, 5750.00, 6900.00),
((select id from fiscal_year where designator = 'FY1112'), 'Stretcher/chair combination', 5, 1, 0, 1, 0, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY1112'), 'Suction, portable', 3, 1, 1, 1, 1, 900.00, 450.00, 540.00),
((select id from fiscal_year where designator = 'FY1112'), 'Ventilator, automatic', 5, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY1112'), 'Ambulance w/chevron FOR URBAN SERVICES ONLY', NULL, 1, 0, 1, 0, 30000.00, 15000.00, 0.00),
((select id from fiscal_year where designator = 'FY1112'), 'Ambulance w/chevron FOR RURAL SERVICES ONLY', NULL, 1, 0, 1, 0, 33333.33, 0.00, 20000.00),
((select id from fiscal_year where designator = 'FY1112'), 'Chevron', NULL, 1, 1, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY1112'), 'Squad/response vehicle w/chevron', NULL, 0, 1, 0, 1, 15000.00, 7500.00, 9000.00),
((select id from fiscal_year where designator = 'FY1112'), 'Data collection software/technology', NULL, 1, 1, 1, 1, 1700.00, 850.00, 1020.00),
((select id from fiscal_year where designator = 'FY1112'), 'Data collection hardware', 3, 1, 1, 1, 1, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY1112'), 'Radio, mobile (up to 2/vehicle)', 5, 1, 1, 1, 1, 5000.00, 2500.00, 3000.00),
((select id from fiscal_year where designator = 'FY1112'), 'Radio, portable (2/vehicle)', 5, 1, 1, 1, 1, 5000.00, 2500.00, 3000.00),
((select id from fiscal_year where designator = 'FY1112'), 'Triage vest, reflective, ANSI-std', 5, 1, 1, 1, 1, 150.00, 75.00, 90.00),
((select id from fiscal_year where designator = 'FY1112'), 'Triage system', 5, 1, 1, 1, 1, 750.00, 375.00, 450.00),
((select id from fiscal_year where designator = 'FY1112'), 'Alerting (up to 5)', 5, 1, 1, 1, 1, 400.00, 200.00, 240.00),
((select id from fiscal_year where designator = 'FY1112'), 'Vehicle safety monitoring system', 5, 1, 1, 1, 1, 3500.00, 1750.00, 2100.00),
((select id from fiscal_year where designator = 'FY1112'), 'PPE/turnout gear/vest/respiratory', 5, 1, 1, 1, 1, 1200.00, 600.00, 720.00),
((select id from fiscal_year where designator = 'FY1112'), 'Protective ballistic vest', 5, 1, 1, 1, 1, 1000.00, 500.00, 600.00),
((select id from fiscal_year where designator = 'FY1112'), 'GPS receiver (1/vehicle)', 5, 1, 1, 1, 1, 500.00, 250.00, 275.00),
((select id from fiscal_year where designator = 'FY1112'), 'Traffic safety', 5, 1, 1, 1, 1, 2500.00, 1250.00, 1500.00),
((select id from fiscal_year where designator = 'FY1112'), 'Large patient moving/carrying device', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY1112'), 'SCBA (up to 2/licensed vehicle)', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY1112'), 'EMT-P/PHRN Written Test', NULL, 1, 1, 0, 0, 300.00, 300.00, 300.00),
((select id from fiscal_year where designator = 'FY1112'), 'EMT/FR Written Test', NULL, 0, 0, 1, 1, 200.00, 200.00, 200.00),
((select id from fiscal_year where designator = 'FY1112'), 'CO detector/monitor', 5, 1, 1, 1, 1, 200.00, 100.00, 120.00),
((select id from fiscal_year where designator = 'FY1112'), '12 lead EKG transmitter system', 5, 1, 1, 0, 0, 1000.00, 500.00, 600.00),
((select id from fiscal_year where designator = 'FY1112'), 'IO drill/injection system', 5, 1, 1, 0, 0, 300.00, 150.00, 180.00),
((select id from fiscal_year where designator = 'FY1112'), 'Narcotics security system', 5, 1, 1, 0, 0, 900.00, 450.00, 540.00),
((select id from fiscal_year where designator = 'FY1112'), 'Refrigerator, mini', 10, 1, 1, 0, 0, 1200.00, 600.00, 720.00),
((select id from fiscal_year where designator = 'FY1112'), 'Tourniquet, commercial', 5, 1, 1, 1, 1, 25.00, 12.50, 15.00),
((select id from fiscal_year where designator = 'FY1112'), 'Bariatric equipment', 5, 1, 1, 1, 1, 20000.00, 10000.00, 12000.00),
((select id from fiscal_year where designator = 'FY1112'), 'Other - with attached documentation', NULL, 1, 1, 1, 1, NULL, NULL, NULL);

INSERT ignore INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%(%2/%vehicle)%"
    and name = "UpTo2PerVehicle";
INSERT ignore INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where ((description like "%(1/vehicle)%") or (description like "%Stairchair%") or (description like "%Vehicle safety monitoring system%") or (description like "%Refrigerator%"))
    and name = "UpTo1PerVehicle";
INSERT ignore INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%(up to 5)%"
    and name = "UpTo5";
INSERT ignore INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where ((description like "AED") or (description like "%Ventilator%"))
    and name = "HasMedicalDirector";
INSERT ignore INTO `epel_special_rule_map` (epel_code,special_rule_id)
  select code as epel_code,
    id as special_rule_id
  from eligible_provider_equipment_list,
    special_rule
  where description like "%Stretcher %"
    and name = "UpTo1PerAmbulance";

COMMIT