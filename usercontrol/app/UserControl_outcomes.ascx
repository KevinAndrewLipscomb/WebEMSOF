<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_outcomes.pas" Inherits="UserControl_outcomes.TWebUserControl_outcomes"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      <ul>
        <li><p><ASP:LinkButton id="LinkButton_completed" runat="server"> request(s) COMPLETED</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_missed_deadlines" runat="server"> request(s) FAILED DEADLINE</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_withdrawn" runat="server"> request(s) WITHDRAWN</ASP:LinkButton></p></li>
        <li><p><ASP:LinkButton id="LinkButton_rejected" runat="server"> request(s) REJECTED</ASP:LinkButton></p></li>
      </ul>
    </td>
  </tr>
</table>
