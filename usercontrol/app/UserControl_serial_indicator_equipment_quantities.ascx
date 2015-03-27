<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_serial_indicator_equipment_quantities.ascx.cs" Inherits="UserControl_serial_indicator_equipment_quantities.TWebUserControl_serial_indicator_equipment_quantities"%>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr>
          <td bgcolor="#f5f5f5">
            <table width="100%">
              <tr>
                <td><strong>Equipment:</strong>
                  <asp:DropDownList id="DropDownList_equipment" runat="server" autopostback="True" onselectedindexchanged="DropDownList_equipment_SelectedIndexChanged"></asp:DropDownList>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td nowrap="nowrap" align="right">
                  <b>Width in years:</b>
                  <asp:TextBox ID="TextBox_width_in_years" runat="server" Columns="3" Text="27"></asp:TextBox>
                  <asp:Button ID="Button_go" runat="server" Text="Go" OnClick="Button_go_Click"/>
                  <asp:Button ID="Button_max" runat="server" CausesValidation="False" OnClick="Button_max_Click" Text="Max" UseSubmitBehavior="False" />
                  <asp:Button ID="Button_default" runat="server" CausesValidation="False" OnClick="Button_default_Click" Text="Default" UseSubmitBehavior="False" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator_width_in_years" runat="server" ControlToValidate="TextBox_width_in_years" ErrorMessage="Please specify a Width in years." Font-Bold="True">&lt;ERR!</asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator_width_in_years" runat="server" ControlToValidate="TextBox_width_in_years" ErrorMessage="Please enter numeric values only for Width in years." Font-Bold="True" ValidationExpression="\d+">&lt;ERR!</asp:RegularExpressionValidator>
                  <asp:RangeValidator ID="RangeValidator_width_in_years" runat="server" ControlToValidate="TextBox_width_in_years" ErrorMessage="The Width in years must currently be between 2 and #." Font-Bold="True" MinimumValue="2" MaximumValue="27" Type="Integer">&lt;ERR!</asp:RangeValidator>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <p>This control chart shows the procured quantity of equipment over time.&nbsp; Data points are logged at the <em>end</em> of each fiscal cycle.</p>
            <p><img id="Image_control" runat="server" width="781" height="417" src="~/serial_indicator_control_chart.aspx?indicator=equipment_quantities&amp;description=" /></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
