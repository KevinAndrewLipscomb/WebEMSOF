<%@ Page language="c#" Debug="true" Codebehind="regional_staffer_fiscal_year_selection.pas" AutoEventWireup="false" Inherits="regional_staffer_fiscal_year_selection.TWebForm_regional_staffer_fiscal_year_selection"%>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <title id="Title" runat="server"></title>
    <script type="text/javascript" src="../js/gradient.js"></script>
  </head>
  <body>
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Available cycles</strong></td>
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
        </table>
      </p>
      <p>
      </p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
    <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
