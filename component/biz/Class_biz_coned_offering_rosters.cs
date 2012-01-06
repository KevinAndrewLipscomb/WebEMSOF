// Derived from KiAspdotnetFramework/component/biz/Class~biz~~template~kicrudhelped~item.cs~template

using Class_db_coned_offering_rosters;
using kix;
using System;
using System.Collections;

namespace Class_biz_coned_offering_rosters
  {
  public class TClass_biz_coned_offering_rosters
    {
    private TClass_db_coned_offering_rosters db_coned_offering_rosters = null;

    public TClass_biz_coned_offering_rosters() : base()
      {
      db_coned_offering_rosters = new TClass_db_coned_offering_rosters();
      }

    public bool Bind(string partial_spec, object target)
      {
      return db_coned_offering_rosters.Bind(partial_spec, target);
      }

    public void BindBaseDataListByClassId
      (
      string sort_order,
      bool be_sort_order_ascending,
      object target,
      string class_id
      )
      {
      db_coned_offering_rosters.BindBaseDataListByClassId(sort_order,be_sort_order_ascending,target,class_id);
      }

      public void BindDirectToListControl(object target)
      {
      db_coned_offering_rosters.BindDirectToListControl(target);
      }

    public bool Delete(string id)
      {
      return db_coned_offering_rosters.Delete(id);
      }

    public bool Get
      (
      string id,
      out string coned_offering_id,
      out string practitioner_id,
      out string instructor_hours
      )
      {
      return db_coned_offering_rosters.Get
        (
        id,
        out coned_offering_id,
        out practitioner_id,
        out instructor_hours
        );
      }

    public void Set
      (
      string id,
      string coned_offering_id,
      string practitioner_id,
      string instructor_hours
      )
      {
      db_coned_offering_rosters.Set
        (
        id,
        coned_offering_id,
        practitioner_id,
        instructor_hours
        );
      }

    } // end TClass_biz_coned_offering_rosters

  }
