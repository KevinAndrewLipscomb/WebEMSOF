<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriations.pas" AutoEventWireup="false" Inherits="county_dictated_appropriations.TWebForm_county_dictated_appropriations" smartnavigation="true" %>
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
      <p>
      <asp:label id="Label_county_name" runat="server" font-bold="True"
      font-size="Large"></asp:label>&nbsp;
      <asp:label id="Label_literal_county" runat="server" font-bold="True"
      font-size="Large">
        County
      </asp:label></p>
      <p>
		<small>Change your WebEMSOF </small>
			<asp:linkbutton id="LinkButton_change_password" runat="server">
		<small>password</small>
	  </asp:linkbutton>&nbsp;| <small>&nbsp;</small>
	  <asp:linkbutton id="LinkButton_change_email_address" runat="server">
		<small>email address</small>
	  </asp:linkbutton>
	  </p>
	  <table cellspacing="0" cellpadding="0" border="1" bordercolor="#dcdcdc">
        <tr>
          <td>
			<table cellspacing="0" cellpadding="5" border="0">
              <tr>
				<td bgcolor="#f5f5f5">
                  <p align="right">
					<strong>Parent appropriation:</strong>
                  </p>
                </td>
                <td>
                  <p align="right">
                  <asp:label id="Label_parent_appropriation_amount" runat="server"></asp:label>
				  </p>
				</td>
				<td>
				  from
				  <asp:label id="Label_region_name" runat="server">
				  </asp:label>&nbsp;for
				  <asp:label id="Label_fiscal_year_designator" runat="server"></asp:label>
				</td>
			  </tr>
			  <tr id="TableRow_sum_of_service_appropriations" runat="server">
				<td>
				  <p align="right">
					-
				  </p>
				</td>
				<td>
				  <p align="right">
				  <asp:label id="Label_sum_of_service_appropriations" runat="server" font-underline="True"></asp:label>
				  </p>
				</td>
				<td>
				  appropriated to services
				</td>
			  </tr>
			  <tr id="TableRow_unappropriated_amount" runat="server">
				<td>
				  <p align="right">
					=
				  </p>
				</td>
				<td>
				  <p align="right">
				  <asp:label id="Label_unappropriated_amount" runat="server">
				  </asp:label>
				  </p>
				</td>
				<td>
				  remaining
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	  <p>
	  <table cellspacing="0" cellpadding="0" border="1" width="100%" bordercolor="#dcdcdc">
		<tr>
		  <td>
	  <table cellspacing="0" cellpadding="10" border="0" width="100%">
		<tr bgcolor="#f5f5f5">
		  <td>
			<strong>Service appropriations</strong>
		  </td>
		  <td>
			<div align="center">
			  <asp:hyperlink id="HyperLink_new_appropriation" runat="server"
			  navigateurl="create_new_service_appropriation.aspx">
				Make new service appropriation(s)
			  </asp:hyperlink>
			</div>
		  </td>
                      <td>
			  <div align="center">
				<asp:linkbutton id="LinkButton_set_service_request_submission_deadline" runat="server">Set deadline for services to submit requests to you</asp:linkbutton>
			  </div></td>
                      <td>
			<div align="right">
			  <asp:label id="Label_make_appropriations_deadline" runat="server" font-bold="True" font-underline="True" font-size="Small" backcolor="Gold"></asp:label>
			</div></td>
		</tr>
		<tr id="TableRow_no_appropriations" runat="server">
		  <td colspan="4">--&nbsp;NONE&nbsp;--
		  </td>
		</tr>
		<tr id="TableRow_datagrid" runat="server">
		  <td colspan="4">
		<asp:datagrid id="DataGrid_service_appropriations" runat="server"
		bordercolor="#DCDCDC" borderstyle="None" borderwidth="1px" backcolor="White" cellpadding="10" gridlines="Horizontal" forecolor="Black"
		allowsorting="True" useaccessibleheader="True" autogeneratecolumns="False" onsortcommand="SortCommand_service_appropriations" visible="False">
                          <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
                          <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
                          <HeaderStyle forecolor="Blue" backcolor="#F5F5F5"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                              <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="name" sortexpression="name" readonly="True" headertext="Name"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="amount" sortexpression="amount" headertext="Amount" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:EditCommandColumn buttontype="LinkButton" updatetext="Update" canceltext="Cancel" edittext="Edit">
                              <ItemStyle forecolor="Blue"></ItemStyle>
                            </ASP:EditCommandColumn>
                            <ASP:ButtonColumn text="Delete" commandname="Delete">
                              <ItemStyle forecolor="Blue"></ItemStyle>
                            </ASP:ButtonColumn>
                          </Columns>
                          <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle>
		</asp:datagrid>
		  </td>
		</tr>
	  </table>
		  </td>
		</tr>
	  </table>
	  </p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server">
	  </asp:placeholder>
	</form>
  </body>
</html>
