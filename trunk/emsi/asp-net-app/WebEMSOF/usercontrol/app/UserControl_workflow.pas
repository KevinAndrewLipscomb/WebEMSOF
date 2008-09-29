unit UserControl_workflow;

interface

uses
  Class_biz_emsof_requests,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_workflow = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_workflow_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_regional_compliance_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_num_requests_needing_development_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_num_requests_needing_finalization_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_num_requests_needing_county_approval_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_exec_dir_approval_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_transmittal_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_state_approval_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_invoice_collection_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_canceled_check_collection_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_reimbursement_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_all_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        biz_emsof_requests: TClass_biz_emsof_requests;
        END;
  strict private
    p: p_type;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    LinkButton_reimbursement: System.Web.UI.WebControls.LinkButton;
    LinkButton_canceled_check_collection: System.Web.UI.WebControls.LinkButton;
    LinkButton_invoice_collection: System.Web.UI.WebControls.LinkButton;
    LinkButton_state_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_transmittal: System.Web.UI.WebControls.LinkButton;
    LinkButton_exec_dir_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_regional_compliance: System.Web.UI.WebControls.LinkButton;
    LinkButton_num_requests_needing_county_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_num_requests_needing_finalization: System.Web.UI.WebControls.LinkButton;
    LinkButton_num_requests_needing_development: System.Web.UI.WebControls.LinkButton;
    LinkButton_all: System.Web.UI.WebControls.LinkButton;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_workflow;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_workflow.InjectPersistentClientSideScript;
begin
{$REGION 'Persistent client-side script'}
//  EstablishClientSideFunction(EL);
//  EstablishClientSideFunction(KGS_TO_LBS);
//  EstablishClientSideFunction(LBS_TO_KGS);
//  EstablishClientSideFunction
//    (
//    'RecalculateDependentValues()',
//    EMPTY
//    + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
//    +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
//    + NEW_LINE
//    + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
//    );
//  //
//  TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
//  TextBox_gross_landed_weight_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_gross_landed_weight_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
{$ENDREGION}
end;

procedure TWebUserControl_workflow.Page_Load(sender: System.Object; e: System.EventArgs);
var
  tally: string;
begin
  //
  if not p.be_loaded then begin
    //
    LinkButton_num_requests_needing_development.text :=
      p.biz_emsof_requests.TallyOfStatus(ALLOCATED) + LinkButton_num_requests_needing_development.text;
    LinkButton_num_requests_needing_finalization.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_SERVICE_FINALIZATION) + LinkButton_num_requests_needing_finalization.text;
    LinkButton_num_requests_needing_county_approval.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_COUNTY_APPROVAL) + LinkButton_num_requests_needing_county_approval.text;
    //
    tally :=p.biz_emsof_requests.TallyOfStatus(NEEDS_REGIONAL_COMPLIANCE_CHECK);
    LinkButton_regional_compliance.text := tally + LinkButton_regional_compliance.text;
    if (tally <> '0') and p.biz_emsof_requests.BeOkToApproveEmsofRequest(NEEDS_REGIONAL_COMPLIANCE_CHECK) then begin
      LinkButton_regional_compliance.font.bold := TRUE;
      LinkButton_regional_compliance.text := LinkButton_regional_compliance.text.ToUpper;
    end;
    //
    tally :=p.biz_emsof_requests.TallyOfStatus(NEEDS_REGIONAL_EXEC_DIR_APPROVAL);
    LinkButton_exec_dir_approval.text := tally + LinkButton_exec_dir_approval.text;
    if (tally <> '0') and p.biz_emsof_requests.BeOkToApproveEmsofRequest(NEEDS_REGIONAL_EXEC_DIR_APPROVAL) then begin
      LinkButton_exec_dir_approval.font.bold := TRUE;
      LinkButton_exec_dir_approval.text := LinkButton_exec_dir_approval.text.ToUpper;
    end;
    //
    LinkButton_transmittal.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_SENT_TO_PA_DOH_EMSO) + LinkButton_transmittal.text;
    LinkButton_state_approval.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_PA_DOH_EMSO_APPROVAL) + LinkButton_state_approval.text;
    LinkButton_invoice_collection.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_INVOICE_COLLECTION) + LinkButton_invoice_collection.text;
    LinkButton_canceled_check_collection.text :=
      p.biz_emsof_requests.TallyOfStatus(NEEDS_CANCELED_CHECK_COLLECTION) + LinkButton_canceled_check_collection.text;
    //
    tally :=p.biz_emsof_requests.TallyOfStatus(NEEDS_REIMBURSEMENT_ISSUANCE);
    LinkButton_reimbursement.text := tally + LinkButton_reimbursement.text;
    if (tally <> '0') then begin
      LinkButton_reimbursement.font.bold := TRUE;
      LinkButton_reimbursement.text := LinkButton_reimbursement.text.ToUpper;
    end;
    //
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_all);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_num_requests_needing_development);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_num_requests_needing_finalization);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_num_requests_needing_county_approval);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_regional_compliance);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_exec_dir_approval);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_transmittal);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_state_approval);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_invoice_collection);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_canceled_check_collection);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_reimbursement);
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

procedure TWebUserControl_workflow.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_workflow.p'] <> nil then begin
    p := p_type(session['UserControl_workflow.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_member_binder_PlaceHolder_content']) = 'UserControl_workflow');
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_workflow.InitializeComponent;
begin
  Include(Self.PreRender, Self.TWebUserControl_workflow_PreRender);
  Include(Self.Load, Self.Page_Load);
  Include(Self.LinkButton_all.Click, Self.LinkButton_all_Click);
  Include(Self.LinkButton_num_requests_needing_development.Click, Self.LinkButton_num_requests_needing_development_Click);
  Include(Self.LinkButton_num_requests_needing_finalization.Click, Self.LinkButton_num_requests_needing_finalization_Click);
  Include(Self.LinkButton_num_requests_needing_county_approval.Click, Self.LinkButton_num_requests_needing_county_approval_Click);
  Include(Self.LinkButton_regional_compliance.Click, Self.LinkButton_regional_compliance_Click);
  Include(Self.LinkButton_exec_dir_approval.Click, Self.LinkButton_exec_dir_approval_Click);
  Include(Self.LinkButton_transmittal.Click, Self.LinkButton_transmittal_Click);
  Include(Self.LinkButton_state_approval.Click, Self.LinkButton_state_approval_Click);
  Include(Self.LinkButton_invoice_collection.Click, Self.LinkButton_invoice_collection_Click);
  Include(Self.LinkButton_canceled_check_collection.Click, Self.LinkButton_canceled_check_collection_Click);
  Include(Self.LinkButton_reimbursement.Click, Self.LinkButton_reimbursement_Click);
end;
{$ENDREGION}

procedure TWebUserControl_workflow.TWebUserControl_workflow_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_workflow.p',p);
end;

function TWebUserControl_workflow.Fresh: TWebUserControl_workflow;
begin
  session.Remove('UserControl_workflow.p');
  Fresh := self;
end;

procedure TWebUserControl_workflow.LinkButton_all_Click(sender: System.Object;
  e: System.EventArgs);
begin
  DropCrumbAndTransferTo('all_emsof_requests.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_reimbursement_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_REIMBURSEMENT_ISSUANCE);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_canceled_check_collection_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_CANCELED_CHECK_COLLECTION);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_invoice_collection_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_INVOICE_COLLECTION);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_state_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_PA_DOH_EMSO_APPROVAL);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_transmittal_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_SENT_TO_PA_DOH_EMSO);
  DropCrumbAndTransferTo('state_required_report.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_exec_dir_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_REGIONAL_EXEC_DIR_APPROVAL);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_num_requests_needing_county_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_COUNTY_APPROVAL);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_num_requests_needing_finalization_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_SERVICE_FINALIZATION);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_num_requests_needing_development_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',ALLOCATED);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_workflow.LinkButton_regional_compliance_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',NEEDS_REGIONAL_COMPLIANCE_CHECK);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

end.
