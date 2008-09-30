<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ Page language="c#" Debug="true" Codebehind="equipment_procurement_detail.pas" AutoEventWireup="false" Inherits="equipment_procurement_detail.TWebForm_equipment_procurement_detail" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head>
    <title id="Title" runat="server"></title>
    <link REL="StyleSheet" HREF="../standard.css" TYPE="text/css" />
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
     <form runat="server">
	  <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr>
          <td bgcolor="#dcdcdc"><strong>Cycle:&nbsp; <asp:DropDownList id="DropDownList_cycle" runat="server" autopostback="True"></asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp; Equipment:&nbsp; <asp:DropDownList id="DropDownList_equipment" runat="server" autopostback="True"></asp:DropDownList></strong></td>
        </tr>
        <tr>
          <td>
            <asp:GridView id="GridView_control" runat="server" gridlines="Horizontal" cellpadding="10" autogeneratecolumns="False" allowsorting="True" emptydatatext="No data available">
                        <Columns>
                          <asp:BoundField datafield="name" headertext="Service name" sortexpression="name%">
                            <HeaderStyle horizontalalign="Left"></HeaderStyle>
                          </asp:BoundField>
                          <asp:BoundField datafield="make_model" headertext="Make/model"></asp:BoundField>
                          <asp:BoundField datafield="place_kept" headertext="Place kept"></asp:BoundField>
                          <asp:BoundField datafield="be_refurbished" headertext="Refurb" sortexpression="be_refurbinshed%">
                            <ItemStyle horizontalalign="Center"></ItemStyle>
                          </asp:BoundField>
                          <asp:BoundField datafield="actual_quantity" headertext="Qty" sortexpression="actual_quantity%">
                            <HeaderStyle horizontalalign="Center"></HeaderStyle>
                            <ItemStyle horizontalalign="Center"></ItemStyle>
                          </asp:BoundField>
                          <asp:BoundField datafield="actual_subtotal_cost" dataformatstring="{0:C}" headertext="Cost" htmlencode="False" sortexpression="actual_subtotal_cost%">
                            <ItemStyle horizontalalign="Right"></ItemStyle>
                          </asp:BoundField>
                          <asp:BoundField datafield="actual_emsof_ante" dataformatstring="{0:C}" headertext="EMSOF part" htmlencode="False" sortexpression="actual_emsof_ante%">
                            <ItemStyle horizontalalign="Right"></ItemStyle>
                          </asp:BoundField>
                        </Columns>
                        <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
            </asp:GridView>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
