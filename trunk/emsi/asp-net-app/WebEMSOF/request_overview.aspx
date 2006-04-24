<%@ Page language="c#" Debug="true" Codebehind="request_overview.pas" AutoEventWireup="false" Inherits="request_overview.TWebForm_request_overview" %>
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
<h3>
		<ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></h3>
      <p>
<strong>Overview of your EMSOF request for
		<ASP:Label id="Label_fiscal_year_designator" runat="server" font-bold="True"></ASP:Label>&nbsp;from
		<ASP:Label id="Label_sponsor_county" runat="server" font-bold="True"></ASP:Label>&nbsp;County</strong></p>
	  <p>You have <ASP:Label id="Label_num_items_in_shopping_cart" runat="server" font-bold="True"></ASP:Label>&nbsp;items in your
	   shopping cart.</p>
      <p>
		<ASP:Table id="Table_shopping_cart" runat="server" cellpadding="0" cellspacing="5" borderwidth="1px" visible="False" gridlines="Both"></ASP:Table></p>
      <p>
<strong>
        <ASP:LinkButton id="LinkButton_add_item" runat="server" font-bold="True">Add item to request</ASP:LinkButton></strong></p></strong>
      <p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder></p>
     </form>
  </body>
</html>
