<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_region_dictated_appropriations.ascx.cs" Inherits="UserControl_region_dictated_appropriations.TWebUserControl_region_dictated_appropriations"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~datagrid~sortable.ascx-template -->
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
      <tr>
        <td>
          <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td>
                <asp:DataGrid id="DataGrid_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True">
                  <Columns>
                    <asp:ButtonColumn text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Detail&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" commandname="Select"></asp:ButtonColumn>
                    <asp:BoundColumn datafield="id" HeaderText="RDA#" ReadOnly="True" SortExpression="id%">
                      <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                      <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Right" />
                    </asp:BoundColumn>
                    <asp:BoundColumn datafield="code" Visible="False"></asp:BoundColumn>
                    <asp:BoundColumn datafield="email_address" Visible="False"></asp:BoundColumn>
                    <asp:BoundColumn datafield="name" headertext="Name" sortexpression="name%"></asp:BoundColumn>
                    <asp:BoundColumn DataField="amount" DataFormatString="{0:C}" HeaderText="Allocation" SortExpression="amount%">
                      <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundColumn>
                    <asp:BoundColumn DataField="deadline" HeaderText="Service submission deadline" SortExpression="deadline%">
                      <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundColumn>
                    <asp:BoundColumn DataField="match_level_description" HeaderText="Default match level" SortExpression="factor%,name"></asp:BoundColumn>
                  </Columns>
                  <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                </asp:DataGrid>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <p>&nbsp;</p>
    <table id="Table_quick_message" runat="server" bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
      <tr>
        <td>
          <table cellspacing="0" cellpadding="10" width="100%" border="0">
            <tr><td bgcolor="#f5f5f5"><a id="QuickMessage"><strong>QuickMessage</strong></a></td></tr>
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" width="100%" border="0">
                  <tr>
                    <td>Send email to:</td>
                    <td>EMSOF Coordinators with above allocations</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Bcc:</td>
                    <td><ASP:Label id="Label_author_email_address" runat="server"></ASP:Label></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Subject:</td>
                    <td><ASP:TextBox id="TextBox_quick_message_subject" runat="server" maxlength="255" columns="72"></ASP:TextBox></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td valign="top">Body:</td>
                    <td><ASP:TextBox id="TextBox_quick_message_body" runat="server" columns="72" rows="18" textmode="MultiLine"></ASP:TextBox></td>
                    <td nowrap="true" valign="top"><ASP:RequiredFieldValidator id="RequiredFieldValidator_quick_message_body" runat="server" errormessage="Please enter a message body." font-bold="True" controltovalidate="TextBox_quick_message_body" validationgroup="quick_message">!ERR!</ASP:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><ASP:Button id="Button_send" runat="server" text="Send" validationgroup="quick_message" onclick="Button_send_Click"></ASP:Button></td>
                    <td></td>
                  </tr>
                  <tr><td valign="top"><small><font color="#c0c0c0">Resolves to:</small></font></td><td valign="top"><small><ASP:Label id="Label_distribution_list" runat="server" forecolor="Silver"></ASP:Label></small></td>
                    <td></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
