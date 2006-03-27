
unit login;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common, system.configuration;

type
  TWebForm_login = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_account_descriptor_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    invalid_credentials_warning: System.Web.UI.HtmlControls.HtmlGenericControl;
    TextBox_password: System.Web.UI.WebControls.TextBox;
    Button_log_in: System.Web.UI.WebControls.Button;
    CheckBox_keep_me_logged_in: System.Web.UI.WebControls.CheckBox;
    DropDownList_account_descriptor: System.Web.UI.WebControls.DropDownList;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_new_password: System.Web.UI.WebControls.Button;
    RangeValidator_account: System.Web.UI.WebControls.RangeValidator;
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
procedure TWebForm_login.InitializeComponent;
begin
  Include(Self.DropDownList_account_descriptor.SelectedIndexChanged, Self.DropDownList_account_descriptor_SelectedIndexChanged);
  Include(Self.TextBox_password.TextChanged, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_login.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_account_descriptors: Borland.Data.Provider.BdpCommand;
  BdpDataReader_account_descriptors: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - login';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    invalid_credentials_warning.Visible := FALSE;
    //
    // Load DropDownList_account
    //
    DropDownList_account_descriptor.Items.Add(listitem.Create('-- Select --','0'));
    bdpCommand_get_account_descriptors := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT emsof_sponsorship_webemsof_account.emsof_sponsorship_id,'
      + 'concat(response_agency_profile.name," (", county_code_name_map.name,")") AS account_descriptor '
      + 'FROM emsof_sponsorship_webemsof_account '
      +   'JOIN emsof_sponsorship on (emsof_sponsorship.id = emsof_sponsorship_webemsof_account.emsof_sponsorship_id) '
      +     'JOIN county_code_name_map ON (county_code_name_map.code = emsof_sponsorship.county_code) '
      +       'JOIN response_agency_profile using (affiliate_num) '
      + 'ORDER BY account_descriptor',
      AppCommon.BdpConnection
      );
    BdpDataReader_account_descriptors := bdpCommand_get_account_descriptors.ExecuteReader;
    while bdpDataReader_account_descriptors.Read do
      DropDownList_account_descriptor.Items.Add
        (
        listitem.Create
          (
          BdpDataReader_account_descriptors['account_descriptor'].ToString,
          BdpDataReader_account_descriptors['emsof_sponsorship_id'].ToString
          )
        );
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_login.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_login.DropDownList_account_descriptor_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('account_id');
  session.Add('account_id',DropDownList_account_descriptor.SelectedValue);
  session.Remove('account_descriptor');
  session.Add('account_descriptor',DropDownList_account_descriptor.SelectedItem.Text);
end;

procedure TWebForm_login.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_match_account: borland.data.provider.BdpCommand;
  be_stale_password_obj: System.Object;
begin
  bdpCommand_match_account := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password FROM emsof_sponsorship_webemsof_account '
    +  'where emsof_sponsorship_webemsof_account.emsof_sponsorship_id="' + DropDownList_account_descriptor.SelectedValue + '" '
    +     'and encoded_password=sha("' + TextBox_password.Text + '")'
    ,AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  be_stale_password_obj := bdpCommand_match_account.ExecuteScalar;
  AppCommon.BdpConnection.Close;
  if be_stale_password_obj <> nil then
    if be_stale_password_obj.ToString = '0' then
      server.Transfer('account_overview.aspx')
    else
      server.Transfer('change_password.aspx')
  else // be_stale_password_obj = nil
    if DropDownList_account_descriptor.SelectedIndex <> 0 then
      invalid_credentials_warning.Visible := TRUE;
  end;

end.
