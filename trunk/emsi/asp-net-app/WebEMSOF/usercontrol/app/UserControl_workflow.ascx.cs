using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_emsof_requests;
namespace UserControl_workflow
{
    public partial class TWebUserControl_workflow: ki_web_ui.usercontrol_class
    {
        private p_type p;
        private void InjectPersistentClientSideScript()
        {
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.EL);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.KGS_TO_LBS);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.LBS_TO_KGS);
            // EstablishClientSideFunction
            // (
            // 'RecalculateDependentValues()',
            // k.EMPTY
            // + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
            // +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
            // );
            // //
            // TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
            // TextBox_gross_landed_weight_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_gross_landed_weight_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );

        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string tally;
            if (!p.be_loaded)
            {
                LinkButton_num_requests_needing_development.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.ALLOCATED) + LinkButton_num_requests_needing_development.Text;
                LinkButton_num_requests_needing_finalization.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_SERVICE_FINALIZATION) + LinkButton_num_requests_needing_finalization.Text;
                LinkButton_num_requests_needing_county_approval.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_COUNTY_APPROVAL) + LinkButton_num_requests_needing_county_approval.Text;
                tally = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_COMPLIANCE_CHECK);
                LinkButton_regional_compliance.Text = tally + LinkButton_regional_compliance.Text;
                if ((tally != "0") && p.biz_emsof_requests.BeOkToApproveEmsofRequest(Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_COMPLIANCE_CHECK))
                {
                    LinkButton_regional_compliance.Font.Bold = true;
                    LinkButton_regional_compliance.Text = LinkButton_regional_compliance.Text.ToUpper();
                }
                tally = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_EXEC_DIR_APPROVAL);
                LinkButton_exec_dir_approval.Text = tally + LinkButton_exec_dir_approval.Text;
                if ((tally != "0") && p.biz_emsof_requests.BeOkToApproveEmsofRequest(Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_EXEC_DIR_APPROVAL))
                {
                    LinkButton_exec_dir_approval.Font.Bold = true;
                    LinkButton_exec_dir_approval.Text = LinkButton_exec_dir_approval.Text.ToUpper();
                }
                LinkButton_transmittal.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO) + LinkButton_transmittal.Text;
                LinkButton_state_approval.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_PA_DOH_EMSO_APPROVAL) + LinkButton_state_approval.Text;
                LinkButton_invoice_collection.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_INVOICE_COLLECTION) + LinkButton_invoice_collection.Text;
                LinkButton_canceled_check_collection.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_CANCELED_CHECK_COLLECTION) + LinkButton_canceled_check_collection.Text;
                tally = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE);
                LinkButton_reimbursement.Text = tally + LinkButton_reimbursement.Text;
                if ((tally != "0"))
                {
                    LinkButton_reimbursement.Font.Bold = true;
                    LinkButton_reimbursement.Text = LinkButton_reimbursement.Text.ToUpper();
                }
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_all);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_num_requests_needing_development);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_num_requests_needing_finalization);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_num_requests_needing_county_approval);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_regional_compliance);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_exec_dir_approval);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_transmittal);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_state_approval);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_invoice_collection);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_canceled_check_collection);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_reimbursement);
                p.be_loaded = true;
            }
            InjectPersistentClientSideScript();

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session[InstanceId() + ".p"] != null)
            {
                p = (p_type)(Session[InstanceId() + ".p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_workflow");
            }
            else
            {
                p.be_loaded = false;
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebUserControl_workflow_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_workflow_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_workflow Fresh()
        {
            TWebUserControl_workflow result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        protected void LinkButton_all_Click(object sender, System.EventArgs e)
        {
            DropCrumbAndTransferTo("all_emsof_requests.aspx");
        }

        protected void LinkButton_reimbursement_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_REIMBURSEMENT_ISSUANCE);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_canceled_check_collection_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_CANCELED_CHECK_COLLECTION);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_invoice_collection_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_INVOICE_COLLECTION);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_state_approval_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_PA_DOH_EMSO_APPROVAL);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_transmittal_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO);
            DropCrumbAndTransferTo("state_required_report.aspx");
        }

        protected void LinkButton_exec_dir_approval_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_EXEC_DIR_APPROVAL);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_num_requests_needing_county_approval_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_COUNTY_APPROVAL);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_num_requests_needing_finalization_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_SERVICE_FINALIZATION);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_num_requests_needing_development_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.ALLOCATED);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_regional_compliance_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_REGIONAL_COMPLIANCE_CHECK);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        private struct p_type
        {
            public bool be_loaded;
            public TClass_biz_emsof_requests biz_emsof_requests;
        }

        protected void LinkButton_transmittal_adjustments_Click(object sender, EventArgs e)
          {
          SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO);
          DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
          }

    } // end TWebUserControl_workflow

}
