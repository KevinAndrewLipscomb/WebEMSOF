using Class_biz_equipment;
using kix;
using System;
using System.Configuration;

namespace UserControl_serial_indicator_equipment_quantities
{
    public partial class TWebUserControl_serial_indicator_equipment_quantities: ki_web_ui.usercontrol_class
    {
    private static class Static
      {
      public const int AVERAGE_NUM_MINUTES_PER_YEAR = 525948; // takes into account all scheduled leap days
      public const string DEFAULT_WIDTH_IN_YEARS = "27"; // should allow easy reading of top margin values
      }

    private struct p_type
      {
      public bool be_loaded;
      public TClass_biz_equipment biz_equipment;
      public string image_control_src_base;
      public string width_in_years;
      public string width_in_years_max;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                p.biz_equipment.BindDescriptionsOnlyToListControl(DropDownList_equipment);
                RangeValidator_width_in_years.MaximumValue = p.width_in_years_max;
                RangeValidator_width_in_years.ErrorMessage = RangeValidator_width_in_years.ErrorMessage.Replace("#",p.width_in_years_max);
                TextBox_width_in_years.Text = p.width_in_years;
                p.image_control_src_base = k.ExpandTildePath(Image_control.Src);
                Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text) + "&width_in_years=" + p.width_in_years;
                p.be_loaded = true;
            }

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
                p.biz_equipment = new TClass_biz_equipment();
                p.width_in_years = Static.DEFAULT_WIDTH_IN_YEARS;
                p.width_in_years_max =
                  Math.Max
                    (
                    val1:double.Parse(Static.DEFAULT_WIDTH_IN_YEARS),
                    val2:Math.Truncate(DateTime.Today.Subtract(DateTime.Parse(ConfigurationManager.AppSettings["year_of_first_serial_dashboard_data_point"] + "-06-30")).TotalMinutes/Static.AVERAGE_NUM_MINUTES_PER_YEAR)
                    )
                    .ToString("f0");
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            PreRender += TWebUserControl_serial_indicator_equipment_quantities_PreRender;
        }

        private void TWebUserControl_serial_indicator_equipment_quantities_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_serial_indicator_equipment_quantities Fresh()
        {
            TWebUserControl_serial_indicator_equipment_quantities result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        protected void DropDownList_equipment_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text) + "&width_in_years=" + p.width_in_years;
        }

    protected void Button_go_Click(object sender, EventArgs e)
      {
      p.width_in_years = k.Safe(TextBox_width_in_years.Text,k.safe_hint_type.NUM);
      Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text) + "&width_in_years=" + p.width_in_years;
      }

    protected void Button_max_Click(object sender, EventArgs e)
      {
      p.width_in_years = p.width_in_years_max;
      TextBox_width_in_years.Text = p.width_in_years_max;
      Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text) + "&width_in_years=" + p.width_in_years;
      }

    protected void Button_default_Click(object sender, EventArgs e)
      {
      p.width_in_years = Static.DEFAULT_WIDTH_IN_YEARS;
      TextBox_width_in_years.Text = Static.DEFAULT_WIDTH_IN_YEARS;
      Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text) + "&width_in_years=" + p.width_in_years;
      }

    } // end TWebUserControl_serial_indicator_equipment_quantities

}
