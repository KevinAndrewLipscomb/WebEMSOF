
unit create_new_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  borland.data.provider,
  Class_biz_services,
  Class_db,
  ki.common,
  system.configuration,
  system.web.mail,
  system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    amount: decimal;
    biz_services: TClass_biz_services;
    db: TClass_db;
    unappropriated_amount: decimal;
    END;
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
    procedure CustomValidator_amount_ServerValidate(source: System.Object; args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure TWebForm_create_new_service_appropriation_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_county_dictated_appropriations_Click(sender: System.Object; 
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure AddAppropriation;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
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
    CheckBox_show_out_of_county_services: System.Web.UI.WebControls.CheckBox;
    RadioButtonList_match_level: System.Web.UI.WebControls.RadioButtonList;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    Label_county_name: System.Web.UI.WebControls.Label;
    Label_literal_county: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_service_appropriations: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_service_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    CustomValidator_amount: System.Web.UI.WebControls.CustomValidator;
    LinkButton_county_dictated_appropriations: System.Web.UI.WebControls.LinkButton;
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
  Include(Self.LinkButton_county_dictated_appropriations.Click, Self.LinkButton_county_dictated_appropriations_Click);
  Include(Self.CheckBox_show_out_of_county_services.CheckedChanged, Self.CheckBox_unfilter_CheckedChanged);
  Include(Self.CustomValidator_amount.ServerValidate, Self.CustomValidator_amount_ServerValidate);
  Include(Self.Button_add_appropriation_and_repeat.Click, Self.Button_add_appropriation_and_repeat_Click);
  Include(Self.Button_add_appropriation_and_stop.Click, Self.Button_add_appropriation_and_stop_Click);
  Include(Self.Button_cancel.Click, Self.Button_cancel_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_create_new_service_appropriation_PreRender);
end;
{$ENDREGION}

procedure TWebForm_create_new_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - create_new_service_appropriation';
    Label_county_name.text := session['county_name'].tostring;
    //
    // Initialize implementation-scoped variables.
    //
    p.amount := 0;
    p.db := TClass_db.Create;
    //
    Label_parent_appropriation_amount.text := decimal.Parse(session['parent_appropriation_amount'].tostring).tostring('C');
    Label_region_name.text := session['region_name'].tostring;
    Label_fiscal_year_designator.text := session['fiscal_year_designator'].tostring;
    Label_sum_of_service_appropriations.text := decimal.Parse(session['sum_of_service_appropriations'].tostring).tostring('C');
    p.unappropriated_amount := decimal(session['unappropriated_amount']);
    Label_unappropriated_amount.text := p.unappropriated_amount.tostring('C');
    if p.unappropriated_amount < 0 then begin
      Label_unappropriated_amount.font.bold := TRUE;
      Label_unappropriated_amount.forecolor := color.red;
    end;
    //
    p.biz_services := TClass_biz_services.Create;
    p.biz_services.BindDropDownList
      (session['county_user_id'].tostring,DropDownList_services,CheckBox_show_out_of_county_services.checked);
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

procedure TWebForm_create_new_service_appropriation.LinkButton_county_dictated_appropriations_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_create_new_service_appropriation.TWebForm_create_new_service_appropriation_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_create_new_service_appropriation.CustomValidator_amount_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
var
  amount_string: string;
begin
  amount_string := Safe(args.value,REAL_NUM);
  if amount_string = system.string.EMPTY then begin
    args.isvalid := FALSE;
  end else begin
    p.amount := decimal.Parse(amount_string);
    args.isvalid := (p.amount > 0) and (p.amount <= p.unappropriated_amount);
  end;
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
  p.biz_services.BindDropDownList
    (session['county_user_id'].tostring,DropDownList_services,CheckBox_show_out_of_county_services.checked);
end;

procedure TWebForm_create_new_service_appropriation.Button_add_appropriation_and_stop_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if page.isvalid then begin
    AddAppropriation;
    server.Transfer('county_dictated_appropriations.aspx');
  end;
end;

procedure TWebForm_create_new_service_appropriation.Button_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_create_new_service_appropriation.Button_add_appropriation_and_repeat_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if page.isvalid then begin
    AddAppropriation;
    TextBox_new_amount.Text := system.string.EMPTY;
    DropDownList_services.SelectedIndex := -1;
    //
    // Update labels in the Parent appropriation section.
    //
    Label_sum_of_service_appropriations.text :=
      (decimal.parse(Safe(Label_sum_of_service_appropriations.text,REAL_NUM)) + p.amount).tostring('C');
    p.unappropriated_amount := p.unappropriated_amount - p.amount;
    Label_unappropriated_amount.text := p.unappropriated_amount.tostring('C');
    if p.unappropriated_amount < 0 then begin
      Label_unappropriated_amount.font.bold := TRUE;
      Label_unappropriated_amount.forecolor := color.red;
    end;
  end;
end;

procedure TWebForm_create_new_service_appropriation.AddAppropriation;
var
  bdp_get_fy_designator: borland.data.provider.bdpcommand;
  bdp_get_service_email_address: borland.data.provider.bdpcommand;
  cc_email_address: string;
  max_county_dictated_appropriation_id_string: string;
  messageText: string;
  service_id_string: string;
begin
  service_id_string := Safe(DropDownList_services.SelectedValue,NUM);
  p.db.Open;
  //
  // Record the new appropriation.
  //
  borland.data.provider.bdpcommand.Create
    (
    'insert into county_dictated_appropriation'
    + ' set region_dictated_appropriation_id = ' + session['region_dictated_appropriation_id'].tostring + ','
    +   ' service_id = ' + service_id_string + ','
    +   ' amount = ' + p.amount.tostring + ','
    +   ' match_level_id = ' + Safe(RadioButtonList_match_level.selectedvalue,NUM),
    p.db.connection
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
    p.db.connection
    )
    .ExecuteScalar.tostring;
  //
  //    Insert and link back to the above max id.
  //
  borland.data.provider.bdpcommand.Create
    (
    'insert into emsof_request_master set county_dictated_appropriation_id = ' + max_county_dictated_appropriation_id_string,
    p.db.connection
    )
    .ExecuteNonQuery;
  //
  // Send notice of the appropriation to the service's email address of record.
  //
  //   Set up the command to get service's email address of record.
  bdp_get_service_email_address := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address from service_user '
    + 'where id = ' + service_id_string,
    p.db.connection
    );
  //   Set up the command to get the appropriate fiscal year designator.
  bdp_get_fy_designator := borland.data.provider.bdpcommand.Create
    (
    'select designator'
    + ' from fiscal_year'
    +   ' join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)'
    + ' where region_dictated_appropriation.id = ' + session['region_dictated_appropriation_id'].tostring,
    p.db.connection
    );
  //   Set up the command to get the County Coorindator's email address.
  cc_email_address := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address from county_user where id = ' + session['county_user_id'].tostring,
    p.db.connection
    )
    .ExecuteScalar.tostring;
  //   Set up the messageText.
  messageText := 'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has made a new EMSOF allocation '
  + 'of ' + p.amount.tostring('C') + ' to your service for ' + bdp_get_fy_designator.ExecuteScalar.tostring + '.' + NEW_LINE
  + NEW_LINE
  + 'You can work on this allocation by visiting:' + NEW_LINE
  + NEW_LINE
  + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
  + ConfigurationSettings.AppSettings['application_name'] + NEW_LINE
  + NEW_LINE
  + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
  + NEW_LINE
  + '   ' + cc_email_address + '  (mailto:' + cc_email_address + ')' + NEW_LINE
  + NEW_LINE
  + '-- ' + ConfigurationSettings.AppSettings['application_name'];
  //   Send the email message.
  ki.common.SmtpMailSend
    (
    ConfigurationSettings.AppSettings['sender_email_address'],
    bdp_get_service_email_address.ExecuteScalar.tostring,
    'New ' + ConfigurationSettings.AppSettings['application_name'] + ' allocation for your service',
    messageText
    );
  //
  p.db.Close;
end;

end.

