<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriations.aspx.cs" AutoEventWireup="True" Inherits="county_dictated_appropriations.TWebForm_county_dictated_appropriations" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
	  <p>
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent></p>
	  <table cellspacing="0" cellpadding="0" border="1" bordercolor="#dcdcdc">
        <tr>
          <td>
			<table cellspacing="0" cellpadding="5" border="0">
              <tr>
				<td bgcolor="#f5f5f5">
                  <p align="right">
					          <strong><asp:Literal ID="Literal_county_name" runat="server"></asp:Literal>&nbsp;County was allocated:</strong>
                  </p>
                </td>
                <td>
                  <p align="right">
                  <asp:label id="Label_parent_appropriation_amount" runat="server"></asp:label>
				  </p>
				</td>
				<td>from <asp:label id="Label_region_name" runat="server">
				  </asp:label>&nbsp;for <asp:label id="Label_fiscal_year_designator" runat="server"></asp:label>
				</td>
			  </tr>
			  <tr id="TableRow_sum_of_service_appropriations" runat="server">
				<td>
				  <p align="right">- </p>
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
				  <p align="right">= </p>
				</td>
				<td>
				  <p align="right">
				  <asp:label id="Label_unappropriated_amount" runat="server">
				  </asp:label>
				  </p>
				</td>
				<td>remaining </td>
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
				<p align="left"><asp:Literal ID="Literal_county_name_2" runat="server"></asp:Literal> County must make service allocations by <asp:label id="Label_make_appropriations_deadline" runat="server" font-bold="True" font-size="Small"></asp:label>.</p></td>
			</tr>
			<tr>
			  <td>
                <p>The last day <asp:Literal ID="Literal_county_name_3" runat="server"></asp:Literal> County will accept EMSOF request submissions&nbsp;from its services is <ASP:LinkButton id="LinkButton_county_dictated_deadline" runat="server" font-bold="True" causesvalidation="False" onclick="LinkButton_county_dictated_deadline_Click"></ASP:LinkButton>.</p>
              </td>
            </tr>
		</table>
            </td>
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
                    <td>To prevent you from exceeding your own allocation, <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;reduced the amount of the service allocation that you just updated.</td>
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
				<td align="center">Only&nbsp;show&nbsp;requests&nbsp;in&nbsp;status:&nbsp;<ASP:DropDownList id="DropDownList_status_filter" runat="server" font-size="Small" autopostback="True" onselectedindexchanged="DropDownList_status_filter_SelectedIndexChanged"></ASP:DropDownList></td>
				<td align="right">
				  <asp:LinkButton id="LinkButton_new_appropriation" runat="server" font-bold="True" causesvalidation="False" onclick="LinkButton_new_appropriation_Click">New</asp:LinkButton>
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
                          <ASP:BoundColumn visible="False" datafield="county_email_address" readonly="True"></ASP:BoundColumn>
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
	  <p></p>
<table id="Table_quick_message" runat="server" bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" width="100%" border="0">
        <tr><td bgcolor="#f5f5f5"><a id="QuickMessage"><strong>QuickMessage</strong></a></td></tr>
        <tr>
          <td>
            <table cellspacing="0" cellpadding="10" width="100%" border="0">
              <tr>
                <td>Send email to:</td>
                <td>
                  <ASP:DropDownList id="DropDownList_quick_message_targets" runat="server" autopostback="True" onselectedindexchanged="DropDownList_quick_message_targets_SelectedIndexChanged">
                    <asp:ListItem selected="True" value="with_allocations">all agencies shown above</asp:ListItem>
                    <asp:ListItem value="emsof_participants_true">all agencies in this county who said in Annual Survey they would be EMSOF participants</asp:ListItem>
                    <asp:ListItem value="emsof_participants_false">all agencies in this county who said in Annual Survey they would *not* be EMSOF participants</asp:ListItem>
                    <asp:ListItem value="emsof_respondents">all agencies in this county who have responded to the Annual Survey</asp:ListItem>
                    <asp:ListItem value="emsof_nonrespondents">all agencies in this county who have *not* responded to the Annual Survey</asp:ListItem>
                    <asp:ListItem value="in_county">all agencies in this county</asp:ListItem>
                  </ASP:DropDownList>
                </td>
                <td></td>
              </tr>
              <tr>
                <td>Bcc:</td>
                <td>
                  <ASP:Label id="Label_author_email_address" runat="server"></ASP:Label></td>
                <td></td>
              </tr>
              <tr>
                <td>Subject:</td>
                <td><ASP:TextBox id="TextBox_quick_message_subject" runat="server" maxlength="255" columns="72"></ASP:TextBox></td>
                <td></td>
              </tr>
              <tr>
                <td valign="top">Body:</td>
                <td><ASP:TextBox id="TextBox_quick_message_body" runat="server" columns="72" rows="18" textmode="MultiLine"></ASP:TextBox></td>
                <td nowrap="true" valign="top"><ASP:RequiredFieldValidator id="RequiredFieldValidator_quick_message_body" runat="server" errormessage="Please enter a message body." font-bold="True" controltovalidate="TextBox_quick_message_body" validationgroup="quick_message">!ERR!</ASP:RequiredFieldValidator></td>
              </tr>
              <tr>
                <td></td>
                <td><ASP:Button id="Button_send" runat="server" text="Send" validationgroup="quick_message" onclick="Button_send_Click"></ASP:Button></td>
                <td></td>
              </tr>
              <tr><td valign="top"><small><font color="#c0c0c0">Resolves to:</small></font></td><td valign="top"><small><ASP:Label id="Label_distribution_list" runat="server" forecolor="Silver"></ASP:Label></small></td>
                <td></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr></table>
	  <p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent></p>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
