<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="UserControl_appropriations_available_to_county.ascx.cs" Inherits="UserControl_appropriations_available_to_county.TWebUserControl_appropriations_available_to_county" %>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~std.ascx-template -->
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr><td bgcolor="#f5f5f5"><strong>Available allocations</strong></td></tr>
        <tr>
          <td>
            <p>
              Which allocation do you want to work with?&nbsp;
              <asp:RequiredFieldValidator ID="RequiredFieldValidator_appropriation" runat="server" ErrorMessage="Please choose an allocation." Font-Bold="True" ControlToValidate="RadioButtonList_appropriation">!ERR!</asp:RequiredFieldValidator>
            </p>
            <p>
              <asp:RadioButtonList ID="RadioButtonList_appropriation" runat="server">
              </asp:RadioButtonList>
            </p>
            <p><asp:Button ID="Button_continue" runat="server" Text="Continue" OnClick="Button_continue_Click" Enabled="false"></asp:Button></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
