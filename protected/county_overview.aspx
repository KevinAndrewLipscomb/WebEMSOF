<%@ Page language="c#" Debug="true" Codebehind="county_overview.pas" AutoEventWireup="false" Inherits="county_overview.TWebForm_county_overview" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>

  <body bgcolor="white">
     <form runat="server">
      <p>
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent></p>
<p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Available allocations</strong></td>
                    </tr>
                    <tr>
                      <td>
<p>Which allocation do you want to work with?&nbsp; <ASP:RequiredFieldValidator id="RequiredFieldValidator_appropriation" runat="server" errormessage="Please choose an allocation." font-bold="True" controltovalidate="RadioButtonList_appropriation">!ERR!</ASP:RequiredFieldValidator></p>
<p>
        <ASP:RadioButtonList id="RadioButtonList_appropriation" runat="server"></ASP:RadioButtonList></p>
<p>
        <ASP:Button id="Button_continue" runat="server" text="Continue"></ASP:Button></p></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
    <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <p><sstchur:SmartScroller id="SmartScroller_control" runat="server" /></p>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
