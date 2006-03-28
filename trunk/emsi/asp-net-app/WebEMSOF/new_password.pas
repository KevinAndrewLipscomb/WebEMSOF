
unit new_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon,
  Borland.Data.Provider, system.web.mail, system.configuration;

type
  TWebForm_new_password = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_account_name: System.Web.UI.WebControls.Label;
    Label_email_address: System.Web.UI.WebControls.Label;
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
procedure TWebForm_new_password.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_new_password.Page_Load(sender: System.Object; e: System.EventArgs);
type
  byte_array_type = array of byte;
var
  BdPCommand_temporarify_password: borland.data.provider.bdpcommand;
  BdpCommand_get_email_address: borland.data.provider.BdpCommand;
  Object_email_address: system.Object;
  temporary_password: string[8];
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - new_password';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    Label_account_name.Text := session.Item['account_descriptor'].ToString;
    //
    // Build a suitably-random password string.
    //
    temporary_password := System.Guid.NewGuid.ToString.Substring(0,8);
    //
    // Make the password string the service's new temporary password, and set the stale flag to force an immediate password change.
    //
    BdpCommand_temporarify_password := borland.data.provider.bdpcommand.Create
      (
      'update webemsof_account_master '
      + 'set encoded_password=sha("' + temporary_password + '"),'
      +   'be_stale_password=TRUE '
      + 'where id=' + session.Item['account_id'].ToString,
      AppCommon.BdpConnection
      );
    BdpCommand_temporarify_password.ExecuteNonQuery;
    //
    // Send the new password to the service's email address of record.
    //
    BdpCommand_get_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address from webemsof_account_master '
      + 'where id ="' + session.Item['account_id'].ToString + '"',
      AppCommon.BdpConnection
      );
    Object_email_address := BdpCommand_get_email_address.ExecuteScalar;
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      ConfigurationSettings.AppSettings['sender_email_address'],
      Object_email_address.ToString,
      ConfigurationSettings.AppSettings['application_name'] + ' temp password',
      'Someone at the host known as ' + request.UserHostName + ' (possibly you) requested a new password for the '
      + session.Item['account_descriptor'].ToString + ' account on the ' + ConfigurationSettings.AppSettings['application_name']
      + ' system.  Please log into ' + ConfigurationSettings.AppSettings['application_name'] + ' using the '
      + 'following credentials.  You will receive further instructions at that time.' + NEW_LINE
      + NEW_LINE
      + '   Account:  ' + session.Item['account_descriptor'].ToString + NEW_LINE
      + '   Password: ' + temporary_password + NEW_LINE
      + NEW_LINE
      + 'The ' + ConfigurationSettings.AppSettings['application_name'] + ' login page is located at:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + '/login.aspx' + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    // Set Label_email_address.
    //
    Label_email_address.Text := Object_email_address.ToString;
    //
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_new_password.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

end.

