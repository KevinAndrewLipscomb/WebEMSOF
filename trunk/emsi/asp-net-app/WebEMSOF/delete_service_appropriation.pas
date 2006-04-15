
unit delete_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider,
  system.web.mail;

type
  TWebForm_delete_service_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_literal_warning: System.Web.UI.WebControls.Label;
    Label_service_name_1: System.Web.UI.WebControls.Label;
    Button_yes: System.Web.UI.WebControls.Button;
    Button_no: System.Web.UI.WebControls.Button;
    Label_fiscal_year: System.Web.UI.WebControls.Label;
    Label_amount: System.Web.UI.WebControls.Label;
    Label_service_name_2: System.Web.UI.WebControls.Label;
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
procedure TWebForm_delete_service_appropriation.InitializeComponent;
begin
  Include(Self.Button_yes.Click, Self.Button_yes_Click);
  Include(Self.Button_no.Click, Self.Button_no_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_delete_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bc_get_appropriation_attributes: borland.data.provider.bdpcommand;
  bc_get_service_name: borland.data.provider.bdpcommand;
  bdr: borland.data.provider.bdpdatareader;
  service_name: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    appcommon.bdpconnection.Open;
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - delete_service_appropriation';
    //
    // Set Label_service_name_*.
    //
    bc_get_service_name := borland.data.provider.bdpcommand.Create
      (
      'select name from service join county_dictated_appropriation on (county_dictated_appropriation.service_id=service.id)'
      + ' where county_dictated_appropriation.id = '
      +     session.item['county_dictated_appropriation_id_selected_for_deletion'].tostring,
      appcommon.bdpconnection
      );
    service_name := bc_get_service_name.ExecuteScalar.tostring;
    Label_service_name_1.text := service_name;
    Label_service_name_2.text := service_name;
    //
    // Set appropriation attribute labels.
    //
    bc_get_appropriation_attributes := borland.data.provider.bdpcommand.Create
      (
      'select designator,county_dictated_appropriation.amount'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' where county_dictated_appropriation.id = '
      +     session.item['county_dictated_appropriation_id_selected_for_deletion'].tostring,
      appcommon.bdpconnection
      );
    bdr := bc_get_appropriation_attributes.ExecuteReader;
    bdr.Read;
    Label_fiscal_year.text := bdr['designator'].tostring;
    Label_amount.text := decimal(bdr['amount']).tostring('C');
    //
    appcommon.bdpconnection.Close;
    end;
end;

procedure TWebForm_delete_service_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_delete_service_appropriation.Button_yes_Click(sender: System.Object;
  e: System.EventArgs);
var
  bc_delete: borland.data.provider.bdpcommand;
  bc_get_cc_email_address: borland.data.provider.bdpcommand;
  bc_get_service_email_address: borland.data.provider.bdpcommand;
begin
  appcommon.bdpconnection.Open;
  //
  // Set up the notification message.  This must be done before we delete the appropriation.
  //
  //   Set up the command to get service's email address of record.
  bc_get_service_email_address := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address'
    + ' from service_user join county_dictated_appropriation on (county_dictated_appropriation.service_id=service_user.id)'
    + ' where county_dictated_appropriation.id =' + session.item['county_dictated_appropriation_id_selected_for_deletion'].tostring,
    AppCommon.BdpConnection
    );
  //   Since we're getting email addresses, let's get the County Coordinator's email address too.
  bc_get_cc_email_address := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address from county_user where id ="' + session.item['county_user_id'].tostring + '"',
    AppCommon.BdpConnection
    );
  //
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  smtpmail.Send
    (
    bc_get_cc_email_address.ExecuteScalar.tostring,
    bc_get_service_email_address.ExecuteScalar.tostring,
    'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
    'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF appropriation from your '
    + 'service for ' + Safe(Label_fiscal_year.text,ALPHANUM) + '.' + NEW_LINE
    + NEW_LINE
    + 'NOTE that the equipment request(s) that you had already entered against this appropriation were also deleted.  This was '
    + 'done with the County Coordinator''s knowledge.' + NEW_LINE
    + NEW_LINE
    + 'You can use ' + ConfigurationSettings.AppSettings['application_name'] + ' by visiting:' + NEW_LINE
    + NEW_LINE
    + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
    + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/main.aspx' + NEW_LINE
    + NEW_LINE
      + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
      + NEW_LINE
      + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
  //
  bc_delete := borland.data.provider.bdpcommand.Create
    (
    'delete from county_dictated_appropriation where id = '
    + session.item['county_dictated_appropriation_id_selected_for_deletion'].tostring,
    appcommon.bdpconnection
    );
  bc_delete.ExecuteNonQuery;
  //
  appcommon.bdpconnection.Close;
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_delete_service_appropriation.Button_no_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

end.

