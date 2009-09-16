using System;
using Class_db_fy_calendar;
using Class_biz_milestones;
namespace Class_biz_fy_calendar
{
    public class TClass_biz_fy_calendar
    {
        private TClass_db_fy_calendar db_fy_calendar = null;
        //Constructor  Create()
        public TClass_biz_fy_calendar() : base()
        {
            db_fy_calendar = new TClass_db_fy_calendar();
        }
        public DateTime MilestoneDate(milestone_type milestone)
        {
            DateTime result;
            result = db_fy_calendar.MilestoneDate(((uint)(milestone)).ToString());
            return result;
        }

    } // end TClass_biz_fy_calendar

}
