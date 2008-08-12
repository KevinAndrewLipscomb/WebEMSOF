unit delete_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, mysql.data.mysqlclient,
  system.web.mail, system.web.security,
  Class_db,
  Class_db_trail;

const ID = '$Id$';

type
  p_type =
    RECORD
    db: TClass_db;
    db_trail: TClass_db_trail;
    END;
  TWebForm_delete_service_appropriation = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_no_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_yes_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_delete_service_appropriation_PreRender(sender: System.Object;
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
    Label_service_name_1: System.Web.UI.WebControls.Label;
    Button_yes: System.Web.UI.WebControls.Button;
    Button_no: System.Web.UI.WebControls.Button;
    Label_fiscal_year: System.Web.UI.WebControls.Label;
    Label_amount: System.Web.UI.WebControls.Label;
    Label_application_name: System.Web.UI.WebControls.Label;
    Label_service_name_2: System.Web.UI.WebControls.Label;
  protected
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
  Include(Self.PreRender, Self.TWebForm_delete_service_appropriation_PreRender);
end;
{$ENDREGION}

procedure TWebForm_delete_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr: mysqldatareader;
  service_name: string;
begin
  if IsPostback then begin
    if assigned(session['p']) then begin
      p := p_type(session['p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - delete_service_appropriation';
    //
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    //
    // Set Label_service_name_*.
    //
    service_name := session['service_name_of_appropriation_selected_for_deletion'].tostring;
    Label_service_name_1.text := service_name;
    Label_service_name_2.text := service_name;
    Label_application_name.text := configurationmanager.appsettings['application_name'];
    //
    // Set appropriation attribute labels.
    //
    p.db.Open;
    dr := mysqlcommand.Create
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
      p.db.connection
      )
      .ExecuteReader;
    dr.Read;
    Label_fiscal_year.text := dr['designator'].tostring;
    Label_amount.text := decimal.Parse(session['amount_of_appropriation_selected_for_deletion'].tostring).tostring('C');
    //
    dr.Close;
    p.db.Close;
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

procedure TWebForm_delete_service_appropriation.TWebForm_delete_service_appropriation_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

procedure TWebForm_delete_service_appropriation.Button_yes_Click(sender: System.Object;
  e: System.EventArgs);
begin
  p.db.Open;
  //
  // Send the notification message.
  //
  kix.SmtpMailSend
    (
    configurationmanager.AppSettings['sender_email_address'],
    session['email_address_of_service_of_appropriation_selected_for_deletion'].tostring,
    'Deletion of ' + configurationmanager.AppSettings['application_name'] + ' allocation for your service',
    'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF allocation from your '
    + 'service for ' + Safe(Label_fiscal_year.text,ALPHANUM) + PERIOD + NEW_LINE
    + NEW_LINE
    + 'NOTE that the equipment request(s) that you had already entered against this allocation were also deleted.  WebEMSOF had '
    + 'made the County Coordinator aware that this would happen.' + NEW_LINE
    + NEW_LINE
    + 'You can view your allocations by visiting:' + NEW_LINE
    + NEW_LINE
    + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
    + configurationmanager.AppSettings['application_name'] + NEW_LINE
    + NEW_LINE
    + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
    + NEW_LINE
    + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
    + NEW_LINE
    + '-- ' + configurationmanager.AppSettings['application_name']
    );
  //
  mysqlcommand.Create
    (
    p.db_trail.Saved
      (
      'delete from county_dictated_appropriation where id = '
      + session['id_of_appropriation_selected_for_deletion'].tostring
      ),
    p.db.connection
    )
    .ExecuteNonQuery;
  //
  p.db.Close;
  BackTrack;
end;

procedure TWebForm_delete_service_appropriation.Button_no_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

end.

