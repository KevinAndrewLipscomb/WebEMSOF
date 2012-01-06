using Class_db_training_institute_statuses;
using kix;

namespace Class_biz_training_institute_statuses
{
    public class TClass_biz_training_institute_statuses
    {
        private TClass_db_training_institute_statuses db_training_institute_statuses = null;
        //Constructor  Create()
        public TClass_biz_training_institute_statuses() : base()
        {
            // TODO: Add any constructor code here
            db_training_institute_statuses = new TClass_db_training_institute_statuses();
        }
        public bool Bind(string partial_code, object target)
        {
            bool result;
            result = db_training_institute_statuses.Bind(partial_code, target);
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_training_institute_statuses.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- training institute status --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string code)
        {
            bool result;
            result = db_training_institute_statuses.Delete(code);
            return result;
        }

        public bool Get(string code, out string description)
        {
            bool result;
            result = db_training_institute_statuses.Get(code, out description);

            return result;
        }

        public void Set(string code, string description)
        {
            db_training_institute_statuses.Set(code, description);

        }

    } // end TClass_biz_training_institute_statuses

}
