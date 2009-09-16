using System.Configuration;

using kix;

using System;



using System.IO;
using System.Web;
namespace Class_biz_notifications
{
    // Class type
    public class TClass_biz_notifications
    {
        private string application_name = String.Empty;
        //Constructor  Create()
        public TClass_biz_notifications() : base()
        {
            application_name = ConfigurationManager.AppSettings["application_name"];
        }
        private delegate string IssueCorruptionNotification_Merge(string s);
        public void IssueCorruptionNotification(string user_kind, string detection_phase)
        {
            StreamReader template_reader;

            IssueCorruptionNotification_Merge Merge = delegate (string s)
              {
              return s
                .Replace("<application_name/>", application_name)
                .Replace("<detection_phase/>", detection_phase)
                .Replace("<user_kind/>", user_kind);
              };

            template_reader = System.IO.File.OpenText(HttpContext.Current.Server.MapPath("template/notification/corruption_notification.txt"));
            // from
            // to
            // subject
            // body
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], ConfigurationManager.AppSettings["sender_email_address"], Merge(template_reader.ReadLine()), Merge(template_reader.ReadToEnd()));
            template_reader.Close();
        }

    } // end TClass_biz_notifications

}

namespace Class_biz_notifications.Units
{
    public class Class_biz_notifications
    {
        public static char[] BreakChars = new char[3 + 1];
        //Constructor  Class_biz_notifications()
        static Class_biz_notifications()
        {
            BreakChars[1] = Convert.ToChar(k.SPACE);
            BreakChars[2] = Convert.ToChar(k.TAB);
            BreakChars[3] = Convert.ToChar(k.HYPHEN);
        }
    } // end Class_biz_notifications

}

