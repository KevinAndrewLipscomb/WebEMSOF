using kix;
using System;
using Class_db_coned_offering_class_final_status_descriptions;
namespace Class_biz_coned_offering_class_final_status_descriptions
{
    public class TClass_biz_coned_offering_class_final_status_descriptions
    {
        private TClass_db_coned_offering_class_final_status_descriptions db_coned_offering_class_final_status_descriptions = null;
        //Constructor  Create()
        public TClass_biz_coned_offering_class_final_status_descriptions() : base()
        {
            // TODO: Add any constructor code here
            db_coned_offering_class_final_status_descriptions = new TClass_db_coned_offering_class_final_status_descriptions();
        }
        public bool Bind(string partial_code, object target)
        {
            bool result;
            result = db_coned_offering_class_final_status_descriptions.Bind(partial_code, target);
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_coned_offering_class_final_status_descriptions.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- court kind --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string code)
        {
            bool result;
            result = db_coned_offering_class_final_status_descriptions.Delete(code);
            return result;
        }

        public bool Get(string code, out string description)
        {
            bool result;
            result = db_coned_offering_class_final_status_descriptions.Get(code, out description);

            return result;
        }

        public void Set(string code, string description)
        {
            db_coned_offering_class_final_status_descriptions.Set(code, description);

        }

    } // end TClass_biz_coned_offering_class_final_status_descriptions

}
