using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_emsof_requests;
using Class_biz_fiscal_years;
namespace UserControl_equipment_procurement_overview
{
    public struct p_type
    {
        public bool be_interactive;
        public bool be_loaded;
        public bool be_sort_order_ascending;
        public TClass_biz_emsof_requests biz_emsof_requests;
        public TClass_biz_fiscal_years biz_fiscal_years;
        public string cycle;
        public string sort_order;
    } // end p_type

    public class TWebUserControl_equipment_procurement_overview: ki_web_ui.usercontrol_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.Label Label_application_name = null;
        protected System.Web.UI.WebControls.DataGrid DataGrid_control = null;
        protected System.Web.UI.WebControls.DropDownList DropDownList_cycle = null;
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

        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                p.biz_fiscal_years.BindListControl(DropDownList_cycle);
                p.cycle = k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM);
                if (!p.be_interactive)
                {
                    DropDownList_cycle.Enabled = false;
                    DataGrid_control.AllowSorting = false;
                }
                Bind();
                p.be_loaded = true;
            }
            InjectPersistentClientSideScript();

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session["UserControl_equipment_procurement_overview.p"] != null)
            {
                p = (p_type)(Session["UserControl_equipment_procurement_overview.p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_control_UserControl_analyses_binder_UserControl_equipment_procurement_binder_PlaceHolder_content"] as string) == "UserControl_equipment_procurement_overview");
            }
            else
            {
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_fiscal_years = new TClass_biz_fiscal_years();
                p.be_interactive = !(Session["mode:report"] != null);
                p.be_loaded = false;
                p.be_sort_order_ascending = false;
                p.sort_order = "emsof_part%";
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DropDownList_cycle.SelectedIndexChanged += new System.EventHandler(this.DropDownList_cycle_SelectedIndexChanged);
            this.DataGrid_control.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_control_ItemDataBound);
            this.DataGrid_control.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_control_SortCommand);
            this.DataGrid_control.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_control_ItemCommand);
            this.PreRender += this.TWebUserControl_equipment_procurement_overview_PreRender;
            this.Load += this.Page_Load;
        }

        private void TWebUserControl_equipment_procurement_overview_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("UserControl_equipment_procurement_overview.p", p);
        }

        public TWebUserControl_equipment_procurement_overview Fresh()
        {
            TWebUserControl_equipment_procurement_overview result;
            Session.Remove("UserControl_equipment_procurement_overview.p");
            result = this;
            return result;
        }

        private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
            {
                SessionSet("equipment_procurement_cycle", p.cycle);
                SessionSet("equipment_procurement_code", k.Safe(e.Item.Cells[Units.UserControl_equipment_procurement_overview.TCI_CODE].Text, k.safe_hint_type.NUM));
                DropCrumbAndTransferTo("equipment_procurement_detail.aspx");
            }
        }

        private void DataGrid_control_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            LinkButton link_button;
            e.Item.Cells[Units.UserControl_equipment_procurement_overview.TCI_CODE].Visible = false;
            if (p.be_interactive)
            {
                if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
                {
                    link_button = ((e.Item.Cells[Units.UserControl_equipment_procurement_overview.TCI_SELECT].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                }
            }
            else
            {
                e.Item.Cells[Units.UserControl_equipment_procurement_overview.TCI_SELECT].Visible = false;
            }
        }

        private void DataGrid_control_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
        {
            if (e.SortExpression == p.sort_order)
            {
                p.be_sort_order_ascending = !p.be_sort_order_ascending;
            }
            else
            {
                p.sort_order = k.Safe(e.SortExpression, k.safe_hint_type.KI_SORT_EXPRESSION);
                p.be_sort_order_ascending = true;
            }
            DataGrid_control.EditItemIndex =  -1;
            Bind();
        }

        private void DropDownList_cycle_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            p.cycle = k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM);
            Bind();
        }

        private void Bind()
        {
            p.biz_emsof_requests.BindEquipmentProcurementOverview(p.cycle, p.sort_order, p.be_sort_order_ascending, DataGrid_control, !p.be_interactive);
        }

    } // end TWebUserControl_equipment_procurement_overview

}

namespace UserControl_equipment_procurement_overview.Units
{
    public class UserControl_equipment_procurement_overview
    {
        public const int TCI_SELECT = 0;
        public const int TCI_CODE = 1;
    } // end UserControl_equipment_procurement_overview

}

