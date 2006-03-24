
unit new_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon,
  Borland.Data.Provider, system.web.mail, Vault;

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
const
  NEW_LINE: string = #10;
var
  Object_affiliate_num: system.object;
  BdpCommand_get_affiliate_num: borland.data.provider.BdpCommand;
  BdPCommand_temporarify_password: borland.data.provider.bdpcommand;
  BdpCommand_get_email_address: borland.data.provider.BdpCommand;
  temporary_password: string[8];
begin
  Title.InnerText := 'WebEMSOF - new_password';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    Label_account_name.Text := session.Item['account_descriptor'].ToString;
    //
    // Prepare a BdpCommand to get the appropriate affiliate_num.
    //
    BdpCommand_get_affiliate_num := borland.data.provider.bdpcommand.Create
      (
      'select affiliate_num from emsof_sponsorship where id = "' + session.Item['emsof_sponsorship_id'].ToString + '"',
      AppCommon.BdpConnection
      );
    Object_affiliate_num := BdpCommand_get_affiliate_num.ExecuteScalar;
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
      + 'where affiliate_num="' + Object_affiliate_num.ToString + '"',
      AppCommon.BdpConnection
      );
    BdpCommand_temporarify_password.ExecuteNonQuery;
    //
    // Send the new password to the service's email address of record.
    //
    BdpCommand_get_email_address := borland.data.provider.bdpcommand.Create
      (
      'select webemsof_primary_email_address from response_agency where affiliate_num ="' + Object_affiliate_num.ToString + '"',
      AppCommon.BdpConnection
      );
    smtpmail.SmtpServer := 'mail.messagingengine.com';
    smtpmail.Send
      (
      'WebEMSOF',
      BdpCommand_get_email_address.ExecuteScalar.ToString,
      'WebEMSOF temp password',
      'Someone (possibly you) requested a new WebEMSOF password for the ' + session.Item['account_descriptor'].ToString
      + ' account.  Please log into WebEMSOF using the following credentials.  You will receive further instructions at that time.'
      + NEW_LINE
      + NEW_LINE
      + '   Account:  ' + session.Item['account_descriptor'].ToString + NEW_LINE
      + '   Password: ' + temporary_password + NEW_LINE
      + NEW_LINE
      + '-- WebEMSOF'
      );
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

