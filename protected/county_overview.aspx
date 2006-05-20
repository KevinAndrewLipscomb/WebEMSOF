<%@ Page language="c#" Debug="true" Codebehind="county_overview.pas" AutoEventWireup="false" Inherits="county_overview.TWebForm_county_appropriation" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <p>
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder></p>
      <p><small>[ 
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Change your WebEMSOF
		<ASP:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</ASP:hyperlink>&nbsp;
		|
		<ASP:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</ASP:hyperlink>&nbsp;]
	  </small></p>
<p>
		<ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>&nbsp;<ASP:Label id="Label_literal_county" runat="server" font-bold="True" font-size="Large">County</ASP:Label></p>
<p>Which appropriation do you want to work with?&nbsp; <ASP:RequiredFieldValidator id="RequiredFieldValidator_appropriation" runat="server" errormessage="Please choose an appropriation." font-bold="True" controltovalidate="RadioButtonList_appropriation">!ERR!</ASP:RequiredFieldValidator></p>
<p>
        <ASP:RadioButtonList id="RadioButtonList_appropriation" runat="server"></ASP:RadioButtonList></p>
<p>
        <ASP:Button id="Button_continue" runat="server" text="Continue"></ASP:Button></p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
