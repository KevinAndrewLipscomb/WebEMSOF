<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_annual_cycle_setup.pas" Inherits="UserControl_annual_cycle_setup.TWebUserControl_annual_cycle_setup"%>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table cellspacing="0" cellpadding="20" border="0">
      <tr>
        <td>
          <p>This form will only be enabled when the most recent End Of Cycle Milestone (currently set at
            <asp:Label id="Label_end_of_cycle_milestone" runat="server"></asp:Label>) has passed.
          </p>
          <asp:Panel id="Panel_control" runat="server" enabled="False">
            <TABLE cellspacing="0" cellpadding="10" border="0">
              <tr>
                <td>Cycle:</td>
                <td><asp:Label id="Label_fy_designator" runat="server"></asp:Label></td>
                <td></td>
              </tr>
              <tr>
                <td valign="top">Allocation from state to region:</td>
                <td valign="top" nowrap>
                  <asp:textbox id="TextBox_noop_ie_behavior_workaround" runat="server" style="DISPLAY: none; VISIBILITY: hidden" /><!-- To work around an IE bug that otherwise prevents Enter in a textbox from submitting a form. -->
                  $<asp:TextBox id="TextBox_state_dictated_appropriation" runat="server"></asp:TextBox>
                </td>
                <td valign="top" nowrap>
                  <asp:RequiredFieldValidator id="RequiredFieldValidator_state_dictated_appropriation" runat="server" controltovalidate="TextBox_state_dictated_appropriation" font-bold="True" errormessage="Please enter an Amount.">!ERR!</asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator id="RegularExpressionValidator_state_dictated_appropriation" runat="server" controltovalidate="TextBox_state_dictated_appropriation" font-bold="True" errormessage="Please enter a valid Amount." validationexpression="[$0\.]*[1-9][0-9,\.]*">!ERR!</asp:RegularExpressionValidator>
                </td>
              </tr>
              <tr>
                <td></td>
                <td><asp:Button id="Button_submit" runat="server" text="Submit"></asp:Button></td>
                <td></td>
              </tr>
            </TABLE>
          </asp:Panel>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
