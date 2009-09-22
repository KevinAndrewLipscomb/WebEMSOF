using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using Class_biz_emsof_requests;
using Class_biz_equipment;
using Class_biz_fiscal_years;
namespace equipment_procurement_detail
{
    public partial class TWebForm_equipment_procurement_detail: ki_web_ui.page_class
    {
        private p_type p;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.GridView_control.Sorting += new System.Web.UI.WebControls.GridViewSortEventHandler(this.GridView_control_Sorting);
            this.PreRender += this.TWebForm_equipment_procurement_detail_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string cycle;
            if (!IsPostBack)
            {
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - equipment_procurement_detail";
                cycle = Session["equipment_procurement_cycle"].ToString();
                p.biz_equipment.BindListControl(cycle, DropDownList_equipment);
                p.biz_fiscal_years.BindListControl(DropDownList_cycle);
                DropDownList_cycle.SelectedValue = cycle;
                DropDownList_equipment.SelectedValue = Session["equipment_procurement_code"].ToString();
                Bind();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (IsPostBack)
            {
                if ((Session["equipment_procurement_detail.p"] != null))
                {
                    p = (p_type)(Session["equipment_procurement_detail.p"]);
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
                else
                {
                    p.biz_emsof_requests = new TClass_biz_emsof_requests();
                    p.biz_equipment = new TClass_biz_equipment();
                    p.biz_fiscal_years = new TClass_biz_fiscal_years();
                    p.be_sort_order_ascending = false;
                    p.sort_order = "name";
                }
            }

        }

        private void GridView_control_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
        {
            if (e.SortExpression == p.sort_order)
            {
                p.be_sort_order_ascending = !p.be_sort_order_ascending;
            }
            else
            {
                p.sort_order = e.SortExpression;
                p.be_sort_order_ascending = true;
            }
            GridView_control.EditIndex =  -1;
            Bind();
        }

        protected void DropDownList_equipment_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            Bind();
        }

        protected void DropDownList_cycle_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            p.biz_equipment.BindListControl(k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM), DropDownList_equipment);
            Bind();
        }

        private void TWebForm_equipment_procurement_detail_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("equipment_procurement_detail.p", p);
        }

        private void Bind()
        {
            p.biz_emsof_requests.BindEquipmentProcurementDetail(k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM), k.Safe(DropDownList_equipment.SelectedValue, k.safe_hint_type.NUM), p.sort_order, p.be_sort_order_ascending, GridView_control);
        }

        private struct p_type
        {
            public bool be_sort_order_ascending;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_biz_equipment biz_equipment;
            public TClass_biz_fiscal_years biz_fiscal_years;
            public string sort_order;
        } // end p_type

    } // end TWebForm_equipment_procurement_detail

}
