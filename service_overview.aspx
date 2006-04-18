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
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td>Your service's WebEMSOF profile is:</td>
			  <td>
					<p align="center">
					  <ASP:Label id="Label_profile_status" runat="server" font-bold="True"></ASP:Label>
					</p></td>
			  <td>
						<div align="center">
					<ASP:LinkButton id="LinkButton_profile_action" runat="server" font-bold="True"></ASP:LinkButton>
						</div></td>
			</tr>
			<tr>
			  <td colspan="3"><hr /></td>
			</tr>
		</table>
		&nbsp;Your EMSOF requests:
		<blockquote>
		<table cellspacing="0" cellpadding="0" width="%" border="1">
		  <tr>
			<td>
			  <table cellspacing="0" cellpadding="10" width="%" border="0">
				<tr>
				  <td></td>
				  <td>
					<p align="center">Status</p></td>
				  <td>
					<p align="center">Value</p></td>
				  <td>
						<p align="center">Action</p></td>
				</tr>
				<tr>
				  <td><ASP:Label id="Label_last_fy_row_leader" runat="server" visible="False">Your request for <strong>last</strong> fiscal year is:</ASP:Label>
						<ASP:Label id="Label_last_fy_request_id" runat="server" visible="False"></ASP:Label></td>
				  <td>
					<div align="center">
					  <ASP:Label id="Label_last_fy_request_status" runat="server" font-bold="True"></ASP:Label>
					</div></td>
				  <td>
					<div align="center">
					  <ASP:Label id="Label_last_fy_request_value" runat="server" font-bold="True"></ASP:Label>
					</div></td>
				  <td>
						<div align="center">
					<ASP:LinkButton id="LinkButton_last_fy_request_action" runat="server" font-bold="True"></ASP:LinkButton>
						</div></td>
				</tr>
				<tr>
				  <td><ASP:Label id="Label_this_fy_row_leader" runat="server" visible="False">Your request for <strong>this</strong> fiscal year is:</ASP:Label>
						<ASP:Label id="Label_this_fy_request_id" runat="server" visible="False"></ASP:Label></td>
				  <td>
					<div align="center">
					  <ASP:Label id="Label_this_fy_request_status" runat="server" font-bold="True"></ASP:Label>
					</div></td>
				  <td>
					<div align="center">
					  <ASP:Label id="Label_this_fy_request_value" runat="server" font-bold="True"></ASP:Label>
					</div></td>
				  <td>
						<div align="center">
					<ASP:LinkButton id="LinkButton_this_fy_request_action" runat="server" font-bold="True"></ASP:LinkButton>
						</div></td>
				</tr>
			  </table></td>
		  </tr>
		</table>
        <p><ASP:Label id="Label_no_dg_items" runat="server" font-bold="True" visible="False">-- NONE --</ASP:Label></p>
		<ASP:DataGrid id="DataGrid" runat="server" autogeneratecolumns="False" cellpadding="5">
          <Columns>
            <ASP:BoundColumn visible="False" datafield="id" readonly="True"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="fy_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="county_name" readonly="True" headertext="County"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="status_code" readonly="True" headertext="Status"></ASP:BoundColumn>
            <ASP:BoundColumn datafield="value" readonly="True" headertext="Value"></ASP:BoundColumn>
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
