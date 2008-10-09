<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_match_level.pas" Inherits="UserControl_match_level.TWebUserControl_match_level"%>
<%@ Register TagPrefix="uc1" TagName="UserControl_drop_down_date" Src="~/usercontrol/ki/UserControl_drop_down_date.ascx" %>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
  <tr>
    <td bgcolor="gainsboro" valign="top">Name:</td>
    <td valign="top">
              <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                  <td valign="middle">
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
      <ASP:TextBox id="TextBox_name" runat="server" columns="31" maxlength="31"></ASP:TextBox><ASP:Button id="Button_lookup" runat="server" causesvalidation="False" text="LOOKUP"></ASP:Button>
                        </td>
                        <td nowrap="True"><small><small><asp:Label id="Label_lookup_arrow" runat="server">&lt;--</asp:Label></small></small></td>
                        <td><small><small><em><asp:Label id="Label_lookup_hint" runat="server">Lookup by partial or full Match level name</asp:Label></em></small></small></td>
                      </tr>
                    </table>
                  </td>
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td valign="middle">
                    <small>
                      <ASP:LinkButton id="LinkButton_reset" runat="server" causesvalidation="False" enabled="False">New lookup</ASP:LinkButton>
                    </small>
                  </td>
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td valign="middle">
                    <small>
                      <ASP:LinkButton id="LinkButton_new_record" runat="server" causesvalidation="False" visible="False">Enter&nbsp;brand&nbsp;new&nbsp;record</ASP:LinkButton>
                    </small>
                  </td>
                </tr>
              </table>
      <ASP:DropDownList id="DropDownList_name" runat="server" visible="False" autopostback="True"></ASP:DropDownList><br>
    </td>
    <td valign="top">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_name" runat="server" errormessage="Please enter Name." font-bold="True" controltovalidate="TextBox_name">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td>Factor:</td>
    <td>
      <ASP:TextBox id="TextBox_factor" runat="server" enabled="False"></ASP:TextBox>
    </td>
    <td>
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_factor" runat="server" errormessage="Please enter Factor." font-bold="True" controltovalidate="TextBox_factor">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_factor" runat="server" errormessage="Please enter a valid Factor." font-bold="True" controltovalidate="TextBox_factor" validationexpression="(\d*\.?\d*)|(-(\d+\.?\d*)|(\.\d*))">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
      </table>
    </td>
  </tr>
</table>
<ASP:Button id="Button_submit" text="Submit" runat="server" enabled="False"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False"></ASP:Button>

