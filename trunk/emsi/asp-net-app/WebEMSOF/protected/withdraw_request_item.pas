
unit withdraw_request_item;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.mail,
  borland.data.provider, system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    saved_emsof_ante: decimal;
    END;

type
  TWebForm_withdraw_request_item = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_withdraw_request_item_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
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
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_request_item_detail: System.Web.UI.WebControls.HyperLink;
    procedure OnInit(e: EventArgs); override;
  private
  public
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_withdraw_request_item.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Button_yes.Click, Self.Button_yes_Click);
  Include(Self.Button_no.Click, Self.Button_no_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_withdraw_request_item_PreRender);
end;
{$ENDREGION}

procedure TWebForm_withdraw_request_item.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback then begin
    p := p_type(session['p']);
  end else begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - withdraw_request_item';
    //
    p.saved_emsof_ante := decimal.Parse(session['emsof_request_item_emsof_ante'].tostring);
    //
    Label_priority.text := session['emsof_request_item_priority'].tostring;
    Label_description.text := session['emsof_request_item_make_model'].tostring + ' '
    + session['emsof_request_item_equipment_category'].tostring;
    Label_emsof_ante.text := p.saved_emsof_ante.tostring('C');
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

procedure TWebForm_withdraw_request_item.TWebForm_withdraw_request_item_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_withdraw_request_item.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
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
    + ' where master_id = ' + session['emsof_request_master_id'].tostring
    +   ' and priority = ' + session['emsof_request_item_priority'].tostring
    + ';'
    + 'update emsof_request_master'
    + ' set value = value - ' + p.saved_emsof_ante.tostring
    + ' where id = ' + session['emsof_request_master_id'].tostring
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
  bdr.Read;
  recipient_list_string := bdr['email_address'].tostring;
  while bdr.Read do begin
    recipient_list_string := recipient_list_string + ',' + bdr['email_address'].tostring;
  end;
  //
  //   Get the service's email address.
  //
  service_email_address := borland.data.provider.bdpcommand.Create
    ('select password_reset_email_address from service_user where id = ' + session['service_user_id'].tostring,appcommon.db)
    .ExecuteScalar.tostring;
  //
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  smtpmail.Send
    (
    service_email_address,
    recipient_list_string,
    'Withdrawal of EMSOF request item',
    session['service_name'].ToString + ' has withdrawn a(n) "' + Label_description.text + '" item from their '
    + session['fiscal_year_designator'].tostring + ' EMSOF request.  The associated sponsor county is '
    + session['sponsor_county'].tostring + ' and the status of this service''s EMSOF request is "'
    + session['emsof_request_master_status'].tostring + '".' + NEW_LINE
    + NEW_LINE
    + session['service_name'].ToString + ' is aware that this action effectively surrenders ' + Label_emsof_ante.text
    + ' of EMSOF matching funds back to the Regional Council.' + NEW_LINE
    + NEW_LINE
    + 'You can see the effect of this action by visiting:' + NEW_LINE
    + NEW_LINE
    + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
    + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/county_overview.aspx' + NEW_LINE
    + NEW_LINE
    + 'Replies to this message will be addressed to the ' + session['service_name'].ToString + ' EMSOF Coordinator.'
    + NEW_LINE
    + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
  //
  appcommon.DbClose;
  server.Transfer('request_overview.aspx');
end;

end.

