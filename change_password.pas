
unit change_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, borland.data.provider, system.configuration,
  borland.vcl.sysutils;

type
  TWebForm_change_password = class(System.Web.UI.Page)
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
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    Button_submit: System.Web.UI.WebControls.Button;
    TextBox_nominal_password: System.Web.UI.WebControls.TextBox;
    TextBox_confirmation_password: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_password: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_confirmation_password: System.Web.UI.WebControls.RequiredFieldValidator;
    CompareValidator1: System.Web.UI.WebControls.CompareValidator;
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
procedure TWebForm_change_password.InitializeComponent;
begin
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_change_password.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - change_password';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Label_account_descriptor.Text := session.Item[session.Item['target_user_table'].ToString + '_name'].ToString;
    end;
end;

procedure TWebForm_change_password.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_change_password.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
var
  BdpCommand_update_account: borland.data.provider.BdpCommand;
begin
  //
  // Commit the data to the database.
  //
  BdpCommand_update_account := borland.data.provider.bdpcommand.Create
    (
    'UPDATE ' + session.Item['target_user_table'].ToString + '_user '
    + 'SET encoded_password = sha("' + Safe(Trim(TextBox_nominal_password.Text),ALPHANUMERIC) + '"),'
    +   'be_stale_password = FALSE '
    + 'WHERE id = "' + session.Item[session.Item['target_user_table'].ToString + '_user_id'].ToString + '"',
    AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  BdpCommand_update_account.ExecuteNonQuery;
  AppCommon.BdpConnection.Close;
  server.Transfer(session.Item['target_user_table'].ToString + '_overview.aspx');
end;

end.

