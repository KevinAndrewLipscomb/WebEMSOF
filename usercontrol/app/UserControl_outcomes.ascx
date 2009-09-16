<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_outcomes.ascx.cs" Inherits="UserControl_outcomes.TWebUserControl_outcomes"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_completed" runat="server" onclick="LinkButton_completed_Click"> request(s) COMPLETED</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_missed_deadlines" runat="server" onclick="LinkButton_missed_deadlines_Click"> request(s) FAILED DEADLINE</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_withdrawn" runat="server" onclick="LinkButton_withdrawn_Click"> request(s) WITHDRAWN</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_rejected" runat="server" onclick="LinkButton_rejected_Click"> request(s) REJECTED</ASP:LinkButton></p></li>
      </ul>
    </td>
  </tr>
</table>
