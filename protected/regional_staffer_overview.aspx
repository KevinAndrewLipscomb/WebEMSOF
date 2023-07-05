<!DOCTYPE html>
<%@ Page language="c#" codebehind="regional_staffer_overview.aspx.cs" AutoEventWireup="True" Inherits="regional_staffer_overview.TWebForm_regional_staffer_overview" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<%@ Register TagPrefix="uc3" TagName="UserControl_regional_staffer_binder" Src="~/usercontrol/app/UserControl_regional_staffer_binder.ascx" %>
<html>
  <head runat="server">
    <title></title>
    <!-- $Id: regional_staffer_overview.aspx 7189 2020-05-25 01:22:15Z kevinanlipscomb $ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <uc3:UserControl_regional_staffer_binder id="UserControl_regional_staffer_binder" runat="server"></uc3:UserControl_regional_staffer_binder>
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
