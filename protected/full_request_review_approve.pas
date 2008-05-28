unit full_request_review_approve;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki, system.configuration, system.web.security,
  borland.data.provider,
  Class_biz_emsof_requests,
  UserControl_print_div;

type
  p_type =
    RECORD
    be_all_costs_proven: boolean;
    be_before_improvement_deadline: boolean;
    be_ok_to_track_payments: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    display_actuals: boolean;
    modify_actuals: boolean;
    num_items: cardinal;
    num_proofs_of_payment: cardinal;
    parent_appropriation_amount: decimal;
    request_id: string;
    status: Class_biz_emsof_requests.status_type;
    sum_of_actual_costs: decimal;
    sum_of_proven_payments: decimal;
    total_emsof_ante: decimal;
    END;
  TWebForm_full_request_review_approve = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_items_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure Button_approve_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_disapprove_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_full_request_review_approve_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_mark_done_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_items_EditCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_items_CancelCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_items_UpdateCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_proofs_of_payment_ItemDataBound(sender: System.Object; 
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure LinkButton_new_proof_of_payment_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_proofs_of_payment_DeleteCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure Button_force_open_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_force_close_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_failed_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_special_promotion_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure BindProofsOfPayment;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_affiliate_num: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    Label_county_approval_timestamp: System.Web.UI.WebControls.Label;
    Label_region_name_1: System.Web.UI.WebControls.Label;
    Label_regional_planner_approval_timestamp: System.Web.UI.WebControls.Label;
    Label_region_name_2: System.Web.UI.WebControls.Label;
    Label_regional_exec_dir_approval_timestamp: System.Web.UI.WebControls.Label;
    Label_state_approval_timestamp: System.Web.UI.WebControls.Label;
    Label_num_items: System.Web.UI.WebControls.Label;
    DataGrid_items: System.Web.UI.WebControls.DataGrid;
    LinkButton_new_proof_of_payment: System.Web.UI.WebControls.LinkButton;
    DataGrid_proofs_of_payment: System.Web.UI.WebControls.DataGrid;
    LinkButton_back_2: System.Web.UI.WebControls.LinkButton;
    Label_next_reviewer: System.Web.UI.WebControls.Label;
    CheckBox_approve: System.Web.UI.WebControls.CheckBox;
    Button_approve: System.Web.UI.WebControls.Button;
    Button_disapprove: System.Web.UI.WebControls.Button;
    Label_current_status: System.Web.UI.WebControls.Label;
    CheckBox_mark_done: System.Web.UI.WebControls.CheckBox;
    Button_mark_done: System.Web.UI.WebControls.Button;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Table_disposition_sentinel: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_prior_approvals: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_regional_planner_approval_timestamp: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_regional_exec_dir_approval_timestamp: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_state_approval_timestamp: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_proofs_of_payment: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_proofs_of_payment_none: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_disposition_nominal: System.Web.UI.HtmlControls.HtmlTable;
    Label_total_of_actual_costs: System.Web.UI.WebControls.Label;
    Label_total_of_proven_payments: System.Web.UI.WebControls.Label;
    Label_total_of_emsof_amounts: System.Web.UI.WebControls.Label;
    Button_force_open: System.Web.UI.WebControls.Button;
    Table_extraordinary_actions: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_force_open: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_application_name: System.Web.UI.WebControls.Label;
    Button_force_close: System.Web.UI.WebControls.Button;
    TableRow_force_closed: System.Web.UI.HtmlControls.HtmlTableRow;
    CheckBox_mark_failed: System.Web.UI.WebControls.CheckBox;
    Button_failed: System.Web.UI.WebControls.Button;
    Table_mark_failed: System.Web.UI.HtmlControls.HtmlTable;
    Table_emphasized_totals: System.Web.UI.HtmlControls.HtmlTable;
    CheckBox_special_promotion: System.Web.UI.WebControls.CheckBox;
    Button_special_promotion: System.Web.UI.WebControls.Button;
    Table_special_promotion: System.Web.UI.HtmlControls.HtmlTable;
    Table_mark_done: System.Web.UI.HtmlControls.HtmlTable;
    Table_action_pending_sentinel: System.Web.UI.HtmlControls.HtmlTable;
    Table_action_pending_nominal: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_return: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_reject: System.Web.UI.HtmlControls.HtmlTableRow;
    TextArea_disapproval_reason: System.Web.UI.HtmlControls.HtmlTextArea;
    Label_sponsor_county_2: System.Web.UI.WebControls.Label;
    UserControl_print_div: TWebUserControl_print_div;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  appcommon,
  Class_biz_appropriations;

const
  TCCI_ACTUALS = 2;
  TCCI_LINKBUTTONS = 3;
  TCCI_PROOF_OF_PAYMENT_LINKBUTTON = 5;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_full_request_review_approve.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.DataGrid_items.CancelCommand, Self.DataGrid_items_CancelCommand);
  Include(Self.DataGrid_items.EditCommand, Self.DataGrid_items_EditCommand);
  Include(Self.DataGrid_items.UpdateCommand, Self.DataGrid_items_UpdateCommand);
  Include(Self.DataGrid_items.ItemDataBound, Self.DataGrid_items_ItemDataBound);
  Include(Self.LinkButton_new_proof_of_payment.Click, Self.LinkButton_new_proof_of_payment_Click);
  Include(Self.DataGrid_proofs_of_payment.DeleteCommand, Self.DataGrid_proofs_of_payment_DeleteCommand);
  Include(Self.DataGrid_proofs_of_payment.ItemDataBound, Self.DataGrid_proofs_of_payment_ItemDataBound);
  Include(Self.Button_approve.Click, Self.Button_approve_Click);
  Include(Self.Button_disapprove.Click, Self.Button_disapprove_Click);
  Include(Self.Button_mark_done.Click, Self.Button_mark_done_Click);
  Include(Self.Button_failed.Click, Self.Button_failed_Click);
  Include(Self.Button_special_promotion.Click, Self.Button_special_promotion_Click);
  Include(Self.Button_force_open.Click, Self.Button_force_open_Click);
  Include(Self.Button_force_close.Click, Self.Button_force_close_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_full_request_review_approve_PreRender);
end;
{$ENDREGION}

procedure TWebForm_full_request_review_approve.Page_Load
  (
  sender: System.Object;
  e: System.EventArgs
  );
var
  be_beyond_invoice_collection: boolean;
  timestamp: datetime;
begin
  appcommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - full_request_review_approve';
    
    Label_account_descriptor.text := session['account_descriptor'].tostring;
    //
    // Initialize class private class members.
    //
    p.biz_emsof_requests := Class_biz_emsof_requests.TClass_biz_emsof_requests.Create;
    //
    // Initialize class private data members.
    //
    p.status := p.biz_emsof_requests.StatusOf(session['e_item']);  // Must be set before next two statements.
    //
    p.display_actuals := p.biz_emsof_requests.BeOkToViewInvoices(p.status);
    p.modify_actuals := p.biz_emsof_requests.BeOkToTrackInvoices(p.status);
    p.num_items := 0;
    p.request_id := p.biz_emsof_requests.IdOf(session['e_item']);
    p.total_emsof_ante := 0;
    //
    // Manage subheading.
    //
    Label_fiscal_year_designator.text := p.biz_emsof_requests.FyDesignatorOf(session['e_item']);
    Label_service_name.text := p.biz_emsof_requests.ServiceNameOf(session['e_item']);
    Label_affiliate_num.text := p.biz_emsof_requests.AffiliateNumOf(session['e_item']);
    //
    // Manage Prior approvals block.
    //
    Table_prior_approvals.visible := FALSE;
    TableRow_regional_planner_approval_timestamp.visible := FALSE;
    TableRow_regional_exec_dir_approval_timestamp.visible := FALSE;
    TableRow_state_approval_timestamp.visible := FALSE;
    Label_sponsor_county.text := p.biz_emsof_requests.SponsorCountyNameOf(session['e_item']);
    //
    if p.status > NEEDS_COUNTY_APPROVAL then begin
      if p.biz_emsof_requests.BeValidCountyApprovalTimestampOf(p.request_id,timestamp) then begin
        Table_prior_approvals.visible := TRUE;
        Label_sponsor_county_2.text := Label_sponsor_county.text;
        Label_county_approval_timestamp.text := timestamp.tostring('HH:mm:ss dddd, MMMM d, yyyy');
      end;
      if p.status > NEEDS_REGIONAL_COMPLIANCE_CHECK then begin
        if p.biz_emsof_requests.BeValidRegionalPlannerApprovalTimestampOf(p.request_id,timestamp) then begin
          TableRow_regional_planner_approval_timestamp.visible := TRUE;
          Label_region_name_1.text := p.biz_emsof_requests.SponsorRegionNameOf(p.biz_emsof_requests.IdOf(session['e_item']));
          Label_regional_planner_approval_timestamp.text := timestamp.tostring('HH:mm:ss dddd, MMMM d, yyyy');
        end;
        if p.status > NEEDS_REGIONAL_EXEC_DIR_APPROVAL then begin
          if p.biz_emsof_requests.BeValidRegionalExecDirApprovalTimestampOf(p.request_id,timestamp) then begin
            TableRow_regional_exec_dir_approval_timestamp.visible := TRUE;
            Label_region_name_2.text := Label_region_name_1.text;
            Label_regional_exec_dir_approval_timestamp.text := timestamp.tostring('HH:mm:ss dddd, MMMM d, yyyy');
          end;
          if p.status > NEEDS_PA_DOH_EMSO_APPROVAL then begin
            if p.biz_emsof_requests.BeValidStateApprovalTimestampOf(p.request_id,timestamp) then begin
              TableRow_state_approval_timestamp.visible := TRUE;
              Label_state_approval_timestamp.text := timestamp.tostring('HH:mm:ss dddd, MMMM d, yyyy');
            end;
          end;
        end;
      end;
    end;
    //
    // Manage Items block (always visible).
    //
    p.biz_emsof_requests.BindDetail(p.request_id,DataGrid_items);
    //
    // Manage Allocation block (always visible), must be managed after Items block is bound.
    //
    p.parent_appropriation_amount :=
      TClass_biz_appropriations.Create.ParentAppropriationOfEmsofRequest(p.biz_emsof_requests.IdOf(session['e_item']));
    Label_parent_appropriation_amount.text := p.parent_appropriation_amount.tostring('C');
    Label_sum_of_emsof_antes.text := p.total_emsof_ante.tostring('C');
    Label_unused_amount.text := (p.parent_appropriation_amount - p.total_emsof_ante).tostring('C');
    Label_num_items.text := p.num_items.tostring;
    //
    // Manage Proof of payment and Emphasized totals blocks.
    //
    be_beyond_invoice_collection :=
      (p.status in [NEEDS_CANCELED_CHECK_COLLECTION,NEEDS_REIMBURSEMENT_ISSUANCE,REIMBURSEMENT_ISSUED]);
    Table_proofs_of_payment.visible := be_beyond_invoice_collection;
    Table_emphasized_totals.visible := be_beyond_invoice_collection;
    if be_beyond_invoice_collection then begin
      p.sum_of_actual_costs := p.biz_emsof_requests.SumOfActualCostsOfRequestItems(p.request_id);
      Label_total_of_actual_costs.text := p.sum_of_actual_costs.tostring('C');
      p.be_ok_to_track_payments := p.biz_emsof_requests.BeOkToTrackPayments(p.status);
      LinkButton_new_proof_of_payment.visible := p.be_ok_to_track_payments;
      //
      BindProofsOfPayment;
      //
      Label_total_of_emsof_amounts.text := p.biz_emsof_requests.ActualValueOf(p.request_id).tostring('C');
    end;
    //
    // Manage Disposition (ie, current approval action) block.
    //
    if p.biz_emsof_requests.BeOkToApproveEmsofRequest(p.status) then begin
      Label_next_reviewer.text :=
        p.biz_emsof_requests.NextReviewer(p.status);
      if datetime.Now <= p.biz_emsof_requests.ReworkDeadline(session['e_item']) then begin
        TableRow_reject.visible := FALSE;
        Button_disapprove.text := 'Return';
      end else begin
        TableRow_return.visible := FALSE;
        Button_disapprove.text := 'REJECT';
      end;
    end else begin
      Table_disposition_sentinel.visible := FALSE;
      Table_disposition_nominal.visible := FALSE;
    end;
    //
    // Manage Action pending block.
    //
    if p.biz_emsof_requests.BeOkToMarkDone(p.status) then begin
      Label_current_status.text := system.object(p.status).tostring;
      case p.status of
      NEEDS_SENT_TO_PA_DOH_EMSO,
      NEEDS_INVOICE_COLLECTION,
      NEEDS_REIMBURSEMENT_ISSUANCE:
        Table_special_promotion.visible := FALSE;
      NEEDS_CANCELED_CHECK_COLLECTION:
        Table_special_promotion.visible := not p.be_all_costs_proven;
      end;
      Table_mark_failed.visible := p.biz_emsof_requests.BeOkToMarkFailed(p.status);
    end else begin
      Table_action_pending_sentinel.visible := FALSE;
      Table_action_pending_nominal.visible := FALSE;
    end;
    //
    // Manage Extraordinary actions block.
    //
    TableRow_force_open.visible := p.biz_emsof_requests.BeOkToForceOpen(session['e_item']);
    TableRow_force_closed.visible := p.biz_emsof_requests.BeOkToRevokeDeadlineExemption(session['e_item']);
    Table_extraordinary_actions.visible := TableRow_force_open.visible or TableRow_force_closed.visible;
    if Table_extraordinary_actions.visible then begin
      Label_application_name.text := configurationsettings.appsettings['application_name'];
    end;
    //
  end;
end;

procedure TWebForm_full_request_review_approve.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_full_request_review_approve.Button_special_promotion_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if CheckBox_special_promotion.checked then begin
    p.biz_emsof_requests.MarkDone(session['e_item'],session['account_descriptor'].tostring);
    server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.Button_failed_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if CheckBox_mark_failed.checked then begin
    p.biz_emsof_requests.MarkFailed(session['e_item'],session['account_descriptor'].tostring);
    server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.Button_force_close_Click(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_emsof_requests.ForceClosed(p.request_id);
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_full_request_review_approve.Button_force_open_Click(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_emsof_requests.ForceOpen(p.request_id);
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_full_request_review_approve.DataGrid_proofs_of_payment_DeleteCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  p.biz_emsof_requests.DeleteProofOfPayment(p.biz_emsof_requests.IdOfProofOfPayment(e.item));
  DataGrid_proofs_of_payment.edititemindex := -1;
  BindProofsOfPayment;
end;

procedure TWebForm_full_request_review_approve.LinkButton_new_proof_of_payment_Click(sender: System.Object;
  e: System.EventArgs);
begin
  stack(session['waypoint_stack']).Push('full_request_review_approve.aspx');
  server.Transfer('add_proof_of_payment.aspx');
end;

procedure TWebForm_full_request_review_approve.DataGrid_items_UpdateCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs
  );
var
  actual_quantity: string;
  actual_subtotal_cost: string;
  invoice_designator: string;
  priority: string;
begin
  //
  priority := Safe(e.Item.Cells[p.biz_emsof_requests.TcciOfFullRequestPriority].Text.Trim,PUNCTUATED);
  invoice_designator := Safe(TextBox(e.Item.Cells[p.biz_emsof_requests.TcciOfFullRequestActuals].FindControl('TextBox_invoice_designator')).Text.Trim,PUNCTUATED);
  actual_quantity := Safe(TextBox(e.Item.Cells[p.biz_emsof_requests.TcciOfFullRequestActuals].FindControl('TextBox_actual_quantity')).Text.Trim,NUM);
  actual_subtotal_cost := Safe(TextBox(e.Item.Cells[p.biz_emsof_requests.TcciOfFullRequestActuals].FindControl('TextBox_actual_subtotal_cost')).Text.Trim,REAL_NUM);
  //
  if (invoice_designator <> EMPTY)
    and (actual_quantity <> EMPTY)
    and (actual_subtotal_cost <> EMPTY)
  then begin
    p.biz_emsof_requests.SetActuals(p.request_id,priority,invoice_designator,actual_quantity,actual_subtotal_cost);
  end;
  //
  DataGrid_items.EditItemIndex := -1;
  p.biz_emsof_requests.BindDetail(p.request_id,DataGrid_items);
  //
end;

procedure TWebForm_full_request_review_approve.DataGrid_items_CancelCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_items.EditItemIndex := -1;
  p.biz_emsof_requests.BindDetail(p.request_id,DataGrid_items);
end;

procedure TWebForm_full_request_review_approve.DataGrid_items_EditCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_items.EditItemIndex := e.Item.ItemIndex;
  p.biz_emsof_requests.BindDetail(p.request_id,DataGrid_items);
end;

procedure TWebForm_full_request_review_approve.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_full_request_review_approve.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_full_request_review_approve.Button_mark_done_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if CheckBox_mark_done.checked then begin
    p.biz_emsof_requests.MarkDone(session['e_item'],session['account_descriptor'].tostring);
    server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.LinkButton_back_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_full_request_review_approve.TWebForm_full_request_review_approve_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_full_request_review_approve.Button_disapprove_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  if TextArea_disapproval_reason.Value <> EMPTY then begin
    p.biz_emsof_requests.Demote
      (
      session['e_item'],
      session['account_descriptor'].tostring,
      Safe(TextArea_disapproval_reason.value,PUNCTUATED),
      Safe(Label_sum_of_emsof_antes.text,CURRENCY_USA)
      );
    server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.Button_approve_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  if CheckBox_approve.checked then begin
    p.biz_emsof_requests.Approve(session['e_item'],session['account_descriptor'].tostring);
    server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.DataGrid_items_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  //
  // Manage column visibility
  //
  e.item.cells[TCCI_ACTUALS].visible := p.display_actuals;
  e.item.cells[TCCI_LINKBUTTONS].visible := p.modify_actuals;
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_items := p.num_items + 1;
    p.total_emsof_ante := p.total_emsof_ante
      + decimal.Parse(databinder.Eval(e.item.dataitem,p.biz_emsof_requests.PropertyNameOfEmsofAnte).tostring);
  end;
end;

procedure TWebForm_full_request_review_approve.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_full_request_review_approve.DataGrid_proofs_of_payment_ItemDataBound
  (
  sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs
  );
begin
  //
  // Manage column visibility
  //
  e.item.cells[TCCI_PROOF_OF_PAYMENT_LINKBUTTON].visible := p.be_ok_to_track_payments;
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_proofs_of_payment := p.num_proofs_of_payment + 1;
    //
  end;
end;

procedure TWebForm_full_request_review_approve.BindProofsOfPayment;
var
  be_datagrid_empty: boolean;
begin
  //
  p.biz_emsof_requests.BindProofsOfPayment(p.request_id,DataGrid_proofs_of_payment);
  //
  // Manage control visibilities.
  //
  be_datagrid_empty := (p.num_proofs_of_payment = 0);
  TableRow_proofs_of_payment_none.visible := be_datagrid_empty;
  Datagrid_proofs_of_payment.visible := not be_datagrid_empty;
  //
  // Manage related controls.
  //
  p.sum_of_proven_payments := p.biz_emsof_requests.SumOfProvenPaymentsOfRequest(p.request_id);
  Label_total_of_proven_payments.text := p.sum_of_proven_payments.tostring('C');
  p.be_all_costs_proven := (p.sum_of_proven_payments >= p.sum_of_actual_costs);
  Table_mark_done.disabled := (not p.be_all_costs_proven) and (p.status <> NEEDS_REIMBURSEMENT_ISSUANCE);
  Table_special_promotion.visible := not p.be_all_costs_proven;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_proofs_of_payment := 0;
  //
end;

end.

