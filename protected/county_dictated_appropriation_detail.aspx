<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriation_detail.pas" AutoEventWireup="false" Inherits="county_dictated_appropriation_detail.TWebForm_county_dictated_appropriation_detail" %>
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
		                       [ Back to <asp:hyperlink id="HyperLink_back" runat="server" navigateurl="county_dictated_appropriations.aspx">county-dictated appropriation</asp:hyperlink>&nbsp;form ]&nbsp;
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
        </table></p>
	  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="5" border="0">
              <tr>
                <td bgcolor="#f5f5f5">
                  <p align="right">
                    <strong>Appropriation:</strong>
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
                  cellpadding="10" gridlines="Horizontal">
                    <headerstyle backcolor="WhiteSmoke"></headerstyle>
                    <columns>
                      <asp:boundcolumn datafield="priority" sortexpression="priority" readonly="true" headertext="Priority">
                        <itemstyle font-size="Large" font-bold="True"
                        horizontalalign="Center" verticalalign="Top">
                        </itemstyle>
                      </asp:boundcolumn>
                      <asp:templatecolumn headertext="Detail">
                        <itemstyle horizontalalign="Left" verticalalign="Top"></itemstyle>
                        <itemtemplate>
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
							  <td>Max unit cost supported by EMSOF:</td>
							  <td><%# DataBinder.Eval(Container.DataItem, "allowable_cost", "{0:C}") %></td>
							</tr>
							<tr>
							  <td>EMSOF ante/effective match level:</td>
							  <td>
								<strong><%# DataBinder.Eval(Container.DataItem, "emsof_ante", "{0:C}") %></strong>&nbsp;
																																																																																																																																																																																																																																																																(<%# DataBinder.Eval(Container.DataItem, "effective_match_level", "{0:P0}") %>)
							  </td>
							</tr>
						  </table>
                        </itemtemplate>
                      </asp:templatecolumn>
                    </columns>
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
					request, <asp:hyperlink id="HyperLink_back_2" runat="server"
				  navigateurl="county_dictated_appropriations.aspx">
					go back to the county-dictated appropriation form
				  </asp:hyperlink>.
				</p></td>
			  </tr>
			  <tr>
				<td>
				  <table cellspacing="0" cellpadding="10" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><strong>To APPROVE and send to the regional council...</strong></td>
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
					  <td bgcolor="#f5f5f5"><strong>&nbsp;To return to service for improvement...</strong></td>
					</tr>
					<tr id="TableRow_reject" runat="server">
					  <td bgcolor="#f5f5f5"><strong>&nbsp;To REJECT...</strong></td>
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
	  <p></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
