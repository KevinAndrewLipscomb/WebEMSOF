unit UserControl_new_service;

interface

uses
  Class_biz_counties,
  Class_biz_services,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_new_service = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_new_service_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure CustomValidator_email_address_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure CustomValidator_affiliate_num_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        biz_counties: TClass_biz_counties;
        biz_services: TClass_biz_services;
        END;
  strict private
    p: p_type;
    procedure Clear;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    UpdatePanel_control: System.Web.UI.UpdatePanel;
    Button_submit: System.Web.UI.WebControls.Button;
    TextBox_service_name: System.Web.UI.WebControls.TextBox;
    TextBox_affiliate_num: System.Web.UI.WebControls.TextBox;
    TextBox_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_service_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_affiliate_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_affiliate_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RequiredFieldValidator_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_email_address: System.Web.UI.WebControls.CustomValidator;
    RequiredFieldValidator_county: System.Web.UI.WebControls.RequiredFieldValidator;
    DropDownList_county: System.Web.UI.WebControls.DropDownList;
    CustomValidator_affiliate_num: System.Web.UI.WebControls.CustomValidator;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_new_service;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_new_service.InjectPersistentClientSideScript;
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

procedure TWebUserControl_new_service.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    p.biz_counties.BindDirectToListControl(DropDownList_county);
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

procedure TWebUserControl_new_service.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_new_service.p'] <> nil then begin
    p := p_type(session['UserControl_new_service.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_regional_staffer_binder_control_UserControl_regional_staffer_new_binder_PlaceHolder_content']) = 'UserControl_new_service');
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_counties := TClass_biz_counties.Create;
    p.biz_services := TClass_biz_services.Create;
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_new_service.InitializeComponent;
begin
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.CustomValidator_email_address.ServerValidate, Self.CustomValidator_email_address_ServerValidate);
  Include(Self.CustomValidator_affiliate_num.ServerValidate, Self.CustomValidator_affiliate_num_ServerValidate);
  Include(Self.PreRender, Self.TWebUserControl_new_service_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_new_service.TWebUserControl_new_service_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_new_service.p',p);
end;

function TWebUserControl_new_service.Fresh: TWebUserControl_new_service;
begin
  session.Remove('UserControl_new_service.p');
  Fresh := self;
end;

procedure TWebUserControl_new_service.CustomValidator_affiliate_num_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := not p.biz_services.BeKnown(Safe(TextBox_affiliate_num.text,NUM));
end;

procedure TWebUserControl_new_service.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if page.isvalid then begin
    if p.biz_services.BeAdded
      (
      Safe(TextBox_service_name.text,ORG_NAME),
      Safe(TextBox_affiliate_num.text,NUM),
      Safe(TextBox_email_address.text,EMAIL_ADDRESS),
      Safe(DropDownList_county.selectedvalue,NUM)
      )
    then begin
      Alert(USER,SUCCESS,'servicadd','Service added',TRUE);
      Clear;
    end else begin
      Alert(APPDATA,DAMAGE,'badsvcrel','Corruption detected during attempt to add service.  The Application Administrator has been notified.  The service was NOT added.',TRUE);
    end;
  end else begin
    ValidationAlert(TRUE);
  end;
end;

procedure TWebUserControl_new_service.Clear;
begin
  TextBox_service_name.text := EMPTY;
  TextBox_affiliate_num.text := EMPTY;
  TextBox_email_address.text := EMPTY;
  DropDownList_county.ClearSelection;
end;

procedure TWebUserControl_new_service.CustomValidator_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := BeValidDomainPartOfEmailAddress(Safe(TextBox_email_address.text,EMAIL_ADDRESS));
end;

end.
