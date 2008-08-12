unit salogin;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  kix, System.Globalization,
  System.Data.SqlClient, System.Data.Common, system.configuration,
  system.text.regularexpressions, system.web.security, system.io,
  Class_biz_accounts;

const ID = '$Id$';

type
  p_type =
    RECORD
    biz_accounts: TClass_biz_accounts;
    END;
  TWebForm_salogin = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_user_kind_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure DropDownList_user_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
    procedure CustomValidator_account_exists_ServerValidate(source: System.Object; 
      args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure TWebForm_salogin_PreRender(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
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
    Label_application_name: System.Web.UI.WebControls.Label;
    DropDownList_user_kind: System.Web.UI.WebControls.DropDownList;
    Label_user: System.Web.UI.WebControls.Label;
    DropDownList_user: System.Web.UI.WebControls.DropDownList;
    RegularExpressionValidator_user_kind: System.Web.UI.WebControls.RegularExpressionValidator;
    TextBox_noop_ie_behavior_workaround: System.Web.UI.WebControls.TextBox;
    CustomValidator_account_exists: System.Web.UI.WebControls.CustomValidator;
    RegularExpressionValidator_user: System.Web.UI.WebControls.RegularExpressionValidator;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_salogin.InitializeComponent;
begin
  Include(Self.CustomValidator_account_exists.ServerValidate, Self.CustomValidator_account_exists_ServerValidate);
  Include(Self.DropDownList_user_kind.SelectedIndexChanged, Self.DropDownList_user_kind_SelectedIndexChanged);
  Include(Self.DropDownList_user.SelectedIndexChanged, Self.DropDownList_user_SelectedIndexChanged);
  Include(Self.Button_log_in.Click, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_salogin_PreRender);
end;
{$ENDREGION}

procedure TWebForm_salogin.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback then begin
    if assigned(session['p']) then begin
      p := p_type(session['p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - salogin';
    Label_application_name.text := configurationmanager.appsettings['application_name'];
    p.biz_accounts := TClass_biz_accounts.Create;
  end;
end;

procedure TWebForm_salogin.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_salogin.TWebForm_salogin_PreRender(sender: System.Object; e: System.EventArgs);
begin
  SessionSet('p',p);
end;

procedure TWebForm_salogin.CustomValidator_account_exists_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := p.biz_accounts.BeValidSysAdminCredentials
    (
    kix.Digest(Safe(TextBox_password.Text.trim,ALPHANUM))
    );
end;

procedure TWebForm_salogin.DropDownList_user_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove(DropDownList_user_kind.selectedvalue + '_user_id');
  session.Add(DropDownList_user_kind.selectedvalue + '_user_id',Safe(DropDownList_user.SelectedValue,NUM));
  session.Remove(DropDownList_user_kind.selectedvalue + '_name');
  session.Add(DropDownList_user_kind.selectedvalue + '_name',Safe(DropDownList_user.SelectedItem.Text,ORG_NAME));
end;

procedure TWebForm_salogin.DropDownList_user_kind_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('target_user_table',Safe(DropDownList_user_kind.selectedvalue,ECMASCRIPT_WORD));
  Label_user.enabled := TRUE;
  if DropDownList_user_kind.selectedvalue = 'service' then begin
    Label_user.text := 'Service';
    p.biz_accounts.BindServices(DropDownList_user);
  end else if DropDownList_user_kind.selectedvalue = 'county' then begin
    Label_user.text := 'County';
    p.biz_accounts.BindCounties(DropDownList_user);
  end else if DropDownList_user_kind.selectedvalue = 'regional_staffer' then begin
    Label_user.text := 'Regional staffer';
    p.biz_accounts.BindRegionalStaffers(DropDownList_user);
  end else begin
    session.Remove('target_user_table');
    Label_user.enabled := FALSE;
    Label_user.text := 'User';
    DropDownList_user.items.Clear;
  end;
end;

procedure TWebForm_salogin.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_salogin.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
begin
  if page.isvalid then begin
    //
    // Set username in session for the benefit of the TableRow_account_control in UserControl_precontent.
    //
    SessionSet('username',Safe(DropDownList_user.SelectedItem.Text,ORG_NAME));
    //
    formsauthentication.RedirectFromLoginPage
      (Safe(DropDownList_user.selectedvalue,HYPHENATED_ALPHANUM),CheckBox_keep_me_logged_in.checked);
    //
  end;
end;

end.
