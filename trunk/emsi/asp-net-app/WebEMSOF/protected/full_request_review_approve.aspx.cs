using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using System.Web.UI;
using Class_biz_emsof_request_return_comments;
using Class_biz_emsof_requests;
using Class_biz_appropriations;
namespace full_request_review_approve
{
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
                if ((Session["full_request_review_approve.p"] != null))
                {
                    p = (p_type)(Session["full_request_review_approve.p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - full_request_review_approve";
                // Initialize class private class members.
                p.biz_emsof_request_return_comments = new TClass_biz_emsof_request_return_comments();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
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
                be_beyond_invoice_collection = (new ArrayList(new status_type[] {Class_biz_emsof_requests.status_type.NEEDS_CANCELED_CHECK_COLLECTION, Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE, Class_biz_emsof_requests.status_type.REIMBURSEMENT_ISSUED}).Contains(p.status));
                Table_proofs_of_payment.Visible = be_beyond_invoice_collection;
                Table_emphasized_totals.Visible = be_beyond_invoice_collection;
                if (be_beyond_invoice_collection)
                {
                    p.sum_of_actual_costs = p.biz_emsof_requests.SumOfActualCostsOfRequestItems(p.request_id);
                    Label_total_of_actual_costs.Text = p.sum_of_actual_costs.ToString("C");
                    p.be_ok_to_track_payments = p.biz_emsof_requests.BeOkToTrackPayments(p.status);
                    LinkButton_new_proof_of_payment.Visible = p.be_ok_to_track_payments;
                    BindProofsOfPayment();
                    Label_total_of_emsof_amounts.Text = p.biz_emsof_requests.ActualValueOf(p.request_id).ToString("C");
                }
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
            p.biz_emsof_requests.ForceOpen(p.request_id);
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

        private void DataGrid_items_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            string actual_quantity;
            string actual_subtotal_cost;
            string invoice_designator;
            string priority;
            priority = k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestPriority())].Text.Trim(), k.safe_hint_type.PUNCTUATED);
            invoice_designator = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_invoice_designator")) as TextBox).Text.Trim(), k.safe_hint_type.PUNCTUATED);
            actual_quantity = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_actual_quantity")) as TextBox).Text.Trim(), k.safe_hint_type.NUM);
            actual_subtotal_cost = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfFullRequestActuals())].FindControl("TextBox_actual_subtotal_cost")) as TextBox).Text.Trim(), k.safe_hint_type.REAL_NUM);
            if ((invoice_designator != k.EMPTY) && (actual_quantity != k.EMPTY) && (actual_subtotal_cost != k.EMPTY))
            {
                p.biz_emsof_requests.SetActuals(p.request_id, priority, invoice_designator, actual_quantity, actual_subtotal_cost);
            }
            DataGrid_items.EditItemIndex =  -1;
            p.biz_emsof_requests.BindDetail(p.request_id, DataGrid_items);

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
            if (CheckBox_mark_done.Checked)
            {
                p.biz_emsof_requests.MarkDone(Session["e_item"], Session["account_descriptor"].ToString());
                BackTrack();
            }
        }

        private void TWebForm_full_request_review_approve_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("full_request_review_approve.p", p);
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
            e.Item.Cells[Units.full_request_review_approve.TCCI_ACTUALS].Visible = p.display_actuals;
            e.Item.Cells[Units.full_request_review_approve.TCCI_LINKBUTTONS].Visible = p.modify_actuals;
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_items = p.num_items + 1;
                p.total_emsof_ante = p.total_emsof_ante + decimal.Parse(DataBinder.Eval(e.Item.DataItem, p.biz_emsof_requests.PropertyNameOfEmsofAnte()).ToString());
            }
        }

        private void DataGrid_proofs_of_payment_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[Units.full_request_review_approve.TCCI_PROOF_OF_PAYMENT_LINKBUTTON].Visible = p.be_ok_to_track_payments;
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
            public TClass_biz_emsof_request_return_comments biz_emsof_request_return_comments;
            public TClass_biz_emsof_requests biz_emsof_requests;
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
        } // end p_type

    } // end TWebForm_full_request_review_approve

}

namespace full_request_review_approve.Units
{
    public class full_request_review_approve
    {
        public const int TCCI_ACTUALS = 2;
        public const int TCCI_LINKBUTTONS = 3;
        public const int TCCI_PROOF_OF_PAYMENT_LINKBUTTON = 5;
    } // end full_request_review_approve

}

