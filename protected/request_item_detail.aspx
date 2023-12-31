<!DOCTYPE html>
<%@ Page language="c#" codebehind="request_item_detail.aspx.cs" AutoEventWireup="True" Inherits="request_item_detail.TWebForm_request_item_detail" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<%@ Register src="../usercontrol/ki/UserControl_attachment_explorer.ascx" tagname="UserControl_attachment_explorer" tagprefix="uc3" %>
<html>
  <head runat="server">
    <!-- $Id: request_item_detail.aspx 7189 2020-05-25 01:22:15Z kevinanlipscomb $ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p><small>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
			  <tr>
				<td>
				  <table cellspacing="0" cellpadding="10" border="0">
					  <tr bgcolor="#f5f5f5">
						<td><strong>Item detail</strong></td>
					  </tr>
					  <tr>
						<td>
<!--
--
-- NOTE:  UserControl_attachment_explorer will not work inside an UpdatePanel.
--
-->
		  <table cellspacing="0" cellpadding="10" border="0">
			  <tr>
				<td valign="top"><p align="right">Equipment category:</p></td>
				<td valign="top">
				  <ASP:DropDownList id="DropDownList_equipment_category" runat="server" autopostback="True" onselectedindexchanged="DropDownList_equipment_category_SelectedIndexChanged"></ASP:DropDownList>
				  <asp:Panel ID="Panel_attached_documentation" runat="server" Visible="False">
				    Attach documentation here:
            <uc3:UserControl_attachment_explorer ID="UserControl_attachment_explorer_control" runat="server" />
          </asp:Panel>
				</td>
				<td valign="top"><ASP:RequiredFieldValidator id="RequiredFieldValidator_equipment_category" runat="server" errormessage="Please select an equipment category." font-bold="True" controltovalidate="DropDownList_equipment_category">!ERR!</ASP:RequiredFieldValidator><ASP:RangeValidator id="RangeValidator_equipment_category" runat="server" errormessage="Please select an equipment category." font-bold="True" controltovalidate="DropDownList_equipment_category" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Life expectancy:</p></td>
				<td><ASP:Label id="Label_life_expectancy" runat="server"></ASP:Label></td>
				<td></td>
			  </tr>
			  <tr>
				<td><p align="right">Make &amp; model:</p></td>
				<td><ASP:TextBox id="TextBox_make_model" runat="server" width="20pc" maxlength="127"></ASP:TextBox></td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_make_model" runat="server" errormessage="Please enter a make and model." font-bold="True" controltovalidate="TextBox_make_model">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_make_model" runat="server" font-bold="True" errormessage="Please enter a valid make and model." validationexpression="[0-9a-zA-Z#\*\(\)\-\+/\. ]+" controltovalidate="TextBox_make_model">!ERR!</ASP:RegularExpressionValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Place where equipment will be kept:</p></td>
				<td><ASP:TextBox id="TextBox_place_kept" runat="server" width="20pc" maxlength="127"></ASP:TextBox></td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_place_kept" runat="server" errormessage="Please enter a place where the equipment will be kept." font-bold="True" controltovalidate="TextBox_place_kept">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_place_kept" runat="server" font-bold="True" errormessage="Please enter a valid place where the equipment will be kept." validationexpression="[0-9a-zA-Z#\(\)\-/\. ]+" controltovalidate="TextBox_place_kept">!ERR!</ASP:RegularExpressionValidator></td>
			  </tr>
			  <tr>
				<td><p align="right">Will the equipment be new or refurbished?:</p></td>
				<td>
				  <ASP:RadioButtonList id="RadioButtonList_condition" runat="server" repeatdirection="Horizontal">
                                    <ASP:ListItem value="0">New</ASP:ListItem>
                                    <ASP:ListItem value="1">Refurbished</ASP:ListItem>
				  </ASP:RadioButtonList>
				</td>
				<td><ASP:RequiredFieldValidator id="RequiredFieldValidator_condition" runat="server" errormessage="Please indicate whether the equipment will be new or refurbished." font-bold="True" controltovalidate="RadioButtonList_condition">!ERR!</ASP:RequiredFieldValidator></td>
			  </tr>
			<tr>
			  <td>
			  <p align="right">Maximum&nbsp;unit cost allowed by EMSOF:&nbsp; $ <br><small><i>If you excede this amount <strong>per unit</strong>, your service must pay the overage.</i></small></p></td>
			  <td>
				<ASP:Label id="Label_allowable_cost" runat="server"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Anticipated unit cost:&nbsp; $</p></td>
			  <td>
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
							  <td><ASP:TextBox id="TextBox_unit_cost" runat="server" width="6pc"></ASP:TextBox></td>
							  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							  <td align="right"><ASP:LinkButton id="LinkButton_recalculate_1" runat="server" font-size="Small" onclick="LinkButton_recalculate_1_Click">Recalculate</ASP:LinkButton></td>
							</tr>
						</table></td>
			  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_unit_cost" runat="server" errormessage="Please enter a unit cost." font-bold="True" controltovalidate="TextBox_unit_cost">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_unit_cost" runat="server" font-bold="True" errormessage="Please enter a valid unit cost." validationexpression="[$0\.]*[1-9][0-9,\.]*" controltovalidate="TextBox_unit_cost">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right">Anticipated quantity:</p></td>
			  <td>&nbsp; 
<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
							  <td><ASP:TextBox id="TextBox_quantity" runat="server" width="6pc"></ASP:TextBox></td>
							  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							  <td align="right"><ASP:LinkButton id="LinkButton_recalculate_2" runat="server" font-size="Small" onclick="LinkButton_recalculate_2_Click">Recalculate</ASP:LinkButton></td>
							</tr>
						</table></td>
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
			  <p align="right">Minimum portion of total cost that your service will pay, <strong>unreimbursed</strong>:&nbsp; $</p></td>
			  <td>
				<ASP:Label id="Label_min_service_ante" runat="server" font-bold="True"></ASP:Label></td>
			  <td></td>
			</tr>
			<tr bgcolor="Khaki">
			  <td valign="middle"><p align="right"><strong>Additional</strong> amount, if any, that your service&nbsp;will pay, <strong>unreimbursed</strong>, to prevent exceeding your allocation:&nbsp; $</p></td>
			  <td>
          <table cellspacing="0" cellpadding="0" width="100%" border="0">
						<tr>
						  <td valign="middle"><ASP:TextBox id="TextBox_additional_service_ante" runat="server" width="6pc"></ASP:TextBox></td>
						  <td valign="middle"><small>(If unsure, LEAVE BLANK unless directed otherwise by WebEMSOF)</small></td>
						  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						  <td align="right" valign="middle"><ASP:LinkButton id="LinkButton_recalculate_3" runat="server" font-size="Small" onclick="LinkButton_recalculate_3_Click">Recalculate</ASP:LinkButton></td>
						</tr>
					</table>
				</td>
			  <td><ASP:RegularExpressionValidator id="RegularExpressionValidator_additional_service_ante" runat="server" font-bold="True" errormessage="Please enter a valid additional amount that your service will pay." validationexpression="[$0\.]*[0-9][0-9,\.]*" controltovalidate="TextBox_additional_service_ante">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td>
			  <p align="right"><strong>Portion of total cost that EMSOF will reimburse you</strong>:&nbsp; $</p></td>
			  <td>
				<ASP:Label id="Label_emsof_ante" runat="server" font-bold="True"></ASP:Label></td>
			  <td><asp:CustomValidator ID="CustomValidator_emsof_ante" runat="server" 
            ErrorMessage="The EMSOF reimbursement cannot be a negative amount.  Please reduce the &quot;Additional amount, if any, that your service will pay, unreimbursed, to prevent exceeding your allocation&quot;." Font-Bold="True" 
            onservervalidate="CustomValidator_emsof_ante_ServerValidate">!ERR!</asp:CustomValidator></td>
			</tr>
			<tr>
			  <td>
						<div align="right"><ASP:Button id="Button_submit_and_repeat" runat="server" text="Submit and Repeat" onclick="Button_submit_and_repeat_Click"></ASP:Button>

						</div></td>
			  <td>&nbsp;<ASP:Button id="Button_submit_and_stop" runat="server" text="Submit and Stop" onclick="Button_submit_and_stop_Click"></ASP:Button>
								  <ASP:Button id="Button_update" runat="server" text="Update" visible="False" onclick="Button_update_Click"></ASP:Button>&nbsp; &nbsp;&nbsp;<ASP:Button id="Button_cancel" runat="server" text="Cancel" causesvalidation="False" onclick="Button_cancel_Click"></ASP:Button>

			  </td>
			  <td>
                                  <asp:CustomValidator id="CustomValidator_special_conditions" runat="server" errormessage="Your request does not comply with special rules in the Eligible Providers Equipment List." font-bold="True" onservervalidate="CustomValidator_special_conditions_ServerValidate">!ERR!</asp:CustomValidator></td>
			</tr>
			<tr id="TableRow_delete" runat="server">
			  <td colspan="2">
								  <div align="center">
								  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="5" border="1" align="center">
									  <tr>
										<td>Check the box <u>and</u>&nbsp;click the button to delete:&nbsp; <ASP:CheckBox id="CheckBox_delete" runat="server" text="Delete this equipment request item"></ASP:CheckBox>&nbsp; <ASP:Button id="Button_delete" runat="server" text="Delete" causesvalidation="False" onclick="Button_delete_Click"></ASP:Button></td>
									  </tr>
								  </table>
								  </div></td>
			  <td></td>
			</tr>
			<tr id="TableRow_post_finalization_actions" runat="server">
			  <td>
                                  <div align="right">[ <ASP:LinkButton id="Button_withdraw" runat="server" onclick="Button_withdraw_Click">Withdraw</ASP:LinkButton>&nbsp;] </div></td>
			  <td></td>
			  <td></td>
			</tr>
		  </table>
						</td>
					  </tr>
				  </table></td>
			  </tr>
		  </table></small></p>
	<uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
