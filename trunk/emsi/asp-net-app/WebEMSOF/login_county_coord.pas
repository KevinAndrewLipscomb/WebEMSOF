
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
    RegularExpressionValidator_password: System.Web.UI.WebControls.RegularExpressionValidator;
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
  bdr: borland.data.provider.BdpDataReader;
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
    bdr := bdpCommand_get_counties.ExecuteReader;
    while bdr.Read do
      DropDownList_county.Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
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
  session.Add('county_user_id',Safe(DropDownList_county.SelectedValue,NUM));
  session.Remove('county_name');
  session.Add('county_name',Safe(DropDownList_county.SelectedItem.Text,ALPHA));
end;

procedure TWebForm_login_county_coord.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login_county_coord.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  bc_match_account: borland.data.provider.BdpCommand;
  bc_get_appropriation_ids: borland.data.provider.BdpCommand;
  bc_get_max_fiscal_year_id: borland.data.provider.BdpCommand;
  bdr_appropriation_ids: borland.data.provider.BdpDataReader;
  bdr_county_user_attribs: borland.data.provider.BdpDataReader;
  county_user_email_address: string;
  max_fiscal_year_id_obj: System.Object;
begin
  bc_match_account := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password, password_reset_email_address FROM county_user '
    +  'where id="' + DropDownList_county.SelectedValue + '" '
    +     'and encoded_password=sha("' + Safe(TextBox_password.Text.Trim,ALPHANUM) + '")'
    ,AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  bdr_county_user_attribs := bc_match_account.ExecuteReader;
  if bdr_county_user_attribs.Read then begin
    if bdr_county_user_attribs['be_stale_password'].ToString = '0' then begin
      //
      // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
      // time.
      //
      county_user_email_address := bdr_county_user_attribs['password_reset_email_address'].tostring;
      bdr_county_user_attribs.Close;
      //
      // The password is not stale.  Where we go next depends on how many appropriations have been made to this county.
      //
      // Determine current fiscal year
      //
      bc_get_max_fiscal_year_id := borland.data.provider.bdpcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        AppCommon.BdpConnection
        );
      max_fiscal_year_id_obj := bc_get_max_fiscal_year_id.ExecuteScalar;
      //
      bc_get_appropriation_ids := borland.data.provider.bdpcommand.Create
        (
        'SELECT region_dictated_appropriation.id'
        + ' FROM region_dictated_appropriation'
        +   ' JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id)'
        +   ' JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)'
        + ' WHERE county_code = ' + session.Item['county_user_id'].ToString
        +   ' and fiscal_year_id >= (' + max_fiscal_year_id_obj.ToString + ' - 1)',
        appcommon.bdpconnection
        );
      bdr_appropriation_ids := bc_get_appropriation_ids.ExecuteReader;
      if not bdr_appropriation_ids.Read then begin
        AppCommon.BdpConnection.Close;
        server.Transfer('no_appropriation.aspx');
      end else begin
        //
        // This county has received at least one appropriation.  Add its id to the session in case it's the only one.  If this isn't
        // the only appropriation, the id will be replaced by the choose_county_appropriation form.
        //
        session.Remove('region_dictated_appropriation_id');
        session.Add('region_dictated_appropriation_id',bdr_appropriation_ids['id'].tostring);
        //
        // Also add the county's email address to the session, as it will be needed by county_dictated_appropriations however we
        // get there.
        //
        session.Remove('county_user_password_reset_email_address');
        session.Add('county_user_password_reset_email_address',county_user_email_address);
        //
        if bdr_appropriation_ids.Read then begin
          AppCommon.BdpConnection.Close;
          server.Transfer('choose_county_appropriation.aspx');
        end else begin
          AppCommon.BdpConnection.Close;
          server.Transfer('county_dictated_appropriations.aspx');
        end;
      end;
    end else begin
      AppCommon.BdpConnection.Close;
      server.Transfer('change_password.aspx');
    end;
  end else begin
    // nothing to read -- could not find any record with those credentials
    if DropDownList_county.SelectedIndex <> 0 then begin
      invalid_credentials_warning.Visible := TRUE;
    end;
  end;
  AppCommon.BdpConnection.Close;
end;

end.
