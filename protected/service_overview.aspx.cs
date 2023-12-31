using Class_biz_fiscal_years;
using Class_biz_fy_calendar;
using Class_biz_milestones;
using Class_db;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI.WebControls;

namespace service_overview
{
    public partial class TWebForm_service_overview: ki_web_ui.page_class
    {

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            DataGrid.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(DataGrid_ItemDataBound);
            DataGrid.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(DataGrid_ItemCommand);
            PreRender += TWebForm_service_overview_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - service_overview";
            string biz_get_profile_status;
            string be_stale_password;
            // make_item_requests_deadline: system.datetime;
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
                BeginBreadCrumbTrail();
                p.db = new TClass_db();
                p.db.Open();
                using var mysql_command_1 = new MySqlCommand("SELECT be_stale_password FROM service_user where id=\"" + Session["service_user_id"].ToString() + "\"", p.db.connection);
                be_stale_password = mysql_command_1.ExecuteScalar().ToString();
                if (be_stale_password == "1")
                {
                    p.db.Close();
                    DropCrumbAndTransferTo("change_password.aspx");
                }
                // Initialize implementation-scoped vars.
                p.biz_fiscal_years = new TClass_biz_fiscal_years();
                p.biz_fy_calendar = new TClass_biz_fy_calendar();
                p.be_before_deadline = true;
                p.tcci_id = 0;
                p.tcci_fy_designator = 1;
                p.tcci_county_name = 2;
                p.tcci_county_dictated_appropriation_id = 3;
                p.tcci_county_dictated_appropriation_amount = 4;
                p.tcci_status_code = 5;
                p.tcci_status = 6;
                p.tcci_value = 7;
                p.tcci_linkbutton = 8;
                p.num_dg_items = 0;
                // Set Label_profile_status
                using var mysql_command_2 = new MySqlCommand("select be_valid_profile from service where id = \"" + Session["service_user_id"].ToString() + "\"", p.db.connection);
                biz_get_profile_status = mysql_command_2.ExecuteScalar().ToString();
                if (biz_get_profile_status == "0")
                {
                    Label_profile_status.Text = "Needs review.";
                    LinkButton_profile_action.Text = "[Review]";
                    var service_annual_survey_submission_deadline = p.biz_fy_calendar.MilestoneDate(milestone_type.SERVICE_ANNUAL_SURVEY_SUBMISSION_DEADLINE);
                    var service_annual_survey_submission_deadline_string = service_annual_survey_submission_deadline.ToString("yyyy-MM-dd HH:mm:ss");
                    if (DateTime.Now <= service_annual_survey_submission_deadline)
                      {
                      Literal_relation_to_annual_survey.Text = "By reviewing and submitting your WebEMSOF profile by " + service_annual_survey_submission_deadline_string + ", you will be responding to the Annual Survey.";
                      }
                    else
                      {
                      Literal_relation_to_annual_survey.Text = "You can review and submit your WebEMSOF profile at any time, but because the Annual Survey submission deadline of " + service_annual_survey_submission_deadline_string + " has passed, the status of your "
                      + "WebEMSOF profile will not change, and you will not be eligible for allocations in this cycle.";
                      }
                    Table_item_requests_section.Visible = false;
                    p.db.Close();
                }
                else
                {
                    Label_profile_status.Text = "Is saved.";
                    LinkButton_profile_action.Text = "[Edit]";
                    Literal_relation_to_annual_survey.Text = "Your WebEMSOF profile has been accepted as your Annual Survey response.";
                    TableData_profile_printable.Visible = true;
                    // Determine current fiscal year
                    using var mysql_command_3 = new MySqlCommand("SELECT max(id) as max_id FROM fiscal_year", p.db.connection);
                    p.max_fiscal_year_id_string = mysql_command_3.ExecuteScalar().ToString();
                    // //
                    // // Determine temporal location with respect to deadline.
                    // //
                    // make_item_requests_deadline := system.datetime
                    // (
                    // MySqlCommand.Create
                    // (
                    // 'select value'
                    // + ' from fy_calendar'
                    // +   ' join fiscal_year on (fiscal_year.id = fiscal_year_id)'
                    // +   ' join milestone_code_name_map on (code = milestone_code)'
                    // + ' where id = ' + max_fiscal_year_id_string
                    // +   ' and name = "emsof-service-item-requests-deadline"',
                    // p.db.connection
                    // )
                    // .ExecuteScalar()
                    // );
                    // //
                    // be_before_deadline := (DateTime.Now <= make_item_requests_deadline);
                    p.db.Close();
                    BindDataGrid();
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            //
            // When NullReferenceException happens during a Page_Load and the Session is empty, it's because this kind of logic is being checked too late, in the Page_Load, rather than in the OnInit.
            //
            if ((Session["service_user_id"] == null) || (Session["service_name"] == null))
              {
              Session.Clear();
              Server.Transfer("~/login.aspx");
              }
        }

        private void TWebForm_service_overview_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        private void DataGrid_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            SessionSet("emsof_request_master_id", k.Safe(e.Item.Cells[(int)(p.tcci_id)].Text, k.safe_hint_type.NUM));
            SessionSet("status_code", k.Safe(e.Item.Cells[(int)(p.tcci_status_code)].Text, k.safe_hint_type.NUM));
            SessionSet("emsof_request_master_status", k.Safe(e.Item.Cells[(int)(p.tcci_status)].Text, k.safe_hint_type.PUNCTUATED));
            SessionSet("fiscal_year_designator", k.Safe(e.Item.Cells[(int)(p.tcci_fy_designator)].Text, k.safe_hint_type.ALPHANUM));
            SessionSet("sponsor_county", k.Safe(e.Item.Cells[(int)(p.tcci_county_name)].Text, k.safe_hint_type.POSTAL_CITY));
            SessionSet("county_dictated_appropriation_id", k.Safe(e.Item.Cells[(int)(p.tcci_county_dictated_appropriation_id)].Text, k.safe_hint_type.REAL_NUM));
            SessionSet("county_dictated_appropriation_amount", k.Safe(e.Item.Cells[(int)(p.tcci_county_dictated_appropriation_amount)].Text, k.safe_hint_type.REAL_NUM));
            DropCrumbAndTransferTo("request_overview.aspx");
        }

        private void DataGrid_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_dg_items++;
                // Drop the appropriate LinkButton in the Action column.
                if (p.be_before_deadline)
                {
                    if (e.Item.Cells[(int)(p.tcci_status_code)].Text == "1")
                    {
                        ((e.Item.Cells[(int)(p.tcci_linkbutton)].Controls[0]) as LinkButton).Text = "Start making item requests";
                    }
                    else if (e.Item.Cells[(int)(p.tcci_status_code)].Text == "2")
                    {
                        ((e.Item.Cells[(int)(p.tcci_linkbutton)].Controls[0]) as LinkButton).Text = "Continue making item requests";
                    }
                }
                e.Item.Cells[(int)(p.tcci_linkbutton)].Controls[0].Visible = p.be_before_deadline && (e.Item.Cells[(int)(p.tcci_status_code)].Text != "12");
                // Deemphasize requests from former cycles.
                if (e.Item.Cells[(int)(p.tcci_fy_designator)].Text != p.biz_fiscal_years.DesignatorOfCurrent())
                {
                    e.Item.Cells[(int)(p.tcci_fy_designator)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_county_name)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_county_dictated_appropriation_amount)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_status)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_value)].Enabled = false;
                }
            }
        }

        protected void LinkButton_profile_action_Click(object sender, System.EventArgs e)
        {
            SessionSet("mode:profile-rendition","create-refresh-edit");
            DropCrumbAndTransferTo("profile.aspx");
        }

        protected void LinkButton_profile_printable_Click(object sender, System.EventArgs e)
        {
            SessionSet("mode:profile-rendition","printable-report");
            DropCrumbAndTransferTo("profile.aspx");
        }

        private void BindDataGrid()
        {
            bool be_datagrid_empty;
            p.db.Open();
            //
            // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
            //
            using var mysql_command = new MySqlCommand
              (
              "SELECT emsof_request_master.id"
              + " , designator as fy_designator"
              + " , name as county_name"
              + " , county_dictated_appropriation.id as county_dictated_appropriation_id"
              + " , county_dictated_appropriation.amount as county_dictated_appropriation_amount"
              + " , status_code"
              + " , request_status_code_description_map.description as status"
              + " , if(emsof_request_master.value > emsof_request_master.actual_value,emsof_request_master.value,emsof_request_master.actual_value) as value"
              + " FROM emsof_request_master"
              +   " JOIN county_dictated_appropriation on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)"
              +   " JOIN region_dictated_appropriation on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)"
              +   " JOIN state_dictated_appropriation on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)"
              +   " JOIN fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)"
              +   " JOIN county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)"
              +   " JOIN request_status_code_description_map on (emsof_request_master.status_code = request_status_code_description_map.code)"
              + " WHERE service_id = " + Session["service_user_id"].ToString()
              +   " and fiscal_year.id >= (" + p.max_fiscal_year_id_string + " - 1)"
              + " order by fy_designator desc,county_name,emsof_request_master.id desc",
              p.db.connection
              );
            DataGrid.DataSource = mysql_command.ExecuteReader();
            DataGrid.DataBind();
            ((MySqlDataReader)(DataGrid.DataSource)).Close();
            be_datagrid_empty = (p.num_dg_items == 0);
            //
            // Manage control visibilities.
            //
            Label_no_dg_items.Visible = be_datagrid_empty;
            DataGrid.Visible = !be_datagrid_empty;
            //
            // Clear aggregation vars for next bind, if any.
            //
            p.num_dg_items = 0;
            p.db.Close();
        }

        private struct p_type
        {
            public bool be_before_deadline;
            public TClass_biz_fiscal_years biz_fiscal_years;
            public TClass_biz_fy_calendar biz_fy_calendar;
            public TClass_db db;
            public uint tcci_id;
            public uint tcci_fy_designator;
            public uint tcci_county_name;
            public uint tcci_county_dictated_appropriation_id;
            public uint tcci_county_dictated_appropriation_amount;
            public uint tcci_status_code;
            public uint tcci_status;
            public uint tcci_value;
            public uint tcci_linkbutton;
            public string max_fiscal_year_id_string;
            public uint num_dg_items;
        } // end p_type

    } // end TWebForm_service_overview

}
