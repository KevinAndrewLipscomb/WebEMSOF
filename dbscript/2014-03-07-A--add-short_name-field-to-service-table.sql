START TRANSACTION
;
ALTER TABLE `service`
  ADD COLUMN `short_name` VARCHAR(31) AFTER `name`
;
update ignore service set short_name = SUBSTRING_INDEX(name,' ',1)
;
update ignore service set short_name = 'ACES OST' where name = 'Allegheny County EMS Council Operations Support Team'
;
update ignore service set short_name = 'Ambulance & Chair' where name = 'Ambulance & Chair Service'
;
update ignore service set short_name = 'Big Knob' where name = 'Big Knob Volunteer fire dept'
;
update ignore service set short_name = 'Butler Ambulance' where name = 'Butler Ambulance Service'
;
update ignore service set short_name = 'Butler Fire' where name = 'Butler Bureau of Fire'
;
update ignore service set short_name = 'Cecil/Muse' where name = 'Cecil Township #2 V.F.D.  Muse Q.R.S.'
;
update ignore service set short_name = 'Citizens Ambulance' where name = 'Citizens Ambulance Service'
;
update ignore service set short_name = 'Citizens Hose' where name = 'Citizens Vol. Hose Company'
;
update ignore service set short_name = 'Pittsburgh' where name = 'City of Pittsburgh Emergency Medical Services'
;
update ignore service set short_name = 'Washington Fire' where name = 'City of Washington Fire Department'
;
update ignore service set short_name = 'Distant Area' where name = 'Distant Area Volunteer Fire Department'
;
update ignore service set short_name = 'East Butler' where name = 'East Butler Ambulance'
;
update ignore service set short_name = 'East Deer' where name = 'East Deer VHC'
;
update ignore service set short_name = 'EAPS' where name = 'Eastern Area Prehospital Service'
;
update ignore service set short_name = 'Elizabeth Fire' where name = 'Elizabeth Fire Department QRS'
;
update ignore service set short_name = 'Elizabeth Twp' where name = 'Elizabeth Twp Area EMS'
;
update ignore service set short_name = 'EMSI' where name = 'Emergency Medical Services Institute'
;
update ignore service set short_name = 'EMS Southwest' where name = 'EMS Southwest Inc.'
;
update ignore service set short_name = 'Enon Valley' where name = 'ENON VALLEY AMBULANCE'
;
update ignore service set short_name = 'Evans City' where name = 'Evans City VFD'
;
update ignore service set short_name = 'Fayette' where name = 'fayette emergency medical service'
;
update ignore service set short_name = 'FDNV' where name = 'Fire Department of North Versailles'
;
update ignore service set short_name = 'Forbes Road' where name = 'Forbes Road Volunteer Fire Department'
;
update ignore service set short_name = 'Ford City' where name = 'Ford City Hose Co. #1 Ambulance Service'
;
update ignore service set short_name = 'Fort Cherry' where name = 'Fort Cherry Ambulance'
;
update ignore service set short_name = 'Greensboro Mon Twp' where name = 'Greensboro & Mon. Twp. VFD'
;
update ignore service set short_name = 'Greenwood Village' where name = 'Greenwood Village VFD'
;
update ignore service set short_name = 'Guardian Angel' where name = 'Guardian Angel Ambulance Services Inc.'
;
update ignore service set short_name = 'Hanover Ambulance' where name = 'Hanover VFD Ambulance'
;
update ignore service set short_name = 'Hanover QRS' where name = 'Hanover VFD QRS 45'
;
update ignore service set short_name = 'Hickory [110]' where affiliate_num = '37907'
;
update ignore service set short_name = 'Hickory [109]' where affiliate_num = '37308'
;
update ignore service set short_name = 'Holiday Park' where name = 'Holiday Park VFD'
;
update ignore service set short_name = 'Kittanning' where name = 'Hose Company #6 Kittanning'
;
update ignore service set short_name = 'Jefferson Hills' where name = 'Jefferson Hills Area Ambulance Association'
;
update ignore service set short_name = 'Jefferson Twp' where name = 'Jefferson Township VFD QRS 49'
;
update ignore service set short_name = 'Jefferson Ambulance' where name = 'Jefferson Vol. Fire Co. Ambulance Service'
;
update ignore service set short_name = 'Jefferson QRS' where name = 'Jefferson Volunteer Fire Company QRS'
;
update ignore service set short_name = 'Kirwan Heights' where name = 'Kirwan Heights EMS'
;
update ignore service set short_name = 'Laurel Valley' where name = 'Laurel Valley Ambulance Service'
;
update ignore service set short_name = 'Ligonier Valley' where name = 'Ligonier Valley Ambulance Service'
;
update ignore service set short_name = 'Lincoln Borough' where name = 'Lincoln Borough VFRC'
;
update ignore service set short_name = 'Lower Burrell' where name = 'Lower Burrell VFC#3'
;
update ignore service set short_name = 'Lower Kiski' where name = 'Lower kiski Ambulance'
;
update ignore service set short_name = 'Lower Valley' where name = 'Lower Valley Ambulance Service'
;
update ignore service set short_name = 'Mars EMS' where name = 'Mars Emergency Medical Service, Inc.'
;
update ignore service set short_name = 'Mars Fire' where name = 'Mars Volunteer FIre Company- QRS'
;
update ignore service set short_name = 'McCandless' where name = 'McCandless-Franklin Park Ambulance Authority'
;
update ignore service set short_name = 'Medic Rescue' where name = 'Medic Rescue'
;
update ignore service set short_name = 'MRTSA' where name = 'Medical Rescue Team South'
;
update ignore service set short_name = 'Mobile Nurse Network' where name = 'Mobile Nurse Network LLC'
;
update ignore service set short_name = 'Mon Valley' where name = 'Monessen Ambulance Service dba Mon Valley Emergency Medical Services'
;
update ignore service set short_name = 'Mount Pleasant EMS' where name = 'Mount Pleasant EMS Medic 10'
;
update ignore service set short_name = 'Mount Pleasant Fire' where name = 'Mount Pleasant Twp. Vol. Fire Dept.'
;
update ignore service set short_name = 'Mt. Morris' where name = 'Mt. Morris Emergency Medical Squad'
;
update ignore service set short_name = 'MAPS' where name = 'Munhall Area Prehospital Services'
;
update ignore service set short_name = 'Mutual Aid' where name = 'Mutual Aid Ambulance Service Inc.'
;
update ignore service set short_name = 'New Castle' where name = 'New Castle Fire Department'
;
update ignore service set short_name = 'New Kensington' where name = 'New Kensington Ambulance'
;
update ignore service set short_name = 'New Wilmington' where name = 'New Wilmington Volunteer Ambulance'
;
update ignore service set short_name = 'North Beaver' where name = 'North Beaver Twp VFD QRS'
;
update ignore service set short_name = 'North Huntingdon' where name = 'North Huntingdon Township Rescue 8 Squad'
;
update ignore service set short_name = 'North Washington' where name = 'North Washington VFC'
;
update ignore service set short_name = 'PA Med Transport' where name = 'Pa. Medical TransportMedevac'
;
update ignore service set short_name = 'Penn Hills' where name = 'Penn Hills Emergency Medical Service'
;
update ignore service set short_name = 'Penn Twp' where name = 'Penn Township Ambulance Assoc.'
;
update ignore service set short_name = 'Peters Twp Fire' where name = 'Peters Township Fire Department'
;
update ignore service set short_name = 'Peters Twp VFW' where name = 'Peters Township VFW Post 764 Ambulance Service'
;
update ignore service set short_name = 'Point Marion' where name = 'Point Marion VFD Ambulance Service'
;
update ignore service set short_name = 'Priority One' where name = 'Priority One EMS'
;
update ignore service set short_name = 'Quaker Valley' where name = 'Quaker Valley Ambulance Authority'
;
update ignore service set short_name = 'Rescue 14 EMS' where name = 'Rescue 14 EMS Inc.'
;
update ignore service set short_name = 'Rices Landing' where name = 'RICES LANDING VOL FIRE DEPARTMENT'
;
update ignore service set short_name = 'Richhill Twp' where name = 'Richhill Twp Vol Fire Co'
;
update ignore service set short_name = 'Ross/West View' where name = 'RossWest View'
;
update ignore service set short_name = 'Rostraver/West Newton' where name = 'Rostraver  West Newton Emergency Services'
;
update ignore service set short_name = 'Scott Twp EMS' where name = 'SCOTT TWP. EMS'
;
update ignore service set short_name = 'Scott Twp Fire' where name = 'Scott Twp. VFD QRS'
;
update ignore service set short_name = 'Slippery Rock' where name = 'Slippery Rock VFC & Rescue Team'
;
update ignore service set short_name = 'South Butler' where name = 'South Butler VFD'
;
update ignore service set short_name = 'SMRT' where name = 'Special Medical Response Team'
;
update ignore service set short_name = 'Tri-Community' where name = 'Tri-Community Ambulance'
;
update ignore service set short_name = 'Tri-Community South' where name = 'Tri-Community South EMS'
;
update ignore service set short_name = 'Union Ambulance' where name = 'UNION AMBULANCE'
;
update ignore service set short_name = 'Union Twp Fire' where name = 'UNION TWP FIRE  QRS'
;
update ignore service set short_name = 'St Margaret' where name = 'UPMC St. Margaret Paramedic Response Team'
;
update ignore service set short_name = 'Washington DPS' where name = 'Washington Dept. of Public Safety'
;
update ignore service set short_name = 'West Alexander' where name = 'west alexander v.f.c'
;
update ignore service set short_name = 'West Deer EMS' where name = 'West Deer EMS, Inc.'
;
update ignore service set short_name = 'West Deer Fire' where name = 'West Deer VFC # 3'
;
update ignore service set short_name = 'West Finley' where name = 'westfinleyvfcsquad53'
;
update ignore service set short_name = 'White Oak' where name = 'White Oak EMS'
;
update ignore service set short_name = 'Woodland Hills' where name = 'Woodland Hills EMS'
;
COMMIT