START TRANSACTION;

insert fiscal_year
set designator = 'FY0708';

insert fy_calendar (fiscal_year_id,milestone_code,`value`) VALUES
((select id from fiscal_year where designator = 'FY0708'),1,'2007-11-30 23:59:59'),
((select id from fiscal_year where designator = 'FY0708'),2,'2008-01-31 23:59:59'),
((select id from fiscal_year where designator = 'FY0708'),3,'2008-02-28 23:59:59'),
((select id from fiscal_year where designator = 'FY0708'),4,'2008-05-30 23:59:59'),
((select id from fiscal_year where designator = 'FY0708'),5,'2008-06-30 23:59:59');

insert state_dictated_appropriation
set region_code = 1,
  fiscal_year_id = (select id from fiscal_year where designator = 'FY0708'),
  amount = 445120;

insert region_dictated_appropriation (state_dictated_appropriation_id,county_code,amount,service_to_county_submission_deadline) VALUES
((select max(id) from state_dictated_appropriation),1,122118,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),2,24844,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),3,31749,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),4,45307,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),5,38466,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),6,17319,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),7,30968,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),8,21394,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),9,46152,'2007-11-16 23:59:59'),
((select max(id) from state_dictated_appropriation),10,66803,'2007-11-16 23:59:59');

INSERT eligible_provider_equipment_list (fiscal_year_id,description,life_expectancy_years,be_eligible_als_amb,be_eligible_als_squad,be_eligible_bls_amb,be_eligible_qrs,allowable_cost,funding_level_nonrural,funding_level_rural) VALUES
((select id from fiscal_year where designator = 'FY0708'), 'EKG monitor/defibrillator w/pacer', 5, 1, 1, 0, 0, 12000.00, 6000.00, 7200.00),
((select id from fiscal_year where designator = 'FY0708'), '12 lead EKG', 5, 1, 1, 0, 0, 20000.00, 10000.00, 12000.00),
((select id from fiscal_year where designator = 'FY0708'), 'AED', 5, 0, 0, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY0708'), 'AED - upgrade existing unit to new standard', NULL, 0, 0, 1, 1, 400.00, 400.00, 400.00),
((select id from fiscal_year where designator = 'FY0708'), 'Oxygen system parts', 5, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY0708'), 'Capnography', 3, 1, 1, 0, 0, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'CPAP', 5, 1, 1, 0, 0, 900.00, 450.00, 540.00),
((select id from fiscal_year where designator = 'FY0708'), 'Pulse oximeter', 5, 1, 1, 1, 0, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY0708'), 'Nitrous oxide delivery system', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY0708'), 'IV infusion pump', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1000.00),
((select id from fiscal_year where designator = 'FY0708'), 'Intubation, durable', 5, 1, 1, 0, 0, 600.00, 300.00, 360.00),
((select id from fiscal_year where designator = 'FY0708'), 'Transtracheal jet insufflators', 5, 1, 1, 0, 0, 200.00, 100.00, 120.00),
((select id from fiscal_year where designator = 'FY0708'), 'Splinting/immobilization devices', 3, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY0708'), 'Stairchair 300 lb capacity', 3, 1, 0, 1, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY0708'), 'Stairchair 500 lb capacity', 5, 1, 0, 1, 0, 2650.00, 1325.00, 1590.00),
((select id from fiscal_year where designator = 'FY0708'), 'Stretcher 300 lb capacity', 5, 1, 0, 1, 0, 4000.00, 2000.00, 2400.00),
((select id from fiscal_year where designator = 'FY0708'), 'Stretcher 500 lb capacity', 5, 1, 0, 1, 0, 11500.00, 5750.00, 6900.00),
((select id from fiscal_year where designator = 'FY0708'), 'Stretcher/chair combination', 5, 1, 0, 1, 0, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY0708'), 'Suction, portable, battery operated', 3, 1, 1, 1, 1, 900.00, 450.00, 540.00),
((select id from fiscal_year where designator = 'FY0708'), 'Ventilator, automatic', 5, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'Ambulance w/chevron FOR URBAN SERVICES ONLY', NULL, 1, 0, 1, 0, 30000.00, 15000.00, 0.00),
((select id from fiscal_year where designator = 'FY0708'), 'Ambulance w/chevron FOR RURAL SERVICES ONLY', NULL, 1, 0, 1, 0, 33333.33, 0.00, 20000.00),
((select id from fiscal_year where designator = 'FY0708'), 'Chevron', NULL, 1, 1, 1, 1, 1000.00, 500.00, 600.00),
((select id from fiscal_year where designator = 'FY0708'), 'Squad/response vehicle', NULL, 0, 1, 0, 1, 15000.00, 7500.00, 9000.00),
((select id from fiscal_year where designator = 'FY0708'), 'Data collection software', NULL, 1, 1, 1, 1, 1700.00, 1700.00, 1700.00),
((select id from fiscal_year where designator = 'FY0708'), 'Data collection hardware', 3, 1, 1, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY0708'), 'Radio, mobile (up to 2/vehicle)', 5, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'Radio, portable (1/vehicle)', 5, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'Triage vest set', 5, 1, 1, 1, 1, 150.00, 75.00, 90.00),
((select id from fiscal_year where designator = 'FY0708'), 'Triage system', 5, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY0708'), 'Alerting (up to 5)', 5, 1, 1, 1, 1, 400.00, 200.00, 240.00),
((select id from fiscal_year where designator = 'FY0708'), 'Vehicle safety monitoring system', 5, 1, 1, 1, 1, 3500.00, 1750.00, 2100.00),
((select id from fiscal_year where designator = 'FY0708'), 'PPE/turnout gear', 5, 1, 1, 1, 1, 1200.00, 600.00, 720.00),
((select id from fiscal_year where designator = 'FY0708'), 'Protective ballistic vest (over garment style)', 5, 1, 1, 1, 1, 1000.00, 500.00, 600.00),
((select id from fiscal_year where designator = 'FY0708'), 'Traffic safety', 5, 1, 1, 1, 1, 2500.00, 1250.00, 1500.00),
((select id from fiscal_year where designator = 'FY0708'), 'Large patient moving/carrying device', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'SCBA (up to 2/licensed vehicle)', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0708'), 'EMT-P Written Test', NULL, 1, 1, 0, 0, 300.00, 300.00, 300.00),
((select id from fiscal_year where designator = 'FY0708'), 'Other - with external documentation', NULL, 1, 1, 1, 1, NULL, NULL, NULL);

COMMIT