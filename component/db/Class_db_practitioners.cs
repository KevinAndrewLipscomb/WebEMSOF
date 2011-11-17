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
      var concat_clause = "concat(IFNULL(last_name,'-'),'|',IFNULL(first_name,'-'),'|',IFNULL(middle_name,'-'),'|',IFNULL(email_address,'-'),'|',IFNULL(county_code,'-'),'|',IFNULL(street_address,'-'),'|',IFNULL(city,'-'),'|',IFNULL(zip,'-'),'|',IFNULL(birth_date,'-'))";
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
        + " , CONVERT(concat(IFNULL(last_name,'-'),'|',IFNULL(first_name,'-'),'|',IFNULL(middle_name,'-'),'|',IFNULL(email_address,'-'),'|',IFNULL(county_code,'-'),'|',IFNULL(street_address,'-'),'|',IFNULL(city,'-'),'|',IFNULL(zip,'-'),'|',IFNULL(birth_date,'-')) USING utf8) as spec"
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
      out string middle_name,
      out string email_address,
      out string new_emso_user_id,
      out string county_code,
      out string street_address,
      out string city,
      out string zip,
      out DateTime birth_date
      )
      {
      last_name = k.EMPTY;
      first_name = k.EMPTY;
      middle_name = k.EMPTY;
      email_address = k.EMPTY;
      new_emso_user_id = k.EMPTY;
      county_code = k.EMPTY;
      street_address = k.EMPTY;
      city = k.EMPTY;
      zip = k.EMPTY;
      birth_date = DateTime.MinValue;
      var result = false;
      //
      Open();
      var dr = new MySqlCommand("select * from practitioner where CAST(id AS CHAR) = \"" + id + "\"", connection).ExecuteReader();
      if (dr.Read())
        {
        last_name = dr["last_name"].ToString();
        first_name = dr["first_name"].ToString();
        middle_name = dr["middle_name"].ToString();
        email_address = dr["email_address"].ToString();
        new_emso_user_id = dr["new_emso_user_id"].ToString();
        county_code = dr["county_code"].ToString();
        street_address = dr["street_address"].ToString();
        city = dr["city"].ToString();
        zip = dr["zip"].ToString();
        birth_date = DateTime.Parse(dr["birth_date"].ToString());
        result = true;
        }
      dr.Close();
      Close();
      return result;
      }

    internal void ImportLatestFromEmsrs(ArrayList recs)
      {
      var childless_field_assignments_clause = k.EMPTY;
      Open();
      foreach (var rec in recs)
        {
        childless_field_assignments_clause = k.EMPTY
        + "last_name = NULLIF('" + (rec as Class_ss_emsams.Practitioner).last_name + "','')"
        + " , first_name = NULLIF('" + (rec as Class_ss_emsams.Practitioner).first_name + "','')"
        + " , middle_name = NULLIF('" + (rec as Class_ss_emsams.Practitioner).middle_name + "','')"
        + " , email_address = NULLIF('" + (rec as Class_ss_emsams.Practitioner).email_address + "','')"
        + " , county_code = NULLIF(IFNULL((select code from county_code_name_map where name = '" + (rec as Class_ss_emsams.Practitioner).county + "'),''),'')"
        + " , street_address = NULLIF('" + (rec as Class_ss_emsams.Practitioner).street_address + "','')"
        + " , city = NULLIF('" + (rec as Class_ss_emsams.Practitioner).city + "','')"
        + " , zip = NULLIF('" + (rec as Class_ss_emsams.Practitioner).zip + "','')"
        + " , birth_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.Practitioner).birth_date + "',''),'%m/%d/%Y')"
        + k.EMPTY;
        new MySqlCommand
          (
          "insert practitioner"
          + " set new_emso_user_id = NULLIF('" + (rec as Class_ss_emsams.Practitioner).new_emso_user_id + "','')"
          + " , " + childless_field_assignments_clause
          + " on duplicate key update "
          + childless_field_assignments_clause,
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
      string middle_name,
      string email_address,
      string new_emso_user_id,
      string county_code,
      string street_address,
      string city,
      string zip,
      DateTime birth_date
      )
      {
      var childless_field_assignments_clause = k.EMPTY
      + "last_name = NULLIF('" + last_name + "','')"
      + " , first_name = NULLIF('" + first_name + "','')"
      + " , middle_name = NULLIF('" + middle_name + "','')"
      + " , email_address = NULLIF('" + email_address + "','')"
      + " , new_emso_user_id = NULLIF('" + new_emso_user_id + "','')"
      + " , county_code = NULLIF('" + county_code + "','')"
      + " , street_address = NULLIF('" + street_address + "','')"
      + " , city = NULLIF('" + city + "','')"
      + " , zip = NULLIF('" + zip + "','')"
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
