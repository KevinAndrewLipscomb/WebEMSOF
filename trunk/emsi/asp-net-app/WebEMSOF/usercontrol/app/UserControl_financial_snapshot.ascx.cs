using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_appropriations;
using Class_biz_emsof_requests;
using Class_biz_fiscal_years;
using Class_biz_regional_staffers;
namespace UserControl_financial_snapshot
{
    public partial class TWebUserControl_financial_snapshot: ki_web_ui.usercontrol_class
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
            decimal amount_actually_spent;
            decimal parent_appropriation;
            decimal sum_of_appropriations;
            if (!p.be_loaded)
            {
                parent_appropriation = p.biz_appropriations.SumOfAppropriationsFromOnlyParent();
                Label_parent_appropriation.Text = parent_appropriation.ToString("C");
                sum_of_appropriations = p.biz_appropriations.SumOfSelfDictatedAppropriations();
                Label_sum_of_appropriations.Text = sum_of_appropriations.ToString("C");
                Label_appropriated_to_services.Text = p.biz_appropriations.SumOfAppropriationsToServicesInRegion(p.biz_regional_staffers.RegionCodeOf(Session["regional_staffer_user_id"].ToString()), p.biz_fiscal_years.IdOfCurrent()).ToString("C");
                Label_requested_by_services.Text = p.biz_emsof_requests.SumOfRequestValues().ToString("C");
                amount_actually_spent = p.biz_emsof_requests.SumOfActualValues();
                Label_actually_spent.Text = amount_actually_spent.ToString("C");
                Label_remaining.Text = (parent_appropriation - amount_actually_spent).ToString("C");
                p.be_loaded = true;
            }
            InjectPersistentClientSideScript();

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session["UserControl_financial_snapshot.p"] != null)
            {
                p = (p_type)(Session["UserControl_financial_snapshot.p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_control_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_financial_snapshot");
            }
            else
            {
                p.be_loaded = false;
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_fiscal_years = new TClass_biz_fiscal_years();
                p.biz_regional_staffers = new TClass_biz_regional_staffers();
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebUserControl_financial_snapshot_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_financial_snapshot_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("UserControl_financial_snapshot.p", p);
        }

        public TWebUserControl_financial_snapshot Fresh()
        {
            TWebUserControl_financial_snapshot result;
            Session.Remove("UserControl_financial_snapshot.p");
            result = this;
            return result;
        }

        private struct p_type
        {
            public bool be_loaded;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_biz_fiscal_years biz_fiscal_years;
            public TClass_biz_regional_staffers biz_regional_staffers;
        } // end p_type

    } // end TWebUserControl_financial_snapshot

}
