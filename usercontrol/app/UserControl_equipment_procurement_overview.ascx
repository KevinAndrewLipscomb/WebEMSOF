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
<asp:GridView id="GridView_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available">
                      <Columns>
                        <asp:CommandField selecttext="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Detail&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" showselectbutton="True"></asp:CommandField>
                        <asp:BoundField datafield="code"></asp:BoundField>
                        <asp:BoundField datafield="description" headertext="Kind of equipment" sortexpression="description%">
                          <HeaderStyle horizontalalign="Left"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="quantity" headertext="Quantity" sortexpression="quantity%">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="emsof_part" dataformatstring="{0:c}" headertext="EMSOF portion" sortexpression="emsof_part%">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="overall_cost" dataformatstring="{0:c}" headertext="Overall cost" sortexpression="overall_cost%">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField datafield="avg_unit_cost" dataformatstring="{0:c}" headertext="Average unit cost" sortexpression="avg_unit_cost%">
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
