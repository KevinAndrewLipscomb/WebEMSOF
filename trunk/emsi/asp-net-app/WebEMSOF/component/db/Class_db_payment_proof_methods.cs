using MySql.Data.MySqlClient;
using System;

using System.Web.UI.WebControls;
using Class_db;
namespace Class_db_payment_proof_methods
{
    public class TClass_db_payment_proof_methods: TClass_db
    {
        //Constructor  Create()
        public TClass_db_payment_proof_methods() : base()
        {
            // TODO: Add any constructor code here

        }
        public void BindListControl(object target)
        {
            MySqlDataReader dr;
            this.Open();
            ((target) as ListControl).Items.Clear();
            ((target) as ListControl).Items.Add(new ListItem("-- Select --", ""));
            dr = new MySqlCommand("SELECT code,description FROM payment_proof_method_code_description_map ORDER BY description", this.connection).ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["description"].ToString(), dr["code"].ToString()));
            }
            dr.Close();
            this.Close();
        }

    } // end TClass_db_payment_proof_methods

}
