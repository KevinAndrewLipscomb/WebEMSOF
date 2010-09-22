<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!-- Derived from KiAspdotnetFramework/protected/template~protected~nonlanding.aspx~template -->
<%@ Page language="c#" Debug="true" Codebehind="county_detail.aspx.cs" AutoEventWireup="True" Inherits="county_detail.TWebForm_county_detail" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc3" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <!-- $Id: template-protected-nonlanding.aspx-template 3003 2009-11-23 17:50:10Z KevinAnLipscomb $ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <table border="1" bordercolor="Gainsboro" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <table border="0" cellpadding="5" cellspacing="0" width="100%">
              <tr><td bgcolor="Whitesmoke" width="100%"><h3>Detail for <asp:Literal ID="Literal_county_name" runat="server"></asp:Literal>&nbsp;County</h3></td></tr>
              <tr>
                <td>
                  <table cellpadding="10" cellspacing="0">
                    <tr>
                      <td>
                        EMSOF Coordinator email address:</td>
                      <td>
                        <asp:TextBox ID="TextBox_email_address" runat="server" Columns="60"></asp:TextBox>
                      </td>
                      <td nowrap="nowrap">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_email_address" runat="server" ControlToValidate="TextBox_email_address" Display="Dynamic" ErrorMessage="Please enter an EMSOF Coordinator email address" Font-Bold="True">!ERR!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator_email_address" runat="server" ControlToValidate="TextBox_email_address" Display="Dynamic" ErrorMessage="Please enter a valid EMSOF Coordinator email address" Font-Bold="True" 
                          ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator_email_address" runat="server" Display="Dynamic" ErrorMessage="Please enter an EMSOF Coordinator email address with a valid domain name (the part after the &quot;@&quot;)" Font-Bold="True" 
                          onservervalidate="CustomValidator_email_address_ServerValidate">!ERR!</asp:CustomValidator>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        Default match level:</td>
                      <td>
                        <asp:DropDownList ID="DropDownList_default_match_level" runat="server">
                        </asp:DropDownList>
                      </td>
                      <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_default_match_level" runat="server" ControlToValidate="DropDownList_default_match_level" Display="Dynamic" ErrorMessage="Please select a Default match level" Font-Bold="True">!ERR!</asp:RequiredFieldValidator>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        &nbsp;</td>
                      <td>
                        <asp:Button ID="Button_submit" runat="server" Text="Submit" onclick="Button_submit_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button_cancel" runat="server" CausesValidation="False" Text="Cancel" onclick="Button_cancel_Click" />
                      </td>
                      <td>
                        &nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc3:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc3:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
