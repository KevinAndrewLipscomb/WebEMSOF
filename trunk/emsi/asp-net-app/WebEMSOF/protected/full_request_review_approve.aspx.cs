using Class_biz_accounts;
using Class_biz_appropriations;
using Class_biz_emsof_request_return_comments;
using Class_biz_emsof_requests;
using Class_biz_equipment;
using Class_biz_services;
using Class_biz_user;
using kix;
using System;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserControl_attachment_explorer;

namespace full_request_review_approve
  {
  public class full_request_review_approve_Static
    {
    public const int TCCI_DETAIL = 2;
    public const int TCCI_ATTACHMENT_KEY = 3;
    public const int TCCI_ACTUALS = 4;
    public const int TCCI_LINKBUTTONS = 5;
    public const int TCCI_PROOF_OF_PAYMENT_LINKBUTTON = 5;
    }

    public partial class TWebForm_full_request_review_approve: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DataGrid_items.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_items_ItemDataBound);
            this.DataGrid_items.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_items_CancelCommand);
            this.DataGrid_items.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_items_EditCommand);
            this.DataGrid_items.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_items_UpdateCommand);
            this.DataGrid_proofs_of_payment.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_proofs_of_payment_ItemDataBound);
            this.DataGrid_proofs_of_payment.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_proofs_of_payment_DeleteCommand);
            this.PreRender += this.TWebForm_full_request_review_approve_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            bool be_beyond_invoice_collection;
            DateTime timestamp;
            if (IsPostBack)
            {
                if ((Session[InstanceId() + ".p"] != null))
                {
                    p = (p_type)(Session[InstanceId() + ".p"]);
                }
                else
                {
                    Server.Transfer("~/timeout.aspx");
                }
            }
            else
            {
                if (Request.ServerVariables["URL"] == Request.CurrentExecutionFilePath)
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - full_request_review_approve";
                // Initialize class private class members.
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_emsof_request_return_comments = new TClass_biz_emsof_request_return_comments();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_equipment = new TClass_biz_equipment();
                p.biz_services = new TClass_biz_services();
                p.biz_user = new TClass_biz_user();
                // Initialize class private data members.
                p.status = p.biz_emsof_requests.StatusOf(Session["e_item"]);
                // Must be set before next two statements.
                p.display_actuals = p.biz_emsof_requests.BeOkToViewInvoices(p.status);
                p.modify_actuals = p.biz_emsof_requests.BeOkToTrackInvoices(p.status);
                p.num_items = 0;
                p.request_id = p.biz_emsof_requests.IdOf(Session["e_item"]);
                p.total_emsof_ante = 0;
                // Manage subheading.
                Label_fiscal_year_designator.Text = p.biz_emsof_requests.FyDesignatorOf(Session["e_item"]);
                Label_service_name.Text = p.biz_emsof_requests.ServiceNameOf(Session["e_item"]);
                Label_affiliate_num.Text = p.biz_emsof_requests.AffiliateNumOf(Session["e_item"]);
                // Manage Prior rejections block.
                Table_prior_rejection_comments.Visible = p.biz_emsof_request_return_comments.Bind(GridView_rejection_comments, p.request_id);
                // Manage Prior approvals block.
                Table_prior_approvals.Visible = false;
                TableRow_regional_planner_approval_timestamp.Visible = false;
                TableRow_regional_exec_dir_approval_timestamp.Visible = false;
                TableRow_state_approval_timestamp.Visible = false;
                Label_sponsor_county.Text = p.biz_emsof_requests.SponsorCountyNameOf(Session["e_item"]);
                if (p.status > Class_biz_emsof_requests.status_type.NEEDS_COUNTY_APPROVAL)
                {
                    if (p.biz_emsof_requests.BeValidCountyApprovalTimestampOf(p.request_id, out timestamp))
                    {
                        Table_prior_approvals.Visible = true;
                        Label_sponsor_county_2.Text = Label_sponsor_county.Text;
                        Label_county_approval_timestamp.Text = timestamp.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                    }
                    if (p.status > Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_COMPLIANCE_CHECK)
                    {
                        if (p.biz_emsof_requests.BeValidRegionalPlannerApprovalTimestampOf(p.request_id, out timestamp))
                        {
                            TableRow_regional_planner_approval_timestamp.Visible = true;
                            Label_region_name_1.Text = p.biz_emsof_requests.SponsorRegionNameOf(p.biz_emsof_requests.IdOf(Session["e_item"]));
                            Label_regional_planner_approval_timestamp.Text = timestamp.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                        }
                        if (p.status > Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_EXEC_DIR_APPROVAL)
                        {
                            if (p.biz_emsof_requests.BeValidRegionalExecDirApprovalTimestampOf(p.request_id, out timestamp))
                            {
                                TableRow_regional_exec_dir_approval_timestamp.Visible = true;
                                Label_region_name_2.Text = Label_region_name_1.Text;
                                Label_regional_exec_dir_approval_timestamp.Text = timestamp.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                            }
                            if (p.status > Class_biz_emsof_requests.status_type.NEEDS_PA_DOH_EMSO_APPROVAL)
                            {
                                if (p.biz_emsof_requests.BeValidStateApprovalTimestampOf(p.request_id, out timestamp))
                                {
                                    TableRow_state_approval_timestamp.Visible = true;
                                    Label_state_approval_timestamp.Text = timestamp.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                                }
                            }
                        }
                    }
                }
                // Manage Items block (always visible).
                p.biz_emsof_requests.BindDetail(p.request_id, DataGrid_items);
                // Manage Allocation block (always visible), must be managed after Items block is bound.
                p.parent_appropriation_amount = new TClass_biz_appropriations().ParentAppropriationOfEmsofRequest(p.biz_emsof_requests.IdOf(Session["e_item"]));
                Label_parent_appropriation_amount.Text = p.parent_appropriation_amount.ToString("C");
                Label_sum_of_emsof_antes.Text = p.total_emsof_ante.ToString("C");
                Label_unused_amount.Text = (p.parent_appropriation_amount - p.total_emsof_ante).ToString("C");
                Label_num_items.Text = p.num_items.ToString();
                // Manage Proof of payment and Emphasized totals blocks.
                be_beyond_invoice_collection = (new ArrayList(new status_type[] {Class_biz_emsof_requests.status_type.NEEDS_CANCELED_CHECK_COLLECTION, Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE, Class_biz_emsof_requests.status_type.REIMBURSEMENT_ISSUED, Class_biz_emsof_requests.status_type.FAILED_DEADLINE, Class_biz_emsof_requests.status_type.DEPLOYED, Class_biz_emsof_requests.status_type.ARCHIVED, Class_biz_emsof_requests.status_type.WITHDRAWN}).Contains(p.status));
                Table_proofs_of_payment.Visible = be_beyond_invoice_collection;
                Table_emphasized_totals.Visible = be_beyond_invoice_collection;
                if (be_beyond_invoice_collection)
                {
                    p.sum_of_actual_costs = p.biz_emsof_requests.SumOfActualCostsOfRequestItems(p.request_id);
                    Label_total_of_actual_costs.Text = p.sum_of_actual_costs.ToString("C");
                    p.be_ok_to_track_payments = p.biz_emsof_requests.BeOkToTrackPayments(p.status);
                    LinkButton_new_proof_of_payment.Visible = p.be_ok_to_track_payments;
                    BindProofsOfPayment();
                    var actual_value = p.biz_emsof_requests.ActualValueOf(p.request_id);
                    Label_total_of_emsof_amounts.Text = actual_value.ToString("C");
                    Label_sum_of_emsof_antes.Text = Label_total_of_emsof_amounts.Text;
                    Label_unused_amount.Text = (p.parent_appropriation_amount - actual_value).ToString("C");
                }
                // Manage QuickMessage block.
                Literal_emsof_contact_name.Text = p.biz_emsof_requests.ServiceNameOf(Session["e_item"]) + " EMSOF Coordinator " + p.biz_services.EmsofCoordinatorNameOf(p.biz_emsof_requests.ServiceIdOf(Session["e_item"]));
                Label_author_email_address.Text = p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum());
                Label_distribution_list.Text = p.biz_emsof_requests.PasswordResetEmailAddressOf(Session["e_item"]);
                Label_sponsor_county_email_address.Text = p.biz_emsof_requests.SponsorCountyEmailAddressOf(Session["e_item"]);
                // Manage Disposition (ie, current approval action) block.
                if (p.biz_emsof_requests.BeOkToApproveEmsofRequest(p.status))
                {
                    Label_next_reviewer.Text = p.biz_emsof_requests.NextReviewer(p.status);
                    if (DateTime.Now <= p.biz_emsof_requests.ReworkDeadline(Session["e_item"]))
                    {
                        TableRow_reject.Visible = false;
                        Button_disapprove.Text = "Return";
                    }
                    else
                    {
                        TableRow_return.Visible = false;
                        Button_disapprove.Text = "REJECT";
                    }
                }
                else
                {
                    Table_disposition_sentinel.Visible = false;
                    Table_disposition_nominal.Visible = false;
                }
                // Manage Action pending block.
                if (p.biz_emsof_requests.BeOkToMarkDone(p.status))
                {
                    Label_current_status.Text = (p.status).ToString();
                    switch(p.status)
                    {
                        case Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO:
                        case Class_biz_emsof_requests.status_type.NEEDS_INVOICE_COLLECTION:
                        case Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE:
                            Table_special_promotion.Visible = false;
                            break;
                        case Class_biz_emsof_requests.status_type.NEEDS_CANCELED_CHECK_COLLECTION:
                            Table_special_promotion.Visible = !p.be_all_costs_proven;
                            break;
                    }
                    Table_mark_failed.Visible = p.biz_emsof_requests.BeOkToMarkFailed(p.status);
                }
                else
                {
                    Table_action_pending_sentinel.Visible = false;
                    Table_action_pending_nominal.Visible = false;
                }
                // Manage Extraordinary actions block.
                TableRow_back_step.Visible = p.biz_emsof_requests.BeOkToRegress(Session["e_item"]);
                if (TableRow_back_step.Visible)
                {
                    Label_predecessor_status.Text = (p.biz_emsof_requests.StatusOf(Session["e_item"]) - 1).ToString();
                }
                TableRow_force_open.Visible = p.biz_emsof_requests.BeOkToForceOpen(Session["e_item"]);
                TableRow_force_closed.Visible = p.biz_emsof_requests.BeOkToRevokeDeadlineExemption(Session["e_item"]);
                Table_extraordinary_actions.Visible = TableRow_back_step.Visible || TableRow_force_open.Visible || TableRow_force_closed.Visible;
                if (Table_extraordinary_actions.Visible)
                {
                    Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void LinkButton_back_2_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void Button_special_promotion_Click(object sender, System.EventArgs e)
        {
            if (CheckBox_special_promotion.Checked)
            {
                p.biz_emsof_requests.MarkDone(Session["e_item"], Session["account_descriptor"].ToString());
                BackTrack();
            }
        }

        protected void Button_failed_Click(object sender, System.EventArgs e)
        {
            if (CheckBox_mark_failed.Checked)
            {
                p.biz_emsof_requests.MarkFailed(Session["e_item"], Session["account_descriptor"].ToString());
                BackTrack();
            }
        }

        protected void Button_force_close_Click(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.ForceClosed(p.request_id);
            BackTrack();
        }

        protected void Button_back_step_Click(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.Regress(p.request_id);
            BackTrack();
        }

        protected void Button_force_open_Click(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.ForceOpen(p.request_id,p.status);
            BackTrack();
        }

        private void DataGrid_proofs_of_payment_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            p.biz_emsof_requests.DeleteProofOfPayment(p.biz_emsof_requests.IdOfProofOfPayment(e.Item));
            DataGrid_proofs_of_payment.EditItemIndex =  -1;
            BindProofsOfPayment();
        }

        protected void LinkButton_new_proof_of_payment_Click(object sender, System.EventArgs e)
        {
            DropCrumbAndTransferTo("add_proof_of_payment.aspx");
        }

        protected void LinkButton_profile_Click(object sender, System.EventArgs e)
          {
          SessionSet("affiliate_num",p.biz_emsof_requests.AffiliateNumOf(Session["e_item"]));
          SessionSet("mode:profile-rendition","create-refresh-edit");
          DropCrumbAndTransferTo("responding_services_detail.aspx");
          }

        private void DataGrid_items_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
          {
            string actual_quantity;
            string actual_subtotal_cost;
            string invoice_designator;
            var priority = k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestPriority())].Text.Trim(), k.safe_hint_type.PUNCTUATED);
            var allowable_cost = k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestAllowableCost())].Text,k.safe_hint_type.REAL_NUM);
            invoice_designator = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_invoice_designator")) as TextBox).Text.Trim(), k.safe_hint_type.PUNCTUATED);
            actual_quantity = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_actual_quantity")) as TextBox).Text.Trim(), k.safe_hint_type.NUM);
            actual_subtotal_cost = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_actual_subtotal_cost")) as TextBox).Text.Trim(), k.safe_hint_type.REAL_NUM);
            var be_ok_to_end_edit_and_rebind = true;
            if ((invoice_designator != k.EMPTY) && (actual_quantity != k.EMPTY) && (actual_subtotal_cost != k.EMPTY))
              {
              var special_rules_violation = p.biz_equipment.SpecialRulesViolation(p.biz_emsof_requests.ServiceIdOf(Session["e_item"]), p.request_id, priority, p.biz_emsof_requests.EquipmentCodeOf(p.request_id, priority), actual_quantity);
              if (special_rules_violation == k.EMPTY)
                {
                p.biz_emsof_requests.SetActuals
                  (
                  p.request_id,
                  priority,
                  invoice_designator,
                  actual_quantity,
                  actual_subtotal_cost,
                  (p.parent_appropriation_amount - p.biz_emsof_requests.SumOfActualEmsofAntesOfOtherRequestItems(p.request_id,priority)).ToString(),
                  allowable_cost
                  );
                }
              else
                {
                be_ok_to_end_edit_and_rebind = false;
                Alert
                  (
                  k.alert_cause_type.APPDATA,
                  k.alert_state_type.WARNING,
                  "sperulvio",
                  "The Actual data you entered for the priority " + priority + " item violates the special rules in the Eligible Providers Equipment List.  The message for the service is: '" + special_rules_violation + "'"
                  );
                }
              }
            if (be_ok_to_end_edit_and_rebind)
              {
              DataGrid_items.EditItemIndex =  -1;
              p.biz_emsof_requests.BindDetail(p.request_id, DataGrid_items);
              }
          }

        private void DataGrid_items_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            DataGrid_items.EditItemIndex =  -1;
            p.biz_emsof_requests.BindDetail(p.request_id, DataGrid_items);
        }

        private void DataGrid_items_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            DataGrid_items.EditItemIndex = e.Item.ItemIndex;
            p.biz_emsof_requests.BindDetail(p.request_id, DataGrid_items);
        }

        protected void Button_mark_done_Click(object sender, System.EventArgs e)
          {
          if (Page.IsValid)
            {
            if (CheckBox_mark_done.Checked)
              {
              p.biz_emsof_requests.MarkDone(Session["e_item"], Session["account_descriptor"].ToString());
              BackTrack();
              }
            }
          }

        private void TWebForm_full_request_review_approve_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        protected void Button_disapprove_Click(object sender, System.EventArgs e)
        {
            string disapproval_reason;
            if (TextArea_disapproval_reason.Value != k.EMPTY)
            {
                disapproval_reason = k.Safe(TextArea_disapproval_reason.Value, k.safe_hint_type.PUNCTUATED);
                p.biz_emsof_requests.Demote(Session["e_item"], Session["account_descriptor"].ToString(), disapproval_reason, k.Safe(Label_sum_of_emsof_antes.Text, k.safe_hint_type.CURRENCY_USA));
                p.biz_emsof_request_return_comments.Log(p.biz_emsof_requests.IdOf(Session["e_item"]), Session["account_descriptor"].ToString(), disapproval_reason);
                BackTrack();
            }
        }

        protected void Button_approve_Click(object sender, System.EventArgs e)
        {
            if (CheckBox_approve.Checked)
            {
                p.biz_emsof_requests.Approve(Session["e_item"], Session["account_descriptor"].ToString());
                BackTrack();
            }
        }

        private void DataGrid_items_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[full_request_review_approve_Static.TCCI_ACTUALS].Visible = p.display_actuals;
            e.Item.Cells[full_request_review_approve_Static.TCCI_LINKBUTTONS].Visible = p.modify_actuals;
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                (e.Item.FindControl("UserControl_attachment_explorer_control") as TWebUserControl_attachment_explorer).path =
                  HttpContext.Current.Server.MapPath("attachment/emsof_request_detail/" + e.Item.Cells[full_request_review_approve_Static.TCCI_ATTACHMENT_KEY].Text);
                p.num_items = p.num_items + 1;
                p.total_emsof_ante = p.total_emsof_ante + decimal.Parse(DataBinder.Eval(e.Item.DataItem, p.biz_emsof_requests.PropertyNameOfEmsofAnte()).ToString());
            }
        }

        private void DataGrid_proofs_of_payment_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[full_request_review_approve_Static.TCCI_PROOF_OF_PAYMENT_LINKBUTTON].Visible = p.be_ok_to_track_payments;
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_proofs_of_payment = p.num_proofs_of_payment + 1;
            }
        }

        private void BindProofsOfPayment()
        {
            bool be_datagrid_empty;
            p.biz_emsof_requests.BindProofsOfPayment(p.request_id, DataGrid_proofs_of_payment);
            // Manage control visibilities.
            be_datagrid_empty = (p.num_proofs_of_payment == 0);
            TableRow_proofs_of_payment_none.Visible = be_datagrid_empty;
            DataGrid_proofs_of_payment.Visible = !be_datagrid_empty;
            // Manage related controls.
            p.sum_of_proven_payments = p.biz_emsof_requests.SumOfProvenPaymentsOfRequest(p.request_id);
            Label_total_of_proven_payments.Text = p.sum_of_proven_payments.ToString("C");
            p.be_all_costs_proven = (p.sum_of_proven_payments >= p.sum_of_actual_costs);
            Table_mark_done.Disabled = (!p.be_all_costs_proven) && (p.status != Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE);
            Table_special_promotion.Visible = !p.be_all_costs_proven;
            // Clear aggregation vars for next bind, if any.
            p.num_proofs_of_payment = 0;

        }

        private struct p_type
        {
            public bool be_all_costs_proven;
            public bool be_ok_to_track_payments;
            public TClass_biz_accounts biz_accounts;
            public TClass_biz_emsof_request_return_comments biz_emsof_request_return_comments;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_biz_equipment biz_equipment;
            public TClass_biz_services biz_services;
            public TClass_biz_user biz_user;
            public bool display_actuals;
            public bool modify_actuals;
            public uint num_items;
            public uint num_proofs_of_payment;
            public decimal parent_appropriation_amount;
            public string request_id;
            public status_type status;
            public decimal sum_of_actual_costs;
            public decimal sum_of_proven_payments;
            public decimal total_emsof_ante;
        }

        protected void Button_send_Click(object sender, EventArgs e)
          {
          k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], Label_distribution_list.Text, TextBox_quick_message_subject.Text, "-- From the " + Session[p.biz_user.Kind() + "_name"].ToString() + " County EMSOF Coordinator (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE + k.NEW_LINE + TextBox_quick_message_body.Text, false, k.EMPTY, p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()), p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()));
          TextBox_quick_message_subject.Text = k.EMPTY;
          TextBox_quick_message_body.Text = k.EMPTY;
          Alert(k.alert_cause_type.LOGIC, k.alert_state_type.NORMAL, "messagsnt", "Message sent", true);
          }

    } // end TWebForm_full_request_review_approve

  }

