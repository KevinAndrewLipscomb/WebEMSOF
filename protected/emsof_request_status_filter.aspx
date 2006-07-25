<%@ Page language="c#" Debug="true" Codebehind="emsof_request_status_filter.pas" AutoEventWireup="false" Inherits="emsof_request_status_filter.TWebForm_emsof_request_status_filter" %>
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
			                                          [ Back to <ASP:LinkButton id="LinkButton_back" runat="server" causesvalidation="False">previous</ASP:LinkButton>&nbsp;form ]&nbsp;
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
                      <td bgcolor="#f5f5f5"><strong>
                          <table cellspacing="0" cellpadding="5" width="100%" border="0">
                              <tr>
                                <td><strong>Requests in status "</strong><ASP:Label id="Label_status" runat="server" font-bold="True"></ASP:Label><strong>"</strong></td>
                                <td>
                                  <p align="right">
                                    <ASP:LinkButton id="LinkButton_generate_state_export_batch" runat="server" font-size="X-Small" visible="False">Generate state-required spreadsheet</ASP:LinkButton></p></td>
                              </tr>
                          </table></strong></td>
					</tr>
					<tr id="TableRow_none" runat="server">
					  <td><em>--&nbsp;NONE&nbsp;--</em></td>
					</tr>
                    <tr>
                      <td>
                        <ASP:DataGrid id="DataGrid_requests" runat="server" allowsorting="True" autogeneratecolumns="False" useaccessibleheader="True" cellpadding="10" gridlines="Horizontal" bordercolor="Gainsboro" borderwidth="1px">
                          <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="service_id" sortexpression="service_id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="service_name" sortexpression="service_name" readonly="True" headertext="Service name"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="county_code" sortexpression="county_code" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="sponsor_county" sortexpression="sponsor_county" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="fiscal_year_designator" sortexpression="fiscal_year_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="emsof_ante" sortexpression="emsof_ante" readonly="True" headertext="EMSOF amount" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="appropriation" sortexpression="appropriation" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="status_code" sortexpression="status_code" readonly="True"></ASP:BoundColumn>
                            <ASP:ButtonColumn visible="False" datatextfield="status_description" sortexpression="status_description" headertext="Status" commandname="Select">
                              <ItemStyle horizontalalign="Center" forecolor="Silver"></ItemStyle>
                            </ASP:ButtonColumn>
                            <ASP:ButtonColumn text="Select" commandname="Select">
                              <ItemStyle font-bold="True" horizontalalign="Center"></ItemStyle>
                            </ASP:ButtonColumn>
						  </Columns></ASP:DataGrid></td>
					</tr>
					<tr id="TableRow_spreadsheet" runat="server">
					  <td>
					  <ASP:DataGrid id="DataGrid_state_export_batch" runat="server" autogeneratecolumns="False" visible="False">
                          <Columns>
                            <ASP:BoundColumn datafield="service_name" readonly="True" headertext="Organization Name"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="life_support_level" readonly="True" headertext="Type of Organization"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="equipment_description" readonly="True" headertext="Equipment/Program"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="quantity" readonly="True" headertext="# Units"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="unit_cost" readonly="True" headertext="Unit Cost"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="total_cost" readonly="True" headertext="Total Cost Amount"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="emsof_ante" readonly="True" headertext="EMSOF Amount"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="provider_match" readonly="True" headertext="Provider Match"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="recommendation" readonly="True" headertext="Recomm"></ASP:BoundColumn>
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
