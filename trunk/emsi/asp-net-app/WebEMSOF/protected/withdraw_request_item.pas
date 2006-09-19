
unit withdraw_request_item;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  ki.common,
  borland.data.provider,
  system.configuration,
  system.web.mail,
  system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    saved_emsof_ante: decimal;
    saved_shortage: decimal;
    END;
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

uses
  Class_biz_accounts;

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
  if (session['p'] = nil)
    or (session['emsof_request_item_additional_service_ante'] = nil)
    or (session['emsof_request_item_emsof_ante'] = nil)
    or (session['emsof_request_item_equipment_category'] = nil)
    or (session['emsof_request_item_make_model'] = nil)
    or (session['emsof_request_item_priority'] = nil)
    or (session['emsof_request_master_id'] = nil)
    or (session['emsof_request_master_status'] = nil)
    or (session['fiscal_year_designator'] = nil)
    or (session['service_name'] = nil)
    or (session['service_user_id'] = nil)
    or (session['sponsor_county'] = nil)
  then begin
    session.Clear;
    server.Transfer('~/login.aspx');
  end;
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - withdraw_request_item';
    //
    p.saved_emsof_ante := decimal.Parse(session['emsof_request_item_emsof_ante'].tostring);
    p.saved_shortage := decimal.Parse(session['emsof_request_item_additional_service_ante'].tostring);
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

procedure TWebForm_withdraw_request_item.Button_yes_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
var
  biz_accounts: TClass_biz_accounts;
  service_email_address: string;
begin
  ki.common.DbOpen;
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
    +   ' , shortage = shortage - ' + p.saved_shortage.tostring
    + ' where id = ' + session['emsof_request_master_id'].tostring
    + ';'
    + 'COMMIT;',
    ki.common.db
    )
    .ExecuteNonQuery;
  ki.common.DbClose;
  //
  // Send the notification message.
  //
  biz_accounts := TClass_biz_accounts.Create;
  service_email_address := biz_accounts.EmailAddressByKindId('service',session['service_user_id'].tostring);
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  smtpmail.Send
    (
    ConfigurationSettings.AppSettings['sender_email_address'],
    biz_accounts.EmailTargetByRole('emsof-request-withdrawal-stakeholder'),
    'Withdrawal of EMSOF request item',
    session['service_name'].ToString + ' has withdrawn a(n) "' + Label_description.text + '" item from their '
    + session['fiscal_year_designator'].tostring + ' EMSOF request.  The associated sponsor county is '
    + session['sponsor_county'].tostring + ' and the status of this service''s EMSOF request is "'
    + session['emsof_request_master_status'].tostring + '".' + NEW_LINE
    + NEW_LINE
    + session['service_name'].ToString + ' is aware that this action effectively surrenders ' + Label_emsof_ante.text
    + ' of EMSOF matching funds for use by others.' + NEW_LINE
    + NEW_LINE
    + 'You can see the effect of this action by visiting:' + NEW_LINE
    + NEW_LINE
    + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
    + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/regional_staffer_overview.aspx'
    + NEW_LINE
    + NEW_LINE
    + 'You can contact the ' + session['service_name'].ToString + ' EMSOF Coordinator at:' + NEW_LINE
    + NEW_LINE
    + '   ' + service_email_address + '  (mailto:' + service_email_address + ')' + NEW_LINE
    + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
  //
  server.Transfer('request_overview.aspx');
end;

end.

