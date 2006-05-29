
unit new_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon,
  Borland.Data.Provider, system.web.mail, system.configuration;

const ID = '$Id$';

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
    Label_email_address: System.Web.UI.WebControls.Label;
    Label_user_name: System.Web.UI.WebControls.Label;
    Label_application_name: System.Web.UI.WebControls.Label;
    HyperLink_login: System.Web.UI.WebControls.HyperLink;
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
procedure TWebForm_new_password.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_new_password.Page_Load(sender: System.Object; e: System.EventArgs);
var
  email_address: string;
  temporary_password: string[8];
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - new_password';
    appcommon.DbOpen;
    Label_user_name.Text := session.Item[session.Item['target_user_table'].ToString + '_name'].ToString;
    if session.item['target_user_table'].tostring = 'county' then begin
      Label_user_name.Text := Label_user_name.Text + ' County';
    end;
    Label_application_name.text := configurationsettings.appsettings['application_name'];
    //
    // Build a suitably-random password string.
    //
    temporary_password := System.Guid.NewGuid.ToString.Substring(0,8);
    //
    // Make the password string the service's new temporary password, and set the stale flag to force an immediate password change.
    //
    borland.data.provider.bdpcommand.Create
      (
      'update ' + session.Item['target_user_table'].ToString + '_user'
      + ' set encoded_password = "' + appcommon.Digest(temporary_password) + '",'
      +   ' be_stale_password = TRUE '
      + ' where id = ' + session.Item[session.Item['target_user_table'].ToString + '_user_id'].ToString,
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    // Send the new password to the service's email address of record.
    //
    email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address from ' + session.Item['target_user_table'].ToString + '_user '
      + 'where id ="' + session.Item[session.Item['target_user_table'].ToString + '_user_id'].ToString + '"',
      appcommon.db
      )
      .ExecuteScalar.tostring;
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      ConfigurationSettings.AppSettings['sender_email_address'],
      email_address,
      ConfigurationSettings.AppSettings['application_name'] + ' temp password',
      'Someone at the host known as ' + Safe(request.UserHostName,HOSTNAME) + ' (possibly you) requested a new password for the "'
      + session.Item[session.Item['target_user_table'].ToString + '_name'].ToString + '" '
      + session.Item['target_user_table'].ToString + ' account on the ' + ConfigurationSettings.AppSettings['application_name']
      + ' system.  Please log into ' + ConfigurationSettings.AppSettings['application_name'] + ' using the following credentials.  '
      + 'You will receive further instructions at that time.' + NEW_LINE
      + NEW_LINE
      + '   ' + session.Item['target_user_table'].ToString + ':' + NEW_LINE
      + '      ' + session.Item[session.Item['target_user_table'].ToString + '_name'].ToString + NEW_LINE
      + '   password:' + NEW_LINE
      + '      ' + temporary_password + NEW_LINE
      + NEW_LINE
      + 'You can complete this process by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    // Set Label_email_address.
    //
    Label_email_address.Text := email_address;
    //
    appcommon.DbClose;
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

