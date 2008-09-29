<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_financial_snapshot.pas" Inherits="UserControl_financial_snapshot.TWebUserControl_financial_snapshot"%>
<table cellspacing="0" cellpadding="20" border="0">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="5" border="0" align="left">
        <tr>
          <td align="right"><ASP:Label id="Label_parent_appropriation" runat="server"></ASP:Label></td>
          <td>allocated to region</td>
        </tr>
        <tr>
          <td align="right"><ASP:Label id="Label_sum_of_appropriations" runat="server"></ASP:Label></td>
          <td>allocated to counties</td>
        </tr>
        <tr>
          <td align="right"><ASP:Label id="Label_appropriated_to_services" runat="server"></ASP:Label></td>
          <td>allocated to services</td>
        </tr>
        <tr>
          <td align="right"><ASP:Label id="Label_requested_by_services" runat="server"></ASP:Label></td>
          <td>requested by services</td>
        </tr>
        <tr>
          <td align="right"><ASP:Label id="Label_actually_spent" runat="server"></ASP:Label></td>
          <td>actually spent</td>
        </tr>
        <tr>
          <td align="right"><ASP:Label id="Label_remaining" runat="server" font-bold="True"></ASP:Label></td>
          <td><strong>remaining</strong></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

