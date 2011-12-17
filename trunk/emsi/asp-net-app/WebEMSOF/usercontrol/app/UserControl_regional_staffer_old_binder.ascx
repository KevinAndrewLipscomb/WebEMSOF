<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_regional_staffer_old_binder.ascx.cs" Inherits="UserControl_regional_staffer_old_binder.TWebUserControl_regional_staffer_old_binder"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      Fulfilled
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_deployed" runat="server" onclick="LinkButton_deployed_Click"> projects currently deployed</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_archived" runat="server" onclick="LinkButton_archived_Click"> projects archived</ASP:LinkButton></p></li>
      </ul>
      Unfulfilled
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_failed_deadline" runat="server" onclick="LinkButton_failed_deadline_Click"> requests failed a deadline</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_withdrawn" runat="server" onclick="LinkButton_withdrawn_Click"> requests withdrawn</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_rejected" runat="server" onclick="LinkButton_rejected_Click"> requests rejected</ASP:LinkButton></p></li>
      </ul>
    </td>
  </tr>
</table>

