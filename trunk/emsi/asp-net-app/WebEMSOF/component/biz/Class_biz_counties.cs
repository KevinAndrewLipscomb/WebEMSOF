using kix;
using System;
using Class_db_counties;
namespace Class_biz_counties
{
    public class TClass_biz_counties
    {
        private TClass_db_counties db_counties = null;
        //Constructor  Create()
        public TClass_biz_counties() : base()
        {
            // TODO: Add any constructor code here
            db_counties = new TClass_db_counties();
        }
        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_counties.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- County --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public string NameOf(string code)
        {
            string result;
            result = db_counties.NameOf(code);
            return result;
        }

    } // end TClass_biz_counties

}
