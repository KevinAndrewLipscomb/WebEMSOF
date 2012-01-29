// Derived from KiAspdotnetFramework/component/db/Class~db~template~kicrudhelped~items.cs~template

using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Web.UI.WebControls;
using UserControl_drop_down_date;

namespace Class_db_coned_offering_rosters
  {
  public class TClass_db_coned_offering_rosters: TClass_db
    {
    private TClass_db_trail db_trail = null;

    public TClass_db_coned_offering_rosters() : base()
      {
      db_trail = new TClass_db_trail();
      }

    public bool Bind(string partial_spec, object target)
      {
      var concat_clause = "concat(id)";
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "select id"
        + " , CONVERT(" + concat_clause + " USING utf8) as spec"
        + " from coned_offering_roster"
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
        + " , CONVERT(concat(id) USING utf8) as spec"
        + " FROM coned_offering_roster"
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

    public void BindBaseDataListByClassId
      (
      string sort_order,
      bool be_sort_order_ascending,
      object target,
      string class_id
      )
      {
      Open();
      ((target) as BaseDataList).DataSource = new MySqlCommand
        (
        "select coned_offering_roster.id as id"
        + " , practitioner.id as practitioner_id"
        + " , last_name"
        + " , first_name"
        + " , middle_initial"
        + " , practitioner_level.short_description as level"
        + " , certification_number"
        + " , IFNULL(DATE_FORMAT(birth_date,'%m/%d/%Y'),'REQUIRED') as birth_date"
        + " , be_birth_date_confirmed"
        + " , IFNULL(practitioner_county_code_name_map.code,coned_offering_county_code_name_map.code) as county_code"
        + " , IFNULL(practitioner_county_code_name_map.name,coned_offering_county_code_name_map.name) as county_name"
        + " , IFNULL(email_address,'DESIRED') as email_address"
        + " , IFNULL(instructor_hours,'none') as instructor_hours"
        + " , practitioner_level.emsrs_code as level_emsrs_code"
        + " , coned_offering.region_council_num as region_emsrs_code"
        + " , coned_offering.course_number as course_number"
        + " , RIGHT(coned_offering.class_number,6) as class"
        + " , be_instructor"
        + " , IFNULL(instructor_hours*10,0) as lcds_instructor_hours"
        + " , DATE_FORMAT(end_date_time,'%m/%d/%Y') as end_date"
        + " , practitioner_county_code_name_map.emsrs_code as practitioner_county_emsrs_code"
        + " , coned_offering.sponsor_number as sponsor_number"
        + " from coned_offering_roster"
        +   " join practitioner on (practitioner.id=coned_offering_roster.practitioner_id)"
        +   " join practitioner_level on (practitioner_level.id=practitioner.level_id)"
        +   " join coned_offering on (coned_offering.class_id=coned_offering_roster.coned_offering_class_id)"
        +   " join county_code_name_map coned_offering_county_code_name_map on (coned_offering_county_code_name_map.emsrs_code=coned_offering.class_county_code)"
        +   " left join county_code_name_map practitioner_county_code_name_map on (practitioner_county_code_name_map.code=practitioner.residence_county_code)"
        + " where coned_offering_class_id = '" + class_id + "'"
        + " order by " + sort_order.Replace("%", (be_sort_order_ascending ? " asc" : " desc")),
        connection
        )
        .ExecuteReader();
      ((target) as BaseDataList).DataBind();
      (((target) as BaseDataList).DataSource as MySqlDataReader).Close();
      Close();
      }

    public bool Delete(string id)
      {
      var result = true;
      Open();
      try
        {
        new MySqlCommand
          (
          db_trail.Saved
            (
            "delete from coned_offering_roster"
            + " where id = '" + id + "'"
            +   " and 'NEEDS_CONED_SPONSOR_FINALIZATION' ="
            +     " ("
            +     " select description"
            +     " from coned_offering"
            +       " join coned_offering_status on (coned_offering_status.id=coned_offering.status_id)"
            +     " where coned_offering.class_id = coned_offering_roster.coned_offering_class_id"
            +     " )"
            ),
          connection
          )
          .ExecuteNonQuery();
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
      out string coned_offering_class_id,
      out string practitioner_id,
      out string instructor_hours
      )
      {
      coned_offering_class_id = k.EMPTY;
      practitioner_id = k.EMPTY;
      instructor_hours = k.EMPTY;
      var result = false;
      //
      Open();
      var dr = new MySqlCommand("select * from coned_offering_roster where CAST(id AS CHAR) = \"" + id + "\"", connection).ExecuteReader();
      if (dr.Read())
        {
        coned_offering_class_id = dr["coned_offering_class_id"].ToString();
        practitioner_id = dr["practitioner_id"].ToString();
        instructor_hours = dr["instructor_hours"].ToString();
        result = true;
        }
      dr.Close();
      Close();
      return result;
      }

    public void Set
      (
      string id,
      string coned_offering_class_id,
      string practitioner_id,
      string instructor_hours
      )
      {
      var childless_field_assignments_clause = k.EMPTY
      + "coned_offering_class_id = NULLIF('" + coned_offering_class_id + "','')"
      + " , practitioner_id = NULLIF('" + practitioner_id + "','')"
      + " , instructor_hours = NULLIF('" + instructor_hours + "','')"
      + k.EMPTY;
      Open();
      new MySqlCommand
        (
        db_trail.Saved
          (
          "insert coned_offering_roster (id,coned_offering_class_id,practitioner_id,instructor_hours)"
          + " select NULLIF('" + id + "','') as id"
          + " , NULLIF('" + coned_offering_class_id + "','') as coned_offering_class_id"
          + " , NULLIF('" + practitioner_id + "','') as practitioner_id"
          + " , NULLIF('" + instructor_hours + "','') as instructor_hours"
          + " from coned_offering"
          +   " join coned_offering_status on (coned_offering_status.id=coned_offering.status_id)"
          + " where coned_offering.class_id = '" + coned_offering_class_id + "'"
          +   " and coned_offering_status.description = 'NEEDS_CONED_SPONSOR_FINALIZATION'"
          + " on duplicate key update "
          + childless_field_assignments_clause
          ),
          connection
        )
        .ExecuteNonQuery();
      Close();
      }

    } // end TClass_db_coned_offering_rosters

  }
