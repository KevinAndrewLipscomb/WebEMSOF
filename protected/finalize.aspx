<%@ Page language="c#" Debug="true" Codebehind="finalize.pas" AutoEventWireup="false" Inherits="finalize.TWebForm_finalize" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_print_div" Src="~/usercontrol/ki/UserControl_print_div.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body bgcolor="white">
     <form runat="server">
      <p>
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent></p>
<uc1:UserControl_print_div id="UserControl_print_div" runat="server"></uc1:UserControl_print_div>
<div id="Div_print_area">
<p><strong>Request phase finalization
</strong></p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_sorry" runat="server">
			<tr>
			  <td>
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><em><strong><font color="#ff0000">SORRY...
</font></strong>
						</em></td>
					</tr>
					<tr>
					  <td>
						<p>You've requested too much.
</p>
						<p>The specified EMSOF reimbursement is more than the allocation you received from the sponsoring county.
</p>
						<p>Please&nbsp;<ASP:LinkButton id="LinkButton_request_overview_0" runat="server" font-bold="True">go back to the request overview form
</ASP:LinkButton> and&nbsp;adjust your request to fit your allocation.
</p>
						<p>HINT:&nbsp; Make a note of the negative "remaining" amount.&nbsp; Select one of your request items.&nbsp; Enter an equivalent [positive] amount in the field labeled, "<strong>Additional
</strong> amount, if any, that your service&nbsp;will pay, <strong>unreimbursed
</strong>".&nbsp; Your request will no longer exceed your allocation, and finalization will proceed normally.
</p></td>
					</tr>
				</table></td>
			</tr>
		</table>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_summary" runat="server">
			<tr>
			  <td>
			  <table cellspacing="0" cellpadding="10" border="0">
				  <tr>
					<td bgcolor="#f5f5f5"><strong>SUMMARY
</strong></td>
				  </tr>
				  <tr>
					<td>
					  <p>This form allows you to&nbsp;route your Requested Items List to your County EMSOF Coordinator for approval.
</p>
					  <p>You must confirm the following before clicking the gray button at the bottom of the page:
</p>
					  <ol>
                        <li>
                      <p>Do you understand that if you complete this form and click the gray button below, you will <u>not
</u> be able to make any future changes to your request (other than costs and quantities), unless your County EMSOF Coordinator rejects it and routes it back to you?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_read_only_1" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton
                                           id="LinkButton_request_overview_1" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li id="ListItem_remainder_goes_to_region" runat="server">
					  <p>Do you realize that you will forfeit the remaining <ASP:Label id="Label_unused_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;of your allocation?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_remainder_goes_to_region" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_2" runat="server">No, take me back
</ASP:LinkButton>
</p></li>
						<li>
					  <p>Do you understand that the anticipated grand total cost of your request is <ASP:Label id="Label_grand_total_cost" runat="server" font-bold="True"></ASP:Label>, and that your service must pay all costs "up front" when ordering from vendors?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_grand_total_up_front" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_3" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li>
					  <p>Do you understand that EMSOF will reimburse a maximum of&nbsp;<ASP:Label id="Label_max_reimbursement_1" runat="server" font-bold="True"></ASP:Label>&nbsp;to your service?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_max_reimbursement" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_4" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li>
					  <p>Do you understand that, if your actual costs are less than your anticipated costs, the actual EMSOF reimbursement will also be less than <ASP:Label id="Label_max_reimbursement_2" runat="server" font-bold="True"></ASP:Label>?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_anticipated_vs_actual" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_5" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li>
					  <p>Do you understand that, if you purchase all the items in your request,&nbsp;at least <ASP:Label id="Label_unreimbursed_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;of your costs will <u>not
</u> be reimbursed?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_unreimbursed_amount" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_6" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li>
					  <p>Do you understand that you must <u>not
</u> order any of the items you have requested until <u>after
</u> you receive a Notice To Proceed message from the Regional Council?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_wait_for_approval_to_order" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_7" runat="server">No, take me back
</ASP:LinkButton>
</p></li>
						<li>
					  <p>After you receive the Notice To Proceed message, these deadlines will apply (unless explicitly waived by the Regional Council):<br>
                            <br>
                            <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
                                <tr>
                                  <td>
							<table cellspacing="0" cellpadding="5" border="0">
								<tr bgcolor="#f5f5f5">
								  <td colspan="2"><strong>Deadlines
</strong></td>
								</tr>
								<tr>
								  <td>You must complete the purchase of all items by:
</td>
								  <td>
                                            <ASP:Label id="Label_deadline_purchase_completion" runat="server" font-bold="True"></ASP:Label></td>
								</tr>
                                <tr>
                                  <td>You must submit all associated invoices to the Regional Council by:
</td>
                                  <td>
                                            <ASP:Label id="Label_deadline_invoice_submission" runat="server" font-bold="True"></ASP:Label></td>
								</tr>
								<tr>
								  <td>You must submit all associated canceled checks to the Regional Council by:
</td>
								  <td>
                                            <ASP:Label id="Label_deadline_canceled_check_submission" runat="server" font-bold="True"></ASP:Label></td>
                                </tr>
							</table></td>
                                </tr>
                            </table><br>Do you understand these deadlines? <br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_deadlines" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_8" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
						<li>
					  <p>Have you read, do you understand, and do you agree to abide by the <ASP:HyperLink id="HyperLink_terms_and_conditions" runat="server" font-bold="True" navigateurl="../resource/terms-and-conditions.pdf" target="_blank">Terms & Conditions
</ASP:HyperLink>&nbsp;of this cycle's EMSOF program?<br>
							<br>
							<ASP:CheckBox id="CheckBox_agree_to_terms_and_conditions" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_9" runat="server">No, take me back
</ASP:LinkButton>
</p></li>
                        <li>
                      <p>Again, do you understand that if you complete this form and click the gray button below, you will <u>not
</u> be able to make any future changes to your request (other than costs and quantities), unless your County EMSOF Coordinator rejects it and routes it back to you?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_read_only_2" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_request_overview_10" runat="server">No, take me back
</ASP:LinkButton><br>
</p></li>
					  </ol>
					  <p><strong>If you answered Yes to all the above questions, you may complete the Request Phase Finalization process by clicking this button:
</strong></p>
					  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
					  <p>
						  <ASP:Button id="Button_finalize" runat="server" text="LOCK YOUR REQUEST AND ROUTE IT TO COUNTY"></ASP:Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<ASP:LinkButton
										 id="LinkButton_request_overview_bottom" runat="server">Cancel
</ASP:LinkButton>
</p>
					  </blockquote></td>
				  </tr>
			  </table></td>
			</tr>
		</table>
</div>
	<uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
	 <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
