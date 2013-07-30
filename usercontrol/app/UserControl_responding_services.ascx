<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_responding_services.ascx.cs" Inherits="UserControl_responding_services.TWebUserControl_responding_services"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~datagrid~sortable.ascx-template -->
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <asp:ValidationSummary ID="ValidationSummary_quick_message" runat="server" ValidationGroup="QuickMessage"/>
    <p>&nbsp;</p>
    <p>
      <small>
        <strong><asp:Label id="Label_num_services" runat="server"></asp:Label>&nbsp;services:</strong>&nbsp;
        <asp:Label ID="Label_num_respondents" runat="server"></asp:Label>&nbsp;surveys submitted,
        <asp:Label id="Label_num_participants" runat="server"></asp:Label>&nbsp;planning to participate in EMSOF,
        <asp:Label id="Label_num_nonparticipants" runat="server"></asp:Label>&nbsp;not
      </small>
    </p>
    <asp:DataGrid id="DataGrid_control" runat="server" allowsorting="True" autogeneratecolumns="False" cellpadding="10" gridlines="Horizontal">
      <Columns>
        <asp:ButtonColumn commandname="update-email-address" text="&lt;IMG src=&quot;~/protected/image/address-book--pencil--16-16.png&quot; alt=&quot;Imitate&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:ButtonColumn commandname="profile-tabbed" text="&lt;IMG src=&quot;~/protected/image/open_document16_h.png&quot; alt=&quot;Profile (tabbed)&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:ButtonColumn commandname="profile-printable" text="&lt;IMG src=&quot;~/protected/image/print16_h.png&quot; alt=&quot;Profile (printable)&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:ButtonColumn CommandName="imitate" Text="&lt;IMG src=&quot;~/protected/image/mask-16-16.png&quot; alt=&quot;Imitate&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;"></asp:ButtonColumn>
        <asp:BoundColumn datafield="affiliate_num" visible="False"></asp:BoundColumn>
        <asp:TemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <HeaderTemplate>
            <asp:CheckBox ID="CheckBox_force_all" runat="server" AutoPostBack="True" oncheckedchanged="CheckBox_force_all_CheckedChanged" style="outline:2px solid SlateGray" ToolTip="Select/Unselect all for QuickMessage" Checked="True" />
          </HeaderTemplate>
          <ItemTemplate>
            <asp:CheckBox ID="CheckBox_selected" runat="server" Checked="True" AutoPostBack="True" oncheckedchanged="CheckBox_selected_CheckedChanged" ToolTip="Select/Unselect for QuickMessage" />
          </ItemTemplate>
          <HeaderStyle HorizontalAlign="Center" />
          <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateColumn>
        <asp:BoundColumn datafield="service_name" headertext="Name" sortexpression="service_name%"></asp:BoundColumn>
        <asp:BoundColumn datafield="county_name" headertext="County" sortexpression="county_name%,service_name">
          <HeaderStyle horizontalalign="Center"></HeaderStyle>
          <ItemStyle horizontalalign="Center"></ItemStyle>
        </asp:BoundColumn>
        <asp:BoundColumn datafield="be_emsof_participant" headertext="EMSOF participant" sortexpression="participation_pecking_order%,service_name">
          <HeaderStyle horizontalalign="Center"></HeaderStyle>
          <ItemStyle horizontalalign="Center"></ItemStyle>
        </asp:BoundColumn>
        <asp:BoundColumn DataField="password_reset_email_address" ReadOnly="True" Visible="False"></asp:BoundColumn>
        <asp:BoundColumn DataField="corpadmin_email_address" ReadOnly="True" Visible="False"></asp:BoundColumn>
        <asp:BoundColumn DataField="coo_email_address" ReadOnly="True" Visible="False"></asp:BoundColumn>
      </Columns>
      <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
    </asp:DataGrid>
    <br />
    <table cellspacing="0" cellpadding="0" style="border:1px solid Gainsboro">
      <tr>
	      <td>
	        <table cellspacing="0" cellpadding="10" border="0">
		        <tr><td bgcolor="#f5f5f5"><a id="QuickMessage"><strong>QuickMessage</strong></a></td></tr>
		        <tr>
			        <td>
                <p>
                  Send email to the services selected (<asp:CheckBox ID="CheckBox_item_sample" runat="server" Checked="True" Enabled="false" />) above.
                  <br />
                  <small><i>Use <asp:CheckBox ID="CheckBox_header_sample" runat="server" Checked="True" style="outline:2px solid SlateGray" Enabled="false" /> in header row to select or unselect all attendees at once.</i></small>
                </p>
			          <table cellspacing="0" cellpadding="10" width="100%" border="0">
                  <tr>
                    <td valign="top">To:</td>
                    <td>
                      <asp:CheckBox ID="CheckBox_use_password_reset_email_address" runat="server" Checked="true" Text="EMSOF contact(s)" AutoPostBack="True" oncheckedchanged="CheckBox_selected_CheckedChanged" />
                      <br />
                      <asp:CheckBox ID="CheckBox_use_corpadmin_email_address" runat="server" Checked="false" Text="Corporate/admin contact(s)" AutoPostBack="True" oncheckedchanged="CheckBox_selected_CheckedChanged" />
                      <br />
                      <asp:CheckBox ID="CheckBox_use_coo_email_address" runat="server" Checked="false" Text="Ops contact(s)" AutoPostBack="True" oncheckedchanged="CheckBox_selected_CheckedChanged" />
                    </td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Bcc:</td>
                    <td><ASP:Literal id="Literal_author_email_address" runat="server"></ASP:Literal></td>
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
					          <td nowrap="nowrap" valign="top">
                      <ASP:RequiredFieldValidator id="RequiredFieldValidator_quick_message_body" runat="server" errormessage="Please enter a message body." font-bold="True" controltovalidate="TextBox_quick_message_body" ValidationGroup="QuickMessage">!ERR!</ASP:RequiredFieldValidator>
                    </td>
				          </tr>
				          <tr>
					          <td></td>
					          <td><ASP:Button id="Button_send" runat="server" text="Send" onclick="Button_send_Click" ValidationGroup="QuickMessage"></ASP:Button></td>
					          <td></td>
				          </tr>
				          <tr>
                    <td valign="top"><small><font color="#c0c0c0">Resolves to:</small></font></td>
                    <td valign="top"><small><ASP:Label id="Label_distribution_list" runat="server" forecolor="Silver" EnableViewState="false"></ASP:Label></small></td>
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
