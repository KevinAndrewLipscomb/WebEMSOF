unit Class_db_services;

interface

uses
  Class_biz_notifications,
  Class_db,
  Class_db_trail;

type
  TClass_db_services = class(TClass_db)
  strict private
    biz_notifications: TClass_biz_notifications;
    db_trail: TClass_db_trail;
  public
    constructor Create;
  published
    function AffiliateNumOfId(id: string): string;
    function BeAdded
      (
      service_name: string;
      affiliate_num: string;
      password_reset_email_address: string;
      county_code: string
      )
      : boolean;
    function BeKnown(affiliate_num: string): boolean;
    function BeValidAndParticipating(id: string): boolean;
    function Bind
      (
      partial_affiliate_num: string;
      target: system.object
      )
      : boolean;
    procedure BindAnnualRespondents
      (
      sort_order: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindListControl
      (
      county_user_id: string;
      target: system.object;
      be_unfiltered: boolean = FALSE;
      be_inclusive_of_invalids_and_nonparticipants: boolean = FALSE
      );
    function Delete(affiliate_num: string): boolean;
    function Get
      (
      affiliate_num: string;
      out name: string;
      out county_code: string;
      out business_phone_num: string;
      out business_fax_num: string;
      out website_address: string;
      out charter_kind: string;
      out corpadmin_contact_name: string;
      out corpadmin_primary_phone_num: string;
      out corpadmin_secondary_phone_num: string;
      out corpadmin_email_address: string;
      out be_emsof_participant: boolean;
      out emsof_nonparticipation_reason: string;
      out emsof_contact_name: string;
      out emsof_contact_primary_phone_num: string;
      out emsof_contact_sms_phone_num: string;
      out coo_name: string;
      out coo_work_phone_num: string;
      out coo_home_phone_num: string;
      out coo_email_address: string;
      out coo_mobile_phone_or_pager_num: string;
      out md_name: string;
      out md_office_phone_num: string;
      out md_home_phone_num: string;
      out md_email_address: string;
      out md_mobile_phone_or_pager_num: string;
      out physical_street_address_line_1: string;
      out physical_street_address_line_2: string;
      out physical_city: string;
      out physical_state: string;
      out physical_zip_code: string;
      out mail_address_line_1: string;
      out mail_address_line_2: string;
      out mail_city: string;
      out mail_state: string;
      out mail_zip_code: string;
      out be_qrs: boolean;
      out be_bls_amb: boolean;
      out be_als_amb: boolean;
      out be_als_squad: boolean;
      out be_air_amb: boolean;
      out be_rescue: boolean;
      out be_pa_turnpike_contractor: boolean;
      out num_doh_licensed_vehicles: string;
      out num_ambulances: string;
      out be_dera: boolean;
      out charter_other_kind: string;
      out be_valid_profile: boolean;
      out federal_tax_id: string;
      out be_qrs_unrecognized: boolean;
      out be_rescue_unrecognized: boolean
      )
      : boolean;
    procedure MarkProfilesStale;
    function NameOf(service_id: string): string;
    procedure &Set
      (
      affiliate_num: string;
      name: string;
      county_code: string;
      business_phone_num: string;
      business_fax_num: string;
      website_address: string;
      charter_kind: string;
      corpadmin_contact_name: string;
      corpadmin_primary_phone_num: string;
      corpadmin_secondary_phone_num: string;
      corpadmin_email_address: string;
      be_emsof_participant: boolean;
      emsof_nonparticipation_reason: string;
      emsof_contact_name: string;
      emsof_contact_primary_phone_num: string;
      emsof_contact_sms_phone_num: string;
      coo_name: string;
      coo_work_phone_num: string;
      coo_home_phone_num: string;
      coo_email_address: string;
      coo_mobile_phone_or_pager_num: string;
      md_name: string;
      md_office_phone_num: string;
      md_home_phone_num: string;
      md_email_address: string;
      md_mobile_phone_or_pager_num: string;
      physical_street_address_line_1: string;
      physical_street_address_line_2: string;
      physical_city: string;
      physical_state: string;
      physical_zip_code: string;
      mail_address_line_1: string;
      mail_address_line_2: string;
      mail_city: string;
      mail_state: string;
      mail_zip_code: string;
      be_qrs: boolean;
      be_bls_amb: boolean;
      be_als_amb: boolean;
      be_als_squad: boolean;
      be_air_amb: boolean;
      be_rescue: boolean;
      be_pa_turnpike_contractor: boolean;
      num_doh_licensed_vehicles: string;
      num_ambulances: string;
      be_dera: boolean;
      charter_other_kind: string;
      be_valid_profile: boolean;
      federal_tax_id: string;
      be_qrs_unrecognized: boolean;
      be_rescue_unrecognized: boolean
      );
  end;

implementation

uses
  kix,
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_services.Create;
begin
  inherited Create;
  biz_notifications := TClass_biz_notifications.Create;
  db_trail := TClass_db_trail.Create;
end;

function TClass_db_services.AffiliateNumOfId(id: string): string;
begin
  self.Open;
  AffiliateNumOfId := mysqlcommand.Create
    (
    'SELECT affiliate_num FROM service WHERE id = ' + id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_services.BeAdded
  (
  service_name: string;
  affiliate_num: string;
  password_reset_email_address: string;
  county_code: string
  )
  : boolean;
begin
  //
  BeAdded := FALSE;
  //
  self.Open;
  if '1' <> mysqlcommand.Create
    ('select max(service_user.id) = max(service.id) from service_user, service',connection).ExecuteScalar.tostring
  then begin
    biz_notifications.IssueCorruptionNotification('SERVICE','BEFORE');
  end else begin
    mysqlcommand.Create
      (
      db_trail.Saved
        (
        'START TRANSACTION'
        + ';'
        + ' insert service'
        + ' set county_code = "' + county_code + '"'
        + ' , affiliate_num = "' + affiliate_num + '"'
        + ' , name = "' + service_name + '"'
        + ' , charter_kind = "9"'
        + ' , corpadmin_contact_name =""'
        + ' , corpadmin_primary_phone_num = ""'
        + ' , be_emsof_participant = FALSE'
        + ' , coo_name = ""'
        + ' , coo_work_phone_num = ""'
        + ' , physical_street_address_line_1 = ""'
        + ' , physical_city = ""'
        + ' , physical_state = ""'
        + ' , physical_zip_code = ""'
        + ' , mail_address_line_1 = ""'
        + ' , mail_city = ""'
        + ' , mail_state = ""'
        + ' , mail_zip_code = ""'
        + ' , num_doh_licensed_vehicles = 0'
        + ' , num_ambulances = 0'
        + ' , be_qrs_unrecognized = FALSE'
        + ' , be_rescue_unrecognized = FALSE'
        + ';'
        + ' insert service_user set password_reset_email_address = "' + password_reset_email_address + '"'
        + ';'
        + ' COMMIT'
        ),
      connection
      )
      .ExecuteNonquery;
    if '1' <> mysqlcommand.Create
      ('select max(service_user.id) = max(service.id) from service_user, service',connection).ExecuteScalar.tostring
    then begin
      biz_notifications.IssueCorruptionNotification('SERVICE','AFTER');
    end else begin
      BeAdded := TRUE;
    end;
  end;
  self.Close;
  //
end;

function TClass_db_services.BeKnown(affiliate_num: string): boolean;
begin
  self.Open;
  BeKnown := nil <>
    mysqlcommand.Create('select 1 from service where affiliate_num = "' + affiliate_num + '"',connection).ExecuteScalar;
  self.Close;
end;

function TClass_db_services.BeValidAndParticipating(id: string): boolean;
begin
  self.Open;
  BeValidAndParticipating := nil <>
    mysqlcommand.Create
      ('select be_valid_profile and be_emsof_participant from service where id = "' + id + '"',connection).ExecuteScalar;
  self.Close;
end;

function TClass_db_services.Bind
  (
  partial_affiliate_num: string;
  target: system.object
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  ListControl(target).items.Clear;
  //
  dr := mysqlcommand.Create
    (
    'SELECT affiliate_num'
    + ' , name'
    + ' , concat(affiliate_num," - ",name) as descriptor'
    + ' FROM service'
    + ' WHERE concat(affiliate_num," - ",name) like "%' + partial_affiliate_num + '%"'
    + ' order by name',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add
      (listitem.Create(dr['descriptor'].tostring,dr['affiliate_num'].tostring));
  end;
  dr.Close;
  self.Close;
  Bind := ListControl(target).items.count > 0;
end;

procedure TClass_db_services.BindAnnualRespondents
  (
  sort_order: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  if be_order_ascending then begin
    sort_order := sort_order.Replace('%',' asc');
  end else begin
    sort_order := sort_order.Replace('%',' desc');
  end;
  self.Open;
  BaseDataList(target).datasource := mysqlcommand.Create
    (
    'select affiliate_num'
    + ' , service.name as service_name'
    + ' , county_code_name_map.name as county_name'
    + ' , IF(be_emsof_participant,"YES","no") as be_emsof_participant'
    + ' from service'
    +   ' join county_code_name_map on (county_code_name_map.code=service.county_code)'
    + ' where be_valid_profile'
    + ' order by ' + sort_order,
    connection
    )
    .ExecuteReader;
  BaseDataList(target).DataBind;
  self.Close;
end;

procedure TClass_db_services.BindListControl
  (
  county_user_id: string;
  target: system.object;
  be_unfiltered: boolean = FALSE;
  be_inclusive_of_invalids_and_nonparticipants: boolean = FALSE
  );
var
  dr: mysqldatareader;
  cmdText: string;
begin
  self.Open;
  ListControl(target).Items.Clear;
  ListControl(target).Items.Add(listitem.Create('-- Select --','0'));
  //
  cmdText := 'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active';
  if not be_unfiltered then begin
    cmdText := cmdText + ' and county_code = "' + county_user_id + '"';
  end;
  if not be_inclusive_of_invalids_and_nonparticipants then begin
    cmdtext := cmdtext + ' and be_valid_profile and be_emsof_participant';
  end;
  cmdText := cmdText + ' ORDER BY name';
  //
  dr := mysqlcommand.Create(cmdText,connection).ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add(listitem.Create(dr['name'].tostring,dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_services.Delete(affiliate_num: string): boolean;
begin
  //
  Delete := TRUE;
  //
  self.Open;
  try
    mysqlcommand.Create(db_trail.Saved('delete from service where affiliate_num = ' + affiliate_num),connection).ExecuteNonquery;
  except on e: exception do
    if e.message.StartsWith('Cannot delete or update a parent row: a foreign key constraint fails',TRUE,nil) then begin
      Delete := FALSE;
    end else begin
      raise e;
    end;
  end;
  self.Close;
end;

function TClass_db_services.Get
  (
  affiliate_num: string;
  out name: string;
  out county_code: string;
  out business_phone_num: string;
  out business_fax_num: string;
  out website_address: string;
  out charter_kind: string;
  out corpadmin_contact_name: string;
  out corpadmin_primary_phone_num: string;
  out corpadmin_secondary_phone_num: string;
  out corpadmin_email_address: string;
  out be_emsof_participant: boolean;
  out emsof_nonparticipation_reason: string;
  out emsof_contact_name: string;
  out emsof_contact_primary_phone_num: string;
  out emsof_contact_sms_phone_num: string;
  out coo_name: string;
  out coo_work_phone_num: string;
  out coo_home_phone_num: string;
  out coo_email_address: string;
  out coo_mobile_phone_or_pager_num: string;
  out md_name: string;
  out md_office_phone_num: string;
  out md_home_phone_num: string;
  out md_email_address: string;
  out md_mobile_phone_or_pager_num: string;
  out physical_street_address_line_1: string;
  out physical_street_address_line_2: string;
  out physical_city: string;
  out physical_state: string;
  out physical_zip_code: string;
  out mail_address_line_1: string;
  out mail_address_line_2: string;
  out mail_city: string;
  out mail_state: string;
  out mail_zip_code: string;
  out be_qrs: boolean;
  out be_bls_amb: boolean;
  out be_als_amb: boolean;
  out be_als_squad: boolean;
  out be_air_amb: boolean;
  out be_rescue: boolean;
  out be_pa_turnpike_contractor: boolean;
  out num_doh_licensed_vehicles: string;
  out num_ambulances: string;
  out be_dera: boolean;
  out charter_other_kind: string;
  out be_valid_profile: boolean;
  out federal_tax_id: string;
  out be_qrs_unrecognized: boolean;
  out be_rescue_unrecognized: boolean
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  Get := FALSE;
  self.Open;
  dr := mysqlcommand.Create('select * from service where CAST(affiliate_num AS CHAR) = "' + affiliate_num + '"',connection).ExecuteReader;
  if dr.Read then begin
    //
    affiliate_num := dr['affiliate_num'].tostring;
    name := dr['name'].tostring;
    county_code := dr['county_code'].tostring;
    business_phone_num := dr['business_phone_num'].tostring;
    business_fax_num := dr['business_fax_num'].tostring;
    website_address := dr['website_address'].tostring;
    charter_kind := dr['charter_kind'].tostring;
    corpadmin_contact_name := dr['corpadmin_contact_name'].tostring;
    corpadmin_primary_phone_num := dr['corpadmin_primary_phone_num'].tostring;
    corpadmin_secondary_phone_num := dr['corpadmin_secondary_phone_num'].tostring;
    corpadmin_email_address := dr['corpadmin_email_address'].tostring;
    be_emsof_participant := (dr['be_emsof_participant'].tostring = '1');
    emsof_nonparticipation_reason := dr['emsof_nonparticipation_reason'].tostring;
    emsof_contact_name := dr['emsof_contact_name'].tostring;
    emsof_contact_primary_phone_num := dr['emsof_contact_primary_phone_num'].tostring;
    emsof_contact_sms_phone_num := dr['emsof_contact_sms_phone_num'].tostring;
    coo_name := dr['coo_name'].tostring;
    coo_work_phone_num := dr['coo_work_phone_num'].tostring;
    coo_home_phone_num := dr['coo_home_phone_num'].tostring;
    coo_email_address := dr['coo_email_address'].tostring;
    coo_mobile_phone_or_pager_num := dr['coo_mobile_phone_or_pager_num'].tostring;
    md_name := dr['md_name'].tostring;
    md_office_phone_num := dr['md_office_phone_num'].tostring;
    md_home_phone_num := dr['md_home_phone_num'].tostring;
    md_email_address := dr['md_email_address'].tostring;
    md_mobile_phone_or_pager_num := dr['md_mobile_phone_or_pager_num'].tostring;
    physical_street_address_line_1 := dr['physical_street_address_line_1'].tostring;
    physical_street_address_line_2 := dr['physical_street_address_line_2'].tostring;
    physical_city := dr['physical_city'].tostring;
    physical_state := dr['physical_state'].tostring;
    physical_zip_code := dr['physical_zip_code'].tostring;
    mail_address_line_1 := dr['mail_address_line_1'].tostring;
    mail_address_line_2 := dr['mail_address_line_2'].tostring;
    mail_city := dr['mail_city'].tostring;
    mail_state := dr['mail_state'].tostring;
    mail_zip_code := dr['mail_zip_code'].tostring;
    be_qrs := (dr['be_qrs'].tostring = '1');
    be_bls_amb := (dr['be_bls_amb'].tostring = '1');
    be_als_amb := (dr['be_als_amb'].tostring = '1');
    be_als_squad := (dr['be_als_squad'].tostring = '1');
    be_air_amb := (dr['be_air_amb'].tostring = '1');
    be_rescue := (dr['be_rescue'].tostring = '1');
    be_pa_turnpike_contractor := (dr['be_pa_turnpike_contractor'].tostring = '1');
    num_doh_licensed_vehicles := dr['num_doh_licensed_vehicles'].tostring;
    num_ambulances := dr['num_ambulances'].tostring;
    be_dera := (dr['be_dera'].tostring = '1');
    charter_other_kind := dr['charter_other_kind'].tostring;
    be_valid_profile := (dr['be_valid_profile'].tostring = '1');
    federal_tax_id := dr['federal_tax_id_num'].tostring;
    be_qrs_unrecognized := (dr['be_qrs_unrecognized'].tostring = '1');
    be_rescue_unrecognized := (dr['be_rescue_unrecognized'].tostring = '1');
    //
    Get := TRUE;
    //
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_services.MarkProfilesStale;
begin
  self.Open;
  mysqlcommand.Create(db_trail.Saved('update service set be_valid_profile = FALSE'),connection).ExecuteNonquery;
  self.Close;
end;

function TClass_db_services.NameOf(service_id: string): string;
begin
  self.Open;
  NameOf := mysqlcommand.Create('select name from service where id = ' + service_id,connection).ExecuteScalar.tostring;
  self.Close;
end;

procedure TClass_db_services.&Set
  (
  affiliate_num: string;
  name: string;
  county_code: string;
  business_phone_num: string;
  business_fax_num: string;
  website_address: string;
  charter_kind: string;
  corpadmin_contact_name: string;
  corpadmin_primary_phone_num: string;
  corpadmin_secondary_phone_num: string;
  corpadmin_email_address: string;
  be_emsof_participant: boolean;
  emsof_nonparticipation_reason: string;
  emsof_contact_name: string;
  emsof_contact_primary_phone_num: string;
  emsof_contact_sms_phone_num: string;
  coo_name: string;
  coo_work_phone_num: string;
  coo_home_phone_num: string;
  coo_email_address: string;
  coo_mobile_phone_or_pager_num: string;
  md_name: string;
  md_office_phone_num: string;
  md_home_phone_num: string;
  md_email_address: string;
  md_mobile_phone_or_pager_num: string;
  physical_street_address_line_1: string;
  physical_street_address_line_2: string;
  physical_city: string;
  physical_state: string;
  physical_zip_code: string;
  mail_address_line_1: string;
  mail_address_line_2: string;
  mail_city: string;
  mail_state: string;
  mail_zip_code: string;
  be_qrs: boolean;
  be_bls_amb: boolean;
  be_als_amb: boolean;
  be_als_squad: boolean;
  be_air_amb: boolean;
  be_rescue: boolean;
  be_pa_turnpike_contractor: boolean;
  num_doh_licensed_vehicles: string;
  num_ambulances: string;
  be_dera: boolean;
  charter_other_kind: string;
  be_valid_profile: boolean;
  federal_tax_id: string;
  be_qrs_unrecognized: boolean;
  be_rescue_unrecognized: boolean
  );
var
  childless_field_assignments_clause: string;
begin
  //
  childless_field_assignments_clause := ' name = NULLIF("' + name + '","")'
  + ' , county_code = NULLIF("' + county_code + '","")'
  + ' , business_phone_num = NULLIF("' + business_phone_num + '","")'
  + ' , business_fax_num = NULLIF("' + business_fax_num + '","")'
  + ' , website_address = NULLIF("' + website_address + '","")'
  + ' , charter_kind = NULLIF("' + charter_kind + '","")'
  + ' , corpadmin_contact_name = NULLIF("' + corpadmin_contact_name + '","")'
  + ' , corpadmin_primary_phone_num = NULLIF("' + corpadmin_primary_phone_num + '","")'
  + ' , corpadmin_secondary_phone_num = NULLIF("' + corpadmin_secondary_phone_num + '","")'
  + ' , corpadmin_email_address = NULLIF("' + corpadmin_email_address + '","")'
  + ' , be_emsof_participant = ' + be_emsof_participant.tostring
  + ' , emsof_nonparticipation_reason = NULLIF("' + emsof_nonparticipation_reason + '","")'
  + ' , emsof_contact_name = NULLIF("' + emsof_contact_name + '","")'
  + ' , emsof_contact_primary_phone_num = NULLIF("' + emsof_contact_primary_phone_num + '","")'
  + ' , emsof_contact_sms_phone_num = NULLIF("' + emsof_contact_sms_phone_num + '","")'
  + ' , coo_name = NULLIF("' + coo_name + '","")'
  + ' , coo_work_phone_num = NULLIF("' + coo_work_phone_num + '","")'
  + ' , coo_home_phone_num = NULLIF("' + coo_home_phone_num + '","")'
  + ' , coo_email_address = NULLIF("' + coo_email_address + '","")'
  + ' , coo_mobile_phone_or_pager_num = NULLIF("' + coo_mobile_phone_or_pager_num + '","")'
  + ' , md_name = NULLIF("' + md_name + '","")'
  + ' , md_office_phone_num = NULLIF("' + md_office_phone_num + '","")'
  + ' , md_home_phone_num = NULLIF("' + md_home_phone_num + '","")'
  + ' , md_email_address = NULLIF("' + md_email_address + '","")'
  + ' , md_mobile_phone_or_pager_num = NULLIF("' + md_mobile_phone_or_pager_num + '","")'
  + ' , physical_street_address_line_1 = NULLIF("' + physical_street_address_line_1 + '","")'
  + ' , physical_street_address_line_2 = NULLIF("' + physical_street_address_line_2 + '","")'
  + ' , physical_city = NULLIF("' + physical_city + '","")'
  + ' , physical_state = NULLIF("' + physical_state + '","")'
  + ' , physical_zip_code = NULLIF("' + physical_zip_code + '","")'
  + ' , mail_address_line_1 = NULLIF("' + mail_address_line_1 + '","")'
  + ' , mail_address_line_2 = NULLIF("' + mail_address_line_2 + '","")'
  + ' , mail_city = NULLIF("' + mail_city + '","")'
  + ' , mail_state = NULLIF("' + mail_state + '","")'
  + ' , mail_zip_code = NULLIF("' + mail_zip_code + '","")'
  + ' , be_qrs = ' + be_qrs.tostring
  + ' , be_bls_amb = ' + be_bls_amb.tostring
  + ' , be_als_amb = ' + be_als_amb.tostring
  + ' , be_als_squad = ' + be_als_squad.tostring
  + ' , be_air_amb = ' + be_air_amb.tostring
  + ' , be_rescue = ' + be_rescue.tostring
  + ' , be_pa_turnpike_contractor = ' + be_pa_turnpike_contractor.tostring
  + ' , num_doh_licensed_vehicles = NULLIF("' + num_doh_licensed_vehicles + '","")'
  + ' , num_ambulances = NULLIF("' + num_ambulances + '","")'
  + ' , be_dera = ' + be_dera.tostring
  + ' , charter_other_kind = NULLIF("' + charter_other_kind + '","")'
  + ' , be_valid_profile = ' + be_valid_profile.tostring
  + ' , federal_tax_id_num = NULLIF("' + federal_tax_id + '","")'
  + ' , be_qrs_unrecognized = ' + be_qrs_unrecognized.tostring
  + ' , be_rescue_unrecognized = ' + be_rescue_unrecognized.tostring;
  //
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'insert service'
      + ' set affiliate_num = NULLIF("' + affiliate_num + '","")'
      + ' , ' + childless_field_assignments_clause
      + ' on duplicate key update '
      + childless_field_assignments_clause
      ),
    connection
    )
    .ExecuteNonquery;
  self.Close;
  //
end;

end.
