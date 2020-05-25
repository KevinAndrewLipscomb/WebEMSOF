using AjaxControlToolkit;
using Class_db;
using kix;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserControl_appropriations_available_to_county
  {

  public partial class TWebUserControl_appropriations_available_to_county: ki_web_ui.usercontrol_class
    {

    private struct p_type
      {
      public bool be_loaded;
      public TClass_db db;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

    protected void Page_Load(object sender, System.EventArgs e)
      {
      if (!p.be_loaded)
        {
        p.db = new TClass_db();
        p.db.Open();
        //
        // Where we go next depends on how many appropriations have been made to this county.
        // Determine current fiscal year
        //
        var max_fiscal_year_id_string = new MySqlCommand("SELECT max(id) as max_id FROM fiscal_year", p.db.connection).ExecuteScalar().ToString();
        var dr = new MySqlCommand
          (
          "SELECT region_dictated_appropriation.id"
          + " , concat('$',format(region_dictated_appropriation.amount,2),' from the ',name,' ',designator,' contract (amendment ',amendment_num,')')" + " as appropriation_description"
          + " FROM region_dictated_appropriation"
          +   " JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id)"
          +   " JOIN region_code_name_map on (region_code_name_map.code=region_code)"
          +   " JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)"
          + " WHERE county_code = " + Session["county_user_id"].ToString()
          +   " and fiscal_year_id = " + max_fiscal_year_id_string,
          p.db.connection
          )
          .ExecuteReader();
        while (dr.Read())
          {
          RadioButtonList_appropriation.Items.Add(new ListItem(dr["appropriation_description"].ToString(), dr["id"].ToString()));
          }
        dr.Close();
        p.db.Close();
        if (RadioButtonList_appropriation.Items.Count == 0)
          {
          Alert(k.alert_cause_type.APPDATA,k.alert_state_type.NORMAL,"noapprop","Sorry, the regional council has not yet made an allocation to you in this cycle.");
          }
        else
          {
          if (RadioButtonList_appropriation.Items.Count == 1)
            {
            RadioButtonList_appropriation.Items[0].Selected = true;
            //SessionSet("region_dictated_appropriation_id", RadioButtonList_appropriation.Items[0].Value);
            //DropCrumbAndTransferTo("county_dictated_appropriations.aspx");
            }
          Button_continue.Enabled = true;
          }
        //
        ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_continue);
        p.be_loaded = true;
        }
      }

    protected override void OnInit(System.EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      var instance_id = InstanceId();
      if (Session[instance_id + ".p"] != null)
        {
        p = (p_type)(Session[instance_id + ".p"]);
        p.be_loaded = IsPostBack;  // This test is sufficient if this control is being used statically on its page.
        //
        // If this control is being used dynamically under one or more parent binder(s), it must ascertain which instance it is, and whether or not that instance's parent binder
        // had it loaded already.
        //
        if (instance_id == "ASP.protected_county_overview_aspx.UserControl_county_binder_control_appropriations_available_to_county")
          {
          p.be_loaded &= ((Session["UserControl_county_binder_control_PlaceHolder_content"] as string) == "UserControl_appropriations_available_to_county");
          }
//      else if (instance_id == "ASP.~_aspx.UserControl_~_binder_appropriations_available_to_county")
//        {
//        p.be_loaded &= ((Session["UserControl_~_binder_PlaceHolder_content"] as string) == "UserControl_appropriations_available_to_county");
//        }
        }
      else
        {
        p.be_loaded = false;
        }
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      PreRender += TWebUserControl_appropriations_available_to_county_PreRender;
      }

    private void TWebUserControl_appropriations_available_to_county_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_appropriations_available_to_county Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      return this;
      }

    protected void Button_continue_Click(object sender, System.EventArgs e)
      {
      SessionSet("region_dictated_appropriation_id", k.Safe(RadioButtonList_appropriation.SelectedValue, k.safe_hint_type.NUM));
      DropCrumbAndTransferTo("county_dictated_appropriations.aspx");
      }

    }

  }
