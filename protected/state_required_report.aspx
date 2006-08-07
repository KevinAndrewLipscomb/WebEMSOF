<%@ Page language="c#" Debug="true" Codebehind="state_required_report.pas" AutoEventWireup="false" Inherits="state_required_report.TWebForm_state_required_report" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title id="Title" runat="server"></title><!-- $Id$ -->
  </head>
  <body>
    <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
	  <p>
		<small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;]
			                                                     [ Back to <ASP:LinkButton id="LinkButton_back" runat="server" causesvalidation="False">previous</ASP:LinkButton>&nbsp;form ]&nbsp;
			                                                     [ Change your <asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
		</small>
	  </p>
	  <p><asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
	  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="10" border="0">
              <tr>
                <td bgcolor="#f5f5f5">
                  <table cellspacing="0" cellpadding="5" width="50%" border="0">
                    <tr>
                      <td>
                        <strong>State-required report</strong>
                      </td>
                      <td>
						<asp:linkbutton id="LinkButton_transmit_to_state" runat="server" enabled="False">Transmit to State</asp:linkbutton>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table cellspacing="0" cellpadding="5" border="0" id="Table_report" runat="server">
                    <tr>
                      <td>
                        Regional EMS council name: <strong>EMERGENCY MEDICAL SERVICE INSTITUTE</strong>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        Total amount available: 
                        <asp:label id="Label_amount_available" runat="server"></asp:label>
                      </td>
                    </tr>
                    <tr id="TableRow_none" runat="server">
                      <td>
                        <em>-- NONE --</em>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <asp:datagrid id="DataGrid_state_export_batch" runat="server" autogeneratecolumns="False" visible="False"
                        font-size="X-Small" showfooter="True" bordercolor="Gainsboro">
                          <footerstyle font-bold="True" backcolor="LightGray"></footerstyle>
                          <alternatingitemstyle backcolor="WhiteSmoke"></alternatingitemstyle>
                          <headerstyle backcolor="LightGray"></headerstyle>
                          <columns>
                            <asp:boundcolumn datafield="service_name" readonly="true" headertext="Organization Name">
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="life_support_level" readonly="true" headertext="Type of Organization">
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="equipment_description" readonly="true" headertext="Equipment/Program">
                              <footerstyle horizontalalign="Right"></footerstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="quantity" readonly="true" headertext="# Units">
                              <itemstyle horizontalalign="Right"></itemstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="unit_cost" readonly="true" headertext="Unit Cost" dataformatstring="{0:C}">
                              <itemstyle horizontalalign="Right"></itemstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="total_cost" readonly="true" headertext="Total Cost Amount"
                            dataformatstring="{0:C}">
                              <headerstyle horizontalalign="Center"></headerstyle>
                              <itemstyle horizontalalign="Right"></itemstyle>
                              <footerstyle horizontalalign="Right"></footerstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="emsof_ante" readonly="true" headertext="EMSOF Amount" dataformatstring="{0:C}">
                              <headerstyle horizontalalign="Center"></headerstyle>
                              <itemstyle horizontalalign="Right"></itemstyle>
                              <footerstyle horizontalalign="Right"></footerstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="provider_match" readonly="true" headertext="Provider Match"
                            dataformatstring="{0:C}">
                              <headerstyle horizontalalign="Center"></headerstyle>
                              <itemstyle horizontalalign="Right"></itemstyle>
                              <footerstyle horizontalalign="Right"></footerstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn datafield="recommendation" readonly="true" headertext="Recomm*">
                              <headerstyle horizontalalign="Center"></headerstyle>
                              <itemstyle horizontalalign="Center"></itemstyle>
                            </asp:boundcolumn>
                            <asp:boundcolumn readonly="true" headertext="EMSOF Approved"></asp:boundcolumn>
                            <asp:boundcolumn readonly="true" headertext="Actual Total Cost" dataformatstring="{0:C}">
                              <headerstyle horizontalalign="Center"></headerstyle>
                              <itemstyle horizontalalign="Right"></itemstyle>
                              <footerstyle horizontalalign="Right"></footerstyle>
                            </asp:boundcolumn>
                          </columns>
                        </asp:datagrid>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table cellspacing="0" cellpadding="5" border="0">
                          <tr>
                            <td align="right">
                              ME:
                            </td>
                            <td></td>
                            <td>
                              __________________________________
                            </td>
                          </tr>
                          <tr>
                            <td align="right" valign="top">
                              Reviewed and Recommended by Regional EMS Council (name):
                            </td>
                            <td></td>
                            <td valign="top">
                              <strong>William E. Groft</strong><br>President 

                            </td>
                          </tr>
                          <tr>
                            <td></td>
                            <td></td>
                            <td valign="top">
                              <strong>Thomas J. McElree</strong><br>Regional EMS Council Director 

                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Funding Round:
                            </td>
                            <td></td>
                            <td>
                              <asp:label id="Label_funding_round" runat="server"></asp:label>
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Submission Date:
                            </td>
                            <td></td>
                            <td>
                              <asp:label id="Label_submission_date" runat="server"></asp:label>
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Review Date:
                            </td>
                            <td></td>
                            <td>
                              __________________________________
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Approval Date:
                            </td>
                            <td></td>
                            <td>
                              __________________________________
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              DOH Approval:
                            </td>
                            <td></td>
                            <td>
                              __________________________________
                            </td>
                          </tr>
                          <tr>
                            <td align="right">
                              Date:
                            </td>
                            <td></td>
                            <td>
                              __________________________________
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
      <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
