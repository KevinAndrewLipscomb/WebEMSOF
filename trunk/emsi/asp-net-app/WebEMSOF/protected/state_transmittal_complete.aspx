<%@ Page language="c#" Debug="true" Codebehind="state_transmittal_complete.pas" AutoEventWireup="false" Inherits="state_transmittal_complete.TWebForm_state_transmittal_complete" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
	  <asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
	  <p>
		<small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;]
			    [ Back to <ASP:LinkButton id="LinkButton_back" runat="server">previous</ASP:LinkButton>&nbsp;form ]&nbsp;
			    [ Change your <asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
		</small>
	  </p>
	  <p><asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
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
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
     </form>
  </body>
</html>
