<%@ Page language="c#" Debug="true" Codebehind="service_overview.pas" AutoEventWireup="false" Inherits="service_overview.TWebForm_service_overview"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>
  <body>
	<form runat="server">
	  <p>
		<asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
	  </p>
	  <p>
		<ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>
	  </p>
	  <p><strong>Account overview</strong>
	  </p>
		<table cellspacing="0" cellpadding="10" border="0">
			<tr>
			  <td>Your service's WebEMSOF profile is:</td>
			  <td>
					<p align="center">
					  <ASP:Label id="Label_profile_status" runat="server" font-bold="True"></ASP:Label>
					</p></td>
			  <td>
						<div align="center">
					<ASP:LinkButton id="LinkButton_profile_action" runat="server" font-bold="True" font-size="Small"></ASP:LinkButton>
						</div></td>
			</tr>
			<tr>
			  <td colspan="3"><hr /></td>
			</tr>
		</table>
		&nbsp;&nbsp; Your EMSOF requests:
		<blockquote>
        <p><ASP:Label id="Label_no_dg_items" runat="server" font-bold="True" visible="False">-- NONE --</ASP:Label></p>
		<ASP:DataGrid id="DataGrid" runat="server"
			bordercolor="#CCCCCC"
			borderstyle="None"
			borderwidth="1px"
			backcolor="White"
			cellpadding="10"
			gridlines="Horizontal"
			forecolor="Black"
			useaccessibleheader="True"
		    autogeneratecolumns="False">
          <HeaderStyle font-bold="True" forecolor="Blue" backcolor="#E0E0E0"></HeaderStyle>
          <Columns>
            <ASP:BoundColumn visible="False" datafield="id" readonly="True"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="fy_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="county_name" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="county_dictated_appropriation_amount" readonly="True" headertext="Amount appropriated" dataformatstring="{0:C}">
              <ItemStyle horizontalalign="Right"></ItemStyle>
            </ASP:BoundColumn>
            <ASP:BoundColumn datafield="status" readonly="True" headertext="Status">
              <ItemStyle font-bold="True"></ItemStyle>
            </ASP:BoundColumn>
            <ASP:BoundColumn datafield="value" readonly="True" headertext="Amount requested" dataformatstring="{0:C}">
              <ItemStyle horizontalalign="Right"></ItemStyle>
            </ASP:BoundColumn>
            <ASP:ButtonColumn headertext="Action"></ASP:ButtonColumn>
          </Columns></ASP:DataGrid>
		</blockquote>
	  <p><small>Change your WebEMSOF
		<a href="http://localhost/WebEMSOF/change_password.aspx">password</a>&nbsp;| <a href="http://localhost/WebEMSOF/change_email_address.aspx">email address</a>
	  </small></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
