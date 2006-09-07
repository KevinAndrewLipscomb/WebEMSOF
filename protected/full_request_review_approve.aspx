<%@ Page language="c#" Debug="true" Codebehind="full_request_review_approve.pas" AutoEventWireup="false" Inherits="full_request_review_approve.TWebForm_full_request_review_approve" %>
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
			<asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
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
                  cellpadding="10" gridlines="Horizontal" bordercolor="#DCDCDC" borderwidth="1px">
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
                                Make/model:
                              </td>
                              <td>
                                <strong><%# DataBinder.Eval(Container.DataItem, "make_model") %></strong>&nbsp;
                                <%# DataBinder.Eval(Container.DataItem, "be_refurbished") %>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                Category:
                              </td>
							  <td><strong><%# DataBinder.Eval(Container.DataItem, "category") %></strong></td>
							</tr>
                            <tr>
							  <td>Place kept:</td>
							  <td><%# DataBinder.Eval(Container.DataItem, "place_kept") %></td>
                            </tr>
                            <tr>
							  <td>Qty/unit cost/subtotal:</td>
                              <td>
								<strong><%# DataBinder.Eval(Container.DataItem, "quantity") %></strong>&nbsp;
                                @
								<%# DataBinder.Eval(Container.DataItem, "unit_cost", "{0:C}") %>&nbsp;
                                ea. =
                                <strong><%# DataBinder.Eval(Container.DataItem, "subtotal", "{0:C}") %></strong>
                              </td>
                            </tr>
                            <tr>
							  <td>Max unit cost allowed by EMSOF:</td>
							  <td><%# DataBinder.Eval(Container.DataItem, "allowable_cost", "{0:C}") %></td>
							</tr>
							<tr>
							  <td>EMSOF amount:</td>
							  <td>
								<strong><%# DataBinder.Eval(Container.DataItem, "emsof_ante", "{0:C}") %></strong>
							  </td>
							</tr>
						  </table>
                            </ItemTemplate>
                          </ASP:TemplateColumn>
                        </Columns>
                  </asp:datagrid>
                </td>
              </tr>
            </table>
          </td>
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
					If you are not ready to disposition this
					                request, <asp:LinkButton id="LinkButton_back_2" runat="server">go back to the previous form</asp:LinkButton>.
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
				  <table cellspacing="0" cellpadding="10" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><strong>To mark the pending action as DONE...</td>
					</tr>
					<tr>
					  <td>
						Check&nbsp;
						<asp:checkbox id="CheckBox_mark_done" runat="server">
						</asp:checkbox>&nbsp;and click
						<asp:button id="Button_mark_done" runat="server" text="DONE"></asp:button>.
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
	  </table>
	  <p></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
	</form>
  </body>
</html>
