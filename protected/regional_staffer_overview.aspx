<%@ Page language="c#" Debug="true" Codebehind="regional_staffer_overview.pas" AutoEventWireup="false" Inherits="regional_staffer_overview.TWebForm_regional_staffer_overview" %>
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
			          [ Change your <asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
		</small>
	  </p>
	  <p><asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
	  <p>
        <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td valign="top">
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" width="100%">
    <tr>
      <td>
                <table cellspacing="0" cellpadding="10" border="0" width="100%">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>WebEMSOF administrivia</strong></td>
                    </tr>
                    <tr>
                      <td>
						<ul>
						  <li><p><ASP:HyperLink id="HyperLink_maintain_service_accounts" runat="server" enabled="False">Maintain service accounts</ASP:HyperLink></p></li>
						  <li><p><ASP:HyperLink id="HyperLink_maintain_county_accounts" runat="server" enabled="False">Maintain county coordinator accounts</ASP:HyperLink></p></li>
						  <li><p><ASP:HyperLink id="HyperLink_maintain_regional_staffer_accounts" runat="server" enabled="False">Maintain regional staffer accounts</ASP:HyperLink></p></li>
						</ul>
					  </td>
                    </tr>
                </table></td>
    </tr>
</table>
<p></p>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" width="100%">
    <tr>
      <td>
                <table cellspacing="0" cellpadding="10" border="0" width="100%">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Annual EMSOF setup tasks</strong></td>
                    </tr>
                    <tr>
                      <td>
                        <ul><li><p>
                              <ASP:HyperLink id="HyperLink_maintain_epels" runat="server" enabled="False">Maintain Eligible Provider Equipment Lists</ASP:HyperLink></p></li><li><p>
                              <ASP:HyperLink id="HyperLink_maintain_region_dictated_appropriations" runat="server" enabled="False">Maintain county fund appropriations</ASP:HyperLink></p></li>
                        </ul></td>
                    </tr>
                </table></td>
    </tr>
</table></td>
			  <td>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>EMSOF workflow items</strong></td>
                    </tr>
                    <tr>
                      <td>
						<ul>
						  <li>
							<p><ASP:Label id="Label_num_requests_needing_development" runat="server"> requests need to be developed by services</ASP:Label></p></li>
						  <li>
							<p><ASP:Label id="Label_county_approval" runat="server"> requests need County Coordinator approval</ASP:Label></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_regional_compliance" runat="server"> requests need regional compliance check</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_exec_dir_approval" runat="server"> requests need Executive Director approval</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_transmittal" runat="server"> requests need transmittal to PA DOH EMSO</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_state_approval" runat="server"> requests need PA DOH EMSO approval</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_invoice_collection" runat="server"> requests need invoice collection</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:HyperLink id="HyperLink_canceled_check_collection" runat="server"> requests need canceled check collection</ASP:HyperLink></p></li>
						  <li>
							<p><ASP:Label id="HyperLink_reimbursement" runat="server"> requests need reimbursement issuance</ASP:Label></p>
						  </li>
						</ul>
					  </td>
                    </tr>
                </table></td>
            </tr>
        </table></td>
            </tr>
        </table></p><p></p>
	  <p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder></p>
     </form>
  </body>
</html>
