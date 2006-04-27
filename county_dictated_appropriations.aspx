<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriations.pas" AutoEventWireup="false" Inherits="county_dictated_appropriations.TWebForm_county_dictated_appropriations" smartnavigation="true" %>
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
		<ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>&nbsp;
		  <ASP:Label id="Label_literal_county" runat="server" font-bold="True" font-size="Large">County</ASP:Label></p>
	  <p><small>Change your WebEMSOF
		<ASP:LinkButton id="LinkButton_change_password" runat="server">password</ASP:LinkButton>&nbsp;|&nbsp;<ASP:LinkButton id="LinkButton_change_email_address" runat="server">email address</ASP:LinkButton>
	  </small></p>
			  <table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td>
				<p align="right">Parent appropriation:</p></td>
			  <td>
              <p align="right"><ASP:Label id="Label_parent_appropriation_amount" runat="server" font-bold="True"></ASP:Label></p></td>
			  <td>from
		<ASP:Label id="Label_region_name" runat="server"></ASP:Label>&nbsp;for <ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label></td>
			</tr>
			<tr id="TableRow_sum_of_service_appropriations" runat="server">
			  <td>
				<p align="right">-</p></td>
			  <td>
              <p align="right">
				<ASP:Label id="Label_sum_of_service_appropriations" runat="server" font-bold="True" font-underline="True"></ASP:Label></p></td>
			  <td>appropriated to services</td>
			</tr>
			<tr id="TableRow_unappropriated_amount" runat="server">
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
			  <td>Service appropriations:</td>
			  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			  <td><ASP:Label id="Label_make_appropriations_deadline" runat="server" font-bold="True" font-underline="True" font-size="Small" backcolor="Gold"></ASP:Label></td>
			</tr>
		</table>
	  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
		<p>
		  <ASP:Label id="Label_no_appropriations" runat="server" font-bold="True" visible="False">-- NONE --</ASP:Label></p>
		<p>
		  <ASP:HyperLink id="HyperLink_new_appropriation" runat="server" navigateurl="create_new_service_appropriation.aspx" font-bold="True">Make new service appropriation(s)</ASP:HyperLink>
		</p>
		<p>
		  <ASP:DataGrid id="DataGrid_service_appropriations" runat="server"
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
			OnSortCommand="SortCommand_service_appropriations" visible="False">
            <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
            <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
            <HeaderStyle font-bold="True" forecolor="Blue" backcolor="#E0E0E0"></HeaderStyle>
            <Columns>
              <ASP:BoundColumn datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
              </ASP:BoundColumn>
              <ASP:BoundColumn datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="name" sortexpression="name" readonly="True" headertext="Name"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="amount" sortexpression="amount" headertext="Amount" dataformatstring="{0:C}">
                <ItemStyle horizontalalign="Right"></ItemStyle>
              </ASP:BoundColumn>
              <ASP:EditCommandColumn buttontype="LinkButton" updatetext="Update" canceltext="Cancel" edittext="Edit">
                <ItemStyle forecolor="Blue"></ItemStyle>
              </ASP:EditCommandColumn>
              <ASP:ButtonColumn text="Delete" commandname="Delete">
                <ItemStyle forecolor="Blue"></ItemStyle>
              </ASP:ButtonColumn>
            </Columns>
            <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle></ASP:DataGrid>
        </p>
	  </blockquote>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
