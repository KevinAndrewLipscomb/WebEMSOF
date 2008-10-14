<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ Page language="c#" Debug="true" Codebehind="responding_services_detail.pas" AutoEventWireup="false" Inherits="responding_services_detail.TWebForm_responding_services_detail" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_service_profile" Src="~/usercontrol/app/UserControl_service_profile.ascx" %>
<html>
  <head runat="server">
    <title id="Title" runat="server"></title>
    <link REL="StyleSheet" HREF="../standard.css" TYPE="text/css" />
    <!-- $Id$ -->
  </head>
  <body bgcolor="white">
    <form runat="server">
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
      <uc2:UserControl_service_profile id="UserControl_service_profile_control" runat="server"></uc2:UserControl_service_profile>
      <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
    </form>
  </body>
</html>
