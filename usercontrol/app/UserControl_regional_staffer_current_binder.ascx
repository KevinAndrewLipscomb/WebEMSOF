<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_regional_staffer_current_binder.ascx.cs" Inherits="UserControl_regional_staffer_current_binder.TWebUserControl_regional_staffer_current_binder"%>
<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
      <tr>
        <td>
          <cc1:TabContainer id="TabContainer_control" runat="server" autopostback="True" cssclass="ajax__tab_ki">
            <cc1:TabPanel runat="server" headertext="Snapshot" id="TabPanel_snapshot"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Workflow" id="TabPanel_workflow"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Outcomes" id="TabPanel_outcomes"></cc1:TabPanel>
            <cc1:TabPanel runat="server" headertext="Services" id="TabPanel_services"></cc1:TabPanel>
          </cc1:TabContainer>
        </td>
      </tr>
      <tr>
        <td style="PADDING:8px; BORDER-BOTTOM:thin solid silver; BORDER-LEFT:thin solid silver; BORDER-RIGHT:thin solid silver;">
          <ASP:PlaceHolder id="PlaceHolder_content" runat="server"></ASP:PlaceHolder>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>