unit UserControl_service_profile;

interface

uses
  Class_biz_appropriations,
  Class_biz_charter_kinds,
  Class_biz_counties,
  Class_biz_services,
  Class_biz_user,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_service_profile = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_service_profile_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure Button_lookup_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_reset_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_delete_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_affiliate_num_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_charter_kind_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure CustomValidator_corpadmin_email_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure CustomValidator_website_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure CustomValidator_coo_email_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure CustomValidator_be_als_medical_director_name_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure CustomValidator_md_email_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure CustomValidator_emsof_contact_email_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure RadioButtonList_be_emsof_participant_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure CustomValidator_num_ambulances_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        affiliate_num: string;
        be_authorized_to_change_affiliate_num_and_delete_service: boolean;
        be_loaded: boolean;
        be_ok_to_config_service_profiles: boolean;
        be_profile_initially_valid: boolean;
        be_service_user: boolean;
        biz_appropriations: TClass_biz_appropriations;
        biz_charter_kinds: TClass_biz_charter_kinds;
        biz_counties: TClass_biz_counties;
        biz_services: TClass_biz_services;
        biz_user: TClass_biz_user;
        END;
  strict private
    p: p_type;
    procedure Clear;
    procedure InjectPersistentClientSideScript;
    procedure ManageCharterControlEnablements;
    procedure ManageEmsofControlEnablements;
    procedure ManageDependentFieldEnablements;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    function PresentRecord(affiliate_num: string): boolean;
    procedure SetLookupMode;
  strict protected
    TextBox_affiliate_num: System.Web.UI.WebControls.TextBox;
    DropDownList_affiliate_num: System.Web.UI.WebControls.DropDownList;
    TextBox_name: System.Web.UI.WebControls.TextBox;
    TextBox_business_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_business_fax_num: System.Web.UI.WebControls.TextBox;
    TextBox_website_address: System.Web.UI.WebControls.TextBox;
    TextBox_corpadmin_contact_name: System.Web.UI.WebControls.TextBox;
    TextBox_corpadmin_primary_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_corpadmin_secondary_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_corpadmin_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_emsof_nonparticipation_reason: System.Web.UI.WebControls.TextBox;
    TextBox_emsof_contact_name: System.Web.UI.WebControls.TextBox;
    TextBox_emsof_contact_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_emsof_contact_primary_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_emsof_contact_sms_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_coo_name: System.Web.UI.WebControls.TextBox;
    TextBox_coo_work_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_coo_home_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_coo_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_coo_mobile_phone_or_pager_num: System.Web.UI.WebControls.TextBox;
    TextBox_md_name: System.Web.UI.WebControls.TextBox;
    TextBox_md_office_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_md_home_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_md_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_md_mobile_phone_or_pager_num: System.Web.UI.WebControls.TextBox;
    TextBox_physical_street_address_line_1: System.Web.UI.WebControls.TextBox;
    TextBox_physical_street_address_line_2: System.Web.UI.WebControls.TextBox;
    TextBox_physical_city: System.Web.UI.WebControls.TextBox;
    TextBox_physical_zip_code: System.Web.UI.WebControls.TextBox;
    TextBox_mail_address_line_1: System.Web.UI.WebControls.TextBox;
    TextBox_mail_address_line_2: System.Web.UI.WebControls.TextBox;
    TextBox_mail_city: System.Web.UI.WebControls.TextBox;
    TextBox_mail_zip_code: System.Web.UI.WebControls.TextBox;
    CheckBox_be_qrs_unrecognized: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_qrs: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_bls_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_als_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_als_squad: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_air_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_rescue_unrecognized: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_rescue: System.Web.UI.WebControls.CheckBox;
    CheckBox_be_pa_turnpike_contractor: System.Web.UI.WebControls.CheckBox;
    TextBox_num_doh_licensed_vehicles: System.Web.UI.WebControls.TextBox;
    TextBox_num_ambulances: System.Web.UI.WebControls.TextBox;
    TextBox_charter_other_kind: System.Web.UI.WebControls.TextBox;
    Button_submit: System.Web.UI.WebControls.Button;
    Button_delete: System.Web.UI.WebControls.Button;
    Button_lookup: System.Web.UI.WebControls.Button;
    Label_lookup_arrow: &label;
    Label_lookup_hint: &label;
    LinkButton_reset: System.Web.UI.WebControls.LinkButton;
    RequiredFieldValidator_affiliate_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_county_code: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_charter_kind: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_corpadmin_contact_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_corpadmin_primary_phone_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_coo_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_coo_work_phone_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_physical_street_address_line_1: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_physical_city: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_physical_zip_code: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_mail_address_line_1: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_mail_city: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_mail_zip_code: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_num_doh_licensed_vehicles: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_num_doh_licensed_vehicles: System.Web.UI.WebControls.RegularExpressionValidator;
    RequiredFieldValidator_num_ambulances: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_num_ambulances: System.Web.UI.WebControls.RegularExpressionValidator;
    DropDownList_county: System.Web.UI.WebControls.DropDownList;
    DropDownList_charter_kind: System.Web.UI.WebControls.DropDownList;
    RadioButtonList_be_emsof_participant: System.Web.UI.WebControls.RadioButtonList;
    RadioButtonList_be_dera: System.Web.UI.WebControls.RadioButtonList;
    RegularExpressionValidator_business_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_business_fax_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_website_address: System.Web.UI.WebControls.RegularExpressionValidator;
    UpdatePanel_charter_kind: System.Web.UI.UpdatePanel;
    RegularExpressionValidator_corpadmin_primary_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_corpadmin_secondary_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_corpadmin_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_corpadmin_email_address: System.Web.UI.WebControls.CustomValidator;
    CustomValidator_website_address: System.Web.UI.WebControls.CustomValidator;
    RequiredFieldValidator_be_emsof_participant: System.Web.UI.WebControls.RequiredFieldValidator;
    UpdatePanel_be_emsof_particpant: System.Web.UI.UpdatePanel;
    RegularExpressionValidator_emsof_contact_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_emsof_contact_email_address: System.Web.UI.WebControls.CustomValidator;
    RegularExpressionValidator_emsof_contact_primary_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RequiredFieldValidator_emsof_contact_primary_phone_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_emsof_contact_sms_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_coo_work_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_coo_home_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_coo_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_coo_email_address: System.Web.UI.WebControls.CustomValidator;
    RegularExpressionValidator_coo_mobile_phone_or_pager_num: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_be_als_medical_director_name: System.Web.UI.WebControls.CustomValidator;
    RegularExpressionValidator_md_office_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_md_home_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_md_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_md_email_address: System.Web.UI.WebControls.CustomValidator;
    RegularExpressionValidator_md_mobile_phone_or_pager_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_physical_zip_code: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_mail_zip_code: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_num_ambulances: System.Web.UI.WebControls.CustomValidator;
    RequiredFieldValidator_be_dera: System.Web.UI.WebControls.RequiredFieldValidator;
    CustomValidator_emsof_contact_name: System.Web.UI.WebControls.CustomValidator;
    TableRow_emsof_contact_name: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_emsof_contact_email_address: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_emsof_contact_primary_phone_num: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_emsof_contact_sms_phone_num: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_emsof_nonparticipation_reason: System.Web.UI.WebControls.Label;
    Label_charter_other_kind: System.Web.UI.WebControls.Label;
    RequiredFieldValidator_emsof_contact_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_emsof_contact_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_charter_other_kind: System.Web.UI.WebControls.RequiredFieldValidator;
    RadioButtonList_be_valid_profile: System.Web.UI.WebControls.RadioButtonList;
    TextBox_federal_tax_id: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_federal_tax_id: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_federal_tax_id: System.Web.UI.WebControls.RegularExpressionValidator;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_service_profile;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_service_profile.Clear;
begin
  //
  TextBox_affiliate_num.text := EMPTY;
  DropDownList_affiliate_num.visible := FALSE;
  TextBox_name.text := EMPTY;
  DropDownList_county.ClearSelection;
  TextBox_business_phone_num.text := EMPTY;
  TextBox_business_fax_num.text := EMPTY;
  TextBox_website_address.text := EMPTY;
  DropDownList_charter_kind.ClearSelection;
  TextBox_corpadmin_contact_name.text := EMPTY;
  TextBox_corpadmin_primary_phone_num.text := EMPTY;
  TextBox_corpadmin_secondary_phone_num.text := EMPTY;
  TextBox_corpadmin_email_address.text := EMPTY;
  RadioButtonList_be_emsof_participant.ClearSelection;
  TextBox_emsof_nonparticipation_reason.text := EMPTY;
  TextBox_emsof_contact_name.text := EMPTY;
  TextBox_emsof_contact_email_address.text := EMPTY;
  TextBox_emsof_contact_primary_phone_num.text := EMPTY;
  TextBox_emsof_contact_sms_phone_num.text := EMPTY;
  TextBox_coo_name.text := EMPTY;
  TextBox_coo_work_phone_num.text := EMPTY;
  TextBox_coo_home_phone_num.text := EMPTY;
  TextBox_coo_email_address.text := EMPTY;
  TextBox_coo_mobile_phone_or_pager_num.text := EMPTY;
  TextBox_md_name.text := EMPTY;
  TextBox_md_office_phone_num.text := EMPTY;
  TextBox_md_home_phone_num.text := EMPTY;
  TextBox_md_email_address.text := EMPTY;
  TextBox_md_mobile_phone_or_pager_num.text := EMPTY;
  TextBox_physical_street_address_line_1.text := EMPTY;
  TextBox_physical_street_address_line_2.text := EMPTY;
  TextBox_physical_city.text := EMPTY;
  TextBox_physical_zip_code.text := EMPTY;
  TextBox_mail_address_line_1.text := EMPTY;
  TextBox_mail_address_line_2.text := EMPTY;
  TextBox_mail_city.text := EMPTY;
  TextBox_mail_zip_code.text := EMPTY;
  CheckBox_be_qrs_unrecognized.checked := FALSE;
  CheckBox_be_qrs.checked := FALSE;
  CheckBox_be_bls_amb.checked := FALSE;
  CheckBox_be_als_amb.checked := FALSE;
  CheckBox_be_als_squad.checked := FALSE;
  CheckBox_be_air_amb.checked := FALSE;
  CheckBox_be_rescue_unrecognized.checked := FALSE;
  CheckBox_be_rescue.checked := FALSE;
  CheckBox_be_pa_turnpike_contractor.checked := FALSE;
  TextBox_num_doh_licensed_vehicles.text := EMPTY;
  TextBox_num_ambulances.text := EMPTY;
  RadioButtonList_be_dera.ClearSelection;
  TextBox_charter_other_kind.text := EMPTY;
  RadioButtonList_be_valid_profile.ClearSelection;
  //
  ManageCharterControlEnablements;
  ManageEmsofControlEnablements;
  //
  // Disable dependent fields.
  //
  TextBox_name.enabled := FALSE;
  DropDownList_county.enabled := FALSE;
  TextBox_business_phone_num.enabled := FALSE;
  TextBox_business_fax_num.enabled := FALSE;
  TextBox_website_address.enabled := FALSE;
  DropDownList_charter_kind.enabled := FALSE;
  TextBox_corpadmin_contact_name.enabled := FALSE;
  TextBox_corpadmin_primary_phone_num.enabled := FALSE;
  TextBox_corpadmin_secondary_phone_num.enabled := FALSE;
  TextBox_corpadmin_email_address.enabled := FALSE;
  RadioButtonList_be_emsof_participant.enabled := FALSE;
  TextBox_emsof_nonparticipation_reason.enabled := FALSE;
  TextBox_emsof_contact_name.enabled := FALSE;
  TextBox_emsof_contact_email_address.enabled := FALSE;
  TextBox_emsof_contact_primary_phone_num.enabled := FALSE;
  TextBox_emsof_contact_sms_phone_num.enabled := FALSE;
  TextBox_coo_name.enabled := FALSE;
  TextBox_coo_work_phone_num.enabled := FALSE;
  TextBox_coo_home_phone_num.enabled := FALSE;
  TextBox_coo_email_address.enabled := FALSE;
  TextBox_coo_mobile_phone_or_pager_num.enabled := FALSE;
  TextBox_md_name.enabled := FALSE;
  TextBox_md_office_phone_num.enabled := FALSE;
  TextBox_md_home_phone_num.enabled := FALSE;
  TextBox_md_email_address.enabled := FALSE;
  TextBox_md_mobile_phone_or_pager_num.enabled := FALSE;
  TextBox_physical_street_address_line_1.enabled := FALSE;
  TextBox_physical_street_address_line_2.enabled := FALSE;
  TextBox_physical_city.enabled := FALSE;
  TextBox_physical_zip_code.enabled := FALSE;
  TextBox_mail_address_line_1.enabled := FALSE;
  TextBox_mail_address_line_2.enabled := FALSE;
  TextBox_mail_city.enabled := FALSE;
  TextBox_mail_zip_code.enabled := FALSE;
  CheckBox_be_qrs_unrecognized.enabled := FALSE;
  CheckBox_be_qrs.enabled := FALSE;
  CheckBox_be_bls_amb.enabled := FALSE;
  CheckBox_be_als_amb.enabled := FALSE;
  CheckBox_be_als_squad.enabled := FALSE;
  CheckBox_be_air_amb.enabled := FALSE;
  CheckBox_be_rescue_unrecognized.enabled := FALSE;
  CheckBox_be_rescue.enabled := FALSE;
  CheckBox_be_pa_turnpike_contractor.enabled := FALSE;
  TextBox_num_doh_licensed_vehicles.enabled := FALSE;
  TextBox_num_ambulances.enabled := FALSE;
  RadioButtonList_be_dera.enabled := FALSE;
  TextBox_charter_other_kind.enabled := FALSE;
  RadioButtonList_be_valid_profile.enabled := FALSE;
  TextBox_federal_tax_id.enabled := FALSE;
  //
  Button_submit.enabled := FALSE;
  Button_delete.enabled := FALSE;
  //
end;

procedure TWebUserControl_service_profile.InjectPersistentClientSideScript;
begin
{$REGION 'Persistent client-side script'}
//  EstablishClientSideFunction(EL);
//  EstablishClientSideFunction(KGS_TO_LBS);
//  EstablishClientSideFunction(LBS_TO_KGS);
//  EstablishClientSideFunction
//    (
//    'RecalculateDependentValues()',
//    EMPTY
//    + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
//    +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
//    + NEW_LINE
//    + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
//    );
//  //
//  TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
//  TextBox_gross_landed_weight_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_gross_landed_weight_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
{$ENDREGION}
end;

procedure TWebUserControl_service_profile.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    if p.be_service_user then begin
      Button_lookup.visible := FALSE;
      Label_lookup_arrow.visible := FALSE;
      Label_lookup_hint.visible := FALSE;
      LinkButton_reset.visible := FALSE;
      Button_delete.visible := FALSE;
    end;
    //
    p.biz_counties.BindDirectToListControl(DropDownList_county,'-- County --');
    p.biz_charter_kinds.BindDirectToListControl(DropDownList_charter_kind,'-- Charter kind --');
    //
    RequireConfirmation(Button_delete,'Are you sure you want to delete this record?');
    //
    if p.be_authorized_to_change_affiliate_num_and_delete_service then begin
      Focus(TextBox_affiliate_num,TRUE);
    end else begin
      PresentRecord(p.affiliate_num);
      Focus(TextBox_name,TRUE);
    end;
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

function TWebUserControl_service_profile.PresentRecord(affiliate_num: string): boolean;
var
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
  be_qrs_unrecognized: boolean;
  be_qrs: boolean;
  be_bls_amb: boolean;
  be_als_amb: boolean;
  be_als_squad: boolean;
  be_air_amb: boolean;
  be_rescue_unrecognized: boolean;
  be_rescue: boolean;
  be_pa_turnpike_contractor: boolean;
  num_doh_licensed_vehicles: string;
  num_ambulances: string;
  be_dera: boolean;
  charter_other_kind: string;
  be_valid_profile: boolean;
  federal_tax_id: string;
begin
  PresentRecord := FALSE;
  if p.biz_services.Get
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
    )
  then begin
    //
    TextBox_affiliate_num.text := affiliate_num;
    TextBox_name.text := name;
    DropDownList_county.selectedvalue := county_code;
    TextBox_business_phone_num.text := business_phone_num;
    TextBox_business_fax_num.text := business_fax_num;
    TextBox_website_address.text := website_address;
    DropDownList_charter_kind.selectedvalue := charter_kind;
    TextBox_corpadmin_contact_name.text := corpadmin_contact_name;
    TextBox_corpadmin_primary_phone_num.text := corpadmin_primary_phone_num;
    TextBox_corpadmin_secondary_phone_num.text := corpadmin_secondary_phone_num;
    TextBox_corpadmin_email_address.text := corpadmin_email_address;
    RadioButtonList_be_emsof_participant.selectedvalue := be_emsof_participant.tostring.toupper;
    TextBox_emsof_nonparticipation_reason.text := emsof_nonparticipation_reason;
    TextBox_emsof_contact_name.text := emsof_contact_name;
    TextBox_emsof_contact_email_address.text := emsof_contact_email_address;
    TextBox_emsof_contact_primary_phone_num.text := emsof_contact_primary_phone_num;
    TextBox_emsof_contact_sms_phone_num.text := emsof_contact_sms_phone_num;
    TextBox_coo_name.text := coo_name;
    TextBox_coo_work_phone_num.text := coo_work_phone_num;
    TextBox_coo_home_phone_num.text := coo_home_phone_num;
    TextBox_coo_email_address.text := coo_email_address;
    TextBox_coo_mobile_phone_or_pager_num.text := coo_mobile_phone_or_pager_num;
    TextBox_md_name.text := md_name;
    TextBox_md_office_phone_num.text := md_office_phone_num;
    TextBox_md_home_phone_num.text := md_home_phone_num;
    TextBox_md_email_address.text := md_email_address;
    TextBox_md_mobile_phone_or_pager_num.text := md_mobile_phone_or_pager_num;
    TextBox_physical_street_address_line_1.text := physical_street_address_line_1;
    TextBox_physical_street_address_line_2.text := physical_street_address_line_2;
    TextBox_physical_city.text := physical_city;
    TextBox_physical_zip_code.text := physical_zip_code;
    TextBox_mail_address_line_1.text := mail_address_line_1;
    TextBox_mail_address_line_2.text := mail_address_line_2;
    TextBox_mail_city.text := mail_city;
    TextBox_mail_zip_code.text := mail_zip_code;
    CheckBox_be_qrs_unrecognized.checked := be_qrs_unrecognized;
    CheckBox_be_qrs.checked := be_qrs;
    CheckBox_be_bls_amb.checked := be_bls_amb;
    CheckBox_be_als_amb.checked := be_als_amb;
    CheckBox_be_als_squad.checked := be_als_squad;
    CheckBox_be_air_amb.checked := be_air_amb;
    CheckBox_be_rescue_unrecognized.checked := be_rescue_unrecognized;
    CheckBox_be_rescue.checked := be_rescue;
    CheckBox_be_pa_turnpike_contractor.checked := be_pa_turnpike_contractor;
    TextBox_num_doh_licensed_vehicles.text := num_doh_licensed_vehicles;
    TextBox_num_ambulances.text := num_ambulances;
    RadioButtonList_be_dera.selectedvalue := be_dera.tostring.toupper;
    TextBox_charter_other_kind.text := charter_other_kind;
    RadioButtonList_be_valid_profile.selectedvalue := be_valid_profile.tostring.toupper;
    TextBox_federal_tax_id.text := federal_tax_id;
    //
    p.be_profile_initially_valid := be_valid_profile;
    //
    TextBox_affiliate_num.enabled := FALSE;
    Button_lookup.enabled := FALSE;
    Label_lookup_arrow.enabled := FALSE;
    Label_lookup_hint.enabled := FALSE;
    LinkButton_reset.enabled := TRUE;
    //
    // Proforma enablements of all dependent fields
    //
    ManageDependentFieldEnablements;
    //
    // Ablement customizations unique to this control
    //
    RadioButtonList_be_valid_profile.enabled := p.be_authorized_to_change_affiliate_num_and_delete_service;
    ManageCharterControlEnablements;
    ManageEmsofControlEnablements;
    Button_submit.enabled := p.be_ok_to_config_service_profiles;
    Button_delete.enabled := p.be_authorized_to_change_affiliate_num_and_delete_service;
    //
    PresentRecord := TRUE;
    //
  end;
end;

procedure TWebUserControl_service_profile.SetLookupMode;
begin
  Clear;
  TextBox_affiliate_num.enabled := TRUE;
  Button_lookup.enabled := TRUE;
  Label_lookup_arrow.enabled := TRUE;
  Label_lookup_hint.enabled := TRUE;
  LinkButton_reset.enabled := FALSE;
  Focus(TextBox_affiliate_num,TRUE);
end;

procedure TWebUserControl_service_profile.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_service_profile.p'] <> nil then begin
    p := p_type(session['UserControl_service_profile.p']);
    p.be_loaded := IsPostBack;
  end else begin
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_charter_kinds := TClass_biz_charter_kinds.Create;
    p.biz_counties := TClass_biz_counties.Create;
    p.biz_services := TClass_biz_services.Create;
    p.biz_user := TClass_biz_user.Create;
    //
    p.affiliate_num := p.biz_services.AffiliateNumOfId(p.biz_user.IdNum);
    p.be_authorized_to_change_affiliate_num_and_delete_service := p.biz_services.BeOkToChangeAffiliateNumAndDelete;
    p.be_loaded := FALSE;
    p.be_service_user := (p.biz_user.Kind = 'service');
    p.be_profile_initially_valid := FALSE;
    //
    p.be_ok_to_config_service_profiles := p.be_service_user
      or httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator');
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_service_profile.InitializeComponent;
begin
  Include(Self.Button_lookup.Click, Self.Button_lookup_Click);
  Include(Self.LinkButton_reset.Click, Self.LinkButton_reset_Click);
  Include(Self.DropDownList_affiliate_num.SelectedIndexChanged, Self.DropDownList_affiliate_num_SelectedIndexChanged);
  Include(Self.CustomValidator_website_address.ServerValidate, Self.CustomValidator_website_address_ServerValidate);
  Include(Self.DropDownList_charter_kind.SelectedIndexChanged, Self.DropDownList_charter_kind_SelectedIndexChanged);
  Include(Self.CustomValidator_corpadmin_email_address.ServerValidate, Self.CustomValidator_corpadmin_email_address_ServerValidate);
  Include(Self.CustomValidator_emsof_contact_email_address.ServerValidate, Self.CustomValidator_emsof_contact_email_address_ServerValidate);
  Include(Self.RadioButtonList_be_emsof_participant.SelectedIndexChanged, Self.RadioButtonList_be_emsof_participant_SelectedIndexChanged);
  Include(Self.CustomValidator_coo_email_address.ServerValidate, Self.CustomValidator_coo_email_address_ServerValidate);
  Include(Self.CustomValidator_be_als_medical_director_name.ServerValidate, Self.CustomValidator_be_als_medical_director_name_ServerValidate);
  Include(Self.CustomValidator_md_email_address.ServerValidate, Self.CustomValidator_md_email_address_ServerValidate);
  Include(Self.CustomValidator_num_ambulances.ServerValidate, Self.CustomValidator_num_ambulances_ServerValidate);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Button_delete.Click, Self.Button_delete_Click);
  Include(Self.PreRender, Self.TWebUserControl_service_profile_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_service_profile.TWebUserControl_service_profile_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_service_profile.p',p);
end;

function TWebUserControl_service_profile.Fresh: TWebUserControl_service_profile;
begin
  session.Remove('UserControl_service_profile.p');
  Fresh := self;
end;

procedure TWebUserControl_service_profile.CustomValidator_num_ambulances_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid :=
    (uint32.Parse(Safe(TextBox_num_ambulances.text,NUM)) <= uint32.Parse(Safe(TextBox_num_doh_licensed_vehicles.text,NUM)));
  //
end;

procedure TWebUserControl_service_profile.RadioButtonList_be_emsof_participant_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  ManageEmsofControlEnablements;
end;

procedure TWebUserControl_service_profile.CustomValidator_emsof_contact_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfEmailAddress(Safe(TextBox_emsof_contact_email_address.text,EMAIL_ADDRESS));
end;

procedure TWebUserControl_service_profile.CustomValidator_md_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfEmailAddress(Safe(TextBox_md_email_address.text,EMAIL_ADDRESS));
end;

procedure TWebUserControl_service_profile.CustomValidator_be_als_medical_director_name_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := not
    (
      (CheckBox_be_als_amb.checked or CheckBox_be_als_squad.checked or CheckBox_be_air_amb.checked)
    and
      (TextBox_md_name.text = EMPTY)
    );
  //
end;

procedure TWebUserControl_service_profile.CustomValidator_coo_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfEmailAddress(Safe(TextBox_coo_email_address.text,EMAIL_ADDRESS));
end;

procedure TWebUserControl_service_profile.CustomValidator_website_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfWebAddress(Safe(TextBox_website_address.text,HTTP_TARGET));
end;

procedure TWebUserControl_service_profile.CustomValidator_corpadmin_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfEmailAddress(Safe(TextBox_corpadmin_email_address.text,EMAIL_ADDRESS));
end;

procedure TWebUserControl_service_profile.DropDownList_charter_kind_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  ManageCharterControlEnablements;
end;

procedure TWebUserControl_service_profile.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if page.IsValid then begin
    //
    //
    p.biz_services.&Set
      (
      Safe(TextBox_affiliate_num.text,NUM),
      Safe(TextBox_name.text,ORG_NAME).trim,
      Safe(DropDownList_county.selectedvalue,NUM),
      Safe(TextBox_business_phone_num.text,NUM),
      Safe(TextBox_business_fax_num.text,NUM),
      Safe(TextBox_website_address.text,HTTP_TARGET).trim,
      Safe(DropDownList_charter_kind.selectedvalue,NUM),
      Safe(TextBox_corpadmin_contact_name.text,HUMAN_NAME).trim,
      Safe(TextBox_corpadmin_primary_phone_num.text,NUM),
      Safe(TextBox_corpadmin_secondary_phone_num.text,NUM),
      Safe(TextBox_corpadmin_email_address.text,EMAIL_ADDRESS).trim,
      (RadioButtonList_be_emsof_participant.selectedvalue = 'TRUE'),
      Safe(TextBox_emsof_nonparticipation_reason.text,PUNCTUATED).trim,
      Safe(TextBox_emsof_contact_name.text,HUMAN_NAME).trim,
      Safe(TextBox_emsof_contact_email_address.text,EMAIL_ADDRESS).trim,
      Safe(TextBox_emsof_contact_primary_phone_num.text,NUM),
      Safe(TextBox_emsof_contact_sms_phone_num.text,NUM),
      Safe(TextBox_coo_name.text,HUMAN_NAME).trim,
      Safe(TextBox_coo_work_phone_num.text,NUM),
      Safe(TextBox_coo_home_phone_num.text,NUM),
      Safe(TextBox_coo_email_address.text,EMAIL_ADDRESS).trim,
      Safe(TextBox_coo_mobile_phone_or_pager_num.text,NUM),
      Safe(TextBox_md_name.text,HUMAN_NAME).trim,
      Safe(TextBox_md_office_phone_num.text,NUM),
      Safe(TextBox_md_home_phone_num.text,NUM),
      Safe(TextBox_md_email_address.text,EMAIL_ADDRESS).trim,
      Safe(TextBox_md_mobile_phone_or_pager_num.text,NUM),
      Safe(TextBox_physical_street_address_line_1.text,POSTAL_STREET_ADDRESS).trim,
      Safe(TextBox_physical_street_address_line_2.text,POSTAL_STREET_ADDRESS).trim,
      Safe(TextBox_physical_city.text,POSTAL_CITY).trim,
      'PA',
      Safe(TextBox_physical_zip_code.text,NUM),
      Safe(TextBox_mail_address_line_1.text,POSTAL_STREET_ADDRESS).trim,
      Safe(TextBox_mail_address_line_2.text,POSTAL_STREET_ADDRESS).trim,
      Safe(TextBox_mail_city.text,POSTAL_CITY).trim,
      'PA',
      Safe(TextBox_mail_zip_code.text,NUM),
      CheckBox_be_qrs.checked,
      CheckBox_be_bls_amb.checked,
      CheckBox_be_als_amb.checked,
      CheckBox_be_als_squad.checked,
      CheckBox_be_air_amb.checked,
      CheckBox_be_rescue.checked,
      CheckBox_be_pa_turnpike_contractor.checked,
      Safe(TextBox_num_doh_licensed_vehicles.text,NUM),
      Safe(TextBox_num_ambulances.text,NUM),
      (RadioButtonList_be_dera.selectedvalue = 'TRUE'),
      Safe(TextBox_charter_other_kind.text,PUNCTUATED).trim,
      (p.be_service_user and not p.be_profile_initially_valid),
      (p.be_service_user or (RadioButtonList_be_valid_profile.selectedvalue = 'TRUE')),
      Safe(TextBox_federal_tax_id.text,NUM),
      CheckBox_be_qrs_unrecognized.checked,
      CheckBox_be_rescue_unrecognized.checked
      );
    Alert(USER,SUCCESS,'recsaved','Record saved.',TRUE);
    SetLookupMode;
  end else begin
    ValidationAlert(TRUE);
  end;
end;

procedure TWebUserControl_service_profile.DropDownList_affiliate_num_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  PresentRecord(DropDownList_affiliate_num.selectedvalue);
end;

procedure TWebUserControl_service_profile.Button_delete_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if p.biz_services.Delete(Safe(TextBox_affiliate_num.text,ALPHANUM)) then begin
    SetLookupMode;
  end else begin
    Alert(kix.APPDATA,kix.FAILURE,'dependency',' Cannot delete this record because another record depends on it.',TRUE);
  end;
end;

procedure TWebUserControl_service_profile.LinkButton_reset_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SetLookupMode;
end;

procedure TWebUserControl_service_profile.ManageDependentFieldEnablements;
begin
  TextBox_name.enabled := p.be_ok_to_config_service_profiles;
  DropDownList_county.enabled := p.be_ok_to_config_service_profiles;
  TextBox_business_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_business_fax_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_website_address.enabled := p.be_ok_to_config_service_profiles;
  DropDownList_charter_kind.enabled := p.be_ok_to_config_service_profiles;
  TextBox_corpadmin_contact_name.enabled := p.be_ok_to_config_service_profiles;
  TextBox_corpadmin_primary_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_corpadmin_secondary_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_corpadmin_email_address.enabled := p.be_ok_to_config_service_profiles;
  RadioButtonList_be_emsof_participant.enabled := p.be_ok_to_config_service_profiles;
  TextBox_emsof_nonparticipation_reason.enabled := p.be_ok_to_config_service_profiles;
  TextBox_emsof_contact_name.enabled := p.be_ok_to_config_service_profiles;
  TextBox_emsof_contact_email_address.enabled := p.be_ok_to_config_service_profiles;
  TextBox_emsof_contact_primary_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_emsof_contact_sms_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_coo_name.enabled := p.be_ok_to_config_service_profiles;
  TextBox_coo_work_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_coo_home_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_coo_email_address.enabled := p.be_ok_to_config_service_profiles;
  TextBox_coo_mobile_phone_or_pager_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_md_name.enabled := p.be_ok_to_config_service_profiles;
  TextBox_md_office_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_md_home_phone_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_md_email_address.enabled := p.be_ok_to_config_service_profiles;
  TextBox_md_mobile_phone_or_pager_num.enabled := p.be_ok_to_config_service_profiles;
  TextBox_physical_street_address_line_1.enabled := p.be_ok_to_config_service_profiles;
  TextBox_physical_street_address_line_2.enabled := p.be_ok_to_config_service_profiles;
  TextBox_physical_city.enabled := p.be_ok_to_config_service_profiles;
  TextBox_physical_zip_code.enabled := p.be_ok_to_config_service_profiles;
  TextBox_mail_address_line_1.enabled := p.be_ok_to_config_service_profiles;
  TextBox_mail_address_line_2.enabled := p.be_ok_to_config_service_profiles;
  TextBox_mail_city.enabled := p.be_ok_to_config_service_profiles;
  TextBox_mail_zip_code.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_qrs_unrecognized.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_qrs.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_bls_amb.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_als_amb.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_als_squad.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_air_amb.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_rescue_unrecognized.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_rescue.enabled := p.be_ok_to_config_service_profiles;
  CheckBox_be_pa_turnpike_contractor.enabled := p.be_ok_to_config_service_profiles;
  TextBox_num_doh_licensed_vehicles.enabled := p.be_ok_to_config_service_profiles;
  TextBox_num_ambulances.enabled := p.be_ok_to_config_service_profiles;
  RadioButtonList_be_dera.enabled := p.be_ok_to_config_service_profiles;
  TextBox_charter_other_kind.enabled := p.be_ok_to_config_service_profiles;
  RadioButtonList_be_valid_profile.enabled := p.be_ok_to_config_service_profiles;
  TextBox_federal_tax_id.enabled := p.be_ok_to_config_service_profiles;
end;

procedure TWebUserControl_service_profile.Button_lookup_Click(sender: System.Object;
  e: System.EventArgs);
var
  num_matches: cardinal;
  saved_affiliate_num: string;
begin
  saved_affiliate_num := TextBox_affiliate_num.text;
  Clear;
  if not PresentRecord(saved_affiliate_num) then begin
    TextBox_affiliate_num.text := saved_affiliate_num;
    p.biz_services.Bind(saved_affiliate_num,DropDownList_affiliate_num);
    num_matches := DropDownList_affiliate_num.items.count;
    if num_matches > 0 then begin
      DropDownList_affiliate_num.visible := TRUE;
      if num_matches = 1 then begin
        PresentRecord(DropDownList_affiliate_num.selectedvalue);
      end else begin
        DropDownList_affiliate_num.items.Insert(0,listitem.Create('-- Select --',EMPTY));
      end;
    end;
  end;
end;

procedure TWebUserControl_service_profile.ManageEmsofControlEnablements;
var
  be_emsof_participant: boolean;
begin
  be_emsof_participant := (RadioButtonList_be_emsof_participant.selectedvalue <> 'FALSE');
  RadioButtonList_be_emsof_participant.enabled :=
    not (p.biz_appropriations.BeAnyCurrentToService(session['service_user_id'].tostring) and be_emsof_participant);
  Label_emsof_nonparticipation_reason.enabled := not be_emsof_participant;
  TextBox_emsof_nonparticipation_reason.enabled := not be_emsof_participant;
  TableRow_emsof_contact_name.visible := be_emsof_participant;
  TableRow_emsof_contact_email_address.visible := be_emsof_participant;
  TableRow_emsof_contact_primary_phone_num.visible := be_emsof_participant;
  TableRow_emsof_contact_sms_phone_num.visible := be_emsof_participant;
  if be_emsof_participant then begin
    TextBox_emsof_nonparticipation_reason.text := EMPTY;
  end else begin
    TextBox_emsof_contact_name.text := EMPTY;
    TextBox_emsof_contact_email_address.text := EMPTY;
    TextBox_emsof_contact_primary_phone_num.text := EMPTY;
    TextBox_emsof_contact_sms_phone_num.text := EMPTY;
  end;
end;

procedure TWebUserControl_service_profile.ManageCharterControlEnablements;
var
  be_charter_other_kind: boolean;
begin
  be_charter_other_kind := (DropDownList_charter_kind.selecteditem.text = 'Other');
  Label_charter_other_kind.enabled := be_charter_other_kind;
  TextBox_charter_other_kind.enabled := be_charter_other_kind;
  RequiredFieldValidator_charter_other_kind.enabled := be_charter_other_kind;
  if not be_charter_other_kind then begin
    TextBox_charter_other_kind.text := EMPTY;
  end;
end;

end.
