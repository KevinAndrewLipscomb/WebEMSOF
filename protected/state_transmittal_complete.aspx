<%@ Page language="c#" codebehind="state_transmittal_complete.aspx.cs" AutoEventWireup="True" Inherits="state_transmittal_complete.TWebForm_state_transmittal_complete" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<!DOCTYPE html>

<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
	<title></title>
      <!-- $Id: state_transmittal_complete.aspx 7189 2020-05-25 01:22:15Z kevinanlipscomb $ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>

  <body bgcolor="white">
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
                        <p><ASP:Button id="Button_return_to_overview" runat="server" text="Return to overview" onclick="Button_return_to_overview_Click"></ASP:Button></p></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
