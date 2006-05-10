<%@ Page language="c#" Debug="true" Codebehind="finalize.pas" AutoEventWireup="false" Inherits="finalize.TWebForm_finalize" %>
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
<p>
        <ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p><small>[ Back to&nbsp;<ASP:HyperLink id="HyperLink_request_overview"
                 runat="server" navigateurl="request_overview.aspx">request overview</ASP:HyperLink> form ]</small></p>
<p><small></small></p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
