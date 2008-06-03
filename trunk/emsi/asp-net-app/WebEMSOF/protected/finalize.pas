unit finalize;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, mysql.data.mysqlclient,
  system.web.mail, system.web.security,
  Class_db,
  UserControl_print_div;

type
  p_type =
    RECORD
    db: TClass_db;
    END;
  TWebForm_finalize = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_finalize_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_0_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_1_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_2_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_3_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_4_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_5_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_6_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_7_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_8_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_9_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_10_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_request_overview_bottom_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure TWebForm_finalize_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Table_sorry: System.Web.UI.HtmlControls.HtmlTable;
    Table_summary: System.Web.UI.HtmlControls.HtmlTable;
    CheckBox_understand_read_only_1: System.Web.UI.WebControls.CheckBox;
    ListItem_remainder_goes_to_region: system.web.ui.htmlcontrols.htmlgenericcontrol;
    Label_grand_total_cost: System.Web.UI.WebControls.Label;
    CheckBox_understand_grand_total_up_front: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_max_reimbursement: System.Web.UI.WebControls.CheckBox;
    Label_max_reimbursement_1: System.Web.UI.WebControls.Label;
    CheckBox_understand_anticipated_vs_actual: System.Web.UI.WebControls.CheckBox;
    Label_unreimbursed_amount: System.Web.UI.WebControls.Label;
    CheckBox_understand_unreimbursed_amount: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_deadlines: System.Web.UI.WebControls.CheckBox;
    CheckBox_agree_to_terms_and_conditions: System.Web.UI.WebControls.CheckBox;
    Button_finalize: System.Web.UI.WebControls.Button;
    CheckBox_understand_read_only_2: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_wait_for_approval_to_order: System.Web.UI.WebControls.CheckBox;
    Label_deadline_purchase_completion: System.Web.UI.WebControls.Label;
    Label_deadline_invoice_submission: System.Web.UI.WebControls.Label;
    Label_deadline_canceled_check_submission: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    CheckBox_understand_remainder_goes_to_region: System.Web.UI.WebControls.CheckBox;
    Label_max_reimbursement_2: System.Web.UI.WebControls.Label;
    LinkButton_request_overview_00: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_0: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_1: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_2: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_3: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_4: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_5: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_6: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_7: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_8: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_9: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_10: System.Web.UI.WebControls.LinkButton;
    LinkButton_request_overview_bottom: System.Web.UI.WebControls.LinkButton;
    HyperLink_terms_and_conditions: System.Web.UI.WebControls.HyperLink;
    UserControl_print_div: TWebUserControl_print_div;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation
 
uses
  Class_biz_accounts,
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  Class_biz_fiscal_years;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_finalize.InitializeComponent;
begin
  Include(Self.LinkButton_request_overview_0.Click, Self.LinkButton_request_overview_0_Click);
  Include(Self.LinkButton_request_overview_1.Click, Self.LinkButton_request_overview_1_Click);
  Include(Self.LinkButton_request_overview_2.Click, Self.LinkButton_request_overview_2_Click);
  Include(Self.LinkButton_request_overview_3.Click, Self.LinkButton_request_overview_3_Click);
  Include(Self.LinkButton_request_overview_4.Click, Self.LinkButton_request_overview_4_Click);
  Include(Self.LinkButton_request_overview_5.Click, Self.LinkButton_request_overview_5_Click);
  Include(Self.LinkButton_request_overview_6.Click, Self.LinkButton_request_overview_6_Click);
  Include(Self.LinkButton_request_overview_7.Click, Self.LinkButton_request_overview_7_Click);
  Include(Self.LinkButton_request_overview_8.Click, Self.LinkButton_request_overview_8_Click);
  Include(Self.LinkButton_request_overview_9.Click, Self.LinkButton_request_overview_9_Click);
  Include(Self.LinkButton_request_overview_10.Click, Self.LinkButton_request_overview_10_Click);
  Include(Self.Button_finalize.Click, Self.Button_finalize_Click);
  Include(Self.LinkButton_request_overview_bottom.Click, Self.LinkButton_request_overview_bottom_Click);
  Include(Self.PreRender, Self.TWebForm_finalize_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_finalize.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr: mysqldatareader;
  biz_fiscal_years: TClass_biz_fiscal_years;
  grand_total_cost: decimal;
  grand_total_cost_obj: system.object;
  max_reimbursement: decimal;
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - finalize';
    //
    biz_fiscal_years := TClass_biz_fiscal_years.Create;
    p.db := TClass_db.Create;
    //
    if decimal(session['unused_amount']) >= 0 then begin
      //
      Table_sorry.visible := FALSE;
      //
      if decimal(session['unused_amount']) = 0 then begin
        ListItem_remainder_goes_to_region.visible := FALSE;
      end else begin
        Label_unused_amount.text := decimal(session['unused_amount']).tostring('C');
      end;
      //
      p.db.Open;
      //
      // Set Label_grand_total_cost.
      //
      grand_total_cost_obj := mysqlcommand.Create
        (
        'select sum(unit_cost*quantity) from emsof_request_detail'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring,
        p.db.connection
        )
        .ExecuteScalar;
      if grand_total_cost_obj = dbnull.value then begin
         grand_total_cost := 0;
      end else begin
         grand_total_cost := decimal(grand_total_cost_obj);
      end;
      Label_grand_total_cost.text := grand_total_cost.tostring('C');
      //
      // Set Label_max_reimbursement.
      //
      max_reimbursement := decimal(session['sum_of_emsof_antes']);
      Label_max_reimbursement_1.text := max_reimbursement.tostring('C');
      Label_max_reimbursement_2.text := Label_max_reimbursement_1.text;
      //
      // Set Label_unreimbursed_amount.
      //
      Label_unreimbursed_amount.text := (grand_total_cost - max_reimbursement).tostring('C');
      //
      // Set Label_deadline_*
      //
      dr := mysqlcommand.Create
        (
        'select value as emsof_service_purchase_completion_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-purchase-completion-deadline"'
        + '   and fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent,
        p.db.connection
        )
        .ExecuteReader;
      dr.Read;
      Label_deadline_purchase_completion.text :=
        datetime.Parse(dr['emsof_service_purchase_completion_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      dr.Close;
      dr := mysqlcommand.Create
        (
        'select value as emsof_service_invoice_submission_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-invoice-submission-deadline"'
        + '   and fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent,
        p.db.connection
        )
        .ExecuteReader;
      dr.Read;
      Label_deadline_invoice_submission.text :=
        datetime.Parse(dr['emsof_service_invoice_submission_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      dr.Close;
      dr := mysqlcommand.Create
        (
        'select value as emsof_service_canceled_check_submission_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-canceled-check-submission-deadline"'
        + '   and fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent,
        p.db.connection
        )
        .ExecuteReader;
      dr.Read;
      Label_deadline_canceled_check_submission.text :=
        datetime.Parse(dr['emsof_service_canceled_check_submission_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      dr.Close;
      //
      p.db.Close;
      //
    end else begin
      Table_summary.visible := FALSE;
    end;
  end;
end;

procedure TWebForm_finalize.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_finalize.TWebForm_finalize_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_finalize.LinkButton_request_overview_bottom_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_10_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_9_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_8_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_7_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_6_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_5_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_4_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_3_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_2_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_1_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.LinkButton_request_overview_0_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_finalize.Button_finalize_Click(sender: System.Object; e: System.EventArgs);
var
  biz_accounts: TClass_biz_accounts;
  cc_email_address: string;
  emsof_request_master_status: string;
  service_email_address: string;
begin
  if CheckBox_understand_read_only_1.checked
    and ((decimal(session['unused_amount']) = 0) or CheckBox_understand_remainder_goes_to_region.checked)
    and CheckBox_understand_grand_total_up_front.checked
    and CheckBox_understand_max_reimbursement.checked
    and CheckBox_understand_anticipated_vs_actual.checked
    and CheckBox_understand_unreimbursed_amount.checked
    and CheckBox_understand_deadlines.checked
    and CheckBox_agree_to_terms_and_conditions.checked
    and CheckBox_understand_read_only_2.checked
    and CheckBox_understand_wait_for_approval_to_order.checked
  then begin
    //
    // Update database.
    //
    TClass_biz_emsof_requests.Create.Finalize(session['emsof_request_master_id'].tostring);
    //
    // Update the appropriate session object.
    //
    emsof_request_master_status := system.object(Class_biz_emsof_requests.status_type(3)).tostring;
    session.Remove('emsof_request_master_status');
    session.Add('emsof_request_master_status',emsof_request_master_status);
    //
    // Send notifications to county and regional coordinators.
    //
    biz_accounts := TClass_biz_accounts.Create;
    //
    service_email_address := biz_accounts.EmailAddressByKindId('service',session['service_user_id'].tostring);
    cc_email_address := biz_accounts.EmailAddressByKindId
      ('county',TClass_biz_appropriations.Create.CountyCodeOfCountyDictum(session['county_dictated_appropriation_id'].tostring));
    //
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      cc_email_address,
      session['service_name'].tostring + ' has finalized its ' + configurationmanager.AppSettings['application_name']
      + ' request',
      session['service_name'].tostring + ' has finalized its ' + configurationmanager.AppSettings['application_name']
      + ' request for ' + session['fiscal_year_designator'].tostring + PERIOD + NEW_LINE
      + NEW_LINE
      + 'Please approve or return/reject this request by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['service_name'].ToString + ' EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + service_email_address + '  (mailto:' + service_email_address + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name']
      );
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      biz_accounts.EmailTargetByRole('emsof-coordinator'),
      session['service_name'].tostring + ' has finalized a ' + configurationmanager.AppSettings['application_name']
      + ' request',
      session['service_name'].tostring + ' has finalized a ' + configurationmanager.AppSettings['application_name']
      + ' request for ' + session['fiscal_year_designator'].tostring + PERIOD + NEW_LINE
      + NEW_LINE
      + 'WebEMSOF has forwarded the finalized request to <' + cc_email_address + '> for county approval.  No action is required '
      + 'from you at this time.' + NEW_LINE
      + NEW_LINE
      + 'You can use WebEMSOF by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['service_name'].ToString + ' EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + service_email_address + '  (mailto:' + service_email_address + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name']
      );
    //
    BackTrack;
    //
  end;
end;

end.

