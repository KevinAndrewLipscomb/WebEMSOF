<%@ Page language="c#" Debug="true" Codebehind="finalize.pas" AutoEventWireup="false" Inherits="finalize.TWebForm_finalize" %>
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
<p>
        <ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p><strong>Request phase finalization</strong></p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_sorry" runat="server">
			<tr>
			  <td>
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><em><strong><font color="#ff0000">SORRY...</font></strong>
						</em></td>
					</tr>
					<tr>
					  <td>
						<p>You've requested too much.</p>
						<p>The specified EMSOF reimbursement is more than the appropriation you received from the sponsoring county.</p>
						<p>Please&nbsp;<ASP:HyperLink id="HyperLink_request_overview_0" runat="server" font-bold="True" navigateurl="request_overview.aspx">go back to the request overview form</ASP:HyperLink> and&nbsp;adjust your request to fit your appropriation.</p>
						<p>HINT:&nbsp; Make a note of the negative "remaining" amount.&nbsp; Select one of your request items.&nbsp; Enter an equivalent [positive] amount in the field labeled, "<strong>Additional</strong> amount, if any, that your service&nbsp;will pay, <strong>unreimbursed</strong>".&nbsp; Your request will no longer exceed your appropriation, and finalization will proceed normally.</p></td>
					</tr>
				</table></td>
			</tr>
		</table>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_summary" runat="server">
			<tr>
			  <td>
			  <table cellspacing="0" cellpadding="10" border="0">
				  <tr>
					<td bgcolor="#f5f5f5"><strong>SUMMARY</strong></td>
				  </tr>
				  <tr>
					<td>
					  <p>This form allows you to&nbsp;route your Requested Items List to your County EMSOF Coordinator for approval.</p>
					  <p>You must confirm the following before clicking the gray button at the bottom of the page:</p>
					  <ol>
                        <li>
                      <p>Do you understand that if you complete this form and click the gray button below, you will <u>not</u> be able to make any future changes to your request (other than costs and quantities), unless your County EMSOF Coordinator rejects it and routes it back to you?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_read_only_1" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink
                                           id="HyperLink_request_overview_1" runat="server" navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li id="ListItem_remainder_goes_to_region" runat="server">
					  <p>Do you realize that you will forfeit the remaining 
                            <ASP:Label id="Label_unused_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;of your appropriation?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_remainder_goes_to_region" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_2" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink></p></li>
						<li>
					  <p>Do you understand that the anticipated grand total cost of your request is
							<ASP:Label id="Label_grand_total_cost" runat="server" font-bold="True"></ASP:Label>, and that your service must pay all costs "up front" when ordering from vendors?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_grand_total_up_front" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_3" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li>
					  <p>Do you understand that EMSOF will reimburse a maximum of&nbsp;<ASP:Label id="Label_max_reimbursement_1" runat="server" font-bold="True"></ASP:Label>&nbsp;to your service?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_max_reimbursement" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_4" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li>
					  <p>Do you understand that, if your actual costs are less than your anticipated costs, the actual EMSOF reimbursement will also be less than 
                            <ASP:Label id="Label_max_reimbursement_2" runat="server" font-bold="True"></ASP:Label>?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_anticipated_vs_actual" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_5" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li>
					  <p>Do you understand that, if you purchase all the items in your request,&nbsp;at least
							<ASP:Label id="Label_unreimbursed_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;of your costs will <u>not</u> be reimbursed?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_unreimbursed_amount" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_6" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li>
					  <p>Do you understand that you must 
                            <u>not</u> order any of the items you have requested until <u>after</u> you receive an Approval To Proceed notice from the Regional Council?<br>
                            <br>
                            <ASP:CheckBox id="CheckBox_understand_wait_for_approval_to_order" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_7" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink></p></li>
						<li>
					  <p>After you receive the Approval To Proceed notice, these deadlines will apply:<br>
                            <br>
                            <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
                                <tr>
                                  <td>
							<table cellspacing="0" cellpadding="5" border="0">
								<tr bgcolor="#f5f5f5">
								  <td colspan="2"><strong>Deadlines</strong></td>
								</tr>
								<tr>
								  <td>You must complete the purchase of all items by:</td>
								  <td>
                                            <ASP:Label id="Label_deadline_purchase_completion" runat="server" font-bold="True"></ASP:Label></td>
								</tr>
                                <tr>
                                  <td>You must submit all associated invoices to the Regional Council by:</td>
                                  <td>
                                            <ASP:Label id="Label_deadline_invoice_submission" runat="server" font-bold="True"></ASP:Label></td>
								</tr>
								<tr>
								  <td>You must submit all associated canceled checks to the Regional Council by:</td>
								  <td>
                                            <ASP:Label id="Label_deadline_canceled_check_submission" runat="server" font-bold="True"></ASP:Label></td>
                                </tr>
							</table></td>
                                </tr>
                            </table><br>Do you understand these deadlines?
							<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_deadlines" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_8" runat="server" navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
						<li>
					  <p>Have you read, do you understand, and do you agree to abide by the
							<ASP:HyperLink id="HyperLink_terms_and_conditions" runat="server" font-bold="True" navigateurl="terms-and-conditions.pdf" target="_blank">Terms & Conditions</ASP:HyperLink>&nbsp;of this cycle's EMSOF program?<br>
							<br>
							<ASP:CheckBox id="CheckBox_agree_to_terms_and_conditions" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_9" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink></p></li>
                        <li>
                      <p>Again, do you understand that if you complete this form and click the gray button below, you will <u>not</u> be able to make any future changes to your request (other than costs and quantities), unless your County EMSOF Coordinator rejects it and routes it back to you?<br>
							<br>
							<ASP:CheckBox id="CheckBox_understand_read_only_2" runat="server" text="Yes"></ASP:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <ASP:HyperLink id="HyperLink_request_overview_10" runat="server"
                 navigateurl="request_overview.aspx">No, take me back</ASP:HyperLink><br></p></li>
					  </ol>
					  <p><strong>If you answered Yes to all the above questions, you may complete the Request Phase Finalization process by clicking this button:</strong></p>
					  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
					  <p>
						  <ASP:Button id="Button_finalize" runat="server" text="LOCK YOUR REQUEST AND ROUTE IT TO COUNTY"></ASP:Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          &nbsp;<ASP:HyperLink
                                         id="HyperLink_request_overview_bottom" runat="server" navigateurl="request_overview.aspx">Cancel</ASP:HyperLink></p>
					  </blockquote></td>
				  </tr>
			  </table></td>
			</tr>
		</table>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
