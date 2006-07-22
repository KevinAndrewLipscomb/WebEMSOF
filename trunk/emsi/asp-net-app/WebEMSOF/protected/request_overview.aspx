<%@ Page language="c#" Debug="true" Codebehind="request_overview.pas" AutoEventWireup="false" Inherits="request_overview.TWebForm_request_overview" %>
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
	  <p>
<small>[ 
          <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:HyperLink id="HyperLink_service_overview" runat="server"
						 navigateurl="service_overview.aspx">service overview</ASP:HyperLink>&nbsp;form ]&nbsp; [ Change your 
		<ASP:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</ASP:hyperlink>&nbsp;| <ASP:HyperLink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</ASP:HyperLink>&nbsp;]
	  </small></p>
<h3>
		<ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></h3></small>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_parent_appropriation_outer" runat="server">
              <tr>
				<td>
	  <table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td bgcolor="#f5f5f5">
				<p align="right"><strong>You were allocated:</strong></p></td>
			  <td>
			  <p align="right"><ASP:Label id="Label_parent_appropriation_amount" runat="server"></ASP:Label></p></td>
			  <td>from
		<ASP:Label id="Label_sponsor_county" runat="server"></ASP:Label>&nbsp;for <ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label></td>
			</tr>
			<tr id="TableRow_sum_of_emsof_antes" runat="server">
			  <td>
				<p align="right">-</p></td>
			  <td>
			  <p align="right">
				<ASP:Label id="Label_sum_of_emsof_antes" runat="server" font-underline="True"></ASP:Label></p></td>
			  <td>requested from EMSOF (below)</td>
			</tr>
			<tr id="TableRow_unrequested_amount" runat="server">
			  <td>
				<p align="right">=</p></td>
			  <td>
              <p align="right"><ASP:Label id="Label_unused_amount" runat="server"></ASP:Label></p></td>
			  <td>remaining</td>
			</tr>
		</table>
				</td>
			  </tr>
		  </table>
      <p></p>
      <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
          <tr>
            <td>
              <table cellspacing="0" cellpadding="5" border="0">
                  <tr>
                    <td bgcolor="#f5f5f5"><strong>Master status:</strong></td>
                    <td>
                      <ASP:Label id="Label_master_status" runat="server"></ASP:Label></td>
                  </tr>
              </table></td>
          </tr>
      </table>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_deadlines" runat="server">
            <tr>
              <td>
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td bgcolor="#f5f5f5"><strong>Deadlines</strong></td>
			</tr>
			<tr>
			  <td>You must finalize your item requests by <ASP:Label id="Label_make_requests_deadline" runat="server" font-bold="True" font-size="Medium"></ASP:Label>.</td>
			</tr>
		</table></td>
			</tr>
		</table>
	  </p>
<p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
			<tr>
			  <td>
		<table cellspacing="0" cellpadding="10" border="0">
			<tr bgcolor="#f5f5f5">
			  <td><strong>Items requested</strong></td>
			  <td>
			  <div align="center"><ASP:HyperLink id="HyperLink_add_item_to_request" runat="server" navigateurl="request_item_detail.aspx">New</ASP:HyperLink>
			  </div></td>
			  <td>
						<p align="center">
						  <ASP:LinkButton id="LinkButton_finalize" runat="server" font-bold="True">FINALIZE...</ASP:LinkButton>
						</p></td>
			</tr>
			<tr>
			  <td colspan="3"><ASP:Label id="Label_no_appropriations" runat="server" visible="False" font-italic="True">-- NONE --</ASP:Label></td>
			</tr>
			<tr>
			  <td colspan="3"><ASP:HyperLink id="HyperLink_epel_doc" runat="server" target="_blank" navigateurl="..\resource\funding-priorities-epel-fy0607.pdf" font-size="X-Small">[ Open DOH Notice of EMSOF Funding Priorities / Eligible Provider Equipment List in new window ]</ASP:HyperLink></td>
            </tr>
		  <tr>
			<td colspan="3">
		  <ASP:DataGrid id="DataGrid_items" runat="server"
			bordercolor="Gainsboro"
			borderstyle="None"
			borderwidth="1px"
			backcolor="White"
			cellpadding="10"
			gridlines="Horizontal"
			forecolor="Black"
			useaccessibleheader="True"
			autogeneratecolumns="False"
			visible="False">
                          <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
                          <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
                          <HeaderStyle font-bold="True" backcolor="WhiteSmoke"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn visible="False" datafield="master_id" readonly="True">
                              <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="priority" readonly="True" headertext="Priority">
                              <ItemStyle horizontalalign="Center"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="code" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="item_description" readonly="True" headertext="Description"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="emsof_ante" readonly="True" headertext="EMSOF amount" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="status" readonly="True" headertext="Status"></ASP:BoundColumn>
                            <ASP:ButtonColumn text="Select" commandname="Select">
                              <ItemStyle forecolor="Blue"></ItemStyle>
                            </ASP:ButtonColumn>
                            <ASP:ButtonColumn text="Increase priority" commandname="IncreasePriority">
                              <ItemStyle forecolor="Blue"></ItemStyle>
                            </ASP:ButtonColumn>
                            <ASP:ButtonColumn text="Decrease priority" commandname="DecreasePriority">
                              <ItemStyle forecolor="Blue"></ItemStyle>
                            </ASP:ButtonColumn>
                          </Columns>
                          <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle></ASP:DataGrid>
            </td>
          </tr>
		</table>
			  </td>
			</tr>
		</table>
	  </p>
		<p></p>
	  <p>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder></p>
	 </form>
  </body>
</html>
