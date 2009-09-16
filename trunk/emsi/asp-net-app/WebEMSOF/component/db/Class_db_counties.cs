using MySql.Data.MySqlClient;
using kix;
using System;

using System.Web.UI.WebControls;
using Class_db;
namespace Class_db_counties
{
    public class TClass_db_counties: TClass_db
    {
        //Constructor  Create()
        public TClass_db_counties() : base()
        {
            // TODO: Add any constructor code here

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

        public string NameOf(string code)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select name from county_code_name_map where code = " + code, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

    } // end TClass_db_counties

}
