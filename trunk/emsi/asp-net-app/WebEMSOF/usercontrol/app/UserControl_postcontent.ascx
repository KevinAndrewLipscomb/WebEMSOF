<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="UserControl_postcontent.ascx.cs" Inherits="UserControl_postcontent.TWebUserControl_postcontent" %>
</td></tr></table>
<p></p>
<table>
  <tr>
    <td>
      <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td>
            <table cellspacing="0" cellpadding="5" border="0">
              <tr>
                <td id="Td_reference_material" runat="server" style="border-left:2px dashed sandybrown; border-top:2px dashed sandybrown;" valign="top">
                  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                      <td>
                        <table cellspacing="0" cellpadding="5" border="0">
                          <tr><td><small><strong><a name="ReferenceMaterial"></a>Reference material</strong></small></td></tr>
                          <tr>
                            <td>
                              <small><small>These links open in a new window.</small></small>
                              <table cellspacing="0" cellpadding="5" border="0">
                                <tr>
                                  <td valign="top">&bull;</td>
                                  <td><small><a href="http://www.emsi.org/" target="_blank">EMSI</a></small></td>
                                </tr>
                                <tr>
                                  <td valign="top">&bull;</td>
                                  <td><small><a runat="server" href="~/resource/funding-priorities-epel.pdf" target="_blank">Funding Priorities and Eligible Provider Equipment List</a></small></td>
                                </tr>
                                <tr>
                                  <td valign="top">&bull;</td>
                                  <td><small><a runat="server" href="~/resource/terms-and-conditions.pdf" target="_blank">Terms and Conditions</a></small></td>
                                </tr>
                                <tr>
                                  <td valign="top">&bull;</td>
                                  <td><small><a runat="server" href="~/resource/Email Whitelist Generator Instructions.htm" target="_blank">Receiving email notifications</a></small></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
                <td>&nbsp;</td>
                <td id="Td_process_improvement" runat="server" style="border-left:2px dashed sandybrown; border-top:2px dashed sandybrown;" valign="top">
                  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                      <td>
                        <table cellspacing="0" cellpadding="5" border="0">
                          <tr><td><small><strong><a name="ProcessImprovement"></a>Process improvement</strong></small></td></tr>
                          <tr><td><small>You can help us make this application better!</small></td></tr>
                          <tr><td><small>Send suggestions <a href="mailto:feedback@frompaper2web.com?subject=WebEMSOF%20suggestion">here</a>.</small></td></tr>
                          <tr id="TableRow_bounty_program" runat="server" visible="false">
                            <td><small><asp:HyperLink ID="HyperLink_bounty_program" runat="server" NavigateUrl="~/protected/bounty_program.aspx" Target="_blank">Make money as a bounty hunter.</asp:HyperLink></small></td>
                          </tr>
                          <tr><td><small><strong>Thanks!</strong></small></td></tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <ajaxToolkit:DropShadowExtender ID="DropShadowExtender_reference_material" runat="server" TargetControlID="Td_reference_material" />
            <ajaxToolkit:DropShadowExtender ID="DropShadowExtender_process_improvement" runat="server" TargetControlID="Td_process_improvement" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
