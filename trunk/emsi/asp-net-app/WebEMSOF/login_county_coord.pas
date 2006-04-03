
unit login_county_coord;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common, system.configuration;

type
  TWebForm_login_county_coord = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_county_SelectedIndexChanged(sender: System.Object;
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
    DropDownList_county: System.Web.UI.WebControls.DropDownList;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_new_password: System.Web.UI.WebControls.Button;
    RangeValidator_county: System.Web.UI.WebControls.RangeValidator;
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
procedure TWebForm_login_county_coord.InitializeComponent;
begin
  Include(Self.DropDownList_county.SelectedIndexChanged, Self.DropDownList_county_SelectedIndexChanged);
  Include(Self.TextBox_password.TextChanged, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_login_county_coord.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_counties: Borland.Data.Provider.BdpCommand;
  BdpDataReader_counties: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - login_county_coord';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    session.Remove('target_user_table');
    session.Add('target_user_table','county');
    AppCommon.BdpConnection.Open;
    invalid_credentials_warning.Visible := FALSE;
    //
    // Load DropDownList_account
    //
    DropDownList_county.Items.Add(listitem.Create('-- Select --','0'));
    bdpCommand_get_counties := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT id,name '
      + 'FROM county_user JOIN county_code_name_map on (county_code_name_map.code = county_user.id) '
      + 'WHERE be_active = TRUE '
      + 'ORDER BY name',
      AppCommon.BdpConnection
      );
    BdpDataReader_counties := bdpCommand_get_counties.ExecuteReader;
    while bdpDataReader_counties.Read do
      DropDownList_county.Items.Add
        (
        listitem.Create
          (
          BdpDataReader_counties['name'].ToString,
          BdpDataReader_counties['id'].ToString
          )
        );
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_login_county_coord.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_login_county_coord.DropDownList_county_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('county_user_id');
  session.Add('county_user_id',DropDownList_county.SelectedValue);
  session.Remove('county_name');
  session.Add('county_name',DropDownList_county.SelectedItem.Text);
end;

procedure TWebForm_login_county_coord.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login_county_coord.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_match_account: borland.data.provider.BdpCommand;
  be_stale_password_obj: System.Object;
begin
  bdpCommand_match_account := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password FROM county_user '
    +  'where id="' + DropDownList_county.SelectedValue + '" '
    +     'and encoded_password=sha("' + TextBox_password.Text + '")'
    ,AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  be_stale_password_obj := bdpCommand_match_account.ExecuteScalar;
  AppCommon.BdpConnection.Close;
  if be_stale_password_obj <> nil then
    if be_stale_password_obj.ToString = '0' then
      server.Transfer('county_appropriation.aspx')
    else
      server.Transfer('change_password.aspx')
  else // be_stale_password_obj = nil
    if DropDownList_county.SelectedIndex <> 0 then
      invalid_credentials_warning.Visible := TRUE;
  end;

end.
