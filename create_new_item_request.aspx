<%@ Page language="c#" Debug="true" Codebehind="create_new_item_request.pas" AutoEventWireup="false" Inherits="create_new_item_request.TWebForm_create_new_item_request" %>
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
	  <p><strong>Create new item request:</strong></p>
	  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
		<table cellspacing="0" cellpadding="0" border="1">
			<tr>
			  <td>
		  <table cellspacing="0" cellpadding="10" border="0">
			  <tr>
				<td><p align="right">Equipment category:</p></td>
				<td>
				  <ASP:DropDownList id="DropDownList_equipment_category" runat="server" autopostback="True"></ASP:DropDownList>&nbsp;&nbsp;
				</td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_equipment_category" runat="server" errormessage="Please select an equipment category." font-bold="True" controltovalidate="DropDownList_equipment_category">!ERR!</ASP:RequiredFieldValidator><ASP:RangeValidator id="RangeValidator_equipment_category" runat="server" errormessage="Please select an equipment category." font-bold="True" controltovalidate="DropDownList_equipment_category" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Life expectancy:</p></td>
				<td><ASP:Label id="Label_life_expectancy" runat="server"></ASP:Label></td>
				<td></td>
			  </tr>
			  <tr>
				<td><p align="right">Make &amp; model:</p></td>
				<td><ASP:TextBox id="TextBox_make_model" runat="server" width="20pc"></ASP:TextBox></td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_make_model" runat="server" errormessage="Please enter a make and model." font-bold="True" controltovalidate="TextBox_make_model">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_make_model" runat="server" font-bold="True" errormessage="Please enter a valid make and model." validationexpression="[a-zA-z0-9#\*\(\)-\+/\. ]+" controltovalidate="TextBox_make_model">!ERR!</ASP:RegularExpressionValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Place where equipment will be kept:</p></td>
				<td><ASP:TextBox id="TextBox_place_kept" runat="server" width="20pc"></ASP:TextBox></td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_place_kept" runat="server" errormessage="Please enter a place where the equipment will be kept." font-bold="True" controltovalidate="TextBox_place_kept">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_place_kept" runat="server" font-bold="True" errormessage="Please enter a valid place where the equipment will be kept." validationexpression="[a-zA-z0-9#\(\)-/\. ]+" controltovalidate="TextBox_place_kept">!ERR!</ASP:RegularExpressionValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Will the equipment be new or refurbished?:</p></td>
				<td>
				  <ASP:RadioButtonList id="RadioButtonList_condition" runat="server" repeatdirection="Horizontal">
					<ASP:ListItem value="New">New</ASP:ListItem>
					<ASP:ListItem value="Refurbished">Refurbished</ASP:ListItem>
				  </ASP:RadioButtonList>
				</td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_condition" runat="server" errormessage="Please indicate whether the equipment will be new or refurbished." font-bold="True" controltovalidate="RadioButtonList_condition">!ERR!</ASP:RequiredFieldValidator></td>
			  </tr>
			<tr>
			  <td>
			  <p align="right">Maximum&nbsp;unit cost supported by EMSOF:&nbsp; $
  <br><small><i>If you excede this amount, your service must pay the overage.</i></small></p></td>
			  <td>
				<ASP:Label id="Label_allowable_cost" runat="server"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Anticipated unit cost:&nbsp; $</p></td>
			  <td><ASP:TextBox id="TextBox_unit_cost" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_unit_cost" runat="server" errormessage="Please enter a unit cost." font-bold="True" controltovalidate="TextBox_unit_cost">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_unit_cost" runat="server" font-bold="True" errormessage="Please enter a valid unit cost." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_unit_cost">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Anticipated quantity:</p></td>
			  <td><ASP:TextBox id="TextBox_quantity" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_quantity" runat="server" errormessage="Please enter a quantity." font-bold="True" controltovalidate="TextBox_quantity">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_quantity" runat="server" font-bold="True" errormessage="Please enter a valid quantity." validationexpression="[1-9][0-9]*" controltovalidate="TextBox_quantity">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">TOTAL COST:&nbsp; $<br><small><i>Your service must pay this amount up front when ordering the equipment.</i></small></p></td>
			  <td>
				<ASP:Label id="Label_total_cost" runat="server"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Match level dictated by
				  <ASP:Label id="Label_sponsor_county" runat="server"></ASP:Label>&nbsp;County:</p></td>
			  <td>
				<ASP:Label id="Label_match_level" runat="server"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Minimum portion of total cost that your service will pay, <strong>unreimbursed</strong>:&nbsp; $</p></td>
			  <td>
				<ASP:Label id="Label_min_service_ante" runat="server" font-bold="True"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td>
			  <p align="right"><strong>Additional</strong> amount, if any, that your service&nbsp;will pay, <strong>unreimbursed</strong>:&nbsp; $</p></td>
			  <td><ASP:TextBox id="TextBox_additional_service_ante" runat="server" width="6pc"></ASP:TextBox>&nbsp;(optional)</td>
			  <td><ASP:RegularExpressionValidator id="RegularExpressionValidator_additional_service_ante" runat="server" font-bold="True" errormessage="Please enter a valid additional amount that your service will pay." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_additional_service_ante">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right"><strong>Portion of total cost that EMSOF will reimburse you</strong>:&nbsp; $</p></td>
			  <td>
				<ASP:Label id="Label_emsof_ante" runat="server" font-bold="True"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td></td>
			  <td><ASP:Button id="Button_submit_and_repeat" runat="server" text="Submit and Repeat"></ASP:Button>&nbsp;<ASP:Button id="Button_submit_and_stop" runat="server" text="Submit and Stop"></ASP:Button>&nbsp;<ASP:Button id="Button_cancel" runat="server" text="Cancel" causesvalidation="False"></ASP:Button></td>
			  <td></td>
			</tr>
		  </table>
			  </td>
			</tr>
		</table>
	  </blockquote>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
