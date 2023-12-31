using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using Class_biz_emsof_requests;
namespace county_unrejection
{
  public partial class TWebForm_county_unrejection: ki_web_ui.page_class
    {

    private struct p_type
      {
      public bool be_datagrid_empty;
        public bool be_sort_order_ascending;
        public TClass_biz_emsof_requests biz_emsof_requests;
        public uint num_datagrid_rows;
        public string sort_order;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            DataGrid_unrejectable_requests.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(Datagrid_unrejectable_requests_ItemCommand);
            DataGrid_unrejectable_requests.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(Datagrid_unrejectable_requests_SortCommand);
            DataGrid_unrejectable_requests.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(Datagrid_unrejectable_requests_ItemDataBound);
            PreRender += TWebForm_county_unrejection_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - county_unrejection";
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
                    // The request for this page could not have been the result of a Server.Transfer call, and the session state is therefore unknown.  This is rarely allowed.
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                else
                {
                    // Initialize implementation-wide vars.
                    p.be_sort_order_ascending = true;
                    p.biz_emsof_requests = new TClass_biz_emsof_requests();
                    p.num_datagrid_rows = 0;
                    p.sort_order = "service_name";
                    Bind();
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void LinkButton_unreject_all_Click(object sender, System.EventArgs e)
        {
            uint i;
            if (DataGrid_unrejectable_requests.Items.Count > 0)
            {
                for (i = 0; i < DataGrid_unrejectable_requests.Items.Count; i ++ )
                {
                    p.biz_emsof_requests.Unreject(DataGrid_unrejectable_requests.Items[(int)i], "county", "The " + Session["county_name"].ToString() + " County EMSOF Coordinator");
                }
                Bind();
            }
        }

        protected void LinkButton_county_dictated_appropriations_Click(object sender, System.EventArgs e)
        {
            BackTrack(2);
        }

        private void Datagrid_unrejectable_requests_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (e.CommandName == "Unreject")
            {
                p.biz_emsof_requests.Unreject(e.Item, "county", "The " + Session["county_name"].ToString() + " County EMSOF Coordinator");
                Bind();
            }
        }

        private void TWebForm_county_unrejection_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        private void Datagrid_unrejectable_requests_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_datagrid_rows++;
            }
        }

        private void Datagrid_unrejectable_requests_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
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
            DataGrid_unrejectable_requests.EditItemIndex =  -1;
            Bind();
        }

        private void Bind()
        {
            p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus(Session["region_dictated_appropriation_id"].ToString(), Class_biz_emsof_requests.status_type.REJECTED, p.sort_order, p.be_sort_order_ascending, DataGrid_unrejectable_requests);
            // Manage control visibilities.
            p.be_datagrid_empty = (p.num_datagrid_rows == 0);
            TableRow_none.Visible = p.be_datagrid_empty;
            DataGrid_unrejectable_requests.Visible = !p.be_datagrid_empty;
            // Clear aggregation vars for next bind, if any.
            p.num_datagrid_rows = 0;

        }

    } // end TWebForm_county_unrejection

}

namespace county_unrejection.Units
{
    public class county_unrejection
    {
        public const string ID = "$Id: county_unrejection.pas 2516 2008-08-29 22:02:49Z kevinanlipscomb $";
    } // end county_unrejection

}

