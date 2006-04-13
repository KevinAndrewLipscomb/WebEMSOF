<%@ Page language="c#" Debug="true" Codebehind="create_new_service_appropriation.pas" AutoEventWireup="false" Inherits="create_new_service_appropriation.TWebForm_create_new_service_appropriation" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder>
		  <table cellspacing="0" cellpadding="5" border="0">
			  <tr>
				<td><strong>Create new appropriation:&nbsp; </strong></td>
			  <td>
              <p align="right">Service:</p></td>
			  <td><ASP:DropDownList id="DropDownList_services" runat="server"></ASP:DropDownList></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_service" runat="server" errormessage="Please select a service." font-bold="True" controltovalidate="DropDownList_services">!ERR!</ASP:RequiredFieldValidator><ASP:RangeValidator id="RangeValidator_service" runat="server" errormessage="Please select a service for a new appropriation." font-bold="True" controltovalidate="DropDownList_services" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator></td>
			  </tr>
			<tr>
			  <td></td>
			  <td>
              <p align="right">Amount:&nbsp; $</p></td>
			  <td><ASP:TextBox id="TextBox_new_amount" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_new_amount" runat="server" errormessage="Please enter an amount for a new appropriation." font-bold="True" controltovalidate="TextBox_new_amount">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_new_amount" runat="server" font-bold="True" errormessage="Please enter a valid amount." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_new_amount">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td></td>
			  <td><ASP:Button id="Button_add_appropriation_and_repeat" runat="server" text="Add and Repeat"></ASP:Button></td>
			  <td><ASP:Button id="Button_add_appropriation_and_stop" runat="server" text="Add and Stop"></ASP:Button></td>
			  <td><ASP:Button id="Button_cancel" runat="server" text="Cancel" causesvalidation="False"></ASP:Button></td>
			</tr>
		  </table>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
