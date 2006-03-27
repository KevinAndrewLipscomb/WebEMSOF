
unit change_email_address;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, borland.data.provider, system.configuration;

type
  TWebForm_change_email_address = class(System.Web.UI.Page)
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
    TextBox_nominal_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_confirmation_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_confirmation_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    CompareValidator1: System.Web.UI.WebControls.CompareValidator;
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
procedure TWebForm_change_email_address.InitializeComponent;
begin
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_change_email_address.Page_Load(sender: System.Object; e: System.EventArgs);
var
  BdpCommand_get_email_address: borland.data.provider.BdpCommand;
  Object_email_address: system.Object;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - change_email_address';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    //
    // Set Label_account descriptor
    //
    Label_account_descriptor.Text := session.Item['account_descriptor'].ToString;
    //
    // Preload email address fields
    //
    BdpCommand_get_email_address := borland.data.provider.BdpCommand.Create
      (
      'SELECT password_reset_email_address '
      + 'FROM emsof_sponsorship_webemsof_account '
      + 'WHERE emsof_sponsorship_id = "' + session.Item['account_id'].ToString + '"',
      AppCommon.BdpConnection
      );
    Object_email_address := BdpCommand_get_email_address.ExecuteScalar;
    TextBox_nominal_email_address.Text := Object_email_address.ToString;
    TextBox_confirmation_email_address.Text := Object_email_address.ToString;
    //
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_change_email_address.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_change_email_address.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
var
  BdpCommand_update_account: borland.data.provider.BdpCommand;
begin
  //
  // Commit the data to the database.
  //
  BdpCommand_update_account := borland.data.provider.bdpcommand.Create
    (
    'UPDATE emsof_sponsorship_webemsof_account '
    + 'SET password_reset_email_address = "' + TextBox_nominal_email_address.Text + '"'
    + 'WHERE emsof_sponsorship_id = "' + session.Item['account_id'].ToString + '"',
    AppCommon.BdpConnection
    );
  AppCommon.BdpConnection.Open;
  BdpCommand_update_account.ExecuteNonQuery;
  AppCommon.BdpConnection.Close;
  server.Transfer('account_overview.aspx');
end;

end.

