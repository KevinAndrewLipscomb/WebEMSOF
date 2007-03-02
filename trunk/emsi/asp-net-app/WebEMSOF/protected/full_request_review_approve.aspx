<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %><%@ Page language="c#" Debug="true" Codebehind="full_request_review_approve.pas" AutoEventWireup="false" Inherits="full_request_review_approve.TWebForm_full_request_review_approve" %>
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
		<small>
		  [ <asp:linkbutton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</asp:linkbutton>&nbsp;]
			             [ Back to <asp:LinkButton id="LinkButton_back" runat="server" causesvalidation="False">previous</asp:LinkButton>&nbsp;form ]&nbsp;
		  [ Change your
			<asp:LinkButton id="LinkButton_change_password" runat="server">password</asp:LinkButton>&nbsp;
			|
			<asp:LinkButton id="LinkButton_change_email_address" runat="server">email address</asp:LinkButton>&nbsp;]
		</small>
	  </p>
	  <p><asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
	  <h3>
		<asp:label id="Label_fiscal_year_designator" runat="server"></asp:label>&nbsp;request from
		<asp:label id="Label_service_name" runat="server"></asp:label>&nbsp;(#
	    <asp:label id="Label_affiliate_num" runat="server"></asp:label>)</h3>
	  <p>
		<table bordercolor="#98fb98" cellspacing="0" cellpadding="5" border="1" id="Table_action_required" runat="server">
			<tr>
			  <td bgcolor="#98fb98"><strong>ACTION REQUIRED:</strong></td>
			  <td>Please review the following information, then indicate your disposition at the bottom of this form.</td>
			</tr>
		</table>
		<table bordercolor="#98fb98" cellspacing="0" cellpadding="5" border="1" id="Table_action_pending" runat="server">
			<tr>
			  <td bgcolor="#98fb98"><strong>ACTION PENDING:</strong></td>
			  <td>See the bottom of this form for a description of the action pending on this request, and for a way to indicate
																												                      that the pending action has been completed.</td>
			</tr>
		</table>
	  </p>
	  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
		<tr>
		  <td>
			<table cellspacing="0" cellpadding="5" border="0">
			  <tr>
				<td bgcolor="#f5f5f5">
				  <p align="right">
					<strong>Allocation:</strong>
				  </p>
				</td>
				<td align="right">
				  <p align="right">

				  </p>
				  <asp:label id="Label_parent_appropriation_amount" runat="server"></asp:label>
				</td>
				<td>
				  from
				  <asp:label id="Label_sponsor_county" runat="server">
				  </asp:label>&nbsp;County
				</td>
			  </tr>
			  <tr id="TableRow_sum_of_emsof_antes" runat="server">
				<td>
				  <p align="right">
					-
				  </p>
				</td>
				<td align="right">
				  <p align="right">

				  </p>
				  <asp:label id="Label_sum_of_emsof_antes" runat="server"
				  font-underline="True"></asp:label>
				</td>
				<td>
				  requested from EMSOF (below)
				</td>
			  </tr>
			  <tr id="TableRow_unrequested_amount" runat="server">
				<td>
				  <p align="right">
					=
				  </p>
				</td>
				<td align="right">
				  <p align="right">

				  </p>
				  <asp:label id="Label_unused_amount" runat="server">
				  </asp:label>
				</td>
				<td>
				  unused
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	  <p>
		<table id="Table_prior_approvals" bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" runat="server">
			<tr><td>
				<table cellspacing="0" cellpadding="5" border="0">
	  <tr>
					  <td bgcolor="#f5f5f5" colspan="2"><strong>Prior approvals</strong></td>
			  </tr>
	  <tr>
		<td><ASP:Label id="Label_sponsor_county_2" runat="server"></ASP:Label>&nbsp;County:</td>
		<td><ASP:Label id="Label_county_approval_timestamp" runat="server"></ASP:Label></td>
	  </tr>
	  <tr id="TableRow_regional_planner_approval_timestamp" runat="server">
		<td>
                        <ASP:Label id="Label_region_name_1" runat="server"></ASP:Label>&nbsp;planner:</td>
		<td><ASP:Label id="Label_regional_planner_approval_timestamp" runat="server"></ASP:Label></td>
	  </tr>
	  <tr id="TableRow_regional_exec_dir_approval_timestamp" runat="server">
		<td>
                        <ASP:Label id="Label_region_name_2" runat="server"></ASP:Label>&nbsp;Executive Director:</td>
		<td><ASP:Label id="Label_regional_exec_dir_approval_timestamp" runat="server"></ASP:Label></td>
	  </tr>
	  <tr id="TableRow_state_approval_timestamp" runat="server">
		<td>PA DOH EMSO:</td>
		<td><ASP:Label id="Label_state_approval_timestamp" runat="server"></ASP:Label></td>
	  </tr>
				</table></td>
			</tr>
        </table>
      </p>
	  <p></p>
      <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="10" border="0">
              <tr>
				<td bgcolor="#f5f5f5"><strong>Items (<asp:label id="Label_num_items" runat="server"></asp:label>)</strong></td>
              </tr>
              <tr>
                <td>
                  <asp:datagrid id="DataGrid_items" runat="server"
                  autogeneratecolumns="False" useaccessibleheader="True"
                  cellpadding="10" gridlines="Horizontal" bordercolor="Gainsboro" borderwidth="1px">
                        <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                        <Columns>
                          <ASP:BoundColumn datafield="priority" sortexpression="priority" readonly="True" headertext="Priority">
                            <ItemStyle font-size="Large" font-bold="True" horizontalalign="Center" verticalalign="Top"></ItemStyle>
                          </ASP:BoundColumn>
                          <ASP:TemplateColumn headertext="Detail">
                            <ItemStyle horizontalalign="Left" verticalalign="Top"></ItemStyle>
                            <ItemTemplate>
                          <table cellpadding="2">
                            <tr>
                              <td>
								<small>Make/model:</small>
                              </td>
                              <td>
								<small><strong><%# DataBinder.Eval(Container.DataItem, "make_model") %></strong>&nbsp;
								<%# DataBinder.Eval(Container.DataItem, "be_refurbished") %></small>
                              </td>
                            </tr>
                            <tr>
                              <td>
								<small>Category:</small>
							  </td>
							  <td><small><strong><%# DataBinder.Eval(Container.DataItem, "category") %></strong></small></td>
							</tr>
                            <tr>
							  <td><small>Place kept:</small></td>
							  <td><small><%# DataBinder.Eval(Container.DataItem, "place_kept") %></small></td>
							</tr>
							<tr>
							  <td><small>Qty/unit cost/subtotal:</small></td>
							  <td>
								<small><strong><%# DataBinder.Eval(Container.DataItem, "quantity") %></strong>&nbsp;
								@
								<%# DataBinder.Eval(Container.DataItem, "unit_cost", "{0:C}") %>&nbsp;
								ea. =
								<strong><%# DataBinder.Eval(Container.DataItem, "subtotal", "{0:C}") %></strong></small>
							  </td>
							</tr>
							<tr>
							  <td><small>Max unit cost allowed by EMSOF:</small></td>
							  <td><small><%# DataBinder.Eval(Container.DataItem, "allowable_cost", "{0:C}") %></small></td>
							</tr>
							<tr>
							  <td><small>EMSOF amount:</small></td>
							  <td>
								<small><strong><%# DataBinder.Eval(Container.DataItem, "emsof_ante", "{0:C}") %></strong></small>
							  </td>
							</tr>
						  </table>
                            </ItemTemplate>
                          </ASP:TemplateColumn>
                          <ASP:TemplateColumn headertext="Actuals">
                            <ItemTemplate>

                              <html>
                                <head></head>
                                <body>
<small>Invoice #/comment:<br>&nbsp;&nbsp;&nbsp;&nbsp; <b><%# DataBinder.Eval(Container.DataItem, "invoice_designator") %></b><br>
Quantity:<br>&nbsp;&nbsp;&nbsp;&nbsp; <b><%# DataBinder.Eval(Container.DataItem, "actual_quantity") %></b><br>
Subtotal cost:<br>&nbsp;&nbsp;&nbsp;&nbsp; <b><%# DataBinder.Eval(Container.DataItem, "actual_subtotal_cost", "{0:C}") %></b><br>
EMSOF amount:<br>&nbsp;&nbsp;&nbsp;&nbsp; <b><%# DataBinder.Eval(Container.DataItem, "actual_emsof_ante", "{0:C}") %></b>
</small>
                                </body>
                              </html>
							</ItemTemplate>
							<EditItemTemplate>
<small>
Invoice #/comment:<br>&nbsp;&nbsp;&nbsp;&nbsp; <ASP:TextBox id="TextBox_invoice_designator" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "invoice_designator") %>'></ASP:TextBox><br>
Actual quantity:<br>&nbsp;&nbsp;&nbsp;&nbsp; <ASP:TextBox id="TextBox_actual_quantity" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "actual_quantity") %>'></ASP:TextBox><br>
Actual subtotal cost:<br>&nbsp;&nbsp;&nbsp;&nbsp; <ASP:TextBox id="TextBox_actual_subtotal_cost" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "actual_subtotal_cost", "{0:C}") %>'></ASP:TextBox><br>
EMSOF amount:<br>&nbsp;&nbsp;&nbsp;&nbsp; <i>(autocalculated)</i>
</small>
							</EditItemTemplate>
						  </ASP:TemplateColumn>
						  <ASP:EditCommandColumn buttontype="LinkButton" updatetext="Update" canceltext="Cancel" edittext="Edit"></ASP:EditCommandColumn>
						</Columns>
				  </asp:datagrid>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	  <p></p>
	  <p></p>
	  <table cellspacing="0" cellpadding="0" border="1" id="Table_proofs_of_payment" runat="server" bordercolor="#dcdcdc">
		<tr>
		  <td>
			<table cellspacing="0" cellpadding="10" border="0" width="100%">
			  <tr>
				<td bgcolor="#f5f5f5">
				  <strong>
						<table cellspacing="0" cellpadding="5" width="100%" border="0">
							<tr>
							  <td><strong>Proofs of payment by service</strong></td>
							  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							  <td>
								<p align="right"><ASP:LinkButton id="LinkButton_new_proof_of_payment" runat="server" font-bold="True" causesvalidation="False">New</ASP:LinkButton></p></td>
							</tr>
						</table></strong>
				</td>
			  </tr>
			  <tr id="TableRow_proofs_of_payment_none" runat="server">
				<td>
				  <p><em>--&nbsp;NONE&nbsp;--</em></p>
				</td>
			  </tr>
			  <tr>
				<td>
						<ASP:DataGrid id="DataGrid_proofs_of_payment" runat="server" autogeneratecolumns="False" useaccessibleheader="True" cellpadding="10" gridlines="Horizontal" bordercolor="Gainsboro" borderwidth="1px">
						<HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
						<Columns>
						  <ASP:BoundColumn visible="False" datafield="id" readonly="True"></ASP:BoundColumn>
						  <ASP:BoundColumn datafield="date_of" readonly="True" headertext="Date"></ASP:BoundColumn>
						  <ASP:BoundColumn datafield="method" readonly="True" headertext="Method">
							<ItemStyle horizontalalign="Center"></ItemStyle>
						  </ASP:BoundColumn>
						  <ASP:BoundColumn datafield="amount" headertext="Amount" dataformatstring="{0:C}">
							<ItemStyle horizontalalign="Right"></ItemStyle>
						  </ASP:BoundColumn>
						  <ASP:BoundColumn datafield="note" headertext="Note"></ASP:BoundColumn>
						  <ASP:ButtonColumn text="Delete" commandname="Delete"></ASP:ButtonColumn>
						</Columns></ASP:DataGrid>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	  <p></p>
	  <table cellspacing="0" cellpadding="10" border="1" id="Table_emphasized_totals" runat="server" bordercolor="darkgray">
		<tr>
		  <td align="center" bgcolor="darkgray"><strong><font color="white">TOTAL OF ACTUAL COSTS</font></strong></td>
		  <td align="center" bgcolor="darkgray"><strong><font color="white">TOTAL OF PROVEN PAYMENTS</font></strong></td>
		  <td align="center" bgcolor="black"><strong><font color="white">TOTAL OF EMSOF AMOUNTS</font></strong></td>
		</tr>
		<tr>
		  <td align="center"><ASP:Label id="Label_total_of_actual_costs" runat="server" font-bold="True"></ASP:Label></td>
		  <td align="center"><ASP:Label id="Label_total_of_proven_payments" runat="server" font-bold="True"></ASP:Label></td>
		  <td align="center"><ASP:Label id="Label_total_of_emsof_amounts" runat="server" font-bold="True"></ASP:Label></td>
		</tr>
	  </table>
	  <p></p>
	  <table cellspacing="0" cellpadding="0" border="1" id="Table_disposition" runat="server" bordercolor="#98fb98">
		<tr>
		  <td>
			<table cellspacing="0" cellpadding="10" border="0">
			  <tr>
				<td bgcolor="#98fb98">
				  <strong>Disposition</strong>
				</td>
			  </tr>
			  <tr>
				<td>
				  <p>
					If you are not ready to disposition this request, <asp:LinkButton id="LinkButton_back_2" runat="server">go back to the previous form</asp:LinkButton>.
				</p></td>
			  </tr>
			  <tr>
				<td>
				  <table cellspacing="0" cellpadding="10" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><strong>To APPROVE and send to
								<ASP:Label id="Label_next_reviewer" runat="server"></ASP:Label>...</strong></td>
					</tr>
					<tr>
					  <td>
						Check&nbsp;
						<asp:checkbox id="CheckBox_approve" runat="server">
						</asp:checkbox>&nbsp;and click
						<asp:button id="Button_approve" runat="server" text="APPROVE"></asp:button>.
					  </td>
					</tr>
					<tr id="TableRow_return" runat="server">
					  <td bgcolor="#f5f5f5"><strong>To return to service for rework...</strong></td>
					</tr>
					<tr id="TableRow_reject" runat="server">
					  <td bgcolor="#f5f5f5"><strong>To REJECT...</strong></td>
					</tr>
					<tr>
					  <td>
						<table cellspacing="0" cellpadding="5" border="0">
						  <tr>
							<td valign="top">
							  Enter reason:
							</td>
							<td valign="top">
							  <textarea rows="3" cols="30" id="TextArea_disapproval_reason" name="TextArea_disapproval_comment" runat="Server"></textarea>
							</td>
							<td valign="top">
							  and click
							  <asp:button id="Button_disapprove" runat="server"></asp:button>.
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
	  <table cellspacing="0" cellpadding="0" border="1" id="Table_mark_done" runat="server" bordercolor="#98fb98">
		<tr>
		  <td>
			<table cellspacing="0" cellpadding="10" border="0">
			  <tr>
				<td bgcolor="#98fb98">
				  <strong>Action pending</strong>
				</td>
			  </tr>
			  <tr>
				<td>
				  <p>The current status of this request in WebEMSOF is
						<ASP:Label id="Label_current_status" runat="server" font-bold="True"></ASP:Label>.</p>
				</td>
			  </tr>
			  <tr>
				<td>
				  <table cellspacing="0" cellpadding="10" border="0" width="100%">
					<tr>
					  <td bgcolor="#f5f5f5"><strong>To mark the pending action as DONE...</strong></td>
					</tr>
					<tr><td>
						Check&nbsp;
						<asp:checkbox id="CheckBox_mark_done" runat="server">
						</asp:checkbox>&nbsp;and click
						<asp:button id="Button_mark_done" runat="server" text="DONE"></asp:button>.
					  </td>
					</tr>
				  </table>
				  <table cellspacing="0" cellpadding="10" width="100%" border="0" id="Table_mark_failed" runat="server">
					  <tr>
						<td bgcolor="#f5f5f5"><strong>To mark this request as FAILED DEADLINE...</strong></td>
					  </tr>
					  <tr>
						<td>Check <ASP:CheckBox id="CheckBox_mark_failed" runat="server"></ASP:CheckBox>&nbsp;and click <ASP:Button id="Button_failed" runat="server" text="FAILED"></ASP:Button>.</td>
					  </tr>
				  </table>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
      <p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_extraordinary_actions" runat="server">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Extraordinary actions</strong></td>
                    </tr>
                    <tr>
                      <td><p><table cellspacing="0" cellpadding="10" border="0">
                              <tr id="TableRow_force_open" runat="server">
                                <td><small>Force this request back to NEEDS_SERVICE_FINALIZATION status and make it exempt from normal deadlines.&nbsp; This action will cause 
                                    <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;to forget about the invoices and proofs of payment that are currently associated with this request.&nbsp; The request must then advance through the entire approval and evidence collection process again.</small></td>
								<td valign="top"><ASP:Button id="Button_force_open" runat="server" text="Do"></ASP:Button></td>
                              </tr>
							  <tr id="TableRow_force_closed" runat="server">
								<td><small>Revoke this request's deadline exemption.&nbsp; This action will prevent the service from making any further modifications to this request.&nbsp; After taking this action, you will still be able to accept or reject the request as usual.</small></td>
								<td valign="top"><ASP:Button id="Button_force_close" runat="server" text="Do"></ASP:Button></td>
							  </tr>
						  </table>
                        </p></td>
                    </tr>
                </table></td>
            </tr>
        </table>
      </p>
	  <p></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder><sstchur:SmartScroller runat="server" />
	</form>
  </body>
</html>
