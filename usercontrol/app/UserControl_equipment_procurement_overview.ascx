<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_equipment_procurement_overview.pas" Inherits="UserControl_equipment_procurement_overview.TWebUserControl_equipment_procurement_overview"%>
<p><b>
    <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="10" border="0">
                <tr>
                  <td bgcolor="#dcdcdc"><strong>Cycle:&nbsp; <asp:DropDownList id="DropDownList_cycle" runat="server" autopostback="True"></asp:DropDownList>




</strong></td>
                </tr>
                <tr>
                  <td>
<asp:GridView id="GridView_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False">
                      <Columns>
                        <asp:BoundField datafield="description" headertext="Kind of equipment">
                          <HeaderStyle horizontalalign="Left"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="quantity" headertext="Quantity">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="emsof_part" dataformatstring="{0:c}" headertext="EMSOF portion">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="overall_cost" dataformatstring="{0:c}" headertext="Overall cost">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="avg_unit_cost" dataformatstring="{0:c}" headertext="Average unit cost">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                      </Columns>
                      <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
</asp:GridView></td>
                </tr>
            </table></td>
        </tr>
    </table>
</b></p>
