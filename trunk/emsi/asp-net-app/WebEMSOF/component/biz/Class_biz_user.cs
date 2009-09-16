using Class_db_user;
using kix;
using System;
using System.Web;

namespace Class_biz_user
{
    public class TClass_biz_user
    {
        //Constructor  Create()
        public TClass_biz_user() : base()
        {
            // TODO: Add any constructor code here

        }
        public string Kind()
        {
            string result;
            string name;
            name = HttpContext.Current.User.Identity.Name;
            result = name.Substring(0, name.LastIndexOf("_"));
            return result;
        }

        public string IdNum()
        {
            string result;
            string name;
            name = HttpContext.Current.User.Identity.Name;
            result = name.Substring(name.LastIndexOf("_") + 1);
            return result;
        }

        public string[] Roles()
        {
            string[] result = {k.EMPTY};
            string name;
            name = HttpContext.Current.User.Identity.Name;
            if (Kind() == Units.Class_biz_user.KIND_THAT_HAS_ROLES)
            {
                result = new TClass_db_user().RolesOf("regional_staffer_", IdNum());
            }
            return result;
        }

    } // end TClass_biz_user

}

namespace Class_biz_user.Units
{
    public class Class_biz_user
    {
        public const string ID = "$Id: Class_biz_user.pas 2343 2008-05-28 21:19:37Z kevinanlipscomb $";
        public const string KIND_THAT_HAS_ROLES = "regional_staffer";
    } // end Class_biz_user

}

