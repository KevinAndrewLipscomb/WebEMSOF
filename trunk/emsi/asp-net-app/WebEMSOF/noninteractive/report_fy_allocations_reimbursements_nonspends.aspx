<%@ Page language="c#" Debug="true" Codebehind="report_fy_allocations_reimbursements_nonspends.aspx.cs" AutoEventWireup="True" Inherits="report_fy_allocations_reimbursements_nonspends.TWebForm_report_fy_allocations_reimbursements_nonspends" EnableViewState="false" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_common_header_bar" Src="~/usercontrol/app/UserControl_common_header_bar.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <asp:ScriptManager id="ScriptManager_control" runat="server"></asp:ScriptManager>
      <uc1:UserControl_common_header_bar id="UserControl_common_header_bar" runat="server"></uc1:UserControl_common_header_bar>
      <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" width="100%">
          <tr>
            <td>
              <table cellspacing="0" cellpadding="10" width="100%" border="0">
                <tr><td bgcolor="#f5f5f5"><strong>Allocations-Reimbursements-Nonspends</strong></td></tr>
                <tr>
                  <td>
                    <small>
                      <p>Best practices:</p>
                      <ul>
                        <li>
                          <p>Visit the <asp:label id="Label_application_name_1" runat="server"></asp:label>&nbsp;website to use
                            additional features, such as sorting and prior cycle selection:</p>
                          <blockquote>
                            <ASP:HyperLink id="HyperLink_web_site" runat="server" font-bold="True"></ASP:HyperLink>
                          </blockquote>
                        </li>
                      </ul>
                    </small>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </p>
      <ASP:PlaceHolder id="PlaceHolder_control" runat="server"></ASP:PlaceHolder>
    </form>
  </body>
</html>
