
unit create_new_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider,
  system.web.mail, system.web.security;

type
  TWebForm_create_new_service_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_add_appropriation_and_repeat_Click(sender: System.Object;
      e: System.EventArgs);
    procedure Button_cancel_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_add_appropriation_and_stop_Click(sender: System.Object;
      e: System.EventArgs);
    procedure CheckBox_unfilter_CheckedChanged(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure AddAppropriation;
    procedure Bind_services;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    DropDownList_services: System.Web.UI.WebControls.DropDownList;
    RangeValidator_service: System.Web.UI.WebControls.RangeValidator;
    TextBox_new_amount: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_new_amount: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_new_amount: System.Web.UI.WebControls.RegularExpressionValidator;
    Button_add_appropriation_and_repeat: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_service: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_add_appropriation_and_stop: System.Web.UI.WebControls.Button;
    Button_cancel: System.Web.UI.WebControls.Button;
    CheckBox_unfilter: System.Web.UI.WebControls.CheckBox;
    RadioButtonList_match_level: System.Web.UI.WebControls.RadioButtonList;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_create_new_service_appropriation.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.CheckBox_unfilter.CheckedChanged, Self.CheckBox_unfilter_CheckedChanged);
  Include(Self.Button_add_appropriation_and_repeat.Click, Self.Button_add_appropriation_and_repeat_Click);
  Include(Self.Button_add_appropriation_and_stop.Click, Self.Button_add_appropriation_and_stop_Click);
  Include(Self.Button_cancel.Click, Self.Button_cancel_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_service_list_filtered: boolean;

procedure TWebForm_create_new_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - create_new_service_appropriation';
    //
    // Initialize implementation-scoped variables.
    //
    be_service_list_filtered := TRUE;
    //
    Bind_services;
  end;
end;

procedure TWebForm_create_new_service_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_create_new_service_appropriation.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_create_new_service_appropriation.CheckBox_unfilter_CheckedChanged(sender: System.Object; 
  e: System.EventArgs);
begin
  be_service_list_filtered := not CheckBox_unfilter.checked;
  Bind_services;
end;

procedure TWebForm_create_new_service_appropriation.Button_add_appropriation_and_stop_Click(sender: System.Object;
  e: System.EventArgs);
begin
  AddAppropriation;
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_create_new_service_appropriation.Button_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_create_new_service_appropriation.Button_add_appropriation_and_repeat_Click(sender: System.Object;
  e: System.EventArgs);
begin
  AddAppropriation;
  TextBox_new_amount.Text := system.string.EMPTY;
  DropDownList_services.SelectedIndex := -1;
end;

procedure TWebForm_create_new_service_appropriation.AddAppropriation;
var
  amount: decimal;
  amount_string: string;
  bc_get_cc_email_address: borland.data.provider.bdpcommand;
  bc_get_fy_designator: borland.data.provider.bdpcommand;
  bc_get_service_email_address: borland.data.provider.bdpcommand;
  max_county_dictated_appropriation_id_string: string;
  messageText: string;
  service_id_string: string;
begin
  amount_string := Safe(TextBox_new_amount.Text.Trim,REAL_NUM);
  service_id_string := Safe(DropDownList_services.SelectedValue,NUM);
  if amount_string <> system.string.EMPTY then begin
    amount := decimal.Parse(amount_string);
    if amount > 0 then begin
      appcommon.DbOpen;
      //
      // Record the new appropriation.
      //
      borland.data.provider.bdpcommand.Create
        (
        'insert into county_dictated_appropriation'
        + ' set region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].tostring + ','
        +   ' service_id = ' + service_id_string + ','
        +   ' amount = ' + amount.tostring + ','
        +   ' match_level_id = ' + Safe(RadioButtonList_match_level.selectedvalue,NUM),
        appcommon.db
        )
        .ExecuteNonQuery;
      //
      // Initialize a new emsof_request_master record, since at this time there must be a one-to-one relationship between a county-
      // dictated appropriation and an EMSOF request.
      //
      //   Get max(county_dictated_appropriation.id), which must be the id of the county_dictated_appropriation record that we just
      //   inserted.
      //
      max_county_dictated_appropriation_id_string := borland.data.provider.bdpcommand.Create
        (
        'select max(id) from county_dictated_appropriation',
        appcommon.db
        )
        .ExecuteScalar.tostring;
      //
      //    Insert and link back to the above max id.
      //
      borland.data.provider.bdpcommand.Create
        (
        'insert into emsof_request_master set county_dictated_appropriation_id = ' + max_county_dictated_appropriation_id_string,
        appcommon.db
        )
        .ExecuteNonQuery;
      //
      // Send notice of the appropriation to the service's email address of record.
      //
      //   Set up the command to get service's email address of record.
      bc_get_service_email_address := borland.data.provider.bdpcommand.Create
        (
        'select password_reset_email_address from service_user '
        + 'where id = ' + service_id_string,
        appcommon.db
        );
      //   Set up the command to get the appropriate fiscal year designator.
      bc_get_fy_designator := borland.data.provider.bdpcommand.Create
        (
        'select designator'
        + ' from fiscal_year'
        +   ' join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)'
        +   ' join region_dictated_appropriation'
        +     ' on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)'
        + ' where region_dictated_appropriation.id = ' + session.Item['region_dictated_appropriation_id'].tostring,
        appcommon.db
        );
      //   Set up the command to get the County Coorindator's email address.
      bc_get_cc_email_address := borland.data.provider.bdpcommand.Create
        (
        'select password_reset_email_address from county_user where id = ' + session.item['county_user_id'].tostring,
        appcommon.db
        );
      //   Set up the messageText.
      messageText := 'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has made a new EMSOF appropriation '
      + 'of ' + amount.tostring('C') + ' to your service for ' + bc_get_fy_designator.ExecuteScalar.tostring + '.' + NEW_LINE
      + NEW_LINE
      + 'You can work on this appropriation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name'])
      + '/protected/service_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name'];
      //   Send the email message.
      smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
      smtpmail.Send
        (
        bc_get_cc_email_address.ExecuteScalar.tostring,
        bc_get_service_email_address.ExecuteScalar.tostring,
        'New ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
        messageText
        );
      //
      appcommon.DbClose;
    end;
  end;
end;

procedure TWebForm_create_new_service_appropriation.Bind_services;
var
  bdr_services: borland.data.provider.BdpDataReader;
  cmdText: string;
begin
  appcommon.DbOpen;
  DropDownList_services.Items.Clear;
  DropDownList_services.Items.Add(listitem.Create('-- Select --','0'));
  //
  cmdText := 'SELECT id,name FROM service_user JOIN service using (id) ';
  if be_service_list_filtered then begin
    cmdText := cmdText + 'where county_code = ' + session.item['county_user_id'].tostring + ' ';
  end;
  cmdText := cmdText + 'ORDER BY name';
  //
  bdr_services := Borland.Data.Provider.BdpCommand.Create(cmdText,appcommon.db).ExecuteReader;
  while bdr_services.Read do begin
    DropDownList_services.Items.Add(listitem.Create(bdr_services['name'].tostring,bdr_services['id'].ToString));
  end;
  appcommon.DbClose;
end;

end.

