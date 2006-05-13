<%@ Page language="c#" Debug="true" Codebehind="finalization_accepted.pas" AutoEventWireup="false" Inherits="finalization_accepted.TWebForm_finalization_accepted" %>
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
        <ASP:Label id="Label_literal_finalization_accepted" runat="server" font-bold="True" font-size="Large">Finalization accepted!</ASP:Label></p>
<p>
        <ASP:HyperLink id="HyperLink_close_and_return" runat="server" font-bold="True" navigateurl="javascript:self.close()">Click here to go back to the request overview form</ASP:HyperLink></p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
