using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_match_level;
using UserControl_drop_down_date;
namespace UserControl_match_level
{
    public partial class TWebUserControl_match_level: ki_web_ui.usercontrol_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.Label Label_application_name = null;
        private void Clear()
        {
            TextBox_name.Text = k.EMPTY;
            DropDownList_name.Visible = false;
            TextBox_factor.Text = k.EMPTY;
      Literal_match_index.Text = k.EMPTY;
      Literal_num_matches.Text = k.EMPTY;
      Panel_match_numbers.Visible = false;
      LinkButton_go_to_match_prior.Visible = false;
      LinkButton_go_to_match_next.Visible = false;
      LinkButton_go_to_match_last.Visible = false;
      LinkButton_go_to_match_first.Visible = false;
            SetDependentFieldAblements(false);
            Button_submit.Enabled = false;
            Button_delete.Enabled = false;

        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                LinkButton_new_record.Visible = p.be_ok_to_config_match_levels;
                LinkButton_go_to_match_first.Text = k.ExpandTildePath(LinkButton_go_to_match_first.Text);
                LinkButton_go_to_match_prior.Text = k.ExpandTildePath(LinkButton_go_to_match_prior.Text);
                LinkButton_go_to_match_next.Text = k.ExpandTildePath(LinkButton_go_to_match_next.Text);
                LinkButton_go_to_match_last.Text = k.ExpandTildePath(LinkButton_go_to_match_last.Text);
                RequireConfirmation(Button_delete, "Are you sure you want to delete this record?");
                Focus(TextBox_name, true);
                p.be_loaded = true;
            }

        }

        private bool PresentRecord(string name)
        {
        Literal_match_index.Text = DropDownList_name.SelectedIndex.ToString();
            bool result;
            decimal factor;
            result = false;
            if (p.biz_match_level.Get(name, out factor))
            {
                TextBox_name.Text = name;
                TextBox_factor.Text = factor.ToString();
                TextBox_name.Enabled = false;
                Button_lookup.Enabled = false;
                Label_lookup_arrow.Enabled = false;
                Label_lookup_hint.Enabled = false;
                LinkButton_reset.Enabled = true;
                SetDependentFieldAblements(p.be_ok_to_config_match_levels);
                Button_submit.Enabled = p.be_ok_to_config_match_levels;
                Button_delete.Enabled = p.be_ok_to_config_match_levels;
                result = true;
            }
            return result;
        }

        private void SetLookupMode()
        {
            Clear();
            TextBox_name.Enabled = true;
            Button_lookup.Enabled = true;
            Label_lookup_arrow.Enabled = true;
            Label_lookup_hint.Enabled = true;
            LinkButton_reset.Enabled = false;
            LinkButton_new_record.Enabled = p.be_ok_to_config_match_levels;
            Focus(TextBox_name, true);
        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (IsPostBack && (Session[InstanceId() + ".p"] != null))
            {
                p = (p_type)(Session[InstanceId() + ".p"]);
            }
            else
            {
                p.be_loaded = false;
                p.biz_match_level = new TClass_biz_match_level();
                p.be_ok_to_config_match_levels = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator");
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            //this.Load += this.Page_Load;
            this.PreRender += this.TWebUserControl_match_level_PreRender;
        }

        private void TWebUserControl_match_level_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_match_level Fresh()
        {
            TWebUserControl_match_level result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            decimal factor;
            if (Page.IsValid)
            {
                factor = 0;
                if (TextBox_factor.Text != k.EMPTY)
                {
                    factor = decimal.Parse(k.Safe(TextBox_factor.Text, k.safe_hint_type.REAL_NUM_INCLUDING_NEGATIVE));
                }
                p.biz_match_level.Set(k.Safe(TextBox_name.Text, k.safe_hint_type.HUMAN_NAME), factor);
                Alert(k.alert_cause_type.USER, k.alert_state_type.SUCCESS, "recsaved", "Record saved.", true);
                SetLookupMode();
            }
            else
            {
                ValidationAlert();
            }
        }

        protected void DropDownList_name_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
        }

        protected void LinkButton_go_to_match_first_Click(object sender, System.EventArgs e)
        {
            DropDownList_name.SelectedIndex = 1;
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
        }

        protected void LinkButton_go_to_match_prior_Click(object sender, System.EventArgs e)
        {
            DropDownList_name.SelectedIndex = Math.Max(1, (DropDownList_name.SelectedIndex - 1));
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
        }

        protected void LinkButton_go_to_match_next_Click(object sender, System.EventArgs e)
        {
            DropDownList_name.SelectedIndex = Math.Min((DropDownList_name.SelectedIndex + 1), (DropDownList_name.Items.Count - 1));
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
        }

        protected void LinkButton_go_to_match_last_Click(object sender, System.EventArgs e)
        {
            DropDownList_name.SelectedIndex = DropDownList_name.Items.Count - 1;
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
        }

        protected void Button_delete_Click(object sender, System.EventArgs e)
        {
            p.biz_match_level.Delete(k.Safe(TextBox_name.Text, k.safe_hint_type.ALPHANUM));
            SetLookupMode();
        }

        protected void LinkButton_new_record_Click(object sender, System.EventArgs e)
        {
            Clear();
            TextBox_name.Text = "*";
            TextBox_name.Enabled = false;
            Button_lookup.Enabled = false;
            Label_lookup_arrow.Enabled = false;
            Label_lookup_hint.Enabled = false;
            LinkButton_reset.Enabled = true;
            LinkButton_new_record.Enabled = false;
            SetDependentFieldAblements(p.be_ok_to_config_match_levels);
            Button_submit.Enabled = p.be_ok_to_config_match_levels;
            Button_delete.Enabled = false;
            Focus(TextBox_name, true);
        }

        protected void LinkButton_reset_Click(object sender, System.EventArgs e)
        {
            SetLookupMode();
        }

        private void SetDependentFieldAblements(bool ablement)
        {
            TextBox_factor.Enabled = ablement;
        }

        protected void Button_lookup_Click(object sender, System.EventArgs e)
        {
            uint num_matches;
            string saved_name;
            saved_name = TextBox_name.Text;
            Clear();
            if (!PresentRecord(saved_name))
            {
                TextBox_name.Text = saved_name;
                p.biz_match_level.Bind(saved_name, DropDownList_name);
                num_matches = (uint)(DropDownList_name.Items.Count);
        if (num_matches > 0)
          {
          DropDownList_name.Visible = true;
          if (num_matches == 1)
            {
            PresentRecord(k.Safe(DropDownList_name.SelectedValue, k.safe_hint_type.HUMAN_NAME));
            }
          else
            {
            Literal_match_index.Text = "0";
            Literal_num_matches.Text = num_matches.ToString();
            Panel_match_numbers.Visible = true;
            LinkButton_go_to_match_prior.Visible = true;
            LinkButton_go_to_match_next.Visible = true;
            LinkButton_go_to_match_last.Visible = true;
            LinkButton_go_to_match_first.Visible = true;
            DropDownList_name.Items.Insert(0, new ListItem("-- Select --", k.EMPTY));
            }
          }
            }
        }

        private struct p_type
        {
            public bool be_loaded;
            public bool be_ok_to_config_match_levels;
            public TClass_biz_match_level biz_match_level;
        } // end p_type

    } // end TWebUserControl_match_level

}
