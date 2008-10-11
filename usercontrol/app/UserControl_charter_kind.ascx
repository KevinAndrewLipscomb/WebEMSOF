<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_charter_kind.pas" Inherits="UserControl_charter_kind.TWebUserControl_charter_kind"%>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
        <tr>
          <td bgcolor="gainsboro" valign="top"><font class="compact">Code:</font></td>
          <td valign="top">
            <font class="compact">
              <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                  <td valign="middle">
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
                          <ASP:TextBox id="TextBox_id" runat="server" columns="3" maxlength="3" cssclass="compact"></ASP:TextBox><ASP:Button id="Button_lookup" runat="server" causesvalidation="False" text="LOOKUP"></ASP:Button>
                        </td>
                        <td nowrap="True"><small><small><asp:Label id="Label_lookup_arrow" runat="server">&lt;--</asp:Label></small></small></td>
                        <td><small><small><em><asp:Label id="Label_lookup_hint" runat="server">Lookup by partial or full Charter kind</asp:Label></em></small></small></td>
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
                      <ASP:LinkButton id="LinkButton_new_record" runat="server" causesvalidation="False" visible="False">Enter&nbsp;brand&nbsp;new&nbsp;Charter&nbsp;kind</ASP:LinkButton>
                    </small>
                  </td>
                </tr>
              </table>
              <ASP:DropDownList id="DropDownList_spec" runat="server" visible="False" autopostback="True"></ASP:DropDownList><br>
            </font>
          </td>
          <td valign="top"></td>
        </tr>
        <tr>
          <td><font class="compact">Description:</font></td>
          <td>
            <font class="compact">
              <ASP:TextBox id="TextBox_description" runat="server" columns="72" maxlength="127" cssclass="compact" enabled="False"></ASP:TextBox>
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
<ASP:Button id="Button_submit" text="Submit" runat="server" enabled="False"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False"></ASP:Button>
