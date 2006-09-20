
unit profile;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common,
  Borland.Data.Common, System.Globalization,
  System.Data.Common, system.configuration, system.web.security,
  Class_biz_services;

const ID = '$Id$';

type
  p_type =
    RECORD
    be_profile_initially_valid: boolean;
    biz_services: Class_biz_services.TClass_biz_services;
    END;
  TWebForm_profile = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_submit_PreRender(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    CheckBox_rescue: System.Web.UI.WebControls.CheckBox;
    CheckBox_air_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_als_squad: System.Web.UI.WebControls.CheckBox;
    CheckBox_als_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_bls_amb: System.Web.UI.WebControls.CheckBox;
    CheckBox_qrs: System.Web.UI.WebControls.CheckBox;
    TextBox_address_line_1: System.Web.UI.WebControls.TextBox;
    Label_affiliate_num: System.Web.UI.WebControls.Label;
    TextBox_service_name: System.Web.UI.WebControls.TextBox;
    TextBox_address_line_2: System.Web.UI.WebControls.TextBox;
    TextBox_zip_code: System.Web.UI.WebControls.TextBox;
    TextBox_federal_tax_id_num: System.Web.UI.WebControls.TextBox;
    TextBox_contact_person_phone_num: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_service_name: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_city: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_address_line_1: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_city: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_zip_code: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_federal_tax_id_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_contact_person_phone_num: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_submit: System.Web.UI.WebControls.Button;
    RegularExpressionValidator_federal_tax_id_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_zip_code: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_contact_person_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
    TextBox_contact_person_name: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_contact_person_name: System.Web.UI.WebControls.RequiredFieldValidator;
    Label_application_name: System.Web.UI.WebControls.Label;
    RegularExpressionValidator_service_name: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_city: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_address_line_2: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_address_line_1: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_contact_person_name: System.Web.UI.WebControls.RegularExpressionValidator;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_service_overview: System.Web.UI.WebControls.HyperLink;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  Class_biz_accounts;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_profile.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.Button_submit.PreRender, Self.Button_submit_PreRender);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_profile.Page_Load(sender: System.Object; e: System.EventArgs);
var
  address_line_1: string;
  address_line_2: string;
  affiliate_num: string;
  be_air_amb: boolean;
  be_als_amb: boolean;
  be_als_squad: boolean;
  be_bls_amb: boolean;
  be_qrs: boolean;
  be_rescue: boolean;
  be_valid_profile: boolean;
  city: string;
  contact_person_name: string;
  contact_person_phone_num: string;
  federal_tax_id_num: string;
  name: string;
  zip_code: string;
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - profile';
    p.biz_services := TClass_biz_services.Create;
    //
    // Set Label_service_name
    //
    Label_service_name.Text := session['service_name'].ToString;
    //
    // Set Label_application_name
    //
    Label_application_name.Text := ConfigurationSettings.AppSettings['application_name'];
    //
    // Get affiliate_num and set Label_affiliate_num
    //
    affiliate_num := p.biz_services.AffiliateNumOfId(session['service_user_id'].ToString);
    Label_affiliate_num.Text := affiliate_num;
    //
    // Get profile
    //
    p.biz_services.GetProfile
      (
      affiliate_num,
      name,
      be_qrs,
      be_bls_amb,
      be_als_amb,
      be_als_squad,
      be_air_amb,
      be_rescue,
      address_line_1,
      address_line_2,
      city,
      zip_code,
      federal_tax_id_num,
      contact_person_name,
      contact_person_phone_num,
      be_valid_profile
      );
    TextBox_service_name.Text := name;
    CheckBox_qrs.Checked := be_qrs;
    CheckBox_bls_amb.Checked := be_bls_amb;
    CheckBox_als_amb.Checked := be_als_amb;
    CheckBox_als_squad.Checked := be_als_squad;
    CheckBox_air_amb.Checked := be_air_amb;
    CheckBox_rescue.Checked := be_rescue;
    TextBox_address_line_1.Text := address_line_1;
    TextBox_address_line_2.Text := address_line_2;
    TextBox_city.Text := city;
    TextBox_zip_code.Text := zip_code;
    TextBox_federal_tax_id_num.Text := federal_tax_id_num;
    TextBox_contact_person_name.Text := contact_person_name;
    TextBox_contact_person_phone_num.Text := contact_person_phone_num;
    p.be_profile_initially_valid := be_valid_profile;
  end;
end;

procedure TWebForm_profile.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_profile.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_profile.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_profile.Button_submit_PreRender(sender: System.Object; e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_profile.LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_profile.Button_submit_Click(sender: System.Object; e: System.EventArgs);
var
  affiliate_num: string;
  contact_person_name: string;
  service_name: string;
begin
  //
  affiliate_num := Safe(Label_affiliate_num.Text,NUM);
  contact_person_name := Safe(TextBox_contact_person_name.Text.trim,HUMAN_NAME);
  service_name := Safe(TextBox_service_name.Text.trim,ORG_NAME);
  //
  // Commit the displayed data to the database.
  //
  p.biz_services.SetProfile
    (
    affiliate_num,
    service_name,
    CheckBox_qrs.Checked.ToString,
    CheckBox_bls_amb.Checked.ToString,
    CheckBox_als_amb.Checked.ToString,
    CheckBox_als_squad.Checked.ToString,
    CheckBox_air_amb.Checked.ToString,
    CheckBox_rescue.Checked.ToString,
    Safe(TextBox_address_line_1.Text.trim,POSTAL_STREET_ADDRESS),
    Safe(TextBox_address_line_2.Text.trim,POSTAL_STREET_ADDRESS),
    Safe(TextBox_city.Text.Trim,POSTAL_CITY),
    Safe(TextBox_zip_code.Text.Trim,HYPHENATED_NUM),
    Safe(TextBox_federal_tax_id_num.Text.trim,HYPHENATED_NUM),
    contact_person_name,
    Safe(TextBox_contact_person_phone_num.Text.trim,PHONE_NUM)
    );
  //
  if not p.be_profile_initially_valid then begin
    //
    // Notify regional council that contact person has affirmed responsibilities.
    //
    TClass_biz_accounts.Create.NotifyRegionOfServicePocAffirmation
      (
      session['service_user_id'].tostring,
      service_name,
      contact_person_name
      );
  end;
  //
  server.Transfer('service_overview.aspx');
end;

end.

