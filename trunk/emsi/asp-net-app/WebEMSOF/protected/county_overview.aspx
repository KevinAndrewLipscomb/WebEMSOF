<%@ Page language="c#" Debug="true" Codebehind="county_overview.pas" AutoEventWireup="false" Inherits="county_overview.TWebForm_county_overview" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
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
     <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
