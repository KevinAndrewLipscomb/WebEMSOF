using MySql.Data.MySqlClient;
using kix;
using System;

using System.Web.UI.WebControls;
using Class_db;
using Class_db_trail;

namespace Class_db_charter_kinds
{
    public class TClass_db_charter_kinds: TClass_db
    {
        private readonly TClass_db_trail db_trail = null;

        //Constructor  Create()
        public TClass_db_charter_kinds() : base()
        {
            // TODO: Add any constructor code here
            db_trail = new TClass_db_trail();
        }
        public bool Bind(string partial_spec, object target)
        {
            bool result;
            MySqlDataReader dr;
            Open();
            ((target) as ListControl).Items.Clear();
            using var my_sql_command = new MySqlCommand("SELECT id" + " , description" + " FROM charter_kind" + " WHERE description like \"%" + partial_spec + "%\"" + " order by id", connection);
            dr = my_sql_command.ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["description"].ToString(), dr["id"].ToString()));
            }
            dr.Close();
            Close();
            result = ((target) as ListControl).Items.Count > 0;
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            MySqlDataReader dr;
            ((target) as ListControl).Items.Clear();
            if (unselected_literal.Length > 0)
            {
                ((target) as ListControl).Items.Add(new ListItem(unselected_literal, k.EMPTY));
            }
            Open();
            using var my_sql_command = new MySqlCommand("SELECT id,description FROM charter_kind where description <> \"(none specified)\" order by id", connection);
            dr = my_sql_command.ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["description"].ToString(), dr["id"].ToString()));
            }
            dr.Close();
            Close();
            if (selected_value.Length > 0)
            {
                ((target) as ListControl).SelectedValue = selected_value;
            }

        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- charter_kind --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string id)
        {
            bool result;
            result = true;
            Open();
            try {
                using var my_sql_command = new MySqlCommand(db_trail.Saved("delete from charter_kind where id = " + id), connection);
                my_sql_command.ExecuteNonQuery();
            }
            catch(System.Exception e) {
                if (e.Message.StartsWith("Cannot delete or update a parent row: a foreign key constraint fails", true, null))
                {
                    result = false;
                }
                else
                {
                    throw;
                }
            }
            Close();
            return result;
        }

        public bool Get(string id, out string description)
        {
            bool result;
            MySqlDataReader dr;

            description = k.EMPTY;
            result = false;
            Open();
            using var my_sql_command = new MySqlCommand("select description from charter_kind where id = \"" + id + "\"", connection);
            dr = my_sql_command.ExecuteReader();
            if (dr.Read())
            {
                description = dr["description"].ToString();
                result = true;
            }
            dr.Close();
            Close();
            return result;
        }

        public void Set(string id, string description)
        {
            string childless_field_assignments_clause;
            childless_field_assignments_clause = "description = \"" + description + "\"";
            Open();
            using var my_sql_command = new MySqlCommand(db_trail.Saved("insert charter_kind" + " set id = NULLIF(\"" + id + "\",\"\")" + " , " + childless_field_assignments_clause + " on duplicate key update " + childless_field_assignments_clause), connection);
            my_sql_command.ExecuteNonQuery();
            Close();

        }

    } // end TClass_db_charter_kinds

}
