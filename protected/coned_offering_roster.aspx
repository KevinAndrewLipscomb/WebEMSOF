<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!-- Derived from KiAspdotnetFramework/protected/template~protected~nonlanding.aspx~template -->
<%@ Page language="c#" Debug="true" Codebehind="coned_offering_roster.aspx.cs" AutoEventWireup="True" Inherits="coned_offering_roster.TWebForm_coned_offering_roster" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc3" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <title></title>
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body id="Body_control" runat="server" bgcolor="white">
    <form runat="server" defaultfocus="TextBox_practitioner">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td>
              <table cellpadding="3" cellspacing="0" style="font-size:85%">
                <tr>
                  <td nowrap="nowrap" bgcolor="Gainsboro">
                    <asp:UpdatePanel ID="UpdatePanel_search_upper" runat="server" UpdateMode="Conditional">
                      <ContentTemplate>
                        <asp:HiddenField ID="HiddenField_practitioner_saved" runat="server" />
                        <b>Search></b>&nbsp;<asp:TextBox ID="TextBox_practitioner" runat="server" OnTextChanged="TextBox_practitioner_TextChanged" autocomplete="off"></asp:TextBox>
                        <asp:Button ID="Button_add" runat="server" Text="" style="display:none; visibility:hidden" CausesValidation="False" OnClick="Button_add_Click"/>
                        <br />
                        <small><i><asp:Literal ID="Literal_click_to_add" runat="server"></asp:Literal></i></small>
                      </ContentTemplate>
                      <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ListBox_practitioner" EventName="SelectedIndexChanged" />
                      </Triggers>
                    </asp:UpdatePanel>
                  </td>
                </tr>
                <tr>
                  <td valign="top" bgcolor="Gainsboro">
                    <asp:UpdatePanel ID="UpdatePanel_search_lower" runat="server" UpdateMode="Conditional">
                      <ContentTemplate>
                        <asp:ListBox ID="ListBox_practitioner" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ListBox_practitioner_SelectedIndexChanged" Rows="36" Width="100%"></asp:ListBox>
                      </ContentTemplate>
                      <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="TextBox_practitioner" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="Button_add" EventName="Click" />
                      </Triggers>
                    </asp:UpdatePanel>
                  </td>
                </tr>
              </table>
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td valign="top">
              <table cellpadding="0" cellspacing="0">
                <tr>
                  <td>
                    <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gainsboro; border-width:1px">
                      <tr>
                        <td>
                          <table cellpadding="5" cellspacing="0">
                            <tr><td colspan="5"><b><asp:Literal ID="Literal_course_title" runat="server"></asp:Literal></b></td></tr>
                            <tr>
                              <td nowrap="nowrap" valign="top"><b>Start:</b></td>
                              <td nowrap="nowrap" valign="top"><asp:Literal ID="Literal_start" runat="server"></asp:Literal></td>
                              <td>&nbsp;</td>
                              <td nowrap="nowrap" valign="top"><b>Approved:</b></td>
                              <td nowrap="nowrap" valign="top"><asp:Literal ID="Literal_be_approved" runat="server"></asp:Literal></td>
                              <td>&nbsp;</td>
                              <td nowrap="nowrap" valign="top"><b>Class #:</b></td>
                              <td nowrap="nowrap" valign="top"><asp:Literal ID="Literal_class_number" runat="server"></asp:Literal></td>
                            </tr>
                            <tr>
                              <td nowrap="nowrap" valign="top"><b>End:</b></td>
                              <td nowrap="nowrap" valign="top"><asp:Literal ID="Literal_end" runat="server"></asp:Literal></td>
                              <td>&nbsp;</td>
                              <td nowrap="nowrap" valign="top"><b>Hours:</b></td>
                              <td nowrap="nowrap" valign="top"><asp:Literal ID="Literal_total_class_hours" runat="server"></asp:Literal></td>
                            </tr>
                            <tr>
                              <td nowrap="nowrap" valign="top"><b>Location:</b></td>
                              <td colspan="7" valign="top"><asp:Literal ID="Literal_location" runat="server"></asp:Literal></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                  <td>
                    <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gainsboro; border-width:1px">
                      <tr>
                        <td>
                          <asp:UpdatePanel ID="UpdatePanel_attendees" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                              <table cellpadding="10" cellspacing="0">
                                <tr><td style="background-color:WhiteSmoke"><b>Attendees</b></td></tr>
                                <tr id="TableRow_none" runat="server"><td><em>--&nbsp;NONE&nbsp;--</em></td></tr>
                                <tr id="TableRow_attendees" runat="server">
                                  <td valign="top">
                                    <asp:DataGrid id="DataGrid_control" runat="server" gridlines="Horizontal" cellpadding="5" autogeneratecolumns="False" allowsorting="True" onsortcommand="DataGrid_control_SortCommand" onitemdatabound="DataGrid_control_ItemDataBound" oncancelcommand="DataGrid_control_CancelCommand" ondeletecommand="DataGrid_control_DeleteCommand" oneditcommand="DataGrid_control_EditCommand" onupdatecommand="DataGrid_control_UpdateCommand" Font-Size="85%">
                                      <Columns>
                                        <asp:ButtonColumn text="&lt;IMG src=&quot;~/protected/image/delete_x16_h.png&quot; alt=&quot;Delete&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" commandname="Delete" Visible="False"></asp:ButtonColumn>
                                        <asp:BoundColumn datafield="id" Visible="False" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn datafield="practitioner_id" Visible="False" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn datafield="last_name" headertext="Last name" sortexpression="last_name%,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn datafield="first_name" headertext="First name" sortexpression="first_name%,last_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn datafield="middle_initial" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="level" HeaderText="Level" ReadOnly="True" SortExpression="practitioner_level.pecking_order%,last_name,first_name,middle_initial,certification_number,birth_date desc">
                                          <ItemStyle Wrap="False" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn datafield="certification_number" headertext="Cert#" sortexpression="certification_number%,last_name,first_name,middle_initial,practitioner_level.pecking_order,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="be_birth_date_confirmed" ReadOnly="True" Visible="False"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="DOB" SortExpression="birth_date%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number">
                                          <ItemTemplate><asp:Label ID="Label_dob" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.birth_date") %>'></asp:Label></ItemTemplate>
                                          <EditItemTemplate>
                                            <asp:TextBox ID="TextBox_dob" runat="server" Columns="9" MaxLength="10" Text='<%# DataBinder.Eval(Container, "DataItem.birth_date") %>' enabled="False"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator_dob" runat="server" ControlToValidate="TextBox_dob" Display="Dynamic" ErrorMessage="Please enter a Birth date." Font-Bold="True" >!ERR!</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator_dob" runat="server" ControlToValidate="TextBox_dob" Display="Dynamic" ErrorMessage="Please enter a valid Birth date using the m/d/yyyy format." Font-Bold="True" ValidationExpression="\d{1,2}[-/]\d{1,2}[-/]\d{4}">!ERR!</asp:RegularExpressionValidator>
                                            <asp:CustomValidator ID="CustomValidator_dob" runat="server" ControlToValidate="TextBox_dob" Display="Dynamic" ErrorMessage="Please enter a valid Birth date consistent with an age of 16-130 years." Font-Bold="True" onservervalidate="CustomValidator_dob_ServerValidate">!ERR!</asp:CustomValidator>
                                            <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender_dob" runat="server" TargetControlID="TextBox_dob" WatermarkText="m/d/yyyy" WatermarkCssClass="textbox_watermark"></asp:TextBoxWatermarkExtender>
                                          </EditItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="county_code" ReadOnly="True" Visible="False"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="County" SortExpression="county_name%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc">
                                          <ItemTemplate><asp:Label ID="Label_county" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.county_name") %>'></asp:Label></ItemTemplate>
                                          <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList_county" runat="server"></asp:DropDownList>
                                          </EditItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Email address" SortExpression="email_address%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc">
                                          <ItemTemplate><asp:Label ID="Label_email_address" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.email_address") %>'></asp:Label></ItemTemplate>
                                          <EditItemTemplate>
                                            <asp:TextBox ID="TextBox_email_address" runat="server" Columns="15" MaxLength="127" Text='<%# DataBinder.Eval(Container, "DataItem.email_address") %>'></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator_email_address" runat="server" ControlToValidate="TextBox_email_address" Display="Dynamic" ErrorMessage="Please enter a valid Email address." Font-Bold="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
                                            <asp:CustomValidator ID="CustomValidator_email_address" runat="server" ControlToValidate="TextBox_email_address" Display="Dynamic" ErrorMessage='Please enter an Email address with a valid Domain Name (the part after the "@").' Font-Bold="True" onservervalidate="CustomValidator_email_address_ServerValidate">!ERR!</asp:CustomValidator>
                                            <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender_email_address" runat="server" TargetControlID="TextBox_email_address" WatermarkText="user@domain.tld" WatermarkCssClass="textbox_watermark"></asp:TextBoxWatermarkExtender>
                                          </EditItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="be_instructor" ReadOnly="True" Visible="False"></asp:BoundColumn>
                                        <asp:TemplateColumn headertext="InstHrs" sortexpression="instructor_hours%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc">
                                          <HeaderStyle HorizontalAlign="Center" />
                                          <ItemTemplate><asp:Label ID="Label_instructor_hours" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.instructor_hours") %>' Visible="false"></asp:Label></ItemTemplate>
                                          <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                          <EditItemTemplate>
                                            <asp:TextBox ID="TextBox_instructor_hours" runat="server" Columns="3" MaxLength="5" Text='<%# DataBinder.Eval(Container, "DataItem.instructor_hours") %>' visible="False"></asp:TextBox>
                                            <asp:CustomValidator ID="CustomValidator_instructor_hours" runat="server" ControlToValidate="TextBox_instructor_hours" Display="Dynamic" ErrorMessage='Please enter a valid Instructor hours value that does not exceed the Total class hours value.' Font-Bold="True" onservervalidate="CustomValidator_instructor_hours_ServerValidate">!ERR!</asp:CustomValidator>
                                            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender_instructor_hours" runat="server" TargetControlID="TextBox_instructor_hours" FilterType="Numbers,Custom" ValidChars="."></asp:FilteredTextBoxExtender>
                                            <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender_instructor_hours" runat="server" TargetControlID="TextBox_instructor_hours" WatermarkText="#.#" WatermarkCssClass="textbox_watermark"></asp:TextBoxWatermarkExtender>
                                          </EditItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:EditCommandColumn CancelText="&lt;IMG src=&quot;~/protected/image/edit-undo-8.png&quot; alt=&quot;Cancel&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" EditText="&lt;IMG src=&quot;~/protected/image/draw_freehand_16_h.png&quot; alt=&quot;Edit&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;" UpdateText="&lt;IMG src=&quot;~/protected/image/document-save-5.png&quot; alt=&quot;Update&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; /&gt;">
                                          <ItemStyle Wrap="False" />
                                        </asp:EditCommandColumn>
                                      </Columns>
                                      <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                                    </asp:DataGrid>
                                  </td>
                                </tr>
                                <tr><td><asp:Button ID="Button_close_and_submit" runat="server" Text="CLOSE CLASS and SUBMIT FOR CREDIT" Font-Bold="True" onclick="Button_close_and_submit_Click" />&nbsp;&nbsp;<asp:CustomValidator ID="CustomValidator_close_class_and_submit_for_credit" runat="server" ErrorMessage="You cannot submit a roster for a class that is not Approved, or could not have been completely presented given the registered Start and total Hours, or that has no Attendees, or still shows that a DOB is 'REQUIRED'." OnServerValidate="CustomValidator_close_class_and_submit_for_credit_ServerValidate" Font-Bold="true" Display="Dynamic">!ERR!</asp:CustomValidator></td></tr>
                                <tr><td><asp:Button ID="Button_generate_completion_documentation" runat="server" Text="Generate completion documentation" Enabled="False" /></td></tr>
                              </table>
                            </ContentTemplate>
                            <Triggers>
                              <asp:AsyncPostBackTrigger ControlID="Button_add" EventName="Click" />
                              <asp:AsyncPostBackTrigger ControlID="ListBox_practitioner" EventName="SelectedIndexChanged" />
                            </Triggers>
                          </asp:UpdatePanel>
                        </td>
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