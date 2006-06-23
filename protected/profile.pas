
unit profile;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common,
  Borland.Data.Common, Borland.Data.Provider, System.Globalization,
  System.Data.Common, system.configuration, system.web.security;

const ID = '$Id$';

type
  TWebForm_profile = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
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
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_profile.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_profile.Page_Load(sender: System.Object; e: System.EventArgs);
var
  affiliate_num: string;
  bdr: borland.data.provider.BdpDataReader;
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - profile';
    ki.common.DbOpen;
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
    affiliate_num := borland.data.provider.BdpCommand.Create
      (
      'SELECT affiliate_num FROM service WHERE id = ' + session['service_user_id'].ToString,
      ki.common.db
      )
      .ExecuteScalar.tostring;
    Label_affiliate_num.Text := affiliate_num;
    //
    // Get profile
    //
    bdr := borland.data.provider.BdpCommand.Create
      (
      'SELECT name,'
      + 'be_qrs,'
      + 'be_bls_amb,'
      + 'be_als_amb,'
      + 'be_als_squad,'
      + 'be_air_amb,'
      + 'be_rescue,'
      + 'address_line_1,'
      + 'address_line_2,'
      + 'city,'
      + 'zip_code,'
      + 'federal_tax_id_num,'
      + 'contact_person_name,'
      + 'contact_person_phone_num '
      + 'FROM service '
      + 'WHERE affiliate_num = "' + affiliate_num + '"',
      ki.common.db
      )
      .ExecuteReader;
    bdr.Read;
    //
    TextBox_service_name.Text := bdr['name'].tostring;
    CheckBox_qrs.Checked := (bdr['be_qrs'].tostring = '1');
    CheckBox_bls_amb.Checked := (bdr['be_bls_amb'].tostring = '1');
    CheckBox_als_amb.Checked := (bdr['be_als_amb'].tostring = '1');
    CheckBox_als_squad.Checked := (bdr['be_als_squad'].tostring = '1');
    CheckBox_air_amb.Checked := (bdr['be_air_amb'].tostring = '1');
    CheckBox_rescue.Checked := (bdr['be_rescue'].tostring = '1');
    TextBox_address_line_1.Text := bdr['address_line_1'].tostring;
    TextBox_address_line_2.Text := bdr['address_line_2'].tostring;
    TextBox_city.Text := bdr['city'].tostring;
    TextBox_zip_code.Text := bdr['zip_code'].tostring;
    TextBox_federal_tax_id_num.Text := bdr['federal_tax_id_num'].tostring;
    TextBox_contact_person_name.Text := bdr['contact_person_name'].tostring;
    TextBox_contact_person_phone_num.Text := bdr['contact_person_phone_num'].tostring;
    //
    ki.common.DbClose;
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

procedure TWebForm_profile.LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_profile.Button_submit_Click(sender: System.Object; e: System.EventArgs);
  //IpHostEntry: System.Net.IpHostEntry;
begin
  //
  // See if the domain part of the given email address actually resolves.
  //
  //IpHostEntry := Dns.Resolve(TextBox_contact_person_email_address.Text);
  //
  // Commit the displayed data to the database.
  //
  ki.common.DbOpen;
  borland.data.provider.bdpcommand.Create
    (
    'UPDATE service '
    + 'SET name = "' + Safe(TextBox_service_name.Text.trim,ORG_NAME) + '",'
    +   'be_qrs = ' + CheckBox_qrs.Checked.ToString + ','
    +   'be_bls_amb = ' + CheckBox_bls_amb.Checked.ToString + ','
    +   'be_als_amb = ' + CheckBox_als_amb.Checked.ToString + ','
    +   'be_als_squad = ' + CheckBox_als_squad.Checked.ToString + ','
    +   'be_air_amb = ' + CheckBox_air_amb.Checked.ToString + ','
    +   'be_rescue = ' + CheckBox_rescue.Checked.ToString + ','
    +   'address_line_1 = "' + Safe(TextBox_address_line_1.Text.trim,POSTAL_STREET_ADDRESS) + '",'
    +   'address_line_2 = "' + Safe(TextBox_address_line_2.Text.trim,POSTAL_STREET_ADDRESS) + '",'
    +   'city = "' + Safe(TextBox_city.Text.Trim,POSTAL_CITY) + '",'
    +   'zip_code = "' + Safe(TextBox_zip_code.Text.Trim,HYPHENATED_NUM) + '",'
    +   'federal_tax_id_num = "' + Safe(TextBox_federal_tax_id_num.Text.trim,HYPHENATED_NUM) + '",'
    +   'contact_person_name = "' + Safe(TextBox_contact_person_name.Text.trim,HUMAN_NAME) + '",'
    +   'contact_person_phone_num = "' + Safe(TextBox_contact_person_phone_num.Text.trim,PHONE_NUM) + '",'
    +   'be_valid_profile = TRUE '
    + 'WHERE affiliate_num = "' + Safe(Label_affiliate_num.Text,NUM) + '"',
    ki.common.db
    )
    .ExecuteNonQuery;
  ki.common.DbClose;
  server.Transfer('service_overview.aspx');
end;

end.

