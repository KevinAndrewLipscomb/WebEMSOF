<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_values_to_region.ascx.cs" Inherits="UserControl_values_to_region.TWebUserControl_values_to_region"%>
<asp:GridView id="GridView_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available"><Columns>
    <asp:BoundField datafield="fiscal_year" headertext="Cycle" sortexpression="fiscal_year%">
      <HeaderStyle horizontalalign="Left"></HeaderStyle>
    </asp:BoundField>
    <asp:BoundField datafield="emsof" dataformatstring="{0:c}" headertext="EMSOF contribution to region-wide project(s)" htmlencode="False" sortexpression="emsof%">
      <ItemStyle horizontalalign="Right"></ItemStyle>
    </asp:BoundField>
  </Columns>
  <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
</asp:GridView>
