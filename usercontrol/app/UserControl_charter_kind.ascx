<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_charter_kind.pas" Inherits="UserControl_charter_kind.TWebUserControl_charter_kind"%>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
        <tr>
          <td valign="top"><font class="compact">Code:</font></td>
          <td valign="top">
            <font class="compact">
              <small><i>Leave empty to save a new charter_kind.</i></small><br>
              <ASP:TextBox id="TextBox_id" runat="server" columns="3" maxlength="3" cssclass="compact"></ASP:TextBox>&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_search" runat="server" causesvalidation="False">Lookup</ASP:LinkButton>&nbsp;&nbsp;&nbsp; <ASP:LinkButton id="LinkButton_reset" runat="server" causesvalidation="False">Reset</ASP:LinkButton><br>
              <ASP:DropDownList id="DropDownList_spec" runat="server" visible="False" autopostback="True"></ASP:DropDownList><br>
            </font>
          </td>
          <td valign="top">
            <asp:RegularExpressionValidator id="RegularExpressionValidator_code" runat="server" errormessage="Please enter a valid Code." font-bold="True" display="Dynamic" controltovalidate="TextBox_id" validationexpression="\d+">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td><font class="compact">Description:</font></td>
          <td>
            <font class="compact">
              <ASP:TextBox id="TextBox_description" runat="server" columns="72" maxlength="127" cssclass="compact"></ASP:TextBox>
            </font>
          </td>
          <td>
            <ASP:RequiredFieldValidator id="RequiredFieldValidator_description" runat="server" errormessage="Please enter Description." font-bold="True" controltovalidate="TextBox_description" display="Dynamic">!ERR!</ASP:RequiredFieldValidator>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<ASP:Button id="Button_submit" text="Submit" runat="server"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False"></ASP:Button>&nbsp;
