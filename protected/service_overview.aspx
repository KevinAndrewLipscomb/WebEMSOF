<%@ Page language="c#" Debug="true" Codebehind="service_overview.pas" AutoEventWireup="false" Inherits="service_overview.TWebForm_service_overview"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>
  <body>
	<form runat="server">
	  <p><asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder></p>
	  <p><small>[ 
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ 
		  Change your WebEMSOF
		<ASP:LinkButton id="LinkButton_change_password" runat="server">password</ASP:LinkButton>&nbsp;| <ASP:LinkButton id="LinkButton_change_email_address" runat="server">email address</ASP:LinkButton>&nbsp;]
	  </small></p>
	  <h1><ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></h1>
	  <h3>Account overview</h3>
	  <h3>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" width="100%" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Your service's WebEMSOF profile is:</strong></td>
                      <td><ASP:Label id="Label_profile_status" runat="server"></ASP:Label></td>
                      <td><ASP:LinkButton id="LinkButton_profile_action" runat="server" font-size="X-Small"></ASP:LinkButton></td>
                    </tr>
                </table></td>
            </tr>
        </table></h3>
	  <h3>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" width="100%" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Your EMSOF requests</strong>
		</td>
                    </tr>
                    <tr>
                      <td>
        <p><ASP:Label id="Label_no_dg_items" runat="server" visible="False">-- No county allocations yet --</ASP:Label></p></td>
                    </tr>
                    <tr>
                      <td>
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
                          <HeaderStyle font-bold="True" backcolor="#F5F5F5"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn visible="False" datafield="id" readonly="True" headertext="WebEMSOF ID#">
                              <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="fy_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="county_name" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="county_dictated_appropriation_id" readonly="True"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="county_dictated_appropriation_amount" readonly="True" headertext="Amount appropriated" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn visible="False" datafield="status_code" readonly="True" headertext="Status code"></ASP:BoundColumn>
                            <ASP:BoundColumn datafield="status" readonly="True" headertext="Status">
                              <ItemStyle font-bold="True" horizontalalign="Center"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:BoundColumn datafield="value" readonly="True" headertext="Amount requested" dataformatstring="{0:C}">
                              <ItemStyle horizontalalign="Right"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:ButtonColumn text="Review" headertext="Action" commandname="Select">
                              <ItemStyle font-bold="True" horizontalalign="Center" forecolor="Blue"></ItemStyle>
                            </ASP:ButtonColumn>
                          </Columns></ASP:DataGrid></td>
                    </tr>
                </table></td>
            </tr>
        </table></h3>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
