
unit login;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common, system.configuration,
  system.text.regularexpressions, system.web.security, system.io;

type
  TWebForm_login = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_user_kind_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure DropDownList_user_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    TextBox_password: System.Web.UI.WebControls.TextBox;
    Button_log_in: System.Web.UI.WebControls.Button;
    CheckBox_keep_me_logged_in: System.Web.UI.WebControls.CheckBox;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_new_password: System.Web.UI.WebControls.Button;
    RegularExpressionValidator_password: System.Web.UI.WebControls.RegularExpressionValidator;
    invalid_credentials_warning: System.Web.UI.HtmlControls.HtmlGenericControl;
    Label_application_name: System.Web.UI.WebControls.Label;
    DropDownList_user_kind: System.Web.UI.WebControls.DropDownList;
    Label_user: System.Web.UI.WebControls.Label;
    DropDownList_user: System.Web.UI.WebControls.DropDownList;
    RangeValidator_username: System.Web.UI.WebControls.RangeValidator;
    RegularExpressionValidator_user_kind: System.Web.UI.WebControls.RegularExpressionValidator;
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
  Include(Self.DropDownList_user_kind.SelectedIndexChanged, Self.DropDownList_user_kind_SelectedIndexChanged);
  Include(Self.DropDownList_user.SelectedIndexChanged, Self.DropDownList_user_SelectedIndexChanged);
  Include(Self.Button_log_in.Click, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_login.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - login';
    Label_application_name.text := configurationsettings.appsettings['application_name'];
    invalid_credentials_warning.Visible := FALSE;
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

procedure TWebForm_login.DropDownList_user_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove(DropDownList_user_kind.selectedvalue + '_user_id');
  session.Add(DropDownList_user_kind.selectedvalue + '_user_id',Safe(DropDownList_user.SelectedValue,NUM));
  session.Remove(DropDownList_user_kind.selectedvalue + '_name');
  session.Add(DropDownList_user_kind.selectedvalue + '_name',Safe(DropDownList_user.SelectedItem.Text,ORG_NAME));
end;

procedure TWebForm_login.DropDownList_user_kind_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
begin
  appcommon.DbOpen;
  session.Remove('target_user_table');
  session.Add('target_user_table',Safe(DropDownList_user_kind.selectedvalue,ALPHA));
  Label_user.enabled := TRUE;
  DropDownList_user.items.Clear;
  DropDownList_user.items.Add(listitem.Create('-- Select --','0'));
  if DropDownList_user_kind.selectedvalue = 'service' then begin
    Label_user.text := 'Service';
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active = TRUE ORDER BY name',
      appcommon.db
      )
      .ExecuteReader;
    while bdr.Read do begin
      DropDownList_user.Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
    end;
  end else if DropDownList_user_kind.selectedvalue = 'county' then begin
    Label_user.text := 'County';
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT id,name '
      + 'FROM county_user JOIN county_code_name_map on (county_code_name_map.code = county_user.id) '
      + 'WHERE be_active = TRUE '
      + 'ORDER BY name',
      appcommon.db
      )
      .ExecuteReader;
    while bdr.Read do begin
      DropDownList_user.Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
    end;
  end else if DropDownList_user_kind.selectedvalue = 'regional_staffer' then begin
    Label_user.text := 'Regional staffer';
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT id,last_name,first_name '
      + 'FROM regional_staffer_user JOIN regional_staffer using (id) '
      + 'WHERE be_active = TRUE '
      + 'ORDER BY last_name,first_name',
      appcommon.db
      )
      .ExecuteReader;
    while bdr.Read do begin
      DropDownList_user.Items.Add
        (listitem.Create(bdr['last_name'].tostring + ', ' + bdr['first_name'].tostring,bdr['id'].ToString));
    end;
  end else begin
    session.Remove('target_user_table');
    Label_user.enabled := FALSE;
    Label_user.text := 'User';
    DropDownList_user.items.Clear;
  end;
  appcommon.DbClose;
end;

procedure TWebForm_login.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  obj: system.object;
begin
  appcommon.DbOpen;
  obj := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT 1 FROM ' + Safe(DropDownList_user_kind.selectedvalue,ALPHA) + '_user'
    +  ' where id = ' + Safe(DropDownList_user.selectedvalue,NUM)
    +     ' and encoded_password = "' + appcommon.Digest(Safe(TextBox_password.Text.trim,ALPHANUM)) + '"'
    ,appcommon.db
    )
    .ExecuteScalar;
  appcommon.DbClose;
  if obj <> nil then begin
    formsauthentication.RedirectFromLoginPage(Safe(DropDownList_user.selecteditem.text,NUM),CheckBox_keep_me_logged_in.checked);
  end else begin
    invalid_credentials_warning.Visible := TRUE;
  end;
end;

end.
