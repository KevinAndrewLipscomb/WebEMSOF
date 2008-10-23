unit withdraw_request_item;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  kix,
  mysql.data.mysqlclient,
  Class_db,
  Class_db_trail,
  system.configuration,
  system.web.mail,
  system.web.security;

type
  TWebForm_withdraw_request_item = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_withdraw_request_item_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        db: TClass_db;
        db_trail: TClass_db_trail;
        saved_emsof_ante: decimal;
        saved_shortage: decimal;
        END;
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
  protected
    procedure OnInit(e: EventArgs); override;
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
  Include(Self.Button_yes.Click, Self.Button_yes_Click);
  Include(Self.Button_no.Click, Self.Button_no_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_withdraw_request_item_PreRender);
end;
{$ENDREGION}

procedure TWebForm_withdraw_request_item.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback then begin
    if assigned(session['withdraw_request_item.p']) then begin
      p := p_type(session['withdraw_request_item.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - withdraw_request_item';
    //
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    p.saved_emsof_ante := decimal.Parse(session['emsof_request_item_emsof_ante'].tostring);
    p.saved_shortage := decimal.Parse(session['emsof_request_item_additional_service_ante'].tostring);
    //
    Label_priority.text := session['emsof_request_item_priority'].tostring;
    Label_description.text := session['emsof_request_item_make_model'].tostring + SPACE
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
  SessionSet('withdraw_request_item.p',p);
end;

procedure TWebForm_withdraw_request_item.Button_no_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack(2);
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
  p.db.Open;
  mysqlcommand.Create
    (
    p.db_trail.Saved
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
      + 'COMMIT;'
      ),
    p.db.connection
    )
    .ExecuteNonQuery;
  p.db.Close;
  //
  // Send the notification message.
  //
  biz_accounts := TClass_biz_accounts.Create;
  service_email_address := biz_accounts.EmailAddressByKindId('service',session['service_user_id'].tostring);
  kix.SmtpMailSend
    (
    configurationmanager.AppSettings['sender_email_address'],
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
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
    + NEW_LINE
    + 'You can contact the ' + session['service_name'].ToString + ' EMSOF Coordinator at:' + NEW_LINE
    + NEW_LINE
    + '   ' + service_email_address + '  (mailto:' + service_email_address + ')' + NEW_LINE
    + NEW_LINE
    + '-- ' + configurationmanager.AppSettings['application_name'],
    // be_html
    FALSE,
    // cc
    EMPTY,
    // bcc
    EMPTY,
    // reply_to
    service_email_address
    );
  //
  BackTrack(2);
end;

end.
