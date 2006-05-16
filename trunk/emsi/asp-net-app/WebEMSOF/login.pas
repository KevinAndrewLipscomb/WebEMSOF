
unit login;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common, system.configuration,
  system.text.regularexpressions,system.web.security;

type
  TWebForm_login = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_service_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
    procedure DropDownList_county_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure DropDownList_regional_staffer_SelectedIndexChanged(sender: System.Object; 
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
    DropDownList_service: System.Web.UI.WebControls.DropDownList;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_new_password: System.Web.UI.WebControls.Button;
    RangeValidator_service: System.Web.UI.WebControls.RangeValidator;
    RegularExpressionValidator_password: System.Web.UI.WebControls.RegularExpressionValidator;
    DropDownList_county: System.Web.UI.WebControls.DropDownList;
    RangeValidator_county: System.Web.UI.WebControls.RangeValidator;
    DropDownList_regional_staffer: System.Web.UI.WebControls.DropDownList;
    RangeValidator_regional_staffer: System.Web.UI.WebControls.RangeValidator;
    TableRow_service: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_county: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_regional_staffer: System.Web.UI.HtmlControls.HtmlTableRow;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

const ID = '$Id$';

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_login.InitializeComponent;
begin
  Include(Self.DropDownList_service.SelectedIndexChanged, Self.DropDownList_service_SelectedIndexChanged);
  Include(Self.DropDownList_county.SelectedIndexChanged, Self.DropDownList_county_SelectedIndexChanged);
  Include(Self.DropDownList_regional_staffer.SelectedIndexChanged, Self.DropDownList_regional_staffer_SelectedIndexChanged);
  Include(Self.TextBox_password.TextChanged, Self.Button_log_in_Click);
  Include(Self.Button_log_in.Click, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_login.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - login';
    //
    invalid_credentials_warning.Visible := FALSE;
    TableRow_service.visible := FALSE;
    TableRow_county.visible := FALSE;
    TableRow_regional_staffer.visible := FALSE;
    //
    AppCommon.BdpConnection.Open;
    //
    if session.item['target_user_table'].tostring = 'service' then begin
      DropDownList_service.Items.Add(listitem.Create('-- Select --','0'));
      bdr := Borland.Data.Provider.BdpCommand.Create
        (
        'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active = TRUE ORDER BY name',
        AppCommon.BdpConnection
        )
        .ExecuteReader;
      while bdr.Read do begin
        DropDownList_service.Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
      end;
      TableRow_service.visible := TRUE;
    end else if session.item['target_user_table'].tostring = 'county' then begin
      DropDownList_county.Items.Add(listitem.Create('-- Select --','0'));
      bdr := Borland.Data.Provider.BdpCommand.Create
        (
        'SELECT id,name '
        + 'FROM county_user JOIN county_code_name_map on (county_code_name_map.code = county_user.id) '
        + 'WHERE be_active = TRUE '
        + 'ORDER BY name',
        AppCommon.BdpConnection
        )
        .ExecuteReader;
      while bdr.Read do begin
        DropDownList_county.Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
      end;
      TableRow_county.visible := TRUE;
    end else if session.item['target_user_table'].tostring = 'regional_staffer' then begin
      DropDownList_regional_staffer.Items.Add(listitem.Create('-- Select --','0'));
      bdr := Borland.Data.Provider.BdpCommand.Create
        (
        'SELECT id,last_name,first_name '
        + 'FROM regional_staffer_user JOIN regional_staffer using (id) '
        + 'WHERE be_active = TRUE '
        + 'ORDER BY last_name,first_name',
        AppCommon.BdpConnection
        )
        .ExecuteReader;
      while bdr.Read do begin
        DropDownList_regional_staffer.Items.Add
          (listitem.Create(bdr['last_name'].tostring + ', ' + bdr['first_name'].tostring,bdr['id'].ToString));
      end;
      TableRow_regional_staffer.visible := TRUE;
    end;
    //
    AppCommon.BdpConnection.Close;
    //
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

procedure TWebForm_login.DropDownList_regional_staffer_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('regional_staffer_user_id');
  session.Add('regional_staffer_user_id',Safe(DropDownList_regional_staffer.SelectedValue,NUM));
  session.Remove('regional_staffer_name');
  session.Add('regional_staffer_name',Safe(DropDownList_regional_staffer.SelectedItem.Text,HUMAN_NAME_CSV));
end;

procedure TWebForm_login.DropDownList_county_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('county_user_id');
  session.Add('county_user_id',Safe(DropDownList_county.SelectedValue,NUM));
  session.Remove('county_name');
  session.Add('county_name',Safe(DropDownList_county.SelectedItem.Text,ALPHA));
end;

procedure TWebForm_login.DropDownList_service_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('service_user_id');
  session.Add('service_user_id',Safe(DropDownList_service.SelectedValue,NUM));
  session.Remove('service_name');
  session.Add('service_name',Safe(DropDownList_service.SelectedItem.Text,ORG_NAME));
end;

procedure TWebForm_login.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  be_stale_password_obj: System.Object;
begin
  AppCommon.BdpConnection.Open;
  be_stale_password_obj := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password FROM ' + session.item['target_user_table'].tostring + '_user'
    +  ' where id=' + session.item[session.item['target_user_table'].tostring + '_user_id'].tostring
    +     ' and encoded_password=sha("' + Safe(TextBox_password.Text.trim,ALPHANUM) + '")'
    ,AppCommon.BdpConnection
    )
    .ExecuteScalar;
  AppCommon.BdpConnection.Close;
  if be_stale_password_obj <> nil then begin
    if be_stale_password_obj.ToString = '0' then begin
      //server.Transfer('service_overview.aspx')
      formsauthentication.RedirectFromLoginPage(DropDownList_service.selectedvalue,CheckBox_keep_me_logged_in.checked);
    end else begin
      server.Transfer('change_password.aspx')
    end;
  end else begin // be_stale_password_obj = nil
    invalid_credentials_warning.Visible := TRUE;
  end;
end;

end.
