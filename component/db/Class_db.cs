using System.Data;
using MySql.Data.MySqlClient;

using System.Configuration;



using System;

namespace Class_db
{
    public class TClass_db
    {
        public MySqlConnection connection = null;
        // The connection member should be protected rather than public once all db operations in WebEMSOF are performed via
        // descendants of this class.
        //Constructor  Create()
        public TClass_db() : base()
        {
            // TODO: Add any constructor code here
            connection = new MySqlConnection();
            connection.ConnectionString = ConfigurationManager.AppSettings["db_connection_string"];
        }
        public void Close()
        {
            connection.Close();
        }

        public void Open()
        {
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }
        }

    } // end TClass_db

}

namespace Class_db.Units
{
    public class Class_db
    {
        public const string ID = "$Id: Class_db.pas 2343 2008-05-28 21:19:37Z kevinanlipscomb $";
    } // end Class_db

}

