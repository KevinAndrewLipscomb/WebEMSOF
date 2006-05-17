
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
begin
  appcommon.DbOpen;
//  //
//  // Send the notification message.
//  //
//  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
//  smtpmail.Send
//    (
//    session.item['county_user_password_reset_email_address'].tostring,
//    session.item['email_address_of_service_of_appropriation_selected_for_deletion'].tostring,
//    'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
//    'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF appropriation from your '
//    + 'service for ' + Safe(Label_fiscal_year.text,ALPHANUM) + '.' + NEW_LINE
//    + NEW_LINE
//    + 'NOTE that the equipment request(s) that you had already entered against this appropriation were also deleted.  This was '
//    + 'done with the County Coordinator''s knowledge.' + NEW_LINE
//    + NEW_LINE
//    + 'You can use ' + ConfigurationSettings.AppSettings['application_name'] + ' by visiting:' + NEW_LINE
//    + NEW_LINE
//    + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
//    + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '.htm' + NEW_LINE
//    + NEW_LINE
//      + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
//      + NEW_LINE
//      + NEW_LINE
//    + '-- ' + ConfigurationSettings.AppSettings['application_name']
//    );
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
  appcommon.DbClose;
  server.Transfer('request_overview.aspx');
end;

end.

