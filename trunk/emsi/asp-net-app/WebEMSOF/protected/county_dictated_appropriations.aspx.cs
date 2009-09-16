using Class_biz_accounts;
using Class_biz_appropriations;
using Class_biz_emsof_requests;
using Class_biz_services;
using Class_biz_user;
using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace county_dictated_appropriations
{
    public partial class TWebForm_county_dictated_appropriations: ki_web_ui.page_class
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
            this.DataGrid_service_appropriations.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_service_appropriations_ItemDataBound);
            this.DataGrid_service_appropriations.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_service_appropriations_CancelCommand);
            this.DataGrid_service_appropriations.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_service_appropriations_EditCommand);
            this.DataGrid_service_appropriations.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_service_appropriations_SortCommand);
            this.DataGrid_service_appropriations.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_service_appropriations_ItemCommand);
            this.DataGrid_service_appropriations.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_service_appropriations_DeleteCommand);
            this.DataGrid_service_appropriations.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_service_appropriations_UpdateCommand);
            this.PreRender += this.TWebForm_county_dictated_appropriations_PreRender;
            this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr_appropriation_attribs;
            DateTime county_dictated_deadline;
            DateTime make_appropriations_deadline;
            if (IsPostBack)
            {
                if ((Session["county_dictated_appropriations.p"] != null))
                {
                    p = (p_type)(Session["county_dictated_appropriations.p"]);
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
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_services = new TClass_biz_services();
                p.biz_user = new TClass_biz_user();
                p.be_before_deadline = true;
                p.be_sort_order_ascending = true;
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                p.num_appropriations = 0;
                p.sort_order = "service_name";
                p.status_filter = k.EMPTY;
                p.sum_of_service_appropriations = 0;
                p.unappropriated_amount = 0;
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - county_dictated_appropriations";
                p.db.Open();
                // Set parent appropriation labels.
                dr_appropriation_attribs = new MySqlCommand("select fiscal_year.designator,region_dictated_appropriation.amount,region_code_name_map.name " + "from region_dictated_appropriation " + "join state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id) " + "join fiscal_year on (fiscal_year.id = fiscal_year_id) " + "join region_code_name_map on (region_code_name_map.code = region_code) " + "where region_dictated_appropriation.id = " + Session["region_dictated_appropriation_id"].ToString(), p.db.connection).ExecuteReader();
                dr_appropriation_attribs.Read();
                Label_fiscal_year_designator.Text = dr_appropriation_attribs["designator"].ToString();
                p.region_dictated_appropriation_amount = (decimal)(dr_appropriation_attribs["amount"]);
                Label_parent_appropriation_amount.Text = p.region_dictated_appropriation_amount.ToString("C");
                Label_region_name.Text = dr_appropriation_attribs["name"].ToString();
                Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                dr_appropriation_attribs.Close();
                // All further rendering is deadline-dependent.
                make_appropriations_deadline = (DateTime)(new MySqlCommand("select value" + " from fy_calendar" + " join fiscal_year on (fiscal_year.id = fiscal_year_id)" + " join milestone_code_name_map on (code = milestone_code)" + " where designator = \"" + k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM) + "\"" + " and name = \"emsof-county-dictated-appropriation-deadline\"", p.db.connection).ExecuteScalar());
                county_dictated_deadline = (DateTime)(new MySqlCommand("select service_to_county_submission_deadline from region_dictated_appropriation" + " where id = " + Session["region_dictated_appropriation_id"].ToString(), p.db.connection).ExecuteScalar());
                SessionSet("county_dictated_deadline", county_dictated_deadline);
                if (DateTime.Now > make_appropriations_deadline)
                {
                    p.be_before_deadline = false;
                    TableRow_sum_of_service_appropriations.Visible = false;
                    TableRow_unappropriated_amount.Visible = false;
                    Table_deadlines.Visible = false;
                    LinkButton_new_appropriation.Visible = false;
                }
                else
                {
                    Label_make_appropriations_deadline.Text = make_appropriations_deadline.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                    LinkButton_county_dictated_deadline.Text = county_dictated_deadline.ToString("HH:mm:ss dddd, MMMM d, yyyy");
                }
                p.db.Close();
                Table_warning_forced_amount.Visible = false;
                Bind_service_appropriations();
                // also affected by be_before_deadline
                BeginBreadCrumbTrail();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);

        }

        protected void DropDownList_status_filter_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            p.status_filter = k.Safe(DropDownList_status_filter.SelectedValue, k.safe_hint_type.NUM);
            Bind_service_appropriations();
        }

        protected void DropDownList_quick_message_targets_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            Bind_distribution_target();
        }

        protected void Button_send_Click(object sender, System.EventArgs e)
        {
            // from
            // to
            // subject
            // body
            // be_html
            // cc
            // bcc
            // reply_to
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], Label_distribution_list.Text, TextBox_quick_message_subject.Text, "-- From the " + Session[p.biz_user.Kind() + "_name"].ToString() + " County EMSOF Coordinator (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE + k.NEW_LINE + TextBox_quick_message_body.Text, false, k.EMPTY, k.EMPTY, p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()));
            TextBox_quick_message_subject.Text = k.EMPTY;
            TextBox_quick_message_body.Text = k.EMPTY;
            Alert(k.alert_cause_type.LOGIC, k.alert_state_type.NORMAL, "messagsnt", "Message sent", true);
        }

        private void TWebForm_county_dictated_appropriations_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("county_dictated_appropriations.p", p);
        }

        private void DataGrid_service_appropriations_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
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
            Table_warning_forced_amount.Visible = false;
            DataGrid_service_appropriations.EditItemIndex =  -1;
            Bind_service_appropriations();
        }

        protected void LinkButton_new_appropriation_Click(object sender, System.EventArgs e)
        {
            SessionSet("parent_appropriation_amount", k.Safe(Label_parent_appropriation_amount.Text, k.safe_hint_type.REAL_NUM));
            SessionSet("region_name", k.Safe(Label_region_name.Text, k.safe_hint_type.ORG_NAME));
            SessionSet("fiscal_year_designator", k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM));
            SessionSet("sum_of_service_appropriations", k.Safe(Label_sum_of_service_appropriations.Text, k.safe_hint_type.REAL_NUM));
            SessionSet("unappropriated_amount", p.unappropriated_amount);
            DropCrumbAndTransferTo("create_new_service_appropriation.aspx");
        }

        private void DataGrid_service_appropriations_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            Stack waypoint_stack;
            if (e.CommandName == "Select")
            {
                SessionSet("calling_form", "county_dictated_appropriations.aspx");
                SessionSet("account_descriptor", Session["county_name"].ToString() + " County");
                SessionSet("e_item", e.Item);
                Session.Remove("waypoint_stack");
                waypoint_stack = new System.Collections.Stack();
                waypoint_stack.Push("county_dictated_appropriations.aspx");
                Session.Add("waypoint_stack", waypoint_stack);
                DropCrumbAndTransferTo("full_request_review_approve.aspx");
            }
            else if (e.CommandName == "Edit")
            {
                p.saved_amount = decimal.Parse(k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfAppropriation())].Text, k.safe_hint_type.REAL_NUM));
            }
        }

        protected void LinkButton_county_dictated_deadline_Click(object sender, System.EventArgs e)
        {
            SessionSet("county_dictated_deadline", LinkButton_county_dictated_deadline.Text);
            DropCrumbAndTransferTo("county_dictated_deadline.aspx");
        }

        private void DataGrid_service_appropriations_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            MySqlCommand bc;
            string id_string;
            p.db.Open();
            id_string = k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfId())].Text, k.safe_hint_type.NUM);
            // Leaving the star out prevents inclusion of nulls in count
            bc = new MySqlCommand("select count(master_id)" + " from emsof_request_detail" + " join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)" + " where county_dictated_appropriation_id = " + id_string, p.db.connection);
            if (bc.ExecuteScalar().ToString() != "0")
            {
                p.db.Close();
                // A service has already entered equipment requests against this appropriation.  Add relevant data to the session and send the
                // county coordinator to a confirmation page.
                SessionSet("id_of_appropriation_selected_for_deletion", id_string);
                Session.Remove("email_address_of_service_of_appropriation_selected_for_deletion");
                Session.Add("email_address_of_service_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text, k.safe_hint_type.EMAIL_ADDRESS));
                Session.Remove("service_name_of_appropriation_selected_for_deletion");
                Session.Add("service_name_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfServiceName())].Text, k.safe_hint_type.ORG_NAME));
                Session.Remove("amount_of_appropriation_selected_for_deletion");
                Session.Add("amount_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfAppropriation())].Text, k.safe_hint_type.REAL_NUM));
                DropCrumbAndTransferTo("delete_service_appropriation.aspx");
            }
            else
            {
                // Nothing is linked to this appropriation, so go ahead and delete it.
                new MySqlCommand(p.db_trail.Saved("delete from county_dictated_appropriation where id = " + id_string), p.db.connection).ExecuteNonQuery();
                // Send a notification message.
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text, k.safe_hint_type.EMAIL_ADDRESS), "Deletion of " + ConfigurationManager.AppSettings["application_name"] + " allocation for your service", "The " + Session["county_name"].ToString() + " County EMSOF Coordinator has deleted an EMSOF allocation from your " + "service for " + k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM) + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "For an overview of your EMSOF allocations, visit:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["county_name"].ToString() + " County EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + Session["county_user_password_reset_email_address"].ToString() + "  (mailto:" + Session["county_user_password_reset_email_address"].ToString() + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, Session["county_user_password_reset_email_address"].ToString());
                p.db.Close();
            }
            Table_warning_forced_amount.Visible = false;
            DataGrid_service_appropriations.EditItemIndex =  -1;
            Bind_service_appropriations();
        }

        private void DataGrid_service_appropriations_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            decimal leftover_or_shortage;
            // Manage column visibility
            e.Item.Cells[Units.county_dictated_appropriations.TCCI_LINKBUTTON_EDIT].Visible = p.be_before_deadline;
            e.Item.Cells[Units.county_dictated_appropriations.TCCI_LINKBUTTON_DELETE].Visible = p.be_before_deadline;
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_appropriations = p.num_appropriations + 1;
                if (!(DropDownList_status_filter.Items.FindByValue(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text) != null))
                {
                    DropDownList_status_filter.Items.Add(new ListItem(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Text, e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text));
                }
                // Manage the way some of the row values are rendered.
                // By default, do not display the Leftover / Shortage value.  But save it off just in case.
                leftover_or_shortage = decimal.Parse(k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfLeftoverOrShortage())].Text, k.safe_hint_type.REAL_NUM_INCLUDING_NEGATIVE));
                e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfLeftoverOrShortage())].Text = k.EMPTY;
                if (Convert.ToInt16(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text) > 2)
                {
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Enabled = true;
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).ForeColor = Color.Blue;
                    if (Convert.ToInt16(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text) >= 3)
                    {
                        if (Convert.ToInt16(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text) == 3)
                        {
                            // Make the need for county approval abundantly conspicuous.
                            ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Font.Bold = true;
                            ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Text = ">" + ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Text.ToUpper() + "<";
                            // Manage the way the Leftover / Shortage is rendered, if at all.
                            if ((leftover_or_shortage != 0))
                            {
                                e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfLeftoverOrShortage())].Text = leftover_or_shortage.ToString("N2");
                                // Must use N format above to preserve unary minus sign on shortages, else approval code won't work.
                                if ((leftover_or_shortage < 0))
                                {
                                    e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfLeftoverOrShortage())].ForeColor = Color.Red;
                                }
                            }
                        }
                        ((e.Item.Cells[Units.county_dictated_appropriations.TCCI_LINKBUTTON_EDIT].Controls[0]) as LinkButton).Visible = false;
                        ((e.Item.Cells[Units.county_dictated_appropriations.TCCI_LINKBUTTON_DELETE].Controls[0]) as LinkButton).Visible = false;
                    }
                }
                else
                {
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Enabled = false;
                }
                if (e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text != "&nbsp;")
                {
                    p.distribution_list_for_services_with_allocations = p.distribution_list_for_services_with_allocations + e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text + k.COMMA_SPACE;
                }
            }
        }

        private void DataGrid_service_appropriations_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            decimal amount;
            string amount_string;
            string appropriation_id_string;
            p.db.Open();
            appropriation_id_string = k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfId())].Text, k.safe_hint_type.NUM);
            amount_string = k.Safe(((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfAppropriation())].Controls[0]) as TextBox).Text.Trim(), k.safe_hint_type.REAL_NUM);
            if (amount_string != k.EMPTY)
            {
                amount = decimal.Parse(amount_string);
                if ((amount - p.saved_amount) > p.unappropriated_amount)
                {
                    amount = p.saved_amount + p.unappropriated_amount;
                    Table_warning_forced_amount.Visible = true;
                }
                else
                {
                    Table_warning_forced_amount.Visible = false;
                }
                new MySqlCommand(p.db_trail.Saved("update county_dictated_appropriation set amount = " + amount.ToString() + " where id = " + appropriation_id_string), p.db.connection).ExecuteNonQuery();
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], k.Safe(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text, k.safe_hint_type.EMAIL_ADDRESS), "Modification of " + ConfigurationManager.AppSettings["application_name"] + " allocation for your service", "The " + Session["county_name"].ToString() + " County EMSOF Coordinator has modified an EMSOF allocation for your " + "service for " + k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM) + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "You can work on this allocation by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["county_name"].ToString() + " County EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + Session["county_user_password_reset_email_address"].ToString() + "  (mailto:" + Session["county_user_password_reset_email_address"].ToString() + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, Session["county_user_password_reset_email_address"].ToString());
                p.db.Close();
                DataGrid_service_appropriations.EditItemIndex =  -1;
                Bind_service_appropriations();
            }
        }

        private void DataGrid_service_appropriations_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            Table_warning_forced_amount.Visible = false;
            DataGrid_service_appropriations.EditItemIndex =  -1;
            Bind_service_appropriations();
        }

        private void DataGrid_service_appropriations_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            DataGrid_service_appropriations.EditItemIndex = e.Item.ItemIndex;
            Bind_service_appropriations();
        }

        private void Bind_service_appropriations()
        {
            bool be_datagrid_empty;
            if (DropDownList_status_filter.Items.Count == 0)
            {
                DropDownList_status_filter.Items.Add(new ListItem("(all)", k.EMPTY));
            }
            p.distribution_list_for_services_with_allocations = k.EMPTY;
            if (p.status_filter != k.EMPTY)
            {
                p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus(Session["region_dictated_appropriation_id"].ToString(), ((status_type)(Convert.ToInt16(p.status_filter))), p.sort_order, p.be_sort_order_ascending, DataGrid_service_appropriations);
                DropDownList_status_filter.SelectedValue = p.status_filter;
            }
            else
            {
                p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriation(Session["region_dictated_appropriation_id"].ToString(), p.sort_order, p.be_sort_order_ascending, DataGrid_service_appropriations);
            }
            // Manage control visibilities.
            be_datagrid_empty = (p.num_appropriations == 0);
            Label_no_appropriations.Visible = be_datagrid_empty;
            DataGrid_service_appropriations.Visible = !be_datagrid_empty;
            // Manage non-DataGrid control properties.
            p.sum_of_service_appropriations = p.biz_appropriations.SumOfSelfDictatedAppropriations();
            Label_sum_of_service_appropriations.Text = p.sum_of_service_appropriations.ToString("C");
            p.unappropriated_amount = p.region_dictated_appropriation_amount - p.sum_of_service_appropriations;
            Label_unappropriated_amount.Text = p.unappropriated_amount.ToString("C");
            if (p.unappropriated_amount < 0)
            {
                Label_unappropriated_amount.Font.Bold = true;
                Label_unappropriated_amount.ForeColor = Color.Red;
            }
            Bind_distribution_target();
            // Clear aggregation vars for next bind, if any.
            p.num_appropriations = 0;
            p.sum_of_service_appropriations = 0;
        }

        private void Bind_distribution_target()
        {
            if (DropDownList_quick_message_targets.SelectedValue == "with_allocations")
            {
                Label_distribution_list.Text = (p.distribution_list_for_services_with_allocations + k.SPACE).TrimEnd(new char[] {k.COMMA, k.SPACE});
            }
            else if (DropDownList_quick_message_targets.SelectedValue == "emsof_participants_true")
            {
                Label_distribution_list.Text = p.biz_services.EmailTargetForCounty(p.biz_user.IdNum(), true, true);
            }
            else if (DropDownList_quick_message_targets.SelectedValue == "emsof_participants_false")
            {
                Label_distribution_list.Text = p.biz_services.EmailTargetForCounty(p.biz_user.IdNum(), true, false);
            }
            else if (DropDownList_quick_message_targets.SelectedValue == "in_county")
            {
                Label_distribution_list.Text = p.biz_services.EmailTargetForCounty(p.biz_user.IdNum());
            }
            TextBox_quick_message_subject.Enabled = Label_distribution_list.Text != k.EMPTY;
            TextBox_quick_message_body.Enabled = Label_distribution_list.Text != k.EMPTY;
            Button_send.Enabled = Label_distribution_list.Text != k.EMPTY;

        }

        private struct p_type
        {
            public TClass_biz_accounts biz_accounts;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_biz_services biz_services;
            public TClass_biz_user biz_user;
            public bool be_before_deadline;
            public bool be_sort_order_ascending;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public string distribution_list_for_services_with_allocations;
            public uint num_appropriations;
            public decimal region_dictated_appropriation_amount;
            public decimal saved_amount;
            public string sort_order;
            public string status_filter;
            public decimal sum_of_service_appropriations;
            public decimal unappropriated_amount;
        } // end p_type

    } // end TWebForm_county_dictated_appropriations

}

namespace county_dictated_appropriations.Units
{
    public class county_dictated_appropriations
    {
        public const int TCCI_LINKBUTTON_EDIT = 14;
        public const int TCCI_LINKBUTTON_DELETE = 15;
    } // end county_dictated_appropriations

}

