using System;
using Class_db_emsof_request_return_comments;
namespace Class_biz_emsof_request_return_comments
{
    public class TClass_biz_emsof_request_return_comments
    {
        private TClass_db_emsof_request_return_comments db_emsof_request_return_comments = null;
        //Constructor  Create()
        public TClass_biz_emsof_request_return_comments() : base()
        {
            db_emsof_request_return_comments = new TClass_db_emsof_request_return_comments();
        }
        public bool Bind(object target, string master_id)
        {
            bool result;
            result = db_emsof_request_return_comments.Bind(target, master_id);
            return result;
        }

        public void Log(string master_id, string demoter, string content)
        {
            db_emsof_request_return_comments.Log(master_id, demoter, content);
        }

    } // end TClass_biz_emsof_request_return_comments

}
