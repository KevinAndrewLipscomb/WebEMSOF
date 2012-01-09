using Class_biz_accounts;
using Class_biz_teaching_entities;
using kix;
using System;
using System.Configuration;
using System.IO;
using System.Web;

namespace Class_biz_notifications
  {

  public class Class_biz_notifications_Static
    {
    public static char[] BreakChars = new char[3 + 1];
    static Class_biz_notifications_Static()
      {
      BreakChars[1] = Convert.ToChar(k.SPACE);
      BreakChars[2] = Convert.ToChar(k.TAB);
      BreakChars[3] = Convert.ToChar(k.HYPHEN);
      }
    }

  public class TClass_biz_notifications
    {

    private string application_name = k.EMPTY;
    private string host_domain_name = k.EMPTY;

    public TClass_biz_notifications() : base()
      {
      application_name = ConfigurationManager.AppSettings["application_name"];
      host_domain_name = ConfigurationManager.AppSettings["host_domain_name"];
      }

    private delegate string IssueCorruptionNotification_Merge(string s);
    internal void IssueCorruptionNotification(string user_kind, string detection_phase)
      {
      IssueCorruptionNotification_Merge Merge = delegate (string s)
        {
        return s
          .Replace("<application_name/>", application_name)
          .Replace("<detection_phase/>", detection_phase)
          .Replace("<user_kind/>", user_kind);
        };

      var template_reader = File.OpenText(HttpContext.Current.Server.MapPath("template/notification/corruption_notification.txt"));
      k.SmtpMailSend
        (
        from:ConfigurationManager.AppSettings["sender_email_address"],
        to:ConfigurationManager.AppSettings["sender_email_address"],
        subject:Merge(template_reader.ReadLine()),
        message_string:Merge(template_reader.ReadToEnd())
        );
      template_reader.Close();
      }

    private delegate string IssueForClassClosed_Merge(string s);
    internal void IssueForClassClosed
      (
      string sponsor_id,
      string sponsor_number,
      string sponsor_name,
      string sponsor_email,
      string sponsor_contact_email,
      string sponsor_public_contact_email,
      string coned_offering_public_contact_email,
      string class_number,
      string course_title,
      string start,
      string end,
      string total_class_hours,
      string location,
      k.int_nonnegative num_attendees,
      string status_description
      )
      {
      IssueForClassClosed_Merge Merge = delegate (string s)
        {
        return s
          .Replace("<application_name/>",application_name)
          .Replace("<host_domain_name/>",host_domain_name)
          .Replace("<class_number/>",class_number.Insert(8,k.HYPHEN).Insert(2,k.HYPHEN))
          .Replace("<sponsor_number/>",sponsor_number)
          .Replace("<sponsor_name/>",sponsor_name)
          .Replace("<status_description/>",status_description)
          .Replace("<course_title/>",course_title)
          .Replace("<start/>",start)
          .Replace("<end/>",end)
          .Replace("<total_class_hours/>",total_class_hours.ToString())
          .Replace("<num_attendees/>",num_attendees.val.ToString())
          .Replace("<location/>",location)
          .Replace("<coned_offering_public_contact_email/>",coned_offering_public_contact_email)
          .Replace("<sponsor_email/>",sponsor_email)
          .Replace("<sponsor_contact_email/>",sponsor_contact_email)
          .Replace("<sponsor_public_contact_email/>",sponsor_public_contact_email)
          ;
        };

      var biz_accounts = new TClass_biz_accounts();
      var template_reader = File.OpenText(HttpContext.Current.Server.MapPath("template/notification/roster_ready.txt"));
      k.SmtpMailSend
        (
        from:ConfigurationManager.AppSettings["sender_email_address"],
        to:biz_accounts.EmailTargetByRole("education-coordinator") + k.COMMA + biz_accounts.EmailTargetByRole("education-specialist"),
        subject:Merge(template_reader.ReadLine()),
        message_string:Merge(template_reader.ReadToEnd()),
        be_html:false,
        cc:(coned_offering_public_contact_email + k.COMMA + sponsor_email + k.COMMA + sponsor_contact_email + k.COMMA + sponsor_public_contact_email).Trim(new char[] {Convert.ToChar(k.COMMA)}).Replace(",,",k.COMMA),
        bcc:k.EMPTY,
        reply_to:sponsor_email
        );
      template_reader.Close();
      }

    }

  }
