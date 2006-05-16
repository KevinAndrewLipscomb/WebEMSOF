<%@ Page language="c#" Debug="true" Codebehind="main.pas" AutoEventWireup="false" Inherits="main.TWebForm_main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder>
<p>Welcome to <ASP:Label id="Label_application_name" runat="server"></ASP:Label>.&nbsp;&nbsp;Please indicate what kind of user you are:</p>
      <ul>
		<li><p><ASP:LinkButton id="LinkButton_service" runat="server">Service (elaborate)</ASP:LinkButton></p></li>
		<li><p><ASP:LinkButton id="LinkButton_county" runat="server">County Coordinator</ASP:LinkButton></p></li>
		<li><p><ASP:LinkButton id="LinkButton_regional_staffer" runat="server">Regional staffer</ASP:LinkButton><!-- (ambulance, QRS, rescue, etc) --></p></li>
      </ul>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
