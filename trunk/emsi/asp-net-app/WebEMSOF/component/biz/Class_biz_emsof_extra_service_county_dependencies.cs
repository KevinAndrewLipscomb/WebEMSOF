using Class_db_emsof_extra_service_county_dependencies;
using kix;
using System;
using System.Collections;
using System.Linq;
using System.Web;

namespace Class_biz_emsof_extra_service_county_dependencies
  {
  public class TClass_biz_emsof_extra_service_county_dependencies
    {

    private TClass_db_emsof_extra_service_county_dependencies db_emsof_extra_service_county_dependencies;

    public TClass_biz_emsof_extra_service_county_dependencies() : base()
      {
      db_emsof_extra_service_county_dependencies = new TClass_db_emsof_extra_service_county_dependencies();
      }

    internal void Get
      (
      string service_id,
      Queue q
      )
      {
      db_emsof_extra_service_county_dependencies.Get(service_id,q);
      }

    internal void Update
      (
      string service_id,
      Queue q,
      string home_county_code
      )
      {
      var dependency = k.EMPTY;
      var cooked_q = new Queue();
      while (q.Count > 0)
        {
        dependency = q.Dequeue().ToString();
        if (dependency != home_county_code)
          {
          cooked_q.Enqueue(dependency);
          }
        }
      db_emsof_extra_service_county_dependencies.Update(service_id,cooked_q);
      }

    }
  }