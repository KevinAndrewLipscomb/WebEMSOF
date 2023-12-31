<!DOCTYPE html>
<%@ Page language="c#" codebehind="service_overview.aspx.cs" AutoEventWireup="True" Inherits="service_overview.TWebForm_service_overview"%>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head runat="server">
    <!-- $Id: service_overview.aspx 7189 2020-05-25 01:22:15Z kevinanlipscomb $ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <h3>
        <table border="1" bordercolor="#dcdcdc" cellspacing="0">
          <tr>
            <td>
              <table cellspacing="0" cellpadding="10" border="0">
                <tr>
                  <td>
                    <table cellspacing="0" cellpadding="10" border="0">
                      <tr>
                        <td bgcolor="#f5f5f5">Your service's WebEMSOF profile:</td>
                        <td><ASP:Label id="Label_profile_status" runat="server"></ASP:Label></td>
                        <td><ASP:LinkButton id="LinkButton_profile_action" runat="server" font-size="Small" onclick="LinkButton_profile_action_Click"></ASP:LinkButton></td>
                        <td id="TableData_profile_printable" runat="server" visible="false"><ASP:LinkButton id="LinkButton_profile_printable" runat="server" font-size="Small" onclick="LinkButton_profile_printable_Click">[View printable report]</ASP:LinkButton></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr><td><asp:Literal ID="Literal_relation_to_annual_survey" runat="server"></asp:Literal></td></tr>
              </table>
            </td>
          </tr>
        </table>
      </h3>
      <h3>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_item_requests_section" runat="server">
          <tr>
            <td>
              <table cellspacing="0" cellpadding="10" width="100%" border="0">
                <tr>
                  <td bgcolor="#f5f5f5"><strong>Your EMSOF requests</strong></td>
                </tr>
                <tr>
                  <td>
                    <p><ASP:Label id="Label_no_dg_items" runat="server" visible="False">-- No county allocations yet --</ASP:Label></p>
                  </td>
                </tr>
                <tr>
                  <td>
                    <ASP:DataGrid id="DataGrid" runat="server"
                      bordercolor="#CCCCCC"
                      borderstyle="None"
                      borderwidth="1px"
                      backcolor="White"
                      cellpadding="10"
                      gridlines="Horizontal"
                      forecolor="Black"
                      useaccessibleheader="True"
                      autogeneratecolumns="False">
                      <HeaderStyle font-bold="True" backcolor="#F5F5F5"></HeaderStyle>
                      <Columns>
                        <ASP:BoundColumn visible="False" datafield="id" readonly="True" headertext="WebEMSOF ID#">
                          <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                        </ASP:BoundColumn>
                        <ASP:BoundColumn datafield="fy_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
                        <ASP:BoundColumn datafield="county_name" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                        <ASP:BoundColumn visible="False" datafield="county_dictated_appropriation_id" readonly="True"></ASP:BoundColumn>
                        <ASP:BoundColumn datafield="county_dictated_appropriation_amount" readonly="True" headertext="Amount allocated" dataformatstring="{0:C}">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </ASP:BoundColumn>
                        <ASP:BoundColumn visible="False" datafield="status_code" readonly="True" headertext="Status code"></ASP:BoundColumn>
                        <ASP:BoundColumn datafield="status" readonly="True" headertext="Status">
                          <ItemStyle font-bold="True" horizontalalign="Center"></ItemStyle>
                        </ASP:BoundColumn>
                        <ASP:BoundColumn datafield="value" readonly="True" headertext="Amount requested" dataformatstring="{0:C}">
                          <ItemStyle horizontalalign="Right"></ItemStyle>
                        </ASP:BoundColumn>
                        <ASP:ButtonColumn text="Review" headertext="Action" commandname="Select">
                          <ItemStyle font-bold="True" horizontalalign="Center" forecolor="Blue"></ItemStyle>
                        </ASP:ButtonColumn>
                      </Columns>
                    </ASP:DataGrid>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </h3>
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
