
unit withdraw_request_item;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.mail,
  borland.data.provider;

type
  TWebForm_withdraw_request_item = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_literal_warning: System.Web.UI.WebControls.Label;
    Button_yes: System.Web.UI.WebControls.Button;
    Button_no: System.Web.UI.WebControls.Button;
    Label_priority: System.Web.UI.WebControls.Label;
    Label_description: System.Web.UI.WebControls.Label;
    Label_emsof_ante: System.Web.UI.WebControls.Label;
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
procedure TWebForm_withdraw_request_item.InitializeComponent;
begin
  Include(Self.Button_yes.Click, Self.Button_yes_Click);
  Include(Self.Button_no.Click, Self.Button_no_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  saved_emsof_ante: decimal;

procedure TWebForm_withdraw_request_item.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - withdraw_request_item';
    //
    saved_emsof_ante := decimal.Parse(session.item['emsof_request_item_emsof_ante'].tostring);
    //
    Label_priority.text := session.item['emsof_request_item_priority'].tostring;
    Label_description.text := session.item['emsof_request_item_equipment_category'].tostring;
    Label_emsof_ante.text := saved_emsof_ante.tostring('C');
  end;
end;

procedure TWebForm_withdraw_request_item.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_withdraw_request_item.Button_no_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_withdraw_request_item.Button_yes_Click(sender: System.Object;
  e: System.EventArgs);
var
  bdr: borland.data.provider.bdpdatareader;
  recipient_list_string: string;
  service_email_address: string;
begin
  appcommon.DbOpen;
  //
  borland.data.provider.bdpcommand.Create
    (
    'START TRANSACTION;'
    + 'update emsof_request_detail'
    + ' set quantity = 0,'
    +   ' additional_service_ante = 0,'
    +   ' emsof_ante = 0,'
    +   ' status_code = 6'
    + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
    +   ' and priority = ' + session.item['emsof_request_item_priority'].tostring
    + ';'
    + 'update emsof_request_master'
    + ' set value = value - ' + saved_emsof_ante.tostring
    + ' where id = ' + session.Item['emsof_request_master_id'].tostring
    + ';'
    + 'COMMIT;',
    appcommon.db
    )
    .ExecuteNonQuery;
  //
  // Send the notification message.
  //
  //   Build the recipient list
  //
  bdr := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address as email_address'
    + ' from regional_staffer_user'
    +   ' join regional_staffer_role on (regional_staffer_role.regional_staffer_id=regional_staffer_user.id)'
    + ' where title = "emsof-request-item-withdrawal-notice-recipient"',
    appcommon.db
    )
    .ExecuteReader;
  recipient_list_string := system.string.EMPTY;
  while bdr.Read do begin
    recipient_list_string := recipient_list_string + bdr['email_address'].tostring;
  end;
  //
  //   Get the service's email address.
  //
  service_email_address := borland.data.provider.bdpcommand.Create
    ('select password_reset_email_address from service_user where id = ' + session.item['service_user_id'].tostring,appcommon.db)' +
    .ExecuteScalar.tostring;
  //
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  smtpmail.Send
    (
    service_email_address,
    recipient_list_string,
    'Withdrawal of EMSOF request item',
    session.Item['service_name'].ToString + ' has withdrawn a(n) "' + Label_description.text + '" item from their '
    + session.item['fiscal_year_designator'].tostring + ' EMSOF request.  The associated sponsor county is '
    + session.item['sponsor_county'].tostring + ' and the status of this service''s EMSOF request is '
    + session.item['emsof_request_master_status'].tostring + '.' + NEW_LINE
    + NEW_LINE
    + session.Item['service_name'].ToString + ' is aware that this action may result in the surrender ' + Label_emsof_ante.text
    + ' of EMSOF matching funds back to the Regional Council, depending on whether the relevant deadlines have passed.' + NEW_LINE
    + NEW_LINE
    + 'You can see the effect of this action by visiting:' + NEW_LINE
    + NEW_LINE
    + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
    + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/county_overview.aspx' + NEW_LINE
    + NEW_LINE
    + 'Replies to this message will be addressed to the ' + session.Item['service_name'].ToString + ' EMSOF Coordinator.'
    + NEW_LINE
    + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
  //
  appcommon.DbClose;
  server.Transfer('request_overview.aspx');
end;

end.

