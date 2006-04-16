
unit login_regional_staffer;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common, system.configuration;

type
  TWebForm_login_regional_staffer = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
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
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_new_password: System.Web.UI.WebControls.Button;
    DropDownList_regional_staffer: System.Web.UI.WebControls.DropDownList;
    RangeValidator_regional_staffer: System.Web.UI.WebControls.RangeValidator;
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
procedure TWebForm_login_regional_staffer.InitializeComponent;
begin
  Include(Self.DropDownList_regional_staffer.SelectedIndexChanged, Self.DropDownList_regional_staffer_SelectedIndexChanged);
  Include(Self.TextBox_password.TextChanged, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_login_regional_staffer.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - login_regional_staffer';
    session.Remove('target_user_table');
    session.Add('target_user_table','regional_staffer');
    AppCommon.BdpConnection.Open;
    invalid_credentials_warning.Visible := FALSE;
    //
    // Load DropDownList_account
    //
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
    AppCommon.BdpConnection.Close;
  end;
end;

procedure TWebForm_login_regional_staffer.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_login_regional_staffer.DropDownList_regional_staffer_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('regional_staffer_user_id');
  session.Add('regional_staffer_user_id',Safe(DropDownList_regional_staffer.SelectedValue,NUM));
  session.Remove('regional_staffer_name');
  session.Add('regional_staffer_name',Safe(DropDownList_regional_staffer.SelectedItem.Text,HUMAN_NAME_CSV));
end;

procedure TWebForm_login_regional_staffer.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login_regional_staffer.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  be_stale_password_obj: System.Object;
begin
  AppCommon.BdpConnection.Open;
  be_stale_password_obj := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password FROM regional_staffer_user '
    +  'where id="' + DropDownList_regional_staffer.SelectedValue + '" '
    +     'and encoded_password=sha("' + Safe(TextBox_password.Text.Trim,ALPHANUM) + '")'
    ,AppCommon.BdpConnection
    )
    .ExecuteScalar;
  AppCommon.BdpConnection.Close;
  if be_stale_password_obj <> nil then begin
    if be_stale_password_obj.ToString = '0' then begin
      server.Transfer('regional_staffer_appropriation.aspx');
    end else begin
      server.Transfer('change_password.aspx');
    end;
  end else begin // be_stale_password_obj = nil
    if DropDownList_regional_staffer.SelectedIndex <> 0 then begin
      invalid_credentials_warning.Visible := TRUE;
    end;
  end;
end;

end.
