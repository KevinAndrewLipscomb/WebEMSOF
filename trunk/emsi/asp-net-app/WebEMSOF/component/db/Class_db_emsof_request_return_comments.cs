using MySql.Data.MySqlClient;
using System;

using System.Web.UI.WebControls;
using Class_db;

namespace Class_db_emsof_request_return_comments
{
    public class TClass_db_emsof_request_return_comments: TClass_db
    {
        //Constructor  Create()
        public TClass_db_emsof_request_return_comments() : base()
        {
            // TODO: Add any constructor code here

        }
        public bool Bind(object target, string master_id)
        {
            bool result;
            MySqlDataReader dr;
            result = false;
            Open();
            using var my_sql_command = new MySqlCommand("select timestamp" + " , demoter" + " , content" + " from emsof_request_return_comment" + " where emsof_request_master_id = \"" + master_id + "\"" + " order by timestamp", connection);
            dr = my_sql_command.ExecuteReader();
            if (dr.HasRows)
            {
                ((target) as GridView).DataSource = dr;
                ((target) as GridView).DataBind();
                result = true;
            }
            Close();
            return result;
        }

        public void Log(string master_id, string demoter, string content)
        {
            Open();
            using var my_sql_command = new MySqlCommand("insert emsof_request_return_comment" + " set emsof_request_master_id = \"" + master_id + "\"" + " , demoter = \"" + demoter + "\"" + " , content = \"" + content + "\"", connection);
            my_sql_command.ExecuteNonQuery();
            Close();
        }

    } // end TClass_db_emsof_request_return_comments

}
