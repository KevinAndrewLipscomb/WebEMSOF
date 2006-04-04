<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriations.pas" AutoEventWireup="false" Inherits="county_dictated_appropriations.TWebForm_county_dictated_appropriations" %>
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
        <ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p>For your 
        <ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label>&nbsp;appropriation of <strong>$</strong>
        <ASP:Label id="Label_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;from 
        <ASP:Label id="Label_region_name" runat="server"></ASP:Label>, the following service appropriations have been made:</p>
<p>
        <ASP:Table id="Table_service_appropriations" runat="server" borderwidth="1px" cellpadding="10"></ASP:Table></p>
<p>From the above county appropriation, you have <strong>$</strong><ASP:Label id="Label_unappropriated_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;left to appropriate to services by the regional deadline of
        <ASP:Label id="Label_regional_county_dictated_appropriation_deadline_date_string" runat="server" font-bold="True" font-underline="True"></ASP:Label>.</p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
