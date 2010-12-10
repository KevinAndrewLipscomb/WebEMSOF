<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_workflow.ascx.cs" Inherits="UserControl_workflow.TWebUserControl_workflow"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_all" runat="server" font-bold="True" onclick="LinkButton_all_Click">All requests</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_development" runat="server" onclick="LinkButton_num_requests_needing_development_Click"> request(s) need to be started by services</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_finalization" runat="server" onclick="LinkButton_num_requests_needing_finalization_Click"> request(s) need to be finished by services</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_num_requests_needing_county_approval" runat="server" onclick="LinkButton_num_requests_needing_county_approval_Click"> request(s) need County Coordinator approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_regional_compliance" runat="server" onclick="LinkButton_regional_compliance_Click"> request(s) need regional compliance check</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_exec_dir_approval" runat="server" onclick="LinkButton_exec_dir_approval_Click"> request(s) need Executive Director approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_transmittal" runat="server" onclick="LinkButton_transmittal_Click"> request(s) need transmittal to PA DOH EMSO</ASP:LinkButton>&nbsp;&nbsp;<b>|</b>&nbsp;&nbsp;<i><asp:LinkButton 
            ID="LinkButton_transmittal_adjustments" runat="server" onclick="LinkButton_transmittal_adjustments_Click">or maybe not</asp:LinkButton></i></p></li>
        <li><p><ASP:LinkButton id="LinkButton_state_approval" runat="server" onclick="LinkButton_state_approval_Click"> request(s) need PA DOH EMSO approval</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_invoice_collection" runat="server" onclick="LinkButton_invoice_collection_Click"> request(s) need invoice collection</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_canceled_check_collection" runat="server" onclick="LinkButton_canceled_check_collection_Click"> request(s) need canceled check collection</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_reimbursement" runat="server" onclick="LinkButton_reimbursement_Click"> request(s) need reimbursement issuance</ASP:LinkButton></p></li>
      </ul>
    </td>
  </tr>
</table>

