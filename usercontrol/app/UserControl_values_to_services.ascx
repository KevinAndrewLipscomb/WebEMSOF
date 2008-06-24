<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_values_to_services.pas" Inherits="UserControl_values_to_services.TWebUserControl_values_to_services"%>
<asp:GridView id="GridView_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available"><Columns>
    <asp:BoundField datafield="fiscal_year" headertext="Cycle" sortexpression="fiscal_year%">
      <HeaderStyle horizontalalign="Left"></HeaderStyle>
    </asp:BoundField>
    <asp:BoundField datafield="emsof" dataformatstring="{0:c}" headertext="EMSOF contributions" htmlencode="False" sortexpression="emsof%">
      <ItemStyle horizontalalign="Right"></ItemStyle>
    </asp:BoundField>
    <asp:BoundField datafield="service_contributions" dataformatstring="{0:c}" headertext="Service contributions" htmlencode="False" sortexpression="service_contributions%">
      <ItemStyle horizontalalign="Right"></ItemStyle>
    </asp:BoundField>
    <asp:BoundField datafield="costs" dataformatstring="{0:c}" headertext="Total" htmlencode="False" sortexpression="costs%">
      <ItemStyle horizontalalign="Right" font-bold="True"></ItemStyle>
    </asp:BoundField>
  </Columns>
  <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
</asp:GridView>
