<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_fy_allocations_reimbursements_returns.ascx.cs" Inherits="UserControl_fy_allocations_reimbursements_returns.TWebUserControl_fy_allocations_reimbursements_returns"%>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
      <tr>
        <td>
          <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td bgcolor="#dcdcdc">
                <table cellpadding="5" cellspacing="0" width="100%">
                  <tr>
                    <td width="99%">
                      <strong>Cycle:&nbsp;<asp:DropDownList ID="DropDownList_cycle" runat="server" autopostback="True" onselectedindexchanged="DropDownList_cycle_SelectedIndexChanged">
                      </asp:DropDownList>
                      </strong>
                    </td>
                    <td>
                      <table border="1" bordercolor="silver" cellpadding="4" cellspacing="0">
                        <tr>
                          <td>
                            <table border="0" cellpadding="2" cellspacing="0">
                              <tr>
                                <td rowspan="3" valign="center">TOTALS:</td>
                                <td align="right" nowrap="nowrap">Allocated</td>
                                <td>=</td>
                                <td align="right" nowrap="nowrap"><asp:Literal ID="Literal_sum_of_allocations" runat="server"></asp:Literal></td>
                              </tr>
                              <tr>
                                <td align="right" nowrap="nowrap">Reimbursed</td>
                                <td>=</td>
                                <td align="right" nowrap="nowrap"><asp:Literal ID="Literal_sum_of_reimbursements" runat="server"></asp:Literal></td>
                              </tr>
                              <tr>
                                <td align="right" nowrap="nowrap">Not spent</td>
                                <td>=</td>
                                <td align="right" nowrap="nowrap"><asp:Literal ID="Literal_sum_of_returns" runat="server"></asp:Literal></td>
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
            <tr>
              <td>
                <asp:DataGrid id="DataGrid_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available">
                  <Columns>
                    <asp:ButtonColumn text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Detail&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" commandname="Select"></asp:ButtonColumn>
                    <asp:BoundColumn datafield="master_id" Visible="False"></asp:BoundColumn>
                    <asp:BoundColumn datafield="service_name" headertext="Service" sortexpression="service_name%,county_name,master_id"></asp:BoundColumn>
                    <asp:BoundColumn datafield="county_name" headertext="County" sortexpression="county_name%,service_name,master_id"></asp:BoundColumn>
                    <asp:BoundColumn datafield="allocation" dataformatstring="{0:C}" sortexpression="allocation%,service_name,county_name,master_id" HeaderText="Allocation">
                      <HeaderStyle horizontalalign="Right"></HeaderStyle>
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="reimbursement" dataformatstring="{0:C}" sortexpression="reimbursement%,service_name,county_name,master_id" HeaderText="Reimbursement">
                      <HeaderStyle horizontalalign="Right"></HeaderStyle>
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="amount_returned" dataformatstring="{0:C}" sortexpression="amount_returned%,service_name,county_name,master_id" HeaderText="Not spent">
                      <HeaderStyle horizontalalign="Right"></HeaderStyle>
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                  </Columns>
                  <HeaderStyle backcolor="WhiteSmoke" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"></HeaderStyle>
                </asp:DataGrid>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
