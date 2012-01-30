// Derived from KiAspdotnetFramework/component/db/Class~db~template~kicrudhelped~items.cs~template

using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Text;
using System.Web.UI.WebControls;
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

    internal void BindDirectToListControlForRoster
      (
      object target,
      string region_code,
      string starting_with
      )
      {
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "SELECT id"
        + " , CONVERT(concat(last_name,', ',first_name,' ',middle_initial,', ',certification_number,', ',IFNULL(DATE_FORMAT(birth_date,'%m/%d/%Y'),'-')) USING utf8) as spec"
        + " FROM practitioner"
        + " where not be_stale"
        +   " and" + (region_code.Length > 0 ? " regional_council_code = '" + region_code + "'" : " 1=1")
        +   " and" + (starting_with.Length > 0 ? " CONVERT(concat(last_name,', ',first_name,' ',middle_initial,', ',certification_number,', ',IFNULL(birth_date,'-')) USING utf8) like '" + starting_with + "%'" : " 1=1")
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
      out DateTime birth_date,
      out string email_address,
      out bool be_stale,
      out string residence_county_code,
      out bool be_birth_date_confirmed,
      out string street_address_1,
      out string street_address_2,
      out string city_state_zip,
      out bool be_instructor
      )
      {
      last_name = k.EMPTY;
      first_name = k.EMPTY;
      middle_initial = k.EMPTY;
      certification_number = k.EMPTY;
      level_id = k.EMPTY;
      regional_council_code = k.EMPTY;
      birth_date = DateTime.MinValue;
      email_address = k.EMPTY;
      be_stale = true;
      residence_county_code = k.EMPTY;
      be_birth_date_confirmed = true;
      street_address_1 = k.EMPTY;
      street_address_2 = k.EMPTY;
      city_state_zip = k.EMPTY;
      be_instructor = false;
      var result = false;
      //
      Open();
      var dr = new MySqlCommand("select * from practitioner where CAST(id AS CHAR) = '" + id + "'", connection).ExecuteReader();
      if (dr.Read())
        {
        last_name = dr["last_name"].ToString();
        first_name = dr["first_name"].ToString();
        middle_initial = dr["middle_initial"].ToString();
        certification_number = dr["certification_number"].ToString();
        level_id = dr["level_id"].ToString();
        regional_council_code = dr["regional_council_code"].ToString();
        birth_date = DateTime.Parse(dr["birth_date"].ToString());
        email_address = dr["birth_date"].ToString();
        be_stale = (dr["be_stale"].ToString() == "1");
        residence_county_code = dr["residence_county_code"].ToString();
        be_birth_date_confirmed = (dr["be_birth_date_confirmed"].ToString() == "1");
        street_address_1 = dr["street_address_1"].ToString();
        street_address_2 = dr["street_address_2"].ToString();
        city_state_zip = dr["city_state_zip"].ToString();
        be_instructor = (dr["be_instructor"].ToString() == "1");
        result = true;
        }
      dr.Close();
      Close();
      return result;
      }

    internal void ImportLatestFromEmsrs(ArrayList recs)
      {
      if (recs.Count > 0)
        {
        //
        // The following is the code I really wanted to use, but MySQL implements it in a way that causes the auto_increment id field to advance when the "on duplicate key update" clause gets applied, which should be the
        // dominant case, and which exhausts id numbers faster than I think is prudent.
        //
        //var sb = new StringBuilder("insert practitioner (last_name,first_name,middle_initial,certification_number,level_id,regional_council_code) values ");
        //Open();
        //foreach (var rec in recs)
        //  {
        //  sb.Append
        //    (
        //    "("
        //    + "NULLIF('" + (rec as Class_ss_emsams.Practitioner).last_name + "','')"
        //    + ",'" + (rec as Class_ss_emsams.Practitioner).first_name + "'"
        //    + ",'" + (rec as Class_ss_emsams.Practitioner).middle_initial + "'"
        //    + ",NULLIF('" + (rec as Class_ss_emsams.Practitioner).certification_number + "','')"
        //    + ",NULLIF(IFNULL((select id from practitioner_level where emsrs_practitioner_level_description = '" + (rec as Class_ss_emsams.Practitioner).level + "'),''),'')"
        //    + ",NULLIF(IFNULL((select code from region_code_name_map where emsrs_active_practitioners_name = '" + (rec as Class_ss_emsams.Practitioner).regional_council + "'),''),'')"
        //    + "),"
        //    );
        //  }
        //new MySqlCommand(sb.ToString().TrimEnd(Convert.ToChar(k.COMMA)) + " on duplicate key update be_stale = false",connection).ExecuteNonQuery();
        //Close();
        //
        var built_insert_values_string = new StringBuilder();
        var built_fresh_ids_string = new StringBuilder();
        var id_obj = new object();
        Open();
        foreach (var rec in recs)
          {
          id_obj = new MySqlCommand
            (
            "select id"
            + " from practitioner"
            + " where certification_number = '" + (rec as Class_ss_emsams.Practitioner).certification_number + "'"
            +   " and last_name = '" + (rec as Class_ss_emsams.Practitioner).last_name + "'"
            +   " and first_name = '" + (rec as Class_ss_emsams.Practitioner).first_name + "'"
            +   " and middle_initial = '" + (rec as Class_ss_emsams.Practitioner).middle_initial + "'"
            +   " and level_id = (select id from practitioner_level where emsrs_practitioner_level_description = '" + (rec as Class_ss_emsams.Practitioner).level + "')"
            +   " and regional_council_code = (select code from region_code_name_map where emsrs_active_practitioners_name = '" + (rec as Class_ss_emsams.Practitioner).regional_council + "')",
            connection
            )
            .ExecuteScalar();
          if (id_obj == null)
            {
            built_insert_values_string.Append
              (
              "("
              + "'" + (rec as Class_ss_emsams.Practitioner).last_name + "'"
              + ",'" + (rec as Class_ss_emsams.Practitioner).first_name + "'"
              + ",'" + (rec as Class_ss_emsams.Practitioner).middle_initial + "'"
              + ",'" + (rec as Class_ss_emsams.Practitioner).certification_number + "'"
              + ",(select id from practitioner_level where emsrs_practitioner_level_description = '" + (rec as Class_ss_emsams.Practitioner).level + "')"
              + ",(select code from region_code_name_map where emsrs_active_practitioners_name = '" + (rec as Class_ss_emsams.Practitioner).regional_council + "')"
              + "),"
              );
            }
          else
            {
            built_fresh_ids_string.Append(id_obj.ToString()).Append(k.COMMA);
            }
          }
        if (built_fresh_ids_string.Length > 0)
          {
          new MySqlCommand
            (
            "update practitioner"
            + " set be_stale = false"
            + " where id in (" + built_fresh_ids_string.ToString().TrimEnd(Convert.ToChar(k.COMMA)) + ")",
            connection
            )
            .ExecuteNonQuery();
          }
        if (built_insert_values_string.Length > 0)
          {
          new MySqlCommand
            (
            "insert practitioner (last_name,first_name,middle_initial,certification_number,level_id,regional_council_code) values "
            + built_insert_values_string.ToString().TrimEnd(Convert.ToChar(k.COMMA)),
            connection
            )
            .ExecuteNonQuery();
          }
        Close();
        }
      }

    internal void MarkAllStale()
      {
      Open();
      new MySqlCommand("update practitioner set be_stale = TRUE",connection).ExecuteNonQuery();
      Close();
      }

    internal void MarkDobsConfirmed(string class_id)
      {
      Open();
      new MySqlCommand
        (
        db_trail.Saved
          (
          "update practitioner"
          + " join coned_offering_roster on (coned_offering_roster.practitioner_id=practitioner.id)"
          + " set be_birth_date_confirmed = TRUE"
          + "  where coned_offering_class_id = '" + class_id + "'"
          ),
        connection
        )
        .ExecuteNonQuery();
      Close();
      }

    internal k.int_nonnegative MaxSpecLength
      (
      string region_code,
      string starting_with
      )
      {
      var max_spec_length = new k.int_nonnegative();
      Open();
      max_spec_length.val = int.Parse
        (
        new MySqlCommand
          (
          "SELECT IFNULL(max(length(CONVERT(concat(last_name,', ',first_name,' ',middle_initial,', ',certification_number,', ',IFNULL(birth_date,'-')) USING utf8))),0)"
          + " FROM practitioner"
          + (region_code.Length > 0 ? " where regional_council_code = '" + region_code + "'" : k.EMPTY),
          connection
          )
          .ExecuteScalar().ToString()
        );
      Close();
      return max_spec_length;
      }

    internal void RemoveStale()
      {
      Open();
      new MySqlCommand("delete from practitioner where be_stale and (select count(*) from coned_offering_roster where practitioner_id = practitioner.id) = 0",connection).ExecuteNonQuery();
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
      DateTime birth_date,
      string email_address,
      bool be_stale,
      string residence_county_code,
      bool be_birth_date_confirmed,
      string street_address_1,
      string street_address_2,
      string city_state_zip,
      bool be_instructor
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
      + " , email_address = NULLIF('" + email_address + "','')"
      + " , be_stale = " + be_stale.ToString()
      + " , residence_county_code = NULLIF('" + residence_county_code + "','')"
      + " , be_birth_date_confirmed = " + be_birth_date_confirmed.ToString()
      + " , street_address_1 = NULLIF('" + street_address_1 + "','')"
      + " , street_address_2 = NULLIF('" + street_address_2 + "','')"
      + " , city_state_zip = NULLIF('" + city_state_zip + "','')"
      + " , be_instructor = " + be_instructor.ToString()
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

    internal void SetFieldsNotImportedFromState
      (
      string id,
      DateTime birth_date,
      string county_code,
      string email_address
      )
      {
      Open();
      new MySqlCommand
        (
        db_trail.Saved
          (
          "update practitioner set birth_date = '" + birth_date.ToString("yyyy-MM-dd") + "'"
          + " , residence_county_code = NULLIF('" + county_code + "','')"
          + " , email_address = NULLIF('" + email_address + "','')"
          + " where id = '" + id + "'"
          ),
          connection
        )
        .ExecuteNonQuery();
      Close();
      }

    } // end TClass_db_practitioners

  }
