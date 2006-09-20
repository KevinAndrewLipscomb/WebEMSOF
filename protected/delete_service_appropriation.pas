
unit delete_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common, system.configuration, borland.data.provider,
  system.web.mail, system.web.security;

const ID = '$Id$';

type
  TWebForm_delete_service_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_county_dictated_appropriations_Click(sender: System.Object; 
      e: System.EventArgs);
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
    Label_application_name: System.Web.UI.WebControls.Label;
    Label_service_name_2: System.Web.UI.WebControls.Label;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_county_dictated_appropriations: System.Web.UI.WebControls.LinkButton;
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
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_county_dictated_appropriations.Click, Self.LinkButton_county_dictated_appropriations_Click);
  Include(Self.Button_yes.Click, Self.Button_yes_Click);
  Include(Self.Button_no.Click, Self.Button_no_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_delete_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.bdpdatareader;
  service_name: string;
begin
  if request.servervariables['URL'] = request.currentexecutionfilepath then begin
    session.Clear;
    server.Transfer('~/login.aspx');
  end;
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    ki.common.DbOpen;
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - delete_service_appropriation';
    //
    // Set Label_service_name_*.
    //
    service_name := session['service_name_of_appropriation_selected_for_deletion'].tostring;
    Label_service_name_1.text := service_name;
    Label_service_name_2.text := service_name;
    Label_application_name.text := configurationsettings.appsettings['application_name'];
    //
    // Set appropriation attribute labels.
    //
    bdr := borland.data.provider.bdpcommand.Create
      (
      'select designator,county_dictated_appropriation.amount'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' where county_dictated_appropriation.id = '
      +     session['id_of_appropriation_selected_for_deletion'].tostring,
      ki.common.db
      )
      .ExecuteReader;
    bdr.Read;
    Label_fiscal_year.text := bdr['designator'].tostring;
    Label_amount.text := decimal.Parse(session['amount_of_appropriation_selected_for_deletion'].tostring).tostring('C');
    //
    ki.common.DbClose;
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

procedure TWebForm_delete_service_appropriation.LinkButton_county_dictated_appropriations_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_delete_service_appropriation.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_delete_service_appropriation.Button_yes_Click(sender: System.Object;
  e: System.EventArgs);
begin
  ki.common.DbOpen;
  //
  // Send the notification message.
  //
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  smtpmail.Send
    (
    ConfigurationSettings.AppSettings['sender_email_address'],
    session['email_address_of_service_of_appropriation_selected_for_deletion'].tostring,
    'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' allocation for your service',
    'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF allocation from your '
    + 'service for ' + Safe(Label_fiscal_year.text,ALPHANUM) + '.' + NEW_LINE
    + NEW_LINE
    + 'NOTE that the equipment request(s) that you had already entered against this allocation were also deleted.  WebEMSOF had '
    + 'made the County Coordinator aware that this would happen.' + NEW_LINE
    + NEW_LINE
    + 'You can view your allocations by visiting:' + NEW_LINE
    + NEW_LINE
    + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
    + ConfigurationSettings.AppSettings['application_name'] + NEW_LINE
    + NEW_LINE
    + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
    + NEW_LINE
    + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
    + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
  //
  borland.data.provider.bdpcommand.Create
    (
    'delete from county_dictated_appropriation where id = '
    + session['id_of_appropriation_selected_for_deletion'].tostring,
    ki.common.db
    )
    .ExecuteNonQuery;
  //
  ki.common.DbClose;
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_delete_service_appropriation.Button_no_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

end.

