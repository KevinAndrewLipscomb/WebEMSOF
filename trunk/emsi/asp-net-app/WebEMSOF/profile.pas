
unit profile;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  Borland.Data.Common, Borland.Data.Provider, System.Globalization, 
  System.Data.Common, system.configuration, borland.vcl.sysutils;

type
  TWebForm_profile = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
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
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_profile.Page_Load(sender: System.Object; e: System.EventArgs);
var
  affiliate_num_obj: System.Object;
  BdpCommand_get_affiliate_num: borland.data.provider.BdpCommand;
  BdpCommand_get_profile: borland.data.provider.BdpCommand;
  bdr: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - template_std';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    //
    // Set Label_service_name
    //
    Label_service_name.Text := session.Item['account_descriptor'].ToString;
    //
    // Set Label_application_name
    //
    Label_application_name.Text := ConfigurationSettings.AppSettings['application_name'];
    //
    // Get affiliate_num and set Label_affiliate_num
    //
    BdpCommand_get_affiliate_num := borland.data.provider.BdpCommand.Create
      (
      'SELECT affiliate_num FROM webemsof_account_detail WHERE id = ' + session.Item['account_id'].ToString,
      AppCommon.BdpConnection
      );
    affiliate_num_obj := BdpCommand_get_affiliate_num.ExecuteScalar;
    Label_affiliate_num.Text := affiliate_num_obj.ToString;
    //
    // Get profile
    //
    BdpCommand_get_profile := borland.data.provider.BdpCommand.Create
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
      + 'WHERE affiliate_num = "' + affiliate_num_obj.ToString + '"',
      AppCommon.BdpConnection
      );
    bdr := BdpCommand_get_profile.ExecuteReader;
    bdr.Read;
    //
    TextBox_service_name.Text := bdr['name'].tostring;
    CheckBox_qrs.Checked := Boolean(bdr['be_qrs']);
    CheckBox_bls_amb.Checked := Boolean(bdr['be_bls_amb']);
    CheckBox_als_amb.Checked := Boolean(bdr['be_als_amb']);
    CheckBox_als_squad.Checked := Boolean(bdr['be_als_squad']);
    CheckBox_air_amb.Checked := Boolean(bdr['be_air_amb']);
    CheckBox_rescue.Checked := Boolean(bdr['be_rescue']);
    TextBox_address_line_1.Text := bdr['address_line_1'].tostring;
    TextBox_address_line_2.Text := bdr['address_line_2'].tostring;
    TextBox_city.Text := bdr['city'].tostring;
    TextBox_zip_code.Text := bdr['zip_code'].tostring;
    TextBox_federal_tax_id_num.Text := bdr['federal_tax_id_num'].tostring;
    TextBox_contact_person_name.Text := bdr['contact_person_name'].tostring;
    TextBox_contact_person_phone_num.Text := bdr['contact_person_phone_num'].tostring;
    //
    AppCommon.BdpConnection.Close;
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

procedure TWebForm_profile.Button_submit_Click(sender: System.Object; e: System.EventArgs);
var
  BdpCommand_update_profile: borland.data.provider.BdpCommand;
  //IpHostEntry: System.Net.IpHostEntry;
begin
  //
  // See if the domain part of the given email address actually resolves.
  //
  //IpHostEntry := Dns.Resolve(TextBox_contact_person_email_address.Text);
  //
  // Commit the displayed data to the database.
  //
  BdpCommand_update_profile := borland.data.provider.bdpcommand.Create
    (
    'UPDATE service '
    + 'SET name = "' + Safe(Trim(TextBox_service_name.Text),HUMAN_NAME) + '",'
    +   'be_qrs = ' + CheckBox_qrs.Checked.ToString + ','
    +   'be_bls_amb = ' + CheckBox_bls_amb.Checked.ToString + ','
    +   'be_als_amb = ' + CheckBox_als_amb.Checked.ToString + ','
    +   'be_als_squad = ' + CheckBox_als_squad.Checked.ToString + ','
    +   'be_air_amb = ' + CheckBox_air_amb.Checked.ToString + ','
    +   'be_rescue = ' + CheckBox_rescue.Checked.ToString + ','
    +   'address_line_1 = "' + Safe(Trim(TextBox_address_line_1.Text),POSTAL_STREET_ADDRESS) + '",'
    +   'address_line_2 = "' + Safe(Trim(TextBox_address_line_2.Text),POSTAL_STREET_ADDRESS) + '",'
    +   'city = "' + Safe(Trim(TextBox_city.Text),POSTAL_CITY) + '",'
    +   'zip_code = "' + Safe(Trim(TextBox_zip_code.Text),HYPHENATED_NUMERALS) + '",'
    +   'federal_tax_id_num = "' + Safe(Trim(TextBox_federal_tax_id_num.Text),HYPHENATED_NUMERALS) + '",'
    +   'contact_person_name = "' + Safe(Trim(TextBox_contact_person_name.Text),HUMAN_NAME) + '",'
    +   'contact_person_phone_num = "' + Safe(Trim(TextBox_contact_person_phone_num.Text),PHONE_NUMBER) + '",'
    +   'be_valid_profile = TRUE '
    + 'WHERE affiliate_num = "' + Safe(Label_affiliate_num.Text,NUMERIC) + '"',
    AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  BdpCommand_update_profile.ExecuteNonQuery;
  AppCommon.BdpConnection.Close;
  server.Transfer('account_overview.aspx');
end;

end.

