<%@ Page language="c#" Debug="true" Codebehind="request_overview.pas" AutoEventWireup="false" Inherits="request_overview.TWebForm_request_overview" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
  </head>

  <body>
     <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder>
<p>
        <ASP:Label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<h3>Request for 
        <ASP:Label id="Label_which_relative_fiscal_year" runat="server" font-bold="True"></ASP:Label>&nbsp;fiscal year</h3>
<h3>Number of items in shopping cart:&nbsp; 
        <ASP:Label id="Label_num_items_in_shopping_cart" runat="server" font-bold="True"></ASP:Label></h3>
<h3>
        <ASP:Table id="Table_shopping_cart" runat="server" cellpadding="0" cellspacing="5" borderwidth="1px" visible="False" gridlines="Both"></ASP:Table></h3>
<h3>
        <ASP:LinkButton id="LinkButton_add_item" runat="server" font-bold="True">Add item to request</ASP:LinkButton></h3>
      <p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder></p>
     </form>
  </body>
</html>
