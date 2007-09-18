SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT=0;
START TRANSACTION;

insert service (county_code,affiliate_num,name,be_qrs,be_bls_amb,be_als_amb,be_als_squad,be_air_amb,be_rescue,address_line_1,address_line_2,city,zip_code,federal_tax_id_num,contact_person_name,contact_person_phone_num,be_valid_profile) values
(1,"02085","Pitcairn Ambulance Association",FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,"582 Sixth Street Rear","","Pitcairn","15140","","George Mashione","4128566432",FALSE),
(1,"02137","West Deer EMS, Inc.",FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,"101 East Union Road","","Cheswick","15024","","Charles H. Fleischer","7242654750",FALSE),
(1,"02347","Crafton Volunteer Fire Department",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"8 Stotz Avenue","","Pittsburgh","15205","","Michael Crown","4124750166",FALSE),
(2,"03007","Lower kiski Ambulance",FALSE,TRUE,TRUE,TRUE,FALSE,FALSE,"PO Box 397","","Leechburg","15656","","Adolph Poli","7248458504",FALSE),
(3,"04301","Chippewa Township Fire Dept",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"2568 Darlington Road","","Beaver Falls","15010","","Jaye Graham","7248468055",FALSE),
(3,"04305","Brighton Township Volunteer Fire Department",TRUE,FALSE,FALSE,FALSE,FALSE,TRUE,"P.O. Box 498","","Beaver","15009","","Robert Williams I","7244953803",FALSE),
(3,"04306","Big Knob Volunteer fire dept",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"1229 RT 989","","Rochester","15074","","Lonnie Vodenichar","7243218177",FALSE),
(4,"10033","Mars Emergency Medical Service, Inc.",FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,"PO box 911","","Mars","16046","","Carin Fullum-Cogley","7246251777",FALSE),
(6,"30002","Bobtown Dunkard Twp Vol Fire Dept Ambulance",FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,"PO Box 386","","Bobtown","15315","","Yvonne Pritchard","7249986032",FALSE),
(8,"37303","UNION TWP FIRE / QRS",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"304 SOUTH SCOTLAND LANE","UNION TWP","NEW CASTLE","16101","","PATRICK M. ANGIOLELLI","7246547115",FALSE),
(8,"37308","Hickory Volunteer Fire Company",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"109 Eastbrook Neshannock Falls RD","","New Castle","16105","","Michael Hall","7247301776",FALSE),
(9,"63031","Bentworth Ambulance Service Inc.",FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,"P.O. Box 152","","Bentleyville","15314","","Paul J. Vahaly","7242395512",FALSE),
(9,"63035","Morris Township Fire Department",FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,"PO Box 21","","Prosperity","15329","","Hugh White","7243504604",FALSE),
(9,"63309","Avella Volunteer Fire Dept QRS",TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,"PO Box G","","Avella","15312","","Edward F Powers Jr","7245870214",FALSE);

insert service_user (password_reset_email_address) values
("pitcairnems@yahoo.com"),
("cfleischer@westdeerems.com"),
("mjcrown@comcast.net"),
("apoli@lowerkiskiems.org"),
("jayeandkathy@comcast.net"),
("mstout63@hotmail.com"),
("bmazzetti26@hotmail.com"),
("cfullum_mems@yahoo.com"),
("bobtownvfd@alltel.net"),
("raconti@state.pa.us"),
("hickoryfire@verizon.net"),
("pjv@bentcom.net"),
("whitehug@co.washington.pa.us"),
("e.powersjr@att.net");

SET FOREIGN_KEY_CHECKS=1;
COMMIT