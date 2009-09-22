<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_equipment_procurement_overview.ascx.cs" Inherits="UserControl_equipment_procurement_overview.TWebUserControl_equipment_procurement_overview"%>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
      <tr>
        <td>
          <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td bgcolor="#dcdcdc"><strong>Cycle:&nbsp;<asp:DropDownList id="DropDownList_cycle" runat="server" autopostback="True" onselectedindexchanged="DropDownList_cycle_SelectedIndexChanged"></asp:DropDownList></strong></td>
            </tr>
            <tr>
              <td>
                <asp:DataGrid id="DataGrid_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available">
                  <Columns>
                    <asp:ButtonColumn text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Detail&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" commandname="Select"></asp:ButtonColumn>
                    <asp:BoundColumn datafield="code"></asp:BoundColumn>
                    <asp:BoundColumn datafield="description" headertext="Kind of equipment" sortexpression="description%">
                      <HeaderStyle horizontalalign="Left"></HeaderStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="quantity" headertext="Quantity" sortexpression="quantity%">
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="emsof_part" dataformatstring="{0:C}" headertext="EMSOF portion" sortexpression="emsof_part%">
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="overall_cost" dataformatstring="{0:C}" headertext="Overall cost" sortexpression="overall_cost%">
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="avg_unit_cost" dataformatstring="{0:C}" headertext="Average unit cost" sortexpression="avg_unit_cost%">
                      <ItemStyle horizontalalign="Right"></ItemStyle>
                    </asp:BoundColumn>
                  </Columns>
                  <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                </asp:DataGrid>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
