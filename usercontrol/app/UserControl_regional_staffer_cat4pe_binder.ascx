<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_regional_staffer_cat4pe_binder.ascx.cs" Inherits="UserControl_regional_staffer_cat4pe_binder.TWebUserControl_regional_staffer_cat4pe_binder"%>
<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
      <tr>
        <td>
          <cc1:TabContainer id="TabContainer_control" runat="server" autopostback="True" cssclass="ajax__tab_ki" CssTheme="None">
            <cc1:TabPanel runat="server" headertext="New" id="TabPanel_new" enabled="False"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Current" id="TabPanel_current"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Old" id="TabPanel_old"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Analyses" id="TabPanel_analyses"></cc1:TabPanel>
          </cc1:TabContainer>
        </td>
      </tr>
      <tr>
        <td class="ki_tab_body">
          <ASP:PlaceHolder id="PlaceHolder_content" runat="server"></ASP:PlaceHolder>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>