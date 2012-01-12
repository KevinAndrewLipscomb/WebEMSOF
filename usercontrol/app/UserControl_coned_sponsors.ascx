<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_coned_sponsors.ascx.cs" Inherits="UserControl_coned_sponsors.TWebUserControl_coned_sponsors"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~datagrid~sortable.ascx-template -->
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <p><strong><asp:Label id="Label_num_coned_sponsors" runat="server"></asp:Label>&nbsp;sponsors</strong></p>
    <asp:DataGrid id="DataGrid_control" runat="server" allowsorting="True" autogeneratecolumns="False" cellpadding="10" gridlines="Horizontal">
      <Columns>
        <asp:ButtonColumn commandname="select" text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Profile (tabbed)&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:BoundColumn datafield="id" visible="False">
          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Top" />
        </asp:BoundColumn>
        <asp:BoundColumn datafield="sponsor_number" headertext="#" sortexpression="sponsor_number%">
          <HeaderStyle horizontalalign="Center" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"></HeaderStyle>
          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Top"></ItemStyle>
          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Top" Wrap="False" />
        </asp:BoundColumn>
        <asp:BoundColumn datafield="name" headertext="Name" sortexpression="name%"></asp:BoundColumn>
        <asp:ButtonColumn commandname="imitate" text="&lt;IMG src=&quot;~/protected/image/mask-16-16.png&quot; alt=&quot;Imitate&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;">
          <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" VerticalAlign="Top" />
        </asp:ButtonColumn>
      </Columns>
      <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
    </asp:DataGrid>
  </ContentTemplate>
</asp:UpdatePanel>
