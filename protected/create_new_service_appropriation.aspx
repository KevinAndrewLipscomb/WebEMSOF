<%@ Page language="c#" Debug="true" Codebehind="create_new_service_appropriation.pas" AutoEventWireup="false" Inherits="create_new_service_appropriation.TWebForm_create_new_service_appropriation" %>
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
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:HyperLink id="HyperLink_county_dictated_appropriations" runat="server" navigateurl="county_dictated_appropriations.aspx">county-dictated appropriations</ASP:HyperLink>&nbsp;form ]</small></p>
      <p><strong>Create new appropriation:</strong>
      </p>
      <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
		  <table cellspacing="0" cellpadding="5" border="0">
			  <tr>
			  <td>
			  <p align="right">Service:</p></td>
			  <td nowrap="true">
				<ASP:DropDownList id="DropDownList_services" runat="server"></ASP:DropDownList>&nbsp;&nbsp; 
                <ASP:CheckBox id="CheckBox_unfilter" runat="server" font-size="Small" text="Check this box to include out-of-county services in the drop-down list" autopostback="True"></ASP:CheckBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_service" runat="server" errormessage="Please select a service." font-bold="True" controltovalidate="DropDownList_services">!ERR!</ASP:RequiredFieldValidator><ASP:RangeValidator id="RangeValidator_service" runat="server" errormessage="Please select a service for a new appropriation." font-bold="True" controltovalidate="DropDownList_services" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator></td>
			  </tr>
			<tr>
			  <td>
			  <p align="right">Amount:&nbsp; $</p></td>
			  <td><ASP:TextBox id="TextBox_new_amount" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_new_amount" runat="server" errormessage="Please enter an amount for a new appropriation." font-bold="True" controltovalidate="TextBox_new_amount">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_new_amount" runat="server" font-bold="True" errormessage="Please enter a valid amount." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_new_amount">!ERR!</ASP:RegularExpressionValidator></td>
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
		  </table>
	  </blockquote>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
