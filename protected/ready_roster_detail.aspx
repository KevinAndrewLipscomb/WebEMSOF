<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!-- Derived from KiAspdotnetFramework/protected/template~protected~nonlanding.aspx~template -->
<%@ Page language="c#" Debug="true" Codebehind="ready_roster_detail.aspx.cs" AutoEventWireup="True" Inherits="ready_roster_detail.TWebForm_ready_roster_detail" %>
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
                  <table cellpadding="10" cellspacing="0">
                    <tr><td style="background-color:WhiteSmoke"><b>Attendees</b></td></tr>
                    <tr id="TableRow_none" runat="server"><td><em>--&nbsp;NONE&nbsp;--</em></td></tr>
                    <tr id="TableRow_attendees" runat="server">
                      <td valign="top">
                        <asp:DataGrid id="DataGrid_control" runat="server" gridlines="Horizontal" cellpadding="5" autogeneratecolumns="False" allowsorting="True" onsortcommand="DataGrid_control_SortCommand" onitemdatabound="DataGrid_control_ItemDataBound" Font-Size="85%" enabledviewstate="false">
                          <Columns>
                            <asp:BoundColumn datafield="last_name" headertext="Last name" sortexpression="last_name%,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="first_name" headertext="First_name" sortexpression="first_name%,last_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="middle_initial" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn DataField="level" HeaderText="Level" ReadOnly="True" SortExpression="practitioner_level.pecking_order%,last_name,first_name,middle_initial,certification_number,birth_date desc">
                              <ItemStyle Wrap="False" />
                            </asp:BoundColumn>
                            <asp:BoundColumn datafield="certification_number" headertext="Cert#" sortexpression="certification_number%,last_name,first_name,middle_initial,practitioner_level.pecking_order,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="birth_date" HeaderText="DOB" SortExpression="birth_date%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="county_name" HeaderText="County" SortExpression="county_name%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn DataField="instructor_hours" ReadOnly="True" HeaderText="InstHrs" SortExpression="instructor_hours%,last_name,first_name,middle_initial,practitioner_level.pecking_order,certification_number,birth_date desc">
                              <HeaderStyle HorizontalAlign="Center" />
                              <ItemStyle HorizontalAlign="Right" Wrap="False" />
                            </asp:BoundColumn>
                          </Columns>
                          <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                        </asp:DataGrid>
                        <asp:DataGrid id="DataGrid_lcds" runat="server" autogeneratecolumns="False" onitemdatabound="DataGrid_lcds_ItemDataBound" enabledviewstate="false" style="display:none">
                          <Columns>
                            <asp:BoundColumn datafield="first_name" headertext="ID" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="last_name" headertext="HEADER" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn datafield="birth_date" HeaderText="DOB" ReadOnly="True"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="VALID"><ItemTemplate>1</ItemTemplate></asp:TemplateColumn>
                            <asp:BoundColumn datafield="certification_number" headertext="OLDCERT" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn DataField="level_emsrs_code" HeaderText="LEVEL1" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn DataField="region_emsrs_code" HeaderText="REGION" ReadOnly="true"></asp:BoundColumn>
                            <asp:BoundColumn DataField="course_number" HeaderText="COURSE" ReadOnly="true"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="OUTOFSTATE"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                            <asp:BoundColumn DataField="class" HeaderText="CLASS" ReadOnly="true"></asp:BoundColumn>
                            <asp:BoundColumn DataField="lcds_instructor_hours" HeaderText="HOURS" ReadOnly="True"></asp:BoundColumn>
                            <asp:BoundColumn DataField="end_date" HeaderText="DATEFINAL" ReadOnly="true"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="SSN"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="REMED"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                            <asp:BoundColumn datafield="practitioner_county_emsrs_code" HeaderText="COUNTY" ReadOnly="True"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="SEND"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                            <asp:BoundColumn DataField="sponsor_number" HeaderText="SPONSORID" ReadOnly="true"></asp:BoundColumn>
                            <asp:TemplateColumn HeaderText="DATETIMESTAMP"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="FORM_TYPE_ID"><ItemTemplate></ItemTemplate></asp:TemplateColumn>
                          </Columns>
                          <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                        </asp:DataGrid>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <table cellpadding="10" cellspacing="0">
                          <tr>
                            <td align="center" style="border:1px solid Gray">
                              <asp:LinkButton ID="LinkButton_gen_lcds" runat="server" onclick="LinkButton_gen_lcds_Click" Font-Bold="True">Generate <i>Large Conference Data Sheet</i></asp:LinkButton><br />
                              <br />
                              ...then...<br />
                              <br />
                              <asp:Button ID="Button_mark_done" runat="server" Text="Mark done" onclick="Button_mark_done_Click"/>
                            </td>
                            <td><b><i>OR</i></b></td>
                            <td style="border:1px solid Gray"><asp:Button ID="Button_submit_to_emsrs" runat="server" Text="Submit to EMSRS and mark done" onclick="Button_submit_to_emsrs_Click" Enabled="False" /></td>
                          </tr>
                        </table>
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