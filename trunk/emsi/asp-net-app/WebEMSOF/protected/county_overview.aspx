<!DOCTYPE HTML>
<%@ Page language="c#" Debug="true" Codebehind="county_overview.aspx.cs" AutoEventWireup="True" Inherits="county_overview.TWebForm_county_overview" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<%@ Register src="../usercontrol/app/UserControl_county_binder.ascx" tagname="UserControl_county_binder" tagprefix="uc3" %>
<html>
  <head runat="server">
    <title></title>
	  <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
     <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <uc3:UserControl_county_binder ID="UserControl_county_binder_control" runat="server" />
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
