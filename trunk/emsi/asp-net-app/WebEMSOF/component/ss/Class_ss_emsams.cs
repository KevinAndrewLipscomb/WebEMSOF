using Class_ss;
using HtmlAgilityPack;
using kix;
using System;
using System.Collections;
using System.IO;
using System.Net;
using System.Net.Cache;
using System.Web;

namespace WebEMSOF.component.ss
  {
  public static class Class_ss_emsams_Static
    {
    }

  internal class Class_ss_emsams : TClass_ss
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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);
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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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

    private bool Request_ems_health_state_pa_us_ConedExportSponsorsearchtxt
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/Export/SponsorSearch_345.txt");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/SponsorSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=jcydtlzcjxtbyawd4zjsbg3w; ConEd_EMSOUserID=345; ASPSESSIONIDQCBBQCCR=HCGDCOMCLNEJMAGGPPNHCAFM");

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

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

    private bool Request_ems_health_state_pa_us_ConedSponsorsearch
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/SponsorSearch.asp");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/MainMenu.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=jcydtlzcjxtbyawd4zjsbg3w; ConEd_EMSOUserID=345; ASPSESSIONIDQCBBQCCR=HCGDCOMCLNEJMAGGPPNHCAFM");

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

    private bool Request_ems_health_state_pa_us_ConedSponsorsearch_Filedelimited_Searchnow
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/SponsorSearch.asp");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/SponsorSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=jcydtlzcjxtbyawd4zjsbg3w; ConEd_EMSOUserID=345; ASPSESSIONIDQCBBQCCR=HCGDCOMCLNEJMAGGPPNHCAFM");

		    request.Method = "POST";

		    string postString = @"cmdMove=Search+Now&name=&number=&Region=&CountyCode=&ExpirationDate_Low=&ExpirationDate_High=&Status=&ApplicationDate_Low=&ApplicationDate_High=&ProcessDate_Low=&ProcessDate_High=&OutputFormat=FileDelimited";
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

    private bool Request_ems_health_state_pa_us_ConedUsersearch
      (
      CookieContainer cookie_container,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/UserSearch.asp");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/MainMenu.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=5gecqtoycvwyikzjp3kz0mtz; ConEd_EMSOUserID=345; ASPSESSIONIDQCACSBCQ=NJAJLPMAEMPCLKMBIIEGHPLA");

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

    private bool Request_ems_health_state_pa_us_ConedUsersearch_RegionalCouncilId_SearchNow
      (
      CookieContainer cookie_container,
      string regional_council_id,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/ConEd/UserSearch.asp");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/ConEd/UserSearch.asp";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=5gecqtoycvwyikzjp3kz0mtz; ConEd_EMSOUserID=345; ASPSESSIONIDQCACSBCQ=NJAJLPMAEMPCLKMBIIEGHPLA");

		    request.Method = "POST";

		    string postString = @"SponsorName=&SponsorID=&cmdMove=Search+Now&FirstName=&LastName=&CertNumber=&RegionalCouncilID=" + regional_council_id + "&CountyCode=";
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

    private bool Request_ems_health_state_pa_us_EmsregActivepractitioners_3000
      (
      CookieContainer cookie_container,
      string view_state,
      string event_validation,
      string next_page_ctl_num,
      out HttpWebResponse response
      )
    {
	    response = null;

	    try
	    {
		    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://ems.health.state.pa.us/emsreg/ActivePractitioners.aspx");
        request.CookieContainer = cookie_container;
        request.CachePolicy = new RequestCachePolicy(RequestCacheLevel.NoCacheNoStore);

		    request.Accept = "image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, */*";
		    request.Referer = "https://ems.health.state.pa.us/emsreg/ActivePractitioners.aspx";
		    request.Headers.Set(HttpRequestHeader.AcceptLanguage, "en-US");
		    request.UserAgent = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E)";
		    request.ContentType = "application/x-www-form-urlencoded";
		    request.Headers.Set(HttpRequestHeader.AcceptEncoding, "gzip, deflate");
		    request.Headers.Set(HttpRequestHeader.CacheControl, "no-cache");
		    //request.Headers.Set(HttpRequestHeader.Cookie, @"ASP.NET_SessionId=2l0x3eidkit2jetl4uovsqsv");

		    request.Method = "POST";

        string postString = @"__EVENTTARGET=" + (view_state.Length == 0 ? k.EMPTY : "_ctl0%24_ctl0%24SessionLinkBar%24Content%24dgActivePractitioners%24_ctl3004%24_ctl" + next_page_ctl_num)
        + "&__EVENTARGUMENT=&__VIEWSTATE=" + (view_state.Length > 0 ? HttpUtility.UrlEncode(view_state) : "%2FwEPDwULLTExNzg2MTQwMjgPZBYCZg9kFgJmD2QWAgIDD2QWAgIDD2QWAgIBD2QWBAI3DxBkDxYcZgIBAgICAwIEAgUCBgIHAggCCQIKAgsCDAINAg4CDwIQAhECEgITAhQCFQIWAhcCGAIZAhoCGxYcEAUCMjAFAjIwZxAFAjUwBQI1MGcQBQMxMDAFAzEwMGcQBQMxNTAFAzE1MGcQBQMyMDAFAzIwMGcQBQMyNTAFAzI1MGcQBQMzMDAFAzMwMGcQBQMzNTAFAzM1MGcQBQM0MDAFAzQwMGcQBQM0NTAFAzQ1MGcQBQM1MDAFAzUwMGcQBQQxMDAwBQQxMDAwZxAFBDIwMDAFBDIwMDBnEAUEMzAwMAUEMzAwMGcQBQIyMAUCMjBnEAUCNTAFAjUwZxAFAzEwMAUDMTAwZxAFAzE1MAUDMTUwZxAFAzIwMAUDMjAwZxAFAzI1MAUDMjUwZxAFAzMwMAUDMzAwZxAFAzM1MAUDMzUwZxAFAzQwMAUDNDAwZxAFAzQ1MAUDNDUwZxAFAzUwMAUDNTAwZxAFBDEwMDAFBDEwMDBnEAUEMjAwMAUEMjAwMGcQBQQzMDAwBQQzMDAwZxYBZmQCOw88KwALAGRkPAOPGanOd%2B%2Fasz1ndu4u%2BJfxAt0GyCQj00qe9R8hQO0%3D")
        + "&__EVENTVALIDATION=" + (event_validation.Length > 0 ? HttpUtility.UrlEncode(event_validation) : "%2FwEWOQL30Y%2BjBwKk3e29BwKsi5ORBwKsi4%2BRBwKsi4uRBwKsi4eRBwKsi4ORBwKsi%2F%2BQBwKsi%2FuQBwKsi%2FeQBwKsi%2FOQBwKsi%2B%2BQBwKsi%2BuQBwKsi%2BeQBwKsi%2BOQBwKsi9%2BQBwKsi9uQBwKsi9eQBwKsi9OQBwKsi8%2BQBwKsi8uQBwKsi8eQBwKsi8OQBwKsi7%2BQBwKsi7uQBwKsi7eQBwKsi7OQBwKsi6%2BQBwK%2Fo8WnCwK6o8WnCwKY4qLwDAKY4tbzDAKZ4qLwDAKZ4tbzDAKW4qLwDAKW4tbzDAKX4qLwDAKX4tbzDAKU4qLwDAKY4uLNBwKZ4uLNBwKW4uLNBwK%2Fo8WnCwK6o8WnCwKY4qLwDAKY4tbzDAKZ4qLwDAKZ4tbzDAKW4qLwDAKW4tbzDAKX4qLwDAKX4tbzDAKU4qLwDAKY4uLNBwKZ4uLNBwKW4uLNBwL3s5yCAjrn621pzzM%2FnReSpQ%2B3sr4F3e12hGqbdpT1XiF0WhEX")
        + "&_ctl0%3A_ctl0%3ASessionLinkBar%3AContent%3AddPageSize=3000"
        + (view_state.Length == 0 ? "&_ctl0%3A_ctl0%3ASessionLinkBar%3AContent%3AbtnRefresh=Refresh" : k.EMPTY);
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
      HttpWebResponse response;
      var cookie_container = new CookieContainer();
      if(
          Request_ems_health_state_pa_us_ConedClasssearch(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedClasssearch_Coned_Filedelimited_Searchnow(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedExportClasssearchtxt(cookie_container,out response)
        )
        {
        var stream_reader = new StreamReader(response.GetResponseStream());
        stream_reader.ReadLine();  //Discard the first line.  It only contains column headings.
        while (!stream_reader.EndOfStream)
          {
          var field_array = stream_reader.ReadLine().Split(new string[] {k.TAB},StringSplitOptions.None);
          var coned_offering = new ConedOffering();
          coned_offering.class_id_1 = k.Safe(field_array[0],k.safe_hint_type.NUM);
          coned_offering.class_type = k.Safe(field_array[1],k.safe_hint_type.ALPHA);
          coned_offering.course_id = k.Safe(field_array[2],k.safe_hint_type.NUM);
          coned_offering.class_number = k.Safe(field_array[3],k.safe_hint_type.NUM);
          coned_offering.course_code = k.Safe(field_array[4],k.safe_hint_type.NUM);
          coned_offering.created_by = k.Safe(field_array[5],k.safe_hint_type.NUM);
          coned_offering.date_created = k.Safe(field_array[6],k.safe_hint_type.DATE_TIME);
          coned_offering.last_edited_by = k.Safe(field_array[7],k.safe_hint_type.NUM);
          coned_offering.date_last_edited = k.Safe(field_array[8],k.safe_hint_type.DATE_TIME);
          coned_offering.sponsor_id = k.Safe(field_array[9],k.safe_hint_type.NUM);
          coned_offering.sponsor_number = k.Safe(field_array[10],k.safe_hint_type.HYPHENATED_NUM);
          coned_offering.training_ins_accred_num = k.Safe(field_array[11],k.safe_hint_type.NUM);
          coned_offering.document_status = k.Safe(field_array[12],k.safe_hint_type.ALPHA);
          coned_offering.class_final_status = k.Safe(field_array[13],k.safe_hint_type.ALPHA);
          coned_offering.course_number = k.Safe(field_array[14],k.safe_hint_type.NUM);
          coned_offering.location = k.Safe(field_array[15],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          coned_offering.student_cost = k.Safe(field_array[16],k.safe_hint_type.CURRENCY_USA);
          coned_offering.tuition_includes = k.Safe(field_array[17],k.safe_hint_type.PUNCTUATED);
          coned_offering.closed = k.Safe(field_array[18],k.safe_hint_type.ALPHA);
          coned_offering.estimated_students = k.Safe(field_array[19],k.safe_hint_type.NUM);
          coned_offering.start_date_time = k.Safe(field_array[20],k.safe_hint_type.DATE_TIME);
          coned_offering.end_date_time = k.Safe(field_array[21],k.safe_hint_type.DATE_TIME);
          coned_offering.start_time = k.Safe(field_array[22],k.safe_hint_type.PUNCTUATED);
          coned_offering.end_time = k.Safe(field_array[23],k.safe_hint_type.PUNCTUATED);
          coned_offering.other_dates_and_times = k.Safe(field_array[24],k.safe_hint_type.PUNCTUATED);
          coned_offering.instructors = k.Safe(field_array[25],k.safe_hint_type.PUNCTUATED);
          coned_offering.instructor_qualifications = k.Safe(field_array[26],k.safe_hint_type.PUNCTUATED);
          coned_offering.verification_name = k.Safe(field_array[27],k.safe_hint_type.HUMAN_NAME);
          coned_offering.contact_name = k.Safe(field_array[28],k.safe_hint_type.HUMAN_NAME);
          coned_offering.contact_address_1 = k.Safe(field_array[29],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          coned_offering.contact_address_2 = k.Safe(field_array[30],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          coned_offering.contact_city = k.Safe(field_array[31],k.safe_hint_type.POSTAL_CITY);
          coned_offering.contact_state = k.Safe(field_array[32],k.safe_hint_type.ALPHA);
          coned_offering.contact_zip = k.Safe(field_array[33],k.safe_hint_type.NUM);
          coned_offering.contact_daytime_phone = k.Safe(field_array[34],k.safe_hint_type.PHONE_NUM);
          coned_offering.contact_evening_phone = k.Safe(field_array[35],k.safe_hint_type.PHONE_NUM);
          coned_offering.contact_email = k.Safe(field_array[36],k.safe_hint_type.EMAIL_ADDRESS);
          coned_offering.public_contact_name = k.Safe(field_array[37],k.safe_hint_type.HUMAN_NAME);
          coned_offering.public_contact_phone = k.Safe(field_array[38],k.safe_hint_type.PHONE_NUM);
          coned_offering.public_contact_email = k.Safe(field_array[39],k.safe_hint_type.EMAIL_ADDRESS);
          coned_offering.public_contact_website = k.Safe(field_array[40],k.safe_hint_type.HTTP_TARGET);
          coned_offering.public_contact_notes = k.Safe(field_array[41],k.safe_hint_type.PUNCTUATED);
          coned_offering.date_submitted_to_region = k.Safe(field_array[42],k.safe_hint_type.DATE_TIME);
          coned_offering.date_received_by_region = k.Safe(field_array[43],k.safe_hint_type.DATE_TIME);
          coned_offering.date_sponsor_notified = k.Safe(field_array[44],k.safe_hint_type.DATE_TIME);
          coned_offering.date_registration_sent_to_state = k.Safe(field_array[45],k.safe_hint_type.DATE_TIME);
          coned_offering.date_cards_sent_to_sponsor = k.Safe(field_array[46],k.safe_hint_type.DATE_TIME);
          coned_offering.date_materials_to_be_returned = k.Safe(field_array[47],k.safe_hint_type.DATE_TIME);
          coned_offering.approved = k.Safe(field_array[48],k.safe_hint_type.NUM);
          coned_offering.region_comments = k.Safe(field_array[49],k.safe_hint_type.PUNCTUATED);
          coned_offering.region_council_num = k.Safe(field_array[50],k.safe_hint_type.NUM);
          coned_offering.class_county_code = k.Safe(field_array[51],k.safe_hint_type.NUM);
          coned_offering.total_class_hours = k.Safe(field_array[52],k.safe_hint_type.REAL_NUM);
          coned_offering.location_address_1 = k.Safe(field_array[53],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          coned_offering.location_address_2 = k.Safe(field_array[54],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          coned_offering.location_city = k.Safe(field_array[55],k.safe_hint_type.POSTAL_CITY);
          coned_offering.location_state = k.Safe(field_array[56],k.safe_hint_type.ALPHA);
          coned_offering.location_zip = k.Safe(field_array[57],k.safe_hint_type.NUM);
          coned_offering.location_zip_plus_4 = k.Safe(field_array[58],k.safe_hint_type.NUM);
          coned_offering.location_phone = k.Safe(field_array[59],k.safe_hint_type.PHONE_NUM);
          coned_offering.location_email = k.Safe(field_array[60],k.safe_hint_type.EMAIL_ADDRESS);
          coned_offering.location_of_registration = k.Safe(field_array[61],k.safe_hint_type.PUNCTUATED);
          coned_offering.primary_text = k.Safe(field_array[62],k.safe_hint_type.PUNCTUATED);
          coned_offering.additional_texts = k.Safe(field_array[63],k.safe_hint_type.NUM);
          coned_offering.final_registration_date = k.Safe(field_array[64],k.safe_hint_type.DATE_TIME);
          coned_offering.offered_as_college_credit = k.Safe(field_array[65],k.safe_hint_type.ALPHA);
          coned_offering.practical_exam_date = k.Safe(field_array[66],k.safe_hint_type.DATE_TIME);
          coned_offering.written_exam_date = k.Safe(field_array[67],k.safe_hint_type.DATE_TIME);
          coned_offering.disapproval_reason_id = k.Safe(field_array[68],k.safe_hint_type.NUM);
          coned_offering.date_final_paperwork_received = k.Safe(field_array[69],k.safe_hint_type.DATE_TIME);
          coned_offering.signed_hard_copy = k.Safe(field_array[70],k.safe_hint_type.ALPHA);
          coned_offering.created_by_first_name = k.Safe(field_array[71],k.safe_hint_type.HUMAN_NAME);
          coned_offering.created_by_last_name = k.Safe(field_array[72],k.safe_hint_type.HUMAN_NAME);
          coned_offering.class_disapproval_reason_description = k.Safe(field_array[73],k.safe_hint_type.PUNCTUATED);
          coned_offering.class_final_status_description = k.Safe(field_array[74],k.safe_hint_type.ALPHA_WORDS);
          coned_offering.sponsor_name = k.Safe(field_array[75],k.safe_hint_type.ORG_NAME);
          coned_offering.courses_course_number = k.Safe(field_array[76],k.safe_hint_type.NUM);
          coned_offering.course_title = k.Safe(field_array[77],k.safe_hint_type.PUNCTUATED);
          coned_offering.cert_course_code = k.Safe(field_array[78],k.safe_hint_type.NUM);
          coned_offering.cert_course_description = k.Safe(field_array[79],k.safe_hint_type.NUM);
          coned_offering.class_id_2 = k.Safe(field_array[80],k.safe_hint_type.NUM);
          class_search_unlimited.Add(coned_offering);
          }
        stream_reader.Close();
        }
      return class_search_unlimited;
      }

    internal class TeachingEntity
      {
      internal string id = k.EMPTY;
      internal string date_created = k.EMPTY;
      internal string date_last_edited = k.EMPTY;
      internal string sponsor_number = k.EMPTY;
      internal string training_ins_accred_num = k.EMPTY;
      internal string name = k.EMPTY;
      internal string short_name = k.EMPTY;
      internal string address_1 = k.EMPTY;
      internal string address_2 = k.EMPTY;
      internal string city = k.EMPTY;
      internal string state = k.EMPTY;
      internal string zip = k.EMPTY;
      internal string county_code = k.EMPTY;
      internal string region = k.EMPTY;
      internal string email = k.EMPTY;
      internal string website = k.EMPTY;
      internal string daytime_phone = k.EMPTY;
      internal string evening_phone = k.EMPTY;
      internal string fax = k.EMPTY;
      internal string business_type_id = k.EMPTY;
      internal string con_ed_level = k.EMPTY;
      internal string certification_level = k.EMPTY;
      internal string contact_prefix = k.EMPTY;
      internal string contact_first_name = k.EMPTY;
      internal string contact_last_name = k.EMPTY;
      internal string contact_suffix = k.EMPTY;
      internal string contact_title = k.EMPTY;
      internal string contact_address_1 = k.EMPTY;
      internal string contact_address_2 = k.EMPTY;
      internal string contact_city = k.EMPTY;
      internal string contact_state = k.EMPTY;
      internal string contact_zip = k.EMPTY;
      internal string contact_daytime_phone = k.EMPTY;
      internal string contact_evening_phone = k.EMPTY;
      internal string contact_fax = k.EMPTY;
      internal string contact_email = k.EMPTY;
      internal string public_contact_name = k.EMPTY;
      internal string public_contact_phone = k.EMPTY;
      internal string public_contact_email = k.EMPTY;
      internal string public_contact_website = k.EMPTY;
      internal string public_contact_notes = k.EMPTY;
      internal string application_date = k.EMPTY;
      internal string application_received = k.EMPTY;
      internal string sponsor_status = k.EMPTY;
      internal string sponsor_status_description = k.EMPTY;
      internal string training_inst_status = k.EMPTY;
      internal string training_inst_status_description = k.EMPTY;
      internal string issue_date = k.EMPTY;
      internal string prev_expiration_date = k.EMPTY;
      internal string expiration_date_sponsor = k.EMPTY;
      internal string expiration_date_training_inst = k.EMPTY;
      internal string process_date = k.EMPTY;
      internal string corrective_action = k.EMPTY;
      internal string compliance_by_date = k.EMPTY;
      internal string initial_accred_date = k.EMPTY;
      internal string accepted_provisional_date = k.EMPTY;
      internal string completed_provisional_date = k.EMPTY;
      internal string withdrawal_challenge_due_date = k.EMPTY;
      internal string letter_for_expiration = k.EMPTY;
      internal string letter_f_for_ppwk_non_compliance = k.EMPTY;
      internal string other_letter = k.EMPTY;
      internal string history = k.EMPTY;
      internal string business_type_description = k.EMPTY;
      }
    internal ArrayList TeachingEntitySearchUnlimited()
      {
      var teaching_entity_search_unlimited = new ArrayList();
      //
      HttpWebResponse response;
      var cookie_container = new CookieContainer();
      if(
          Request_ems_health_state_pa_us_ConedSponsorsearch(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedSponsorsearch_Filedelimited_Searchnow(cookie_container,out response)
        &&
          Request_ems_health_state_pa_us_ConedExportSponsorsearchtxt(cookie_container,out response)
        )
        {
        var stream_reader = new StreamReader(response.GetResponseStream());
        stream_reader.ReadLine();  //Discard the first line.  It only contains column headings.
        while (!stream_reader.EndOfStream)
          {
          var field_array = stream_reader.ReadLine().Split(new string[] {k.TAB},StringSplitOptions.None);
          var teaching_entity = new TeachingEntity();
          teaching_entity.id = k.Safe(field_array[0],k.safe_hint_type.NUM);
          teaching_entity.date_created = k.Safe(field_array[1],k.safe_hint_type.DATE_TIME);
          teaching_entity.date_last_edited = k.Safe(field_array[2],k.safe_hint_type.DATE_TIME);
          teaching_entity.sponsor_number = k.Safe(field_array[3],k.safe_hint_type.HYPHENATED_NUM);
          teaching_entity.training_ins_accred_num = k.Safe(field_array[4],k.safe_hint_type.HYPHENATED_NUM);
          teaching_entity.name = k.Safe(field_array[5],k.safe_hint_type.ORG_NAME);
          teaching_entity.short_name = k.Safe(field_array[6],k.safe_hint_type.ORG_NAME);
          teaching_entity.address_1 = k.Safe(field_array[7],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          teaching_entity.address_2 = k.Safe(field_array[8],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          teaching_entity.city = k.Safe(field_array[9],k.safe_hint_type.POSTAL_CITY);
          teaching_entity.state = k.Safe(field_array[10],k.safe_hint_type.ALPHA);
          teaching_entity.zip = k.Safe(field_array[11],k.safe_hint_type.HYPHENATED_NUM);
          teaching_entity.county_code = k.Safe(field_array[12],k.safe_hint_type.NUM);
          teaching_entity.region = k.Safe(field_array[13],k.safe_hint_type. NUM);
          teaching_entity.email = k.Safe(field_array[14],k.safe_hint_type.EMAIL_ADDRESS);
          teaching_entity.website = k.Safe(field_array[15],k.safe_hint_type.HTTP_TARGET);
          teaching_entity.daytime_phone = k.Safe(field_array[16],k.safe_hint_type.PHONE_NUM);
          teaching_entity.evening_phone = k.Safe(field_array[17],k.safe_hint_type.PHONE_NUM);
          teaching_entity.fax = k.Safe(field_array[18],k.safe_hint_type.PHONE_NUM);
          teaching_entity.business_type_id = k.Safe(field_array[19],k.safe_hint_type.NUM);
          teaching_entity.con_ed_level = k.Safe(field_array[20],k.safe_hint_type.PUNCTUATED);
          teaching_entity.certification_level = k.Safe(field_array[21],k.safe_hint_type.PUNCTUATED);
          teaching_entity.contact_prefix = k.Safe(field_array[22],k.safe_hint_type.HUMAN_NAME);
          teaching_entity.contact_first_name = k.Safe(field_array[23],k.safe_hint_type.HUMAN_NAME);
          teaching_entity.contact_last_name = k.Safe(field_array[24],k.safe_hint_type.HUMAN_NAME);
          teaching_entity.contact_suffix = k.Safe(field_array[25],k.safe_hint_type.HUMAN_NAME);
          teaching_entity.contact_title = k.Safe(field_array[26],k.safe_hint_type.MAKE_MODEL);
          teaching_entity.contact_address_1 = k.Safe(field_array[27],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          teaching_entity.contact_address_2 = k.Safe(field_array[28],k.safe_hint_type.POSTAL_STREET_ADDRESS);
          teaching_entity.contact_city = k.Safe(field_array[29],k.safe_hint_type.POSTAL_CITY);
          teaching_entity.contact_state = k.Safe(field_array[30],k.safe_hint_type.ALPHA);
          teaching_entity.contact_zip = k.Safe(field_array[31],k.safe_hint_type.HYPHENATED_NUM);
          teaching_entity.contact_daytime_phone = k.Safe(field_array[32],k.safe_hint_type.PHONE_NUM);
          teaching_entity.contact_evening_phone = k.Safe(field_array[33],k.safe_hint_type.PHONE_NUM);
          teaching_entity.contact_fax = k.Safe(field_array[34],k.safe_hint_type.PHONE_NUM);
          teaching_entity.contact_email = k.Safe(field_array[35],k.safe_hint_type.EMAIL_ADDRESS);
          teaching_entity.public_contact_name = k.Safe(field_array[36],k.safe_hint_type.HUMAN_NAME);
          teaching_entity.public_contact_phone = k.Safe(field_array[37],k.safe_hint_type.PHONE_NUM);
          teaching_entity.public_contact_email = k.Safe(field_array[38],k.safe_hint_type.EMAIL_ADDRESS);
          teaching_entity.public_contact_website = k.Safe(field_array[39],k.safe_hint_type.HTTP_TARGET);
          teaching_entity.public_contact_notes = k.Safe(field_array[40],k.safe_hint_type.PUNCTUATED);
          teaching_entity.application_date = k.Safe(field_array[41],k.safe_hint_type.DATE_TIME);
          teaching_entity.application_received = k.Safe(field_array[42],k.safe_hint_type.DATE_TIME);
          teaching_entity.sponsor_status = k.Safe(field_array[43],k.safe_hint_type.NUM);
          teaching_entity.sponsor_status_description = k.Safe(field_array[44],k.safe_hint_type.ALPHA_WORDS);
          teaching_entity.training_inst_status = k.Safe(field_array[45],k.safe_hint_type.NUM);
          teaching_entity.training_inst_status_description = k.Safe(field_array[46],k.safe_hint_type.ALPHA_WORDS);
          teaching_entity.issue_date = k.Safe(field_array[47],k.safe_hint_type.DATE_TIME);
          teaching_entity.prev_expiration_date = k.Safe(field_array[48],k.safe_hint_type.DATE_TIME);
          teaching_entity.expiration_date_sponsor = k.Safe(field_array[49],k.safe_hint_type.DATE_TIME);
          teaching_entity.expiration_date_training_inst = k.Safe(field_array[50],k.safe_hint_type.DATE_TIME);
          teaching_entity.process_date = k.Safe(field_array[51],k.safe_hint_type.DATE_TIME);
          teaching_entity.corrective_action = k.Safe(field_array[52],k.safe_hint_type.PUNCTUATED);
          teaching_entity.compliance_by_date = k.Safe(field_array[53],k.safe_hint_type.DATE_TIME);
          teaching_entity.initial_accred_date = k.Safe(field_array[54],k.safe_hint_type.DATE_TIME);
          teaching_entity.accepted_provisional_date = k.Safe(field_array[55],k.safe_hint_type.DATE_TIME);
          teaching_entity.completed_provisional_date = k.Safe(field_array[56],k.safe_hint_type.DATE_TIME);
          teaching_entity.withdrawal_challenge_due_date = k.Safe(field_array[57],k.safe_hint_type.DATE_TIME);
          teaching_entity.letter_for_expiration = k.Safe(field_array[58],k.safe_hint_type.ALPHA);
          teaching_entity.letter_f_for_ppwk_non_compliance = k.Safe(field_array[59],k.safe_hint_type.ALPHA);
          teaching_entity.other_letter = k.Safe(field_array[60],k.safe_hint_type.ALPHA);
          teaching_entity.history = k.Safe(field_array[61],k.safe_hint_type.MEMO);
          teaching_entity.business_type_description = k.Safe(field_array[62],k.safe_hint_type.MAKE_MODEL);
          teaching_entity_search_unlimited.Add(teaching_entity);
          }
        stream_reader.Close();
        }
      return teaching_entity_search_unlimited;
      }

    internal class Practitioner
      {
      internal string last_name = k.EMPTY;
      internal string first_name = k.EMPTY;
      internal string middle_initial = k.EMPTY;
      internal string certification_number = k.EMPTY;
      internal string level = k.EMPTY;
      internal string regional_council = k.EMPTY;
      }
    internal class ActivePractitionersContext
      {
      internal CookieContainer cookie_container = null;
      internal string view_state = k.EMPTY;
      internal string event_validation = k.EMPTY;
      internal string next_page_ctl_num = k.EMPTY;
      internal k.int_sign_range disposition = null;
      }
    internal ArrayList ActivePractitioners
      (
      ActivePractitionersContext context
      )
      {
      var active_practitioners = new ArrayList();
      //
      HttpWebResponse response;
      if (context.cookie_container == null)
        {
        context.cookie_container = new CookieContainer();
        context.disposition = new k.int_sign_range();
        }
      if (Request_ems_health_state_pa_us_EmsregActivepractitioners_3000(context.cookie_container,context.view_state,context.event_validation,context.next_page_ctl_num,out response))
        {
        var html_document = HtmlDocumentOf(ConsumedStreamOf(response));
        //
        // The initial XPaths are determined by visiting the page in IE9, selecting "F12 developer tools", setting Document Mode to IE9 Standards, navigating to the node of interest, and disregarding any form or tbody tags.
        //
        var hn_target_table = html_document.GetElementbyId("_ctl0__ctl0_SessionLinkBar_Content_dgActivePractitioners"); 
        //
        var hnc_last_name = hn_target_table.SelectNodes("tr/td[1]/span");
        var hnc_first_name = hn_target_table.SelectNodes("tr/td[2]/span");
        var hnc_middle_initial = hn_target_table.SelectNodes("tr/td[3]/span");
        var hnc_certification_number = hn_target_table.SelectNodes("tr/td[4]/span");
        var hnc_level = hn_target_table.SelectNodes("tr/td[5]/span");
        var hnc_regional_council = hn_target_table.SelectNodes("tr/td[6]/span");
        //
        for (var i = new k.subtype<int>(1,hnc_last_name.Count - 1); i.val < i.LAST; i.val++)  //limits take into account non-data header & page index rows
          {
          var practitioner = new Practitioner();
          practitioner.last_name = k.Safe(hnc_last_name[i.val].InnerText.Trim(),k.safe_hint_type.HUMAN_NAME);
          practitioner.first_name = k.Safe(hnc_first_name[i.val].InnerText.Trim(),k.safe_hint_type.HUMAN_NAME);
          practitioner.middle_initial = k.Safe(hnc_middle_initial[i.val].InnerText.Trim(),k.safe_hint_type.HUMAN_NAME);
          practitioner.certification_number = k.Safe(hnc_certification_number[i.val].InnerText.Trim(),k.safe_hint_type.NUM);
          practitioner.level = k.Safe(hnc_level[i.val].InnerText.Trim(),k.safe_hint_type.HUMAN_NAME);
          practitioner.regional_council = k.Safe(hnc_regional_council[i.val].InnerText.Trim(),k.safe_hint_type.ORG_NAME);
          active_practitioners.Add(practitioner);
          }
        //
        context.view_state = html_document.GetElementbyId("__VIEWSTATE").Attributes["value"].Value;
        context.event_validation = html_document.GetElementbyId("__EVENTVALIDATION").Attributes["value"].Value;
        //
        var hn_current_page_num_node_next_sibling = hnc_last_name[hnc_last_name.Count - 1].NextSibling;
        if (hn_current_page_num_node_next_sibling == null)
          {
          context.disposition.val = 1;
          }
        else
          {
          context.next_page_ctl_num = hn_current_page_num_node_next_sibling.NextSibling.Attributes["href"].Value
            .Replace("javascript:__doPostBack(&#39;_ctl0$_ctl0$SessionLinkBar$Content$dgActivePractitioners$_ctl3004$_ctl",k.EMPTY)
            .Replace("&#39;,&#39;&#39;)",k.EMPTY);
          context.disposition.val = 0;
          }
        }
      return active_practitioners;
      }

    }
  }
