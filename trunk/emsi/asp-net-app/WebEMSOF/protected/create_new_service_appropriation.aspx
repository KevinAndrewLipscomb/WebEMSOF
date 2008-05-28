<%@ Page language="c#" Debug="true" Codebehind="create_new_service_appropriation.pas" AutoEventWireup="false" Inherits="create_new_service_appropriation.TWebForm_create_new_service_appropriation" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <p>
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent></p>
	  <p><small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:LinkButton id="LinkButton_county_dictated_appropriations" runat="server">county-dictated allocations</ASP:LinkButton>&nbsp;form ]</small></p>
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
      <p><strong>
          <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
              <tr>
                <td>
                  <table cellspacing="0" cellpadding="5" border="0">
                      <tr>
                        <td bgcolor="#f5f5f5"><strong>New allocation</strong></td>
                      </tr>
                      <tr>
                        <td>
		  <table cellspacing="0" cellpadding="5" border="0">
			  <tr>
			  <td>
			  <p align="right">Service:</p></td>
			  <td nowrap="true">
				<ASP:DropDownList id="DropDownList_services" runat="server"></ASP:DropDownList>&nbsp;&nbsp; 
                <ASP:CheckBox id="CheckBox_show_out_of_county_services" runat="server" font-size="Small" text="Check this box to include out-of-county services in the drop-down list" autopostback="True"></ASP:CheckBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_service" runat="server" errormessage="Please select a service." font-bold="True" controltovalidate="DropDownList_services">!ERR!</ASP:RequiredFieldValidator><ASP:RangeValidator id="RangeValidator_service" runat="server" errormessage="Please select a service for a new allocation." font-bold="True" controltovalidate="DropDownList_services" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator></td>
			  </tr>
			<tr>
			  <td>
			  <p align="right">Amount:&nbsp; $</p></td>
			  <td><ASP:TextBox id="TextBox_new_amount" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_new_amount" runat="server" errormessage="Please enter an amount for a new allocation." font-bold="True" controltovalidate="TextBox_new_amount">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_new_amount" runat="server" font-bold="True" errormessage="Please enter a valid amount." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_new_amount">!ERR!</ASP:RegularExpressionValidator>
                                  <ASP:CustomValidator id="CustomValidator_amount" runat="server" errormessage="Please enter a valid amount not greater than what remains in your county allocation" font-bold="True" controltovalidate="TextBox_new_amount">!ERR!</ASP:CustomValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Match level:</p></td>
			  <td>
                <ASP:RadioButtonList id="RadioButtonList_match_level" runat="server" repeatdirection="Horizontal">
                  <ASP:ListItem value="1" selected="True">Standard (50%)</ASP:ListItem>
                  <ASP:ListItem value="2">Rural (60%)</ASP:ListItem>
                </ASP:RadioButtonList></td>
			  <td></td>
			</tr>
			<tr>
			  <td></td>
			  <td><ASP:Button id="Button_add_appropriation_and_repeat" runat="server" text="Add and Repeat"></ASP:Button>&nbsp;<ASP:Button id="Button_add_appropriation_and_stop" runat="server" text="Add and Stop"></ASP:Button>&nbsp;<ASP:Button id="Button_cancel" runat="server" text="Cancel" causesvalidation="False"></ASP:Button></td>
			  <td></td>
			</tr>
		  </table></td>
                      </tr>
                  </table></td>
              </tr>
          </table></strong>
      </p>
	<uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
     <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
