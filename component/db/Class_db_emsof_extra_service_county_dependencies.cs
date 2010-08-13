using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Linq;
using System.Web;

namespace Class_db_emsof_extra_service_county_dependencies
  {
  public class TClass_db_emsof_extra_service_county_dependencies : TClass_db
    {

    private TClass_db_trail db_trail;

    public TClass_db_emsof_extra_service_county_dependencies() : base()
      {
      db_trail = new TClass_db_trail();
      }

    internal void Get
      (
      string service_id,
      Queue q
      )
      {
      Open();
      var dr = new MySqlCommand("select county_code from emsof_extra_service_county_dependency where service_id = '" + service_id + "'",connection).ExecuteReader();
      while (dr.Read())
        {
        q.Enqueue(dr["county_code"].ToString());
        }
      Close();
      }

    internal void Update
      (
      string service_id,
      Queue q
      )
      {
      var sql = "START TRANSACTION;"
      + " delete from emsof_extra_service_county_dependency where service_id = '" + service_id + "';";
      while (q.Count > 0)
        {
        sql += " insert ignore emsof_extra_service_county_dependency set service_id = '" + service_id + "', county_code = '" + q.Dequeue().ToString() + "';";
        }
      sql += " COMMIT";
      Open();
      new MySqlCommand(db_trail.Saved(sql),connection).ExecuteNonQuery();
      Close();
      }

    }
  }