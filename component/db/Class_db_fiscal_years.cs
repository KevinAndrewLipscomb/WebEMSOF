using MySql.Data.MySqlClient;
using System;

using System.Web.UI.WebControls;
using Class_db;
namespace Class_db_fiscal_years
{
    public class TClass_db_fiscal_years: TClass_db
    {
        //Constructor  Create()
        public TClass_db_fiscal_years() : base()
        {
            // TODO: Add any constructor code here

        }
        public void BindListControl(object target)
        {
            this.Open();
            ((target) as ListControl).DataSource = new MySqlCommand("select id,designator from fiscal_year order by id desc", this.connection).ExecuteReader();
            ((target) as ListControl).DataValueField = "id";
            ((target) as ListControl).DataTextField = "designator";
            ((target) as ListControl).DataBind();
            this.Close();
        }

        public string DesignatorOfCurrent()
        {
            string result;
            this.Open();
            result = new MySqlCommand("select designator from fiscal_year order by id desc limit 1", this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public string IdOfCurrent()
        {
            string result;
            this.Open();
            result = new MySqlCommand("select max(id) from fiscal_year", this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public string IdOfDesignator(string designator)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select id from fiscal_year where designator = \"" + designator + "\"", this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public void StartNew(string designator)
        {
            this.Open();
            new MySqlCommand("insert ignore fiscal_year set designator = \"" + designator + "\"", this.connection).ExecuteNonQuery();
            this.Close();
        }

    } // end TClass_db_fiscal_years

}
