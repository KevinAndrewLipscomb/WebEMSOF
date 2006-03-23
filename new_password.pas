
unit new_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon,
  Borland.Data.Provider, system.web.mail;

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
    BdpConnection1: Borland.Data.Provider.BdpConnection;
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
  Self.BdpConnection1 := Borland.Data.Provider.BdpConnection.Create;
  // 
  // BdpConnection1
  // 
  Self.BdpConnection1.ConnectionOptions := 'transaction isolation=ReadCommit' +
  'ted';
  Self.BdpConnection1.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=egalmess;provider=MySQL (Core Lab);hostname=db4' +
  'free.org';
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_new_password.Page_Load(sender: System.Object; e: System.EventArgs);
var
  BdPCommand_temporarify_password: borland.data.provider.bdpcommand;
  BdpCommand_get_email_address: borland.data.provider.BdpCommand;
  MailMessage_new_password: system.web.mail.MailMessage;
  temporary_password: string[8];
begin
  Title.InnerText := 'WebEMSOF - new_password';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Label_account_name.Text := session.Item['account'].ToString;
    //
    // Build a suitably-random password string.
    //
    temporary_password := System.Guid.NewGuid.ToString.Substring(1,8);
    //
    // Make the password string the service's new temporary password, and set the stale flag to force an immediate password change.
    //
    BdpCommand_temporarify_password := borland.data.provider.bdpcommand.Create
      (
      'update response_agency '
      + 'set encoded_password=sha("' + temporary_password + '"),'
      +   'be_stale_password=TRUE '
      + 'where id="' + session.Item['id'].ToString + '"',
      BdpConnection1
      );
    BdpCommand_temporarify_password.ExecuteNonQuery;
    //
    // Send the new password to the service's email address of record.
    //
    BdpCommand_get_email_address := borland.data.provider.bdpcommand.Create
      (
      'select webemsof_primary_email_address from response_agency where id ="' + session.Item['id'].ToString + '"',
      BdpConnection1
      );
    MailMessage_new_password := system.web.mail.mailmessage.Create;
    MailMessage_new_password.&To := BdpCommand_get_email_address.ExecuteScalar.ToString;
    MailMessage_new_password.Subject := 'WebEMSOF temp password';
    MailMessage_new_password.Body :=
      'Someone (possibly you) requested a new WebEMSOF password for the ' + session.Item['account'].ToString + ' account.  Please '
      + 'log into WebEMSOF using the following credentials.  You will then have to pick a permanent password that you are likely '
      + 'to remember.'
      + '   Account:  ' + session.Item['account'].ToString
      + '   Password: ' + temporary_password;
    SmtpMail.Send(MailMessage_new_password);
    //
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

