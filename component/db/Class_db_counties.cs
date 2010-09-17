using Class_db;
using Class_db_fiscal_years;
using kix;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;

namespace Class_db_counties
{
  public class county_summary
    {
    public string code;
    public string name;
    }

    public class TClass_db_counties: TClass_db
    {

        private TClass_db_fiscal_years db_fiscal_years;

        //Constructor  Create()
        public TClass_db_counties() : base()
          {
          db_fiscal_years = new TClass_db_fiscal_years();
          }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            MySqlDataReader dr;
            ((target) as ListControl).Items.Clear();
            if (unselected_literal != k.EMPTY)
            {
                ((target) as ListControl).Items.Add(new ListItem(unselected_literal, k.EMPTY));
            }
            this.Open();
            dr = new MySqlCommand("SELECT code,name FROM county_code_name_map order by name", this.connection).ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["name"].ToString(), dr["code"].ToString()));
            }
            dr.Close();
            this.Close();
            if (selected_value != k.EMPTY)
            {
                ((target) as ListControl).SelectedValue = selected_value;
            }

        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- County --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public void BindGrid(string sort_order, bool be_sort_order_ascending, object target)
          {
          if (be_sort_order_ascending)
            {
            sort_order = sort_order.Replace("%", " asc");
            }
          else
            {
            sort_order = sort_order.Replace("%", " desc");
            }
          Open();
          ((target) as BaseDataList).DataSource = new MySqlCommand
            (
            "select code"
            + " , county_code_name_map.name as name"
            + " , password_reset_email_address as email_address"
            + " , concat(match_level.name,' (',FORMAT(factor*100,0),'%)') as match_level_description"
            + " from county_code_name_map"
            +   " join county_user on (county_user.id=county_code_name_map.code)"
            +   " join match_level on (match_level.id=county_code_name_map.default_match_level_id)"
            + " order by " + sort_order,
            connection
            )
            .ExecuteReader();
          ((target) as BaseDataList).DataBind();
          Close();
          }

        public string NameOf(string code)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select name from county_code_name_map where code = " + code, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

    internal string NameOfSummary(object summary)
      {
      return (summary as county_summary).name;
      }

    public object Summary(string code)
      {
      Open();
      var dr =
        (
        new MySqlCommand
          (
          "select name"
          + " from county_code_name_map"
          + " where code = '" + code + "'",
          connection
          )
          .ExecuteReader()
        );
      dr.Read();
      var the_summary = new county_summary()
        {
        code = code,
        name = dr["name"].ToString()
        };
      Close();
      return the_summary;
      }

    } // end TClass_db_counties

}
