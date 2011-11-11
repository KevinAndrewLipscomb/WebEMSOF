using HtmlAgilityPack;
using kix;
using System;
using System.Collections;
using System.IO;
using System.Net;

namespace WebEMSOF.component.ss
  {
  public static class Class_ss_Static
    {
    }

  public class Class_ss_emsams
    {

    private bool Request_ems_health_state_pa_us_Emsportal_Login
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
      {
	    response = null;
	    try
	      {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/emsportal/");
        request.CookieContainer = cookie_container;
        //
		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/emsportal/";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=dh4f2wnm3ei4m1xogh0yp3lb");
        //
		    request.Method = "POST";
        //
		    string postString = @"__LASTFOCUS=&__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=%2FwEPDwUKLTE3NTAzOTU4NA9kFgJmD2QWAmYPZBYCAgMPZBYEAgUPZBYCAgkPZBYGAgcPDxYCHgRUZXh0ZWRkAgsPDxYCHwAFrgFUbyBhY2Nlc3MgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCB3aXRoaW4gdGhpcyBzaXRlLCB5b3UgbXVzdCBmaXJzdCBzdXBwbHkgeW91ciBVc2VyIElEIGFuZCBQYXNzd29yZC4gSWYgeW91IGFyZSBhIG5ldyB1c2VyLCBwbGVhc2UgY2xpY2sgdGhlIE5ldyBVc2VyIGh5cGVybGluayBvbiB0aGUgbGVmdC5kZAIVDw9kFgIeCm9ua2V5cHJlc3MFD2NhcExvY2soZXZlbnQpO2QCBw8PFgIfAAUFMi43LjdkZGSi3%2Bq%2FrXRXfWRoV8kTgPXhWWMlBSdUfN5bJQ1nQ4lB1w%3D%3D&__EVENTVALIDATION=%2FwEWCwK40YmkBALIuezVAQLuz5ccAtGzipwGAtHfmMwJAv%2FMl4kOAuH2v7gNAqzHicUMAq%2FYnNUFAordjeMHApXYxf4CaG4O68g%2BvQJ0d%2FaODlJI0L%2By96Dj4XwJJJfYntaxtjs%3D&ctl00%24ctl00%24SessionLinkBar%24Content%24txtUserName=KALipscomb&ctl00%24ctl00%24SessionLinkBar%24Content%24txtPassword=Pallifica1&ctl00%24ctl00%24SessionLinkBar%24Content%24cmdLoginUser=Login";
		    byte[] postBytes = System.Text.Encoding.UTF8.GetBytes(postString);
		    request.ContentLength = postBytes.Length;
		    Stream stream = request.GetRequestStream();
		    stream.Write(postBytes, 0, postBytes.Length);
		    stream.Close();
        //
		    response = (HttpWebResponse)request.GetResponse();
	      }
	    catch (WebException e)
	      {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	      }
	    catch (Exception)
	      {
		    if(response != null) response.Close();
		    return false;
	      }
	    return true;
      }

    private bool Request_ems_health_state_pa_us_EmsportalApplicationtransfersTransfertoconed
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
      {
	    response = null;

	    try
	      {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/EMSPortal/ApplicationTransfers/TransferToConEd.aspx");
        request.CookieContainer = cookie_container;

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/EMSPortal/ApplicationList.aspx";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=hymy3yujgf1gaopjfodpcqfn");

		    response = (HttpWebResponse)request.GetResponse();
	      }
	    catch (WebException e)
	      {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
  	    }
	    catch (Exception)
	      {
		    if(response != null) response.Close();
		    return false;
	      }

	    return true;
      }

    private bool Request_ems_health_state_pa_us_ConedClasssearch
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/ClassSearch.asp");
        request.CookieContainer = cookie_container;

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/MainMenu.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=hymy3yujgf1gaopjfodpcqfn; ConEd_EMSOUserID=345; ASPSESSIONIDSCCDSBCQ=JDKNGNNCEFNLKBKABEAGCCPJ; ASPSESSIONIDQCBBRDCQ=MFMNIHOCGKDFKAECCINFODBN; EMS_EMSOUserID=KALipscomb; EMS_EMSOType=QRS; ASPSESSIONIDSCDBSADR=BAMDPJOCCGMIMJLGHPPCFEIG; ASPSESSIONIDQCDARDDQ=OABNCNOCAOGCDDDIGLEBHGFH; ASPSESSIONIDSABBRDDR=AKIJMAPCAGNFPBAIGBJEHGJN");

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }

    private bool Request_ems_health_state_pa_us_ConedClasssearch_Coned_Filedelimited_Searchnow
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/ClassSearch.asp");
        request.CookieContainer = cookie_container;

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/ClassSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=drkxrxkrje0i1irpscgw35g3; ConEd_EMSOUserID=345; ASPSESSIONIDSCDATADQ=NLGPKEICGOFDPEKCGMIBHCHH");

		    request.Method = "POST";

		    string postString = @"SearchMode=&cmdMove=Search+Now&ClassType=CONED&CourseNumber=&CourseTitle=&CourseCode=&StartDate_Low=&StartDate_High=&ClassCountyCode=&RegionCouncilNum=&ClassNumber=&IncludeDisapprovedClasses=0&OutputFormat=FileDelimited";
		    byte[] postBytes = System.Text.Encoding.UTF8.GetBytes(postString);
		    request.ContentLength = postBytes.Length;
		    Stream stream = request.GetRequestStream();
		    stream.Write(postBytes, 0, postBytes.Length);
		    stream.Close();

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }

    private bool Request_ems_health_state_pa_us_ConedExportClasssearchtxt
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/Export/ClassSearch_345.txt");
        request.CookieContainer = cookie_container;

		    request.Accept = "text/html, application/xhtml+xml, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/ClassSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=eftwud551xujf0rdibjcz4re");

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }
    private bool Request_ems_health_state_pa_us_ConedListclassnumbers
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/ListClassNumbers.asp");
        request.CookieContainer = cookie_container;

		    request.Accept = "*/*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/ClassSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=hymy3yujgf1gaopjfodpcqfn; ConEd_EMSOUserID=345; ASPSESSIONIDSCCDSBCQ=JDKNGNNCEFNLKBKABEAGCCPJ; ASPSESSIONIDQCBBRDCQ=MFMNIHOCGKDFKAECCINFODBN; EMS_EMSOUserID=KALipscomb; EMS_EMSOType=QRS; ASPSESSIONIDSCDBSADR=BAMDPJOCCGMIMJLGHPPCFEIG; ASPSESSIONIDQCDARDDQ=OABNCNOCAOGCDDDIGLEBHGFH; ASPSESSIONIDSABBRDDR=AKIJMAPCAGNFPBAIGBJEHGJN");

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }

    private bool Request_ems_health_state_pa_us_ConedListClassNumbers_Coned_2011_999999_ShowNumbers
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/ListClassNumbers.asp");
        request.CookieContainer = cookie_container;

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/ListClassNumbers.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=hymy3yujgf1gaopjfodpcqfn; ConEd_EMSOUserID=345; ASPSESSIONIDSCCDSBCQ=JDKNGNNCEFNLKBKABEAGCCPJ; ASPSESSIONIDQCBBRDCQ=MFMNIHOCGKDFKAECCINFODBN; EMS_EMSOUserID=KALipscomb; EMS_EMSOType=QRS; ASPSESSIONIDSCDBSADR=BAMDPJOCCGMIMJLGHPPCFEIG; ASPSESSIONIDQCDARDDQ=OABNCNOCAOGCDDDIGLEBHGFH; ASPSESSIONIDSABBRDDR=AKIJMAPCAGNFPBAIGBJEHGJN");

		    request.Method = "POST";

		    string postString = @"ClassType=CONED&ClassYear=2011&HowMany=999999&cmdMove=Show+Numbers";
		    byte[] postBytes = System.Text.Encoding.UTF8.GetBytes(postString);
		    request.ContentLength = postBytes.Length;
		    Stream stream = request.GetRequestStream();
		    stream.Write(postBytes, 0, postBytes.Length);
		    stream.Close();

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }

    private bool Request_ems_health_state_pa_us_Coned_Mainmenu_Logout
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/MainMenu.asp?cmdMove=logout");
        request.CookieContainer = cookie_container;

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/MainMenu.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=5rk44se5bzjgtspmizipbpwp; ConEd_EMSOUserID=345; ASPSESSIONIDQCCATACQ=IPDLADIDOFONKEFNONAJIAEK");

		    response = (HttpWebResponse)request.GetResponse();
	    }
	    catch (WebException e)
	    {
		    if (e.Status == WebExceptionStatus.ProtocolError) response = (HttpWebResponse)e.Response;
		    else return false;
	    }
	    catch (Exception)
	    {
		    if(response != null) response.Close();
		    return false;
	    }

	    return true;
    }

    internal class ConedOffering
      {
      internal string class_id_1 = k.EMPTY;
      internal string class_type = k.EMPTY;
      internal string course_id = k.EMPTY;
      internal string class_number = k.EMPTY;
      internal string course_code = k.EMPTY;
      internal string created_by = k.EMPTY;
      internal string date_created = k.EMPTY;
      internal string last_edited_by = k.EMPTY;
      internal string date_last_edited = k.EMPTY;
      internal string sponsor_id = k.EMPTY;
      internal string sponsor_number = k.EMPTY;
      internal string training_ins_accred_num = k.EMPTY;
      internal string document_status = k.EMPTY;
      internal string class_final_status = k.EMPTY;
      internal string course_number = k.EMPTY;
      internal string location = k.EMPTY;
      internal string student_cost = k.EMPTY;
      internal string tuition_includes = k.EMPTY;
      internal string closed = k.EMPTY;
      internal string estimated_students = k.EMPTY;
      internal string start_date_time = k.EMPTY;
      internal string end_date_time = k.EMPTY;
      internal string start_time = k.EMPTY;
      internal string end_time = k.EMPTY;
      internal string other_dates_and_times = k.EMPTY;
      internal string instructors = k.EMPTY;
      internal string instructor_qualifications = k.EMPTY;
      internal string verification_name = k.EMPTY;
      internal string contact_name = k.EMPTY;
      internal string contact_address_1 = k.EMPTY;
      internal string contact_address_2 = k.EMPTY;
      internal string contact_city = k.EMPTY;
      internal string contact_state = k.EMPTY;
      internal string contact_zip = k.EMPTY;
      internal string contact_daytime_phone = k.EMPTY;
      internal string contact_evening_phone = k.EMPTY;
      internal string contact_email = k.EMPTY;
      internal string public_contact_name = k.EMPTY;
      internal string public_contact_phone = k.EMPTY;
      internal string public_contact_email = k.EMPTY;
      internal string public_contact_website = k.EMPTY;
      internal string public_contact_notes = k.EMPTY;
      internal string date_submitted_to_region = k.EMPTY;
      internal string date_received_by_region = k.EMPTY;
      internal string date_sponsor_notified = k.EMPTY;
      internal string date_registration_sent_to_state = k.EMPTY;
      internal string date_cards_sent_to_sponsor = k.EMPTY;
      internal string date_materials_to_be_returned = k.EMPTY;
      internal string approved = k.EMPTY;
      internal string region_comments = k.EMPTY;
      internal string region_council_num = k.EMPTY;
      internal string class_county_code = k.EMPTY;
      internal string total_class_hours = k.EMPTY;
      internal string location_address_1 = k.EMPTY;
      internal string location_address_2 = k.EMPTY;
      internal string location_city = k.EMPTY;
      internal string location_state = k.EMPTY;
      internal string location_zip = k.EMPTY;
      internal string location_zip_plus_4 = k.EMPTY;
      internal string location_phone = k.EMPTY;
      internal string location_email = k.EMPTY;
      internal string location_of_registration = k.EMPTY;
      internal string primary_text = k.EMPTY;
      internal string additional_texts = k.EMPTY;
      internal string final_registration_date = k.EMPTY;
      internal string offered_as_college_credit = k.EMPTY;
      internal string practical_exam_date = k.EMPTY;
      internal string written_exam_date = k.EMPTY;
      internal string disapproval_reason_id = k.EMPTY;
      internal string date_final_paperwork_received = k.EMPTY;
      internal string signed_hard_copy = k.EMPTY;
      internal string created_by_first_name = k.EMPTY;
      internal string created_by_last_name = k.EMPTY;
      internal string class_disapproval_reason_description = k.EMPTY;
      internal string class_final_status_description = k.EMPTY;
      internal string sponsor_name = k.EMPTY;
      internal string courses_course_number = k.EMPTY;
      internal string course_title = k.EMPTY;
      internal string cert_course_code = k.EMPTY;
      internal string cert_course_description = k.EMPTY;
      internal string class_id_2 = k.EMPTY;
      }
    internal ArrayList ClassSearchUnlimited()
      {
      var class_search_unlimited = new ArrayList();
      //
      HttpWebResponse dummy_response;
      HttpWebResponse response;
      var cookie_container = new CookieContainer();
      if(
          Request_ems_health_state_pa_us_Emsportal_Login(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_EmsportalApplicationtransfersTransfertoconed(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedClasssearch(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedClasssearch_Coned_Filedelimited_Searchnow(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedExportClasssearchtxt(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_Coned_Mainmenu_Logout(cookie_container,out dummy_response)
        )
        {
        var stream_reader = new StreamReader(response.GetResponseStream());
        stream_reader.ReadLine();  //Discard the first line.  It only contains column headings.
        while (!stream_reader.EndOfStream)
          {
          var field_array = stream_reader.ReadLine().Split(new string[] {k.TAB},StringSplitOptions.None);
          var coned_offering = new ConedOffering();
          coned_offering.class_id_1 = field_array[0];
          coned_offering.class_type = field_array[1];
          coned_offering.course_id = field_array[2];
          coned_offering.class_number = field_array[3];
          coned_offering.course_code = field_array[4];
          coned_offering.created_by = field_array[5];
          coned_offering.date_created = field_array[6];
          coned_offering.last_edited_by = field_array[7];
          coned_offering.date_last_edited = field_array[8];
          coned_offering.sponsor_id = field_array[9];
          coned_offering.sponsor_number = field_array[10];
          coned_offering.training_ins_accred_num = field_array[11];
          coned_offering.document_status = field_array[12];
          coned_offering.class_final_status = field_array[13];
          coned_offering.course_number = field_array[14];
          coned_offering.location = field_array[15];
          coned_offering.student_cost = field_array[16];
          coned_offering.tuition_includes = field_array[17];
          coned_offering.closed = field_array[18];
          coned_offering.estimated_students = field_array[19];
          coned_offering.start_date_time = field_array[20];
          coned_offering.end_date_time = field_array[21];
          coned_offering.start_time = field_array[22];
          coned_offering.end_time = field_array[23];
          coned_offering.other_dates_and_times = field_array[24];
          coned_offering.instructors = field_array[25];
          coned_offering.instructor_qualifications = field_array[26];
          coned_offering.verification_name = field_array[27];
          coned_offering.contact_name = field_array[28];
          coned_offering.contact_address_1 = field_array[29];
          coned_offering.contact_address_2 = field_array[30];
          coned_offering.contact_city = field_array[31];
          coned_offering.contact_state = field_array[32];
          coned_offering.contact_zip = field_array[33];
          coned_offering.contact_daytime_phone = field_array[34];
          coned_offering.contact_evening_phone = field_array[35];
          coned_offering.contact_email = field_array[36];
          coned_offering.public_contact_name = field_array[37];
          coned_offering.public_contact_phone = field_array[38];
          coned_offering.public_contact_email = field_array[39];
          coned_offering.public_contact_website = field_array[40];
          coned_offering.public_contact_notes = field_array[41];
          coned_offering.date_submitted_to_region = field_array[42];
          coned_offering.date_received_by_region = field_array[43];
          coned_offering.date_sponsor_notified = field_array[44];
          coned_offering.date_registration_sent_to_state = field_array[45];
          coned_offering.date_cards_sent_to_sponsor = field_array[46];
          coned_offering.date_materials_to_be_returned = field_array[47];
          coned_offering.approved = field_array[48];
          coned_offering.region_comments = field_array[49];
          coned_offering.region_council_num = field_array[50];
          coned_offering.class_county_code = field_array[51];
          coned_offering.total_class_hours = field_array[52];
          coned_offering.location_address_1 = field_array[53];
          coned_offering.location_address_2 = field_array[54];
          coned_offering.location_city = field_array[55];
          coned_offering.location_state = field_array[56];
          coned_offering.location_zip = field_array[57];
          coned_offering.location_zip_plus_4 = field_array[58];
          coned_offering.location_phone = field_array[59];
          coned_offering.location_email = field_array[60];
          coned_offering.location_of_registration = field_array[61];
          coned_offering.primary_text = field_array[62];
          coned_offering.additional_texts = field_array[63];
          coned_offering.final_registration_date = field_array[64];
          coned_offering.offered_as_college_credit = field_array[65];
          coned_offering.practical_exam_date = field_array[66];
          coned_offering.written_exam_date = field_array[67];
          coned_offering.disapproval_reason_id = field_array[68];
          coned_offering.date_final_paperwork_received = field_array[69];
          coned_offering.signed_hard_copy = field_array[70];
          coned_offering.created_by_first_name = field_array[71];
          coned_offering.created_by_last_name = field_array[72];
          coned_offering.class_disapproval_reason_description = field_array[73];
          coned_offering.class_final_status_description = field_array[74];
          coned_offering.sponsor_name = field_array[75];
          coned_offering.courses_course_number = field_array[76];
          coned_offering.course_title = field_array[77];
          coned_offering.cert_course_code = field_array[78];
          coned_offering.cert_course_description = field_array[79];
          coned_offering.class_id_2 = field_array[80];
          class_search_unlimited.Add(coned_offering);
          }
        stream_reader.Close();
        }
      return class_search_unlimited;
      }

    //internal class ConedOffering
    //  {
    //  internal string num = k.EMPTY;
    //  internal string region_code = k.EMPTY;
    //  internal string end_date = k.EMPTY;
    //  }
    //internal ArrayList MonitoredConedOffering()
    //  {
    //  var monitored_coned_offering = new ArrayList();
    //  //
    //  HttpWebResponse dummy_response;
    //  HttpWebResponse response;
    //  var cookie_container = new CookieContainer();
    //  var stream = k.EMPTY;
    //  if(
    //      Request_ems_health_state_pa_us_Emsportal_Login(cookie_container,out response)
    //    &&
    //      Request_ems_health_state_pa_us_EmsportalApplicationtransfersTransfertoconed(cookie_container,out response)
    //    &&
    //      Request_ems_health_state_pa_us_ConedClasssearch(cookie_container,out response)
    //    &&
    //      Request_ems_health_state_pa_us_ConedListclassnumbers(cookie_container,out response)
    //    &&
    //      Request_ems_health_state_pa_us_ConedListClassNumbers_Coned_2011_999999_ShowNumbers(cookie_container,out response)
    //    &&
    //      Request_ems_health_state_pa_us_Coned_Mainmenu_Logout(cookie_container,out dummy_response)
    //    )
    //    {
    //    var stream_reader = new StreamReader(response.GetResponseStream());
    //    stream = stream_reader.ReadToEnd(); 
    //    stream_reader.Close();
    //    //
    //    var html_document = new HtmlDocument(); 
    //    html_document.LoadHtml(stream);
    //    //
    //    // The initial XPaths are determined by visiting the page in IE9, selecting "F12 developer tools", setting Document Mode to IE9 Standards, navigating to the node of interest, and disregarding any tbody tags.
    //    //
    //    var hnc_class_number = html_document.DocumentNode.SelectNodes("/html/body/font[3]/table/tr/td[1]");
    //    var hnc_region_code = html_document.DocumentNode.SelectNodes("/html/body/font[3]/table/tr/td[3]");
    //    var hnc_class_end_date = html_document.DocumentNode.SelectNodes("/html/body/font[3]/table/tr/td[8]");
    //    //
    //    for (var i = new k.subtype<int>(0,hnc_class_number.Count); i.val < i.LAST; i.val++)
    //      {
    //      var coned_offering = new ConedOffering();
    //      coned_offering.num = hnc_class_number[i.val].InnerText.Trim();
    //      coned_offering.region_code = hnc_region_code[i.val].InnerText.Trim();
    //      coned_offering.end_date = hnc_class_end_date[i.val].InnerText.Trim();
    //      monitored_coned_offering.Add(coned_offering);
    //      }
    //    }
    //  return monitored_coned_offering;
    //  }

    }
  }
