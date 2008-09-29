<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_workflow.pas" Inherits="UserControl_workflow.TWebUserControl_workflow"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_all" runat="server" font-bold="True">All requests</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_development" runat="server"> request(s) need to be started by services</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_finalization" runat="server"> request(s) need to be finished by services</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_county_approval" runat="server"> request(s) need County Coordinator approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_regional_compliance" runat="server"> request(s) need regional compliance check</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_exec_dir_approval" runat="server"> request(s) need Executive Director approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_transmittal" runat="server"> request(s) need transmittal to PA DOH EMSO</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_state_approval" runat="server"> request(s) need PA DOH EMSO approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_invoice_collection" runat="server"> request(s) need invoice collection</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_canceled_check_collection" runat="server"> request(s) need canceled check collection</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_reimbursement" runat="server"> request(s) need reimbursement issuance</ASP:LinkButton></p></li>
      </ul>
    </td>
  </tr>
</table>

