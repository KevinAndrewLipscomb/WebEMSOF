unit Class_biz_services;

interface

uses
  Class_db_services;

type
  TClass_biz_services = class
  private
    db_services: TClass_db_services;
  public
    constructor Create;
    function AffiliateNumOfId(id: string): string;
    function BeOkToChangeAffiliateNumAndDelete: boolean;
    function Bind
      (
      partial_affiliate_num: string;
      target: system.object
      )
      : boolean;
    procedure BindListControl
      (
      county_user_id: string;
      target: system.object;
      be_unfiltered: boolean = FALSE
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
      out emsof_contact_email_address: string;
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
      emsof_contact_email_address: string;
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
      be_new_affirmation: boolean;
      id: string;
      be_valid_profile: boolean;
      federal_tax_id: string;
      be_qrs_unrecognized: boolean;
      be_rescue_unrecognized: boolean
      );
  end;

implementation

uses
  Class_biz_accounts,
  system.web;

constructor TClass_biz_services.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_services := TClass_db_services.Create;
end;

function TClass_biz_services.AffiliateNumOfId(id: string): string;
begin
  AffiliateNumOfId := db_services.AffiliateNumOfId(id);
end;

function TClass_biz_services.BeOkToChangeAffiliateNumAndDelete: boolean;
begin
  BeOkToChangeAffiliateNumAndDelete := httpcontext.current.user.IsInRole('director')
    or httpcontext.current.user.IsInRole('emsof-coordinator')
    or httpcontext.current.user.IsInRole('emsof-planner');
end;

function TClass_biz_services.Bind
  (
  partial_affiliate_num: string;
  target: system.object
  )
  : boolean;
begin
  Bind := db_services.Bind(partial_affiliate_num,target);
end;

procedure TClass_biz_services.BindListControl
  (
  county_user_id: string;
  target: system.object;
  be_unfiltered: boolean = FALSE
  );
begin
  db_services.BindListControl(county_user_id,target,be_unfiltered);
end;

function TClass_biz_services.Delete(affiliate_num: string): boolean;
begin
  Delete := db_services.Delete(affiliate_num);
end;

function TClass_biz_services.Get
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
  out emsof_contact_email_address: string;
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
begin
  //
  Get := db_services.Get
    (
    affiliate_num,
    name,
    county_code,
    business_phone_num,
    business_fax_num,
    website_address,
    charter_kind,
    corpadmin_contact_name,
    corpadmin_primary_phone_num,
    corpadmin_secondary_phone_num,
    corpadmin_email_address,
    be_emsof_participant,
    emsof_nonparticipation_reason,
    emsof_contact_name,
    emsof_contact_email_address,
    emsof_contact_primary_phone_num,
    emsof_contact_sms_phone_num,
    coo_name,
    coo_work_phone_num,
    coo_home_phone_num,
    coo_email_address,
    coo_mobile_phone_or_pager_num,
    md_name,
    md_office_phone_num,
    md_home_phone_num,
    md_email_address,
    md_mobile_phone_or_pager_num,
    physical_street_address_line_1,
    physical_street_address_line_2,
    physical_city,
    physical_state,
    physical_zip_code,
    mail_address_line_1,
    mail_address_line_2,
    mail_city,
    mail_state,
    mail_zip_code,
    be_qrs,
    be_bls_amb,
    be_als_amb,
    be_als_squad,
    be_air_amb,
    be_rescue,
    be_pa_turnpike_contractor,
    num_doh_licensed_vehicles,
    num_ambulances,
    be_dera,
    charter_other_kind,
    be_valid_profile,
    federal_tax_id,
    be_qrs_unrecognized,
    be_rescue_unrecognized
    );
  //
end;

function TClass_biz_services.NameOf(service_id: string): string;
begin
  NameOf := db_services.NameOf(service_id);
end;

procedure TClass_biz_services.&Set
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
  emsof_contact_email_address: string;
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
  be_new_affirmation: boolean;
  id: string;
  be_valid_profile: boolean;
  federal_tax_id: string;
  be_qrs_unrecognized: boolean;
  be_rescue_unrecognized: boolean
  );
begin
  //
  db_services.&Set
    (
    affiliate_num,
    name,
    county_code,
    business_phone_num,
    business_fax_num,
    website_address,
    charter_kind,
    corpadmin_contact_name,
    corpadmin_primary_phone_num,
    corpadmin_secondary_phone_num,
    corpadmin_email_address,
    be_emsof_participant,
    emsof_nonparticipation_reason,
    emsof_contact_name,
    emsof_contact_email_address,
    emsof_contact_primary_phone_num,
    emsof_contact_sms_phone_num,
    coo_name,
    coo_work_phone_num,
    coo_home_phone_num,
    coo_email_address,
    coo_mobile_phone_or_pager_num,
    md_name,
    md_office_phone_num,
    md_home_phone_num,
    md_email_address,
    md_mobile_phone_or_pager_num,
    physical_street_address_line_1,
    physical_street_address_line_2,
    physical_city,
    physical_state,
    physical_zip_code,
    mail_address_line_1,
    mail_address_line_2,
    mail_city,
    mail_state,
    mail_zip_code,
    be_qrs,
    be_bls_amb,
    be_als_amb,
    be_als_squad,
    be_air_amb,
    be_rescue,
    be_pa_turnpike_contractor,
    num_doh_licensed_vehicles,
    num_ambulances,
    be_dera,
    charter_other_kind,
    be_valid_profile,
    federal_tax_id,
    be_qrs_unrecognized,
    be_rescue_unrecognized
    );
  if be_new_affirmation then begin
    //
    // Notify regional council that contact person has affirmed responsibilities.
    //
    TClass_biz_accounts.Create.NotifyRegionOfServicePocAffirmation(id,name,emsof_contact_name);
    //
  end;
  //
end;

end.
