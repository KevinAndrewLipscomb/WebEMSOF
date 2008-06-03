<%@ Page language="c#" Debug="true" Codebehind="state_transmittal_complete.pas" AutoEventWireup="false" Inherits="state_transmittal_complete.TWebForm_state_transmittal_complete" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
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
                      <td bgcolor="#f5f5f5"><strong>State transmittal complete</strong></td>
                    </tr>
                    <tr>
                      <td>
                        <p><ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;has successfully sent the report to PA DOH EMSO via email.&nbsp; A copy of the email has also been sent to your region's EMSOF Coordinator (which may or may not be you).</p>
                        <p><ASP:Button id="Button_return_to_overview" runat="server" text="Return to overview"></ASP:Button></p></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
     <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
