<%@ Page language="c#" Debug="true" Codebehind="county_appropriation.pas" AutoEventWireup="false" Inherits="county_appropriation.TWebForm_county_appropriation" %>
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
        <ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label><strong>&nbsp;County</strong></p>
<p>Which appropriation do you want to work with?</p>
<p>
        <ASP:RadioButtonList id="RadioButtonList_appropriation" runat="server"></ASP:RadioButtonList></p>
<p>
        <ASP:Button id="Button_continue" runat="server" text="Continue"></ASP:Button></p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
