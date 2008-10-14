<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_responding_services.pas" Inherits="UserControl_responding_services.TWebUserControl_responding_services"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~datagrid~sortable.ascx-template -->
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <p>&nbsp;</p>
    <p>
      <small>
        <strong><asp:Label id="Label_num_respondents" runat="server"></asp:Label>&nbsp;services:</strong>&nbsp;
        <asp:Label id="Label_num_participants" runat="server"></asp:Label>&nbsp;planning to participate in EMSOF,
        <asp:Label id="Label_num_nonparticipants" runat="server"></asp:Label>&nbsp;not
      </small>
    </p>
    <asp:DataGrid id="DataGrid_control" runat="server" allowsorting="True" autogeneratecolumns="False" cellpadding="10" gridlines="Horizontal">
      <Columns>
        <asp:ButtonColumn commandname="Select" text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Detail&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:BoundColumn datafield="affiliate_num" visible="False"></asp:BoundColumn>
        <asp:BoundColumn datafield="service_name" headertext="Name" sortexpression="service_name%"></asp:BoundColumn>
        <asp:BoundColumn datafield="county_name" headertext="County" sortexpression="county_name%,service_name">
          <HeaderStyle horizontalalign="Center"></HeaderStyle>
          <ItemStyle horizontalalign="Center"></ItemStyle>
        </asp:BoundColumn>
        <asp:BoundColumn datafield="be_emsof_participant" headertext="EMSOF participant" sortexpression="be_emsof_participant%,service_name">
          <HeaderStyle horizontalalign="Center"></HeaderStyle>
          <ItemStyle horizontalalign="Center"></ItemStyle>
        </asp:BoundColumn>
      </Columns>
      <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
    </asp:DataGrid>
  </ContentTemplate>
</asp:UpdatePanel>
