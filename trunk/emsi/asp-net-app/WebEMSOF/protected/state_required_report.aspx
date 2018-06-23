<!DOCTYPE HTML>
<%@ Page language="c#" Debug="true" Codebehind="state_required_report.aspx.cs" AutoEventWireup="True" Inherits="state_required_report.TWebForm_state_required_report" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <title></title>
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="10" border="0">
              <tr>
                <td bgcolor="#f5f5f5">
                  <table cellspacing="0" cellpadding="5" width="75%" border="0">
                    <tr>
                      <td><strong>State-required report</strong></td>
                      <td>&nbsp;&nbsp;&nbsp;</td>
                      <td>
                        <p align="center">
                          <ASP:LinkButton id="LinkButton_export_scratch_copy" runat="server" enabled="False" onclick="LinkButton_export_scratch_copy_Click">1. Export scratch copy</ASP:LinkButton>
                        </p>
                      </td>
                      <td>&nbsp;&nbsp;&nbsp;</td>
                      <td>
                        <div align="center">
                          <asp:linkbutton id="LinkButton_transmit_to_state" runat="server" enabled="False" onclick="LinkButton_transmit_to_state_Click">2. Mark DONE and advance to next step</asp:linkbutton>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5">
                        <small>A total of <ASP:Label id="Label_total_num_requests" runat="server" font-bold="True"></ASP:Label>&nbsp;requests are ready to be transmitted to the state.</small>
                      </td>
                    </tr>
                    <tr id="TableRow_this_is_everything" runat="server" visible="False">
                      <td colspan="5">
                        <small>
                          This report includes request items from all&nbsp;<ASP:Label id="Label_total_num_requests_2" runat="server" font-bold="True"></ASP:Label> requests made in funding round
                          #<asp:label id="Label_funding_round_everything" runat="server"></asp:label>.
                        </small>
                      </td>
                    </tr>
                    <tr id="TableRow_this_is_just_some" runat="server" visible="False">
                      <td colspan="5">
                        <small>
                          This report only includes items from the&nbsp;<ASP:Label id="Label_num_filtered_requests" runat="server" font-bold="True"></ASP:Label>&nbsp;requests made against
                          <ASP:DropDownList id="DropDownList_amendment" runat="server" autopostback="True" onselectedindexchanged="DropDownList_amendment_SelectedIndexChanged"></ASP:DropDownList> in funding round
                          #<asp:label id="Label_funding_round_some" runat="server"></asp:label>.
                        </small>
                      </td>
                    </tr>
                    <tr><td colspan="5"><small>Do not copy/paste cells marked <strong>PROTECTED</strong> into state spreadsheet.</small></td></tr>
                    <tr id="TableRow_replacement_note" runat="server" visible="false">
                      <td colspan="5">
                        <small>
                          Rows marked with a star in the <i>Notes</i> field are <u>replacements</u> for rows that were reported in a previous funding round in this fiscal year.&nbsp; PA DOH EMSB should <u>delete</u> the
                          associated batch of rows from its previous records and use the items in this batch instead.&nbsp; The "W#" can be used to positively determine associated batches.
                        </small>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table cellspacing="0" cellpadding="5" border="0" id="Table_report" runat="server">
                    <tr id="TableRow_none" runat="server"><td><em>-- NONE --</em></td></tr>
                    <tr>
                      <td>
                        <asp:datagrid id="DataGrid_state_export_batch" runat="server" autogeneratecolumns="False" visible="False" font-size="X-Small" bordercolor="Gainsboro">
                          <FooterStyle font-bold="True" backcolor="LightGray"></FooterStyle>
                          <AlternatingItemStyle backcolor="WhiteSmoke"></AlternatingItemStyle>
                          <HeaderStyle backcolor="LightGray"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn datafield="service_name" readonly="True" headertext="Service"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="life_support_level" readonly="True" headertext="Org Type"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="match_level" readonly="True" headertext="Rural"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="equipment_description" readonly="True" headertext="Equipment"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="quantity" readonly="True" headertext="QTY">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="unit_cost" readonly="True" headertext="Unit Price">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                              <FooterStyle horizontalalign="Right"></FooterStyle>
                            </ASP:BoundColumn>
                            <asp:TemplateColumn HeaderText="Total Cost"><ItemTemplate><strong>PROTECTED</strong></ItemTemplate></asp:TemplateColumn>
                            <ASP:BoundColumn datafield="recommendation" readonly="True" headertext="Recom">
                              <HeaderStyle horizontalalign="Center"></HeaderStyle>
                              <ItemStyle horizontalalign="Center"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="discouragement_code" readonly="True" headertext="Not Recom">
                              <HeaderStyle horizontalalign="Center"></HeaderStyle>
                              <ItemStyle horizontalalign="Center"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="provider_match" readonly="True" headertext="Provider Match">
                              <HeaderStyle horizontalalign="Center"></HeaderStyle>
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                              <FooterStyle horizontalalign="Right"></FooterStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="emsof_ante" readonly="True" headertext="EMSOF Funds Requested">
                              <HeaderStyle horizontalalign="Center"></HeaderStyle>
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                              <FooterStyle horizontalalign="Right"></FooterStyle>
                            </ASP:BoundColumn>
                            <asp:TemplateColumn HeaderText="Errors"><ItemTemplate><strong>PROTECTED</strong></ItemTemplate></asp:TemplateColumn>
                            <ASP:BoundColumn datafield="note" readonly="True" headertext="Notes"></ASP:BoundColumn>
                          </Columns>
                        </asp:datagrid>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
