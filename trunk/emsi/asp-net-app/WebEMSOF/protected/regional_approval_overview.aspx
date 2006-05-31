<%@ Page language="c#" Debug="true" Codebehind="regional_approval_overview.pas" AutoEventWireup="false" Inherits="regional_approval_overview.TWebForm_regional_approval_overview" %>
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
			                 [ Back to <ASP:HyperLink id="HyperLink_back" runat="server">(previous)</ASP:HyperLink>&nbsp;form ]&nbsp;
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
                      <td bgcolor="#f5f5f5"><strong>Requests needing regional plan compliance check</strong></td>
					</tr>
					<tr id="TableRow_none" runat="server">
					  <td><em>--&nbsp;NONE&nbsp;--</em></td>
					</tr>
                    <tr>
                      <td>
                        <ASP:DataGrid id="DataGrid_requests" runat="server" allowsorting="True" autogeneratecolumns="False" useaccessibleheader="True" cellpadding="10" gridlines="Horizontal" bordercolor="Gainsboro" borderwidth="1px">
                          <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn visible="False" datafield="id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="service_name" sortexpression="service_name" readonly="True" headertext="Service name"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="sponsor_county" sortexpression="sponsor_county" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="emsof_ante" sortexpression="emsof_ante" readonly="True" headertext="EMSOF ante" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="status_code" readonly="True"></ASP:BoundColumn>
                            <ASP:ButtonColumn datatextfield="status_description" sortexpression="status_description" headertext="Status" commandname="Select">
                              <ItemStyle font-bold="True" horizontalalign="Center"></ItemStyle>
                            </ASP:ButtonColumn>
                            <ASP:BoundColumn visible="False" datafield="fiscal_year_id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="fiscal_year_designator" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="county_dictated_appropriation_amount" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="county_dictated_appropriation_id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="rework_deadline" readonly="True"></ASP:BoundColumn>
                          </Columns></ASP:DataGrid></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder></p>
     </form>
  </body>
</html>
