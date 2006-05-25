<%@ Page language="c#" Debug="true" Codebehind="region_dictated_appropriations.pas" AutoEventWireup="false" Inherits="region_dictated_appropriations.TWebForm_region_dictated_appropriations" smartnavigation="true" %>
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
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Change your WebEMSOF
			<asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
</small></p>
	  <p>
	  <asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
	  <p>
        <table cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><a name="ActionRequired" /><strong>Action required</strong></td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                </table></td>
            </tr>
		</table></p>
	  <p></p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_appropriations" runat="server">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><a name="Appropriations" /><strong>Appropriations</strong></td>
					</tr>
					<tr>
					  <td>
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
				  for
				  <asp:label id="Label_fiscal_year_designator" runat="server"></asp:label>
				</td>
			  </tr>
			  <tr id="TableRow_sum_of_county_appropriations" runat="server">
				<td>
				  <p align="right">
					-
				  </p>
				</td>
				<td>
				  <p align="right">
				  <asp:label id="Label_sum_of_county_appropriations" runat="server" font-underline="True"></asp:label>
				  </p>
				</td>
				<td>appropriated to&nbsp;counties (below)</td>
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
	  <p></p>
	  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_deadlines" runat="server">
		  <tr>
			<td>
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td bgcolor="#f5f5f5" colspan="2">
				<p align="left"><strong>Deadlines</strong>
				</p></td>
			</tr>
			<tr>
			  <td>
<p>The last day you will accept EMSOF request submissions&nbsp;from services is
				<ASP:LinkButton id="LinkButton_region_dictated_deadline" runat="server" font-bold="True">LinkButton_region_dictated_deadline</ASP:LinkButton>.</p></td>
						  </tr>
		</table></td>
		  </tr>
	  </table>
	  <p></p>
	  <table bordercolor="#ffd700" cellspacing="0" cellpadding="0" border="1" id="Table_warning_forced_amount" runat="server">
			<tr>
              <td>
			  <table cellspacing="0" cellpadding="5" border="0">
                  <tr>
					<td bgcolor="#ffd700"><strong>Warning</strong></td>
                  </tr>
				  <tr>
                    <td>To prevent you from exceeding your own appropriation, 
					  <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;reduced the amount of the county appropriation that you just updated.</td>
                  </tr>
			  </table></td>
            </tr>
		</table>
	  <p></p>
	  <table cellspacing="0" cellpadding="0" border="1"  bordercolor="#dcdcdc">
		<tr>
		  <td>
	  <table cellspacing="0" cellpadding="10" border="0">
		<tr bgcolor="#f5f5f5">
		  <td>
			<strong>County appropriations</strong>
		  </td>
		  <td>
			<div align="center">
			  <asp:LinkButton id="LinkButton_new_appropriation" runat="server" font-bold="True" enabled="False">New</asp:LinkButton>
			</div>
		  </td>
		</tr>
		<tr>
		  <td colspan="4">
						<ASP:Label id="Label_no_appropriations" runat="server" font-italic="True">-- NONE --</ASP:Label>
		  </td>
		</tr>
		<tr>
		  <td colspan="4">
		<asp:datagrid id="DataGrid_county_appropriations" runat="server"
		bordercolor="Gainsboro" borderstyle="None" borderwidth="1px" backcolor="White" cellpadding="10" gridlines="Horizontal" forecolor="Black"
		allowsorting="True" useaccessibleheader="True" autogeneratecolumns="False" onsortcommand="SortCommand_county_appropriations" visible="False">
                                          <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
                                          <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
                                          <HeaderStyle forecolor="Blue" backcolor="WhiteSmoke"></HeaderStyle>
                                          <Columns>
                                            <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                                              <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                                            </ASP:BoundColumn>
                                            <ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
                                            <ASP:BoundColumn visible="False" datafield="county_code" sortexpression="county_code" readonly="True"></ASP:BoundColumn>
                                            <ASP:BoundColumn datafield="name" sortexpression="name" readonly="True" headertext="Name"></ASP:BoundColumn>
                                            <ASP:BoundColumn datafield="amount" sortexpression="amount" headertext="Amount" dataformatstring="{0:C}">
                                              <ItemStyle horizontalalign="Right"></ItemStyle>
                                            </ASP:BoundColumn>
                                            <ASP:EditCommandColumn buttontype="LinkButton" updatetext="Update" canceltext="Cancel" edittext="Edit">
                                              <ItemStyle forecolor="Blue"></ItemStyle>
                                            </ASP:EditCommandColumn>
                                            <ASP:ButtonColumn visible="False" text="Delete" commandname="Delete">
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
					  </td>
					</tr>
				</table>
			  </td>
			</tr>
		</table>
	  <p></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server">
	  </asp:placeholder>
	</form>
  </body>
</html>
