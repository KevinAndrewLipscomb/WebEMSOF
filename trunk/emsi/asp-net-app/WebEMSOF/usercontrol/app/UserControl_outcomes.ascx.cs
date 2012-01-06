using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_emsof_requests;
namespace UserControl_outcomes
{
    public partial class TWebUserControl_outcomes: ki_web_ui.usercontrol_class
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
            if (!p.be_loaded)
            {
                LinkButton_completed.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.REIMBURSEMENT_ISSUED) + LinkButton_completed.Text;
                LinkButton_missed_deadlines.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.FAILED_DEADLINE) + LinkButton_missed_deadlines.Text;
                LinkButton_withdrawn.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.WITHDRAWN) + LinkButton_withdrawn.Text;
                LinkButton_rejected.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.REJECTED) + LinkButton_rejected.Text;
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_completed);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_missed_deadlines);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_withdrawn);
                ScriptManager.GetCurrent(Page).RegisterPostBackControl(LinkButton_rejected);
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_regional_staffer_current_binder_PlaceHolder_content_PlaceHolder_content"] as string) == "UserControl_outcomes");
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
            this.PreRender += this.TWebUserControl_outcomes_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_outcomes_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_outcomes Fresh()
        {
            TWebUserControl_outcomes result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        protected void LinkButton_rejected_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.REJECTED);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_withdrawn_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.WITHDRAWN);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_completed_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.REIMBURSEMENT_ISSUED);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        protected void LinkButton_missed_deadlines_Click(object sender, System.EventArgs e)
        {
            SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.FAILED_DEADLINE);
            DropCrumbAndTransferTo("emsof_request_status_filter.aspx");
        }

        private struct p_type
        {
            public bool be_loaded;
            public TClass_biz_emsof_requests biz_emsof_requests;
        } // end p_type

    } // end TWebUserControl_outcomes

}
