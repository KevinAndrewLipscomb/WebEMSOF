<%@ Page language="c#" Debug="true" Codebehind="delete_service_appropriation.pas" AutoEventWireup="false" Inherits="delete_service_appropriation.TWebForm_delete_service_appropriation" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <p>
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder></p>
      <p><small>[ 
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:LinkButton id="LinkButton_county_dictated_appropriations" runat="server">county-dictated allocations</ASP:LinkButton>&nbsp;form ]</small></p>
<p>
        <table bordercolor="#ffd700" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                      <td bgcolor="#ffd700">
        <ASP:Label id="Label_literal_warning" runat="server" font-bold="True" font-size="Large">&nbsp;Warning!&nbsp;</ASP:Label></td>
                    </tr>
                    <tr>
					  <td>
<p><ASP:Label id="Label_service_name_1" runat="server"></ASP:Label>&nbsp;has&nbsp;already entered equipment requests in association with the
		<ASP:Label id="Label_fiscal_year" runat="server"></ASP:Label>&nbsp;allocation of
		<ASP:Label id="Label_amount" runat="server"></ASP:Label>&nbsp;that you made to them.&nbsp; If you delete the allocation, <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;will also <strong>permanently delete</strong> the associated equipment requests.&nbsp; The equipment requests will <strong>not</strong> automatically carry over to any other allocation.</p>
<p>Are you sure you want to permanently delete this allocation (and all equipment requests that
		<ASP:Label id="Label_service_name_2" runat="server"></ASP:Label>&nbsp;has already entered against it)?</p>
<p>
		<table cellspacing="0" cellpadding="10" border="0">
			<tr>
			  <td>
				<div align="center">
		<ASP:Button id="Button_yes" runat="server" text="Yes"></ASP:Button>
				</div></td>
			  <td>-- Delete the allocation and the linked equipment requests.</td>
			</tr>
			<tr>
			  <td>
				<div align="center"><ASP:Button id="Button_no" runat="server" text="No"></ASP:Button>
				</div></td>
			  <td>-- Leave the allocation the way it is.</td>
			</tr>
		</table>
		</p>
					  </td>
					</tr>
				</table></td>
			</tr>
		</table></p>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
