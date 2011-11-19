// Derived from KiAspdotnetFramework/component/db/Class~db~template~kicrudhelped~items.cs~template

using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Web.UI.WebControls;
using UserControl_drop_down_date;
using WebEMSOF.component.ss;

namespace Class_db_practitioners
  {
  public class TClass_db_practitioners: TClass_db
    {
    private TClass_db_trail db_trail = null;

    public TClass_db_practitioners() : base()
      {
      db_trail = new TClass_db_trail();
      }

    public bool Bind(string partial_spec, object target)
      {
      var concat_clause = "concat(IFNULL(last_name,'-'),'|',IFNULL(first_name,'-'),'|',IFNULL(certification_number,'-'),'|',IFNULL(level_id,'-'),'|',IFNULL(regional_council_code,'-'),'|',IFNULL(birth_date,'-'))";
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "select id"
        + " , CONVERT(" + concat_clause + " USING utf8) as spec"
        + " from practitioner"
        + " where " + concat_clause + " like '%" + partial_spec.ToUpper() + "%'"
        + " order by spec",
        connection
        )
        .ExecuteReader();
      while (dr.Read())
        {
        ((target) as ListControl).Items.Add(new ListItem(dr["spec"].ToString(), dr["id"].ToString()));
        }
      dr.Close();
      Close();
      return ((target) as ListControl).Items.Count > 0;
      }

    public void BindDirectToListControl(object target)
      {
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "SELECT id"
        + " , CONVERT(concat(IFNULL(last_name,'-'),'|',IFNULL(first_name,'-'),'|',IFNULL(certification_number,'-'),'|',IFNULL(level_id,'-'),'|',IFNULL(regional_council_code,'-'),'|',IFNULL(birth_date,'-')) USING utf8) as spec"
        + " FROM practitioner"
        + " order by spec",
        connection
        )
        .ExecuteReader();
      while (dr.Read())
        {
        ((target) as ListControl).Items.Add(new ListItem(dr["spec"].ToString(), dr["id"].ToString()));
        }
      dr.Close();
      Close();
      }

    public bool Delete(string id)
      {
      var result = true;
      Open();
      try
        {
        new MySqlCommand(db_trail.Saved("delete from practitioner where id = \"" + id + "\""), connection).ExecuteNonQuery();
        }
      catch(System.Exception e)
        {
        if (e.Message.StartsWith("Cannot delete or update a parent row: a foreign key constraint fails", true, null))
          {
          result = false;
          }
        else
          {
          throw e;
          }
        }
      Close();
      return result;
      }

    public bool Get
      (
      string id,
      out string last_name,
      out string first_name,
      out string middle_initial,
      out string certification_number,
      out string level_id,
      out string regional_council_code,
      out DateTime birth_date
      )
      {
      last_name = k.EMPTY;
      first_name = k.EMPTY;
      middle_initial = k.EMPTY;
      certification_number = k.EMPTY;
      level_id = k.EMPTY;
      regional_council_code = k.EMPTY;
      birth_date = DateTime.MinValue;
      var result = false;
      //
      Open();
      var dr = new MySqlCommand("select * from practitioner where CAST(id AS CHAR) = \"" + id + "\"", connection).ExecuteReader();
      if (dr.Read())
        {
        last_name = dr["last_name"].ToString();
        first_name = dr["first_name"].ToString();
        middle_initial = dr["middle_initial"].ToString();
        certification_number = dr["certification_number"].ToString();
        level_id = dr["level_id"].ToString();
        regional_council_code = dr["regional_council_code"].ToString();
        birth_date = DateTime.Parse(dr["birth_date"].ToString());
        result = true;
        }
      dr.Close();
      Close();
      return result;
      }

    internal void ImportLatestFromEmsrs(ArrayList recs)
      {
      Open();
      foreach (var rec in recs)
        {
        new MySqlCommand
          (
          "insert ignore practitioner"
          + " set last_name = NULLIF('" + (rec as Class_ss_emsams.Practitioner).last_name + "','')"
          + " , first_name = NULLIF('" + (rec as Class_ss_emsams.Practitioner).first_name + "','')"
          + " , middle_initial = NULLIF('" + (rec as Class_ss_emsams.Practitioner).middle_initial + "','')"
          + " , certification_number = NULLIF('" + (rec as Class_ss_emsams.Practitioner).certification_number + "','')"
          + " , level_id = NULLIF(IFNULL((select id from practitioner_level where emsrs_practitioner_level_description = '" + (rec as Class_ss_emsams.Practitioner).level + "'),''),'')"
          + " , regional_council_code = NULLIF(IFNULL((select code from region_code_name_map where emsrs_active_practitioners_name = '" + (rec as Class_ss_emsams.Practitioner).regional_council + "'),''),'')",
          connection
          )
          .ExecuteNonQuery();
        }
      Close();
      }

    public void Set
      (
      string id,
      string last_name,
      string first_name,
      string middle_initial,
      string certification_number,
      string level_id,
      string regional_council_code,
      DateTime birth_date
      )
      {
      var childless_field_assignments_clause = k.EMPTY
      + "last_name = NULLIF('" + last_name + "','')"
      + " , first_name = NULLIF('" + first_name + "','')"
      + " , middle_initial = NULLIF('" + middle_initial + "','')"
      + " , certification_number = NULLIF('" + certification_number + "','')"
      + " , level_id = NULLIF('" + level_id + "','')"
      + " , regional_council_code = NULLIF('" + regional_council_code + "','')"
      + " , birth_date = '" + birth_date.ToString("yyyy-MM-dd") + "'"
      + k.EMPTY;
      Open();
      new MySqlCommand
        (
        db_trail.Saved
          (
          "insert practitioner"
          + " set id = NULLIF('" + id + "','')"
          + " , " + childless_field_assignments_clause
          + " on duplicate key update "
          + childless_field_assignments_clause
          ),
          connection
        )
        .ExecuteNonQuery();
      Close();
      }

    } // end TClass_db_practitioners

  }
