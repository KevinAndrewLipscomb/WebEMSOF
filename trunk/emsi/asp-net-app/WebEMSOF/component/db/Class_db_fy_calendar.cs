using MySql.Data.MySqlClient;
using System;
using Class_db;

namespace Class_db_fy_calendar
{
    public class TClass_db_fy_calendar: TClass_db
    {
        //Constructor  Create()
        public TClass_db_fy_calendar() : base()
        {
            // TODO: Add any constructor code here

        }
        public DateTime MilestoneDate(string milestone_code)
        {
            DateTime result;
            object milestone_date_obj;
            result = DateTime.MaxValue;
            Open();
            using var my_sql_command = new MySqlCommand("select value" + " from fy_calendar" + " where fiscal_year_id = (select max(id) from fiscal_year)" + " and milestone_code = \"" + milestone_code + "\"", connection);
            milestone_date_obj = my_sql_command.ExecuteScalar();
            Close();
            if ((milestone_date_obj != null))
            {
                result = (DateTime)(milestone_date_obj);
            }

            return result;
        }

    } // end TClass_db_fy_calendar

}
