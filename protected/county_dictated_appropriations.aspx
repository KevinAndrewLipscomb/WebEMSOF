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
	  <p><small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Change your WebEMSOF
			<asp:LinkButton id="LinkButton_change_password" runat="server">password</asp:LinkButton>&nbsp;
			|
			<asp:LinkButton id="LinkButton_change_email_address" runat="server">email address</asp:LinkButton>&nbsp;]
</small></p>
	  <p>
	  <asp:label id="Label_county_name" runat="server" font-bold="True"
	  font-size="Large"></asp:label>
	  <asp:label id="Label_literal_county" runat="server" font-bold="True"
	  font-size="Large">
		County
	  </asp:label></p>
	  <table cellspacing="0" cellpadding="0" border="1" bordercolor="#dcdcdc">
        <tr>
          <td>
			<table cellspacing="0" cellpadding="5" border="0">
              <tr>
				<td bgcolor="#f5f5f5">
                  <p align="right">
					<strong>You were allocated:</strong>
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
				<td>allocated to services (below)</td>
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
				<p align="left">You must&nbsp;make service allocations by
			  <asp:label id="Label_make_appropriations_deadline" runat="server" font-bold="True" font-size="Small"></asp:label>.</p></td>
			</tr>
			<tr>
			  <td>
<p>The last day you will accept EMSOF request submissions&nbsp;from your county's services is
				<ASP:LinkButton id="LinkButton_county_dictated_deadline" runat="server" font-bold="True"></ASP:LinkButton>.</p></td>
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
                    <td>To prevent you from exceeding your own allocation, 
                      <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;reduced the amount of the service allocation that you just updated.</td>
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
			<table border="0" cellpadding="10" cellspacing="0" width="100%">
			  <tr>
				<td>
				  <strong>Service allocations</strong>
				</td>
				<td align="center"><ASP:CheckBox id="CheckBox_hide_nonapproval_requests" runat="server" text="Only show requests needing approval" font-size="Small" autopostback="True"></ASP:CheckBox></td>
				<td align="right">
				  <asp:LinkButton id="LinkButton_new_appropriation" runat="server" font-bold="True">New</asp:LinkButton>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr>
		  <td>
			<ASP:Label id="Label_no_appropriations" runat="server" font-italic="True">-- NONE --</ASP:Label>
		  </td>
		</tr>
		<tr>
		  <td>
		<asp:datagrid id="DataGrid_service_appropriations" runat="server"
		bordercolor="Gainsboro" borderstyle="None" borderwidth="1px" backcolor="White" cellpadding="10" gridlines="Horizontal" forecolor="Black"
		allowsorting="True" useaccessibleheader="True" autogeneratecolumns="False" visible="False">
                        <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
                        <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
                        <HeaderStyle forecolor="Blue" backcolor="WhiteSmoke"></HeaderStyle>
                        <Columns>
                          <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                            <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="service_id" sortexpression="service_id" readonly="True"></ASP:BoundColumn>
                          <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
                          <ASP:BoundColumn datafield="service_name" sortexpression="service_name" readonly="True" headertext="Name"></ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="county_code" sortexpression="county_code" readonly="True"></ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="sponsor_county" sortexpression="sponsor_county" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="fiscal_year_designator" sortexpression="fiscal_year_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="emsof_ante" sortexpression="emsof_ante" readonly="True" headertext="EMSOF amount" dataformatstring="{0:C}">
                            <ItemStyle horizontalalign="Right"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:BoundColumn datafield="appropriation" sortexpression="appropriation" headertext="Amount" dataformatstring="{0:C}">
                            <ItemStyle font-bold="True"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:BoundColumn datafield="leftover_or_shortage" sortexpression="leftover_or_shortage" readonly="True" headertext="+Leftover / -Shortage">
                            <HeaderStyle horizontalalign="Center"></HeaderStyle>
                            <ItemStyle horizontalalign="Center"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:BoundColumn datafield="has_wish_list" sortexpression="has_wish_list" readonly="True" headertext="Wish list">
                            <ItemStyle horizontalalign="Center"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
                          <ASP:BoundColumn visible="False" datafield="status_code" sortexpression="status_code" readonly="True"></ASP:BoundColumn>
                          <ASP:ButtonColumn datatextfield="status_description" sortexpression="status_code" headertext="Status" commandname="Select">
                            <ItemStyle horizontalalign="Center" forecolor="Silver"></ItemStyle>
                          </ASP:ButtonColumn>
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
	  <p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server">
	  </asp:placeholder></p>
	</form>
  </body>
</html>
