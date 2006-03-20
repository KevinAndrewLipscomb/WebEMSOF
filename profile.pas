
unit profile;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  Borland.Data.Common, Borland.Data.Provider, System.Globalization, 
  System.Data.Common;

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
    BdpConnection1: Borland.Data.Provider.BdpConnection;
    Label_affiliate_num: System.Web.UI.WebControls.Label;
    TextBox_service_name: System.Web.UI.WebControls.TextBox;
    TextBox_address_line_2: System.Web.UI.WebControls.TextBox;
    TextBox_zip_code: System.Web.UI.WebControls.TextBox;
    TextBox_federal_tax_id_num: System.Web.UI.WebControls.TextBox;
    TextBox_contact_person_name: System.Web.UI.WebControls.TextBox;
    TextBox_contact_person_phone_num: System.Web.UI.WebControls.TextBox;
    TextBox_contact_person_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_service_name: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_city: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_address_line_1: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_city: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_zip_code: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_federal_tax_id_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_contact_person_name: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_contact_person_phone_num: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_contact_person_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_submit: System.Web.UI.WebControls.Button;
    RegularExpressionValidator_contact_person_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_federal_tax_id_num: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_zip_code: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_contact_person_phone_num: System.Web.UI.WebControls.RegularExpressionValidator;
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
  Self.BdpConnection1 := Borland.Data.Provider.BdpConnection.Create;
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  // 
  // BdpConnection1
  // 
  Self.BdpConnection1.ConnectionOptions := 'transaction isolation=ReadCommit' +
  'ted';
  Self.BdpConnection1.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=egalmess;provider=MySQL (Core Lab);min pool siz' +
  'e=0;hostname=db4free.org';
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_profile.Page_Load(sender: System.Object; e: System.EventArgs);
var
  affiliate_num_obj: System.Object;
  BdpCommand_get_affiliate_num: borland.data.provider.BdpCommand;
  BdpCommand_get_profile: borland.data.provider.BdpCommand;
  BdpDataReader_profile: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := 'WebEMSOF - template_std';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    BdpConnection1.Open;
    //
    // Set Label_service_name
    //
    Label_service_name.Text := session.Item['account_descriptor'].ToString;
    //
    // Get affiliate_num and set Label_affiliate_num
    //
    BdpCommand_get_affiliate_num := borland.data.provider.BdpCommand.Create
      (
      'SELECT affiliate_num FROM emsof_sponsorship WHERE id = ' + session.Item['emsof_sponsorship_id'].ToString,
      bdpConnection1
      );
    affiliate_num_obj := BdpCommand_get_affiliate_num.ExecuteScalar;
    Label_affiliate_num.Text := affiliate_num_obj.ToString;
    //
    // Get profile
    //
    BdpCommand_get_profile := borland.data.provider.BdpCommand.Create
      (
      'SELECT name,'
      + 'webemsof_primary_email_address,'
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
      + 'FROM response_agency '
      + 'WHERE affiliate_num = "' + affiliate_num_obj.ToString + '"',
      BdpConnection1
      );
    BdpDataReader_profile := BdpCommand_get_profile.ExecuteReader;
    BdpDataReader_profile.Read;
    //
    TextBox_service_name.Text := BdpDataReader_profile.GetString(0);
    TextBox_contact_person_email_address.Text := BdpDataReader_profile.GetString(1);
    CheckBox_qrs.Checked := Boolean(BdpDataReader_profile.GetInt16(2));
    CheckBox_bls_amb.Checked := Boolean(BdpDataReader_profile.GetInt16(3));
    CheckBox_als_amb.Checked := Boolean(BdpDataReader_profile.GetInt16(4));
    CheckBox_als_squad.Checked := Boolean(BdpDataReader_profile.GetInt16(5));
    CheckBox_air_amb.Checked := Boolean(BdpDataReader_profile.GetInt16(6));
    CheckBox_rescue.Checked := Boolean(BdpDataReader_profile.GetInt16(7));
    TextBox_address_line_1.Text := BdpDataReader_profile.GetString(8);
    TextBox_address_line_2.Text := BdpDataReader_profile.GetString(9);
    TextBox_city.Text := BdpDataReader_profile.GetString(10);
    TextBox_zip_code.Text := BdpDataReader_profile.GetString(11);
    TextBox_federal_tax_id_num.Text := BdpDataReader_profile.GetString(12);
    TextBox_contact_person_name.Text := BdpDataReader_profile.GetString(13);
    TextBox_contact_person_phone_num.Text := BdpDataReader_profile.GetString(14);
    //
    BdPConnection1.Close;
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
begin
  BdpCommand_update_profile := borland.data.provider.bdpcommand.Create
    (
    'UPDATE response_agency '
    + 'SET name = "' + TextBox_service_name.Text + '",'
    +   'webemsof_primary_email_address = "' + TextBox_contact_person_email_address.Text + '",'
    +   'be_qrs = ' + CheckBox_qrs.Checked.ToString + ','
    +   'be_bls_amb = ' + CheckBox_bls_amb.Checked.ToString + ','
    +   'be_als_amb = ' + CheckBox_als_amb.Checked.ToString + ','
    +   'be_als_squad = ' + CheckBox_als_squad.Checked.ToString + ','
    +   'be_air_amb = ' + CheckBox_air_amb.Checked.ToString + ','
    +   'be_rescue = ' + CheckBox_rescue.Checked.ToString + ','
    +   'address_line_1 = "' + TextBox_address_line_1.Text + '",'
    +   'address_line_2 = "' + TextBox_address_line_2.Text + '",'
    +   'city = "' + TextBox_city.Text + '",'
    +   'zip_code = "' + TextBox_zip_code.Text + '",'
    +   'federal_tax_id_num = "' + TextBox_federal_tax_id_num.Text + '",'
    +   'contact_person_name = "' + TextBox_contact_person_name.Text + '",'
    +   'contact_person_phone_num = "' + TextBox_contact_person_phone_num.Text + '",'
    +   'be_profile_valid = 1 '
    + 'WHERE affiliate_num = "' + Label_affiliate_num.Text + '"',
    BdpConnection1
    );
  BdpCommand_update_profile.Connection.Open;
  BdpCommand_update_profile.ExecuteNonQuery;
  BdpCommand_update_profile.Connection.Close;
  server.Transfer('account_overview.aspx');
end;

end.

