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
	  <p><small>Change your WebEMSOF
		<a href="http://localhost/WebEMSOF/change_password.aspx">password</a>&nbsp;| <a href="http://localhost/WebEMSOF/change_email_address.aspx">email address</a>
	  </small></p>
	  <table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td>
				<p align="right">Parent appropriation:</p></td>
			  <td>
              <p align="right"><ASP:Label id="Label_parent_appropriation_amount" runat="server" font-bold="True"></ASP:Label></p></td>
			  <td>from
		<ASP:Label id="Label_sponsor_county" runat="server"></ASP:Label>&nbsp;for <ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label></td>
			</tr>
			<tr id="TableRow_sum_of_item_amounts" runat="server">
			  <td>
				<p align="right">-</p></td>
			  <td>
              <p align="right">
				<ASP:Label id="Label_sum_of_item_amounts" runat="server" font-bold="True" font-underline="True"></ASP:Label></p></td>
			  <td>appropriated to services</td>
			</tr>
			<tr id="TableRow_unrequested_amount" runat="server">
			  <td>
				<p align="right">=</p></td>
			  <td>
              <p align="right"><ASP:Label id="Label_unappropriated_amount" runat="server" font-bold="True"></ASP:Label></p></td>
			  <td>remaining</td>
			</tr>
		</table>
		<p></p>
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td>Items requested:</td>
			  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			  <td><ASP:Label id="Label_make_requests_deadline" runat="server" font-bold="True" font-underline="True" font-size="Small" backcolor="Gold"></ASP:Label></td>
			</tr>
		</table>
	  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
		<p>
		  <ASP:Label id="Label_no_appropriations" runat="server" font-bold="True" visible="False">-- NONE --</ASP:Label></p>
		<p>
		  <ASP:HyperLink id="HyperLink_add_item_to_request" runat="server" navigateurl="add_item_to_request.aspx" font-bold="True">Add item(s) to request</ASP:HyperLink>
		</p>
		<p>
		  <ASP:DataGrid id="DataGrid_items" runat="server"
			bordercolor="#CCCCCC"
			borderstyle="None"
			borderwidth="1px"
			backcolor="White"
			cellpadding="10"
			gridlines="Horizontal"
			forecolor="Black"
			allowsorting="True"
			useaccessibleheader="True"
			autogeneratecolumns="False"
			visible="False">
            <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
            <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
			<Columns>
              <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
              </ASP:BoundColumn>
              <ASP:BoundColumn datafield="priority" sortexpression="priority" readonly="True" headertext="Priority"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="equipment-description" sortexpression="equipment_description" readonly="True" headertext="Equipment description"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="value" sortexpression="value" headertext="Value"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="status" sortexpression="status" readonly="True" headertext="Status"></ASP:BoundColumn>
              <ASP:ButtonColumn text="Select" commandname="Select"></ASP:ButtonColumn>
              <ASP:ButtonColumn text="Increase priority" commandname="IncreasePriority"></ASP:ButtonColumn>
              <ASP:ButtonColumn text="Decrease priority" commandname="DecreasePriority"></ASP:ButtonColumn>
            </Columns>
            <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle></ASP:DataGrid>
        </p>
	  </blockquote></strong>
      <p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder></p>
     </form>
  </body>
</html>
