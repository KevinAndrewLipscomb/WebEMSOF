<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_serial_indicator_equipment_quantities.pas" Inherits="UserControl_serial_indicator_equipment_quantities.TWebUserControl_serial_indicator_equipment_quantities"%>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr>
          <td bgcolor="#f5f5f5"><strong>Equipment:</strong>
            <asp:DropDownList id="DropDownList_equipment" runat="server" autopostback="True"></asp:DropDownList>
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
