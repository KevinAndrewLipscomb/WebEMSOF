
unit change_email_address;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, borland.data.provider, system.configuration,
  system.net;

type
  TWebForm_change_email_address = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure CustomValidator1_ServerValidate(source: System.Object; args: System.Web.UI.WebControls.ServerValidateEventArgs);
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
    RegularExpressionValidator_nominal_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    Label_literal_county: System.Web.UI.WebControls.Label;
    CustomValidator1: System.Web.UI.WebControls.CustomValidator;
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
  Include(Self.CustomValidator1.ServerValidate, Self.CustomValidator1_ServerValidate);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_change_email_address.Page_Load(sender: System.Object; e: System.EventArgs);
var
  email_address: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - change_email_address';
    appcommon.DbOpen;
    //
    // Set Label_account descriptor
    //
    Label_account_descriptor.Text := session.Item[session.Item['target_user_table'].ToString + '_name'].ToString;
    //
    // Preload email address fields
    //
    email_address := borland.data.provider.BdpCommand.Create
      (
      'SELECT password_reset_email_address '
      + 'FROM ' + session.Item['target_user_table'].ToString + '_user '
      + 'WHERE id = "' + session.Item[session.Item['target_user_table'].ToString + '_user_id'].ToString + '"',
      appcommon.db
      )
      .ExecuteScalar.tostring;
    TextBox_nominal_email_address.Text := email_address;
    TextBox_confirmation_email_address.Text := email_address;
    //
    appcommon.DbClose;
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

procedure TWebForm_change_email_address.CustomValidator1_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := TRUE;
  try
    dns.GetHostByName(args.value);
  except
    args.isvalid := FALSE;
  end;
end;

procedure TWebForm_change_email_address.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
begin
  appcommon.DbOpen;
  //
  // Commit the data to the database.
  //
  borland.data.provider.bdpcommand.Create
    (
    'UPDATE ' + session.Item['target_user_table'].ToString + '_user '
    + 'SET password_reset_email_address = "' + Safe(TextBox_nominal_email_address.Text.Trim,EMAIL_ADDRESS) + '"'
    + 'WHERE id = "' + session.Item[session.Item['target_user_table'].ToString + '_user_id'].ToString + '"',
    appcommon.db
    )
    .ExecuteNonQuery;
  appcommon.DbClose;
  server.Transfer(session.Item['target_user_table'].ToString + '_overview.aspx');
end;

end.

