<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ Page language="c#" Debug="true" Codebehind="emsof_request_status_filter.aspx.cs" AutoEventWireup="True" Inherits="emsof_request_status_filter.TWebForm_emsof_request_status_filter" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head>
    <title id="Title" runat="server"></title>
    <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>
  <body bgcolor="white">
     <form runat="server">
	  <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>

  <table cellspacing="0" cellpadding="5" width="100%" border="0">
      <tr>
		<td><strong>Requests in status "<ASP:Label id="Label_status" runat="server" font-bold="True"></ASP:Label>"</strong></td>
        <td><ASP:LinkButton id="LinkButton_retransmit_to_state" runat="server" enabled="False" visible="False" onclick="LinkButton_retransmit_to_state_Click">Retransmit to State</ASP:LinkButton></td>
      </tr>
  </table></strong></td>
					</tr>
					<tr id="TableRow_none" runat="server">
					  <td><em>--&nbsp;NONE&nbsp;--</em></td>
					</tr>
					<tr id="TableRow_data" runat="server">
					  <td>
						<p align="right"><a href="#QuickMessage">QuickMessage</a></p>
						<p>
						<ASP:DataGrid id="DataGrid_requests" runat="server" allowsorting="True" autogeneratecolumns="False" useaccessibleheader="True" cellpadding="10" gridlines="Horizontal" bordercolor="Gainsboro" borderwidth="1px">
						  <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
						  <Columns>
							<ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="service_id" sortexpression="service_id" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
							<ASP:BoundColumn datafield="service_name" sortexpression="service_name" readonly="True" headertext="Service name"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="county_code" sortexpression="county_code" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn datafield="sponsor_county" sortexpression="sponsor_county" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
							<ASP:BoundColumn datafield="fiscal_year_designator" sortexpression="fiscal_year_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
							<ASP:BoundColumn datafield="emsof_ante" sortexpression="emsof_ante" readonly="True" headertext="EMSOF amount" dataformatstring="{0:C}">
							  <ItemStyle horizontalalign="Right"></ItemStyle>
							</ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="appropriation" sortexpression="appropriation" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="leftover_or_shortage" sortexpression="leftover_or_shortage" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="has_wish_list" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
							<ASP:BoundColumn visible="False" datafield="status_code" sortexpression="status_code" readonly="True"></ASP:BoundColumn>
							<ASP:ButtonColumn visible="False" datatextfield="status_description" sortexpression="status_description" headertext="Status" commandname="Select">
							  <ItemStyle horizontalalign="Center" forecolor="Silver"></ItemStyle>
							</ASP:ButtonColumn>
							<ASP:ButtonColumn text="Select" commandname="Select">
							  <ItemStyle font-bold="True" horizontalalign="Center"></ItemStyle>
							</ASP:ButtonColumn>
						  </Columns></ASP:DataGrid>
						</p>
					  </td>
					</tr>
					<tr id="TableRow_spreadsheet" runat="server">
					</tr>
                </table></td>
            </tr>
        </table></p>
	  <p></p>
<table id="Table_quick_message" runat="server" bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
  <tr>
	<td>
	  <table cellspacing="0" cellpadding="10" width="100%" border="0">
		  <tr><td bgcolor="#f5f5f5"><a id="QuickMessage"><strong>QuickMessage</strong></a></td>
		  </tr>
		  <tr>
			<td><p>Send email to the agencies listed in the above table.</p>
			  <table cellspacing="0" cellpadding="10" width="100%" border="0">
				  <tr>
					<td>Subject:</td>
					<td><ASP:TextBox id="TextBox_quick_message_subject" runat="server" maxlength="255" columns="72"></ASP:TextBox></td>
					<td></td>
				  </tr>
				  <tr>
					<td valign="top">Body:</td>
					<td><ASP:TextBox id="TextBox_quick_message_body" runat="server" columns="72" rows="18" textmode="MultiLine"></ASP:TextBox></td>
					<td nowrap="true" valign="top"><ASP:RequiredFieldValidator id="RequiredFieldValidator_quick_message_body" runat="server" errormessage="Please enter a message body." font-bold="True" controltovalidate="TextBox_quick_message_body">!ERR!</ASP:RequiredFieldValidator></td>
				  </tr>
				  <tr>
					<td></td>
					<td><ASP:Button id="Button_send" runat="server" text="Send" onclick="Button_send_Click"></ASP:Button></td>
					<td></td>
				  </tr>
				  <tr><td valign="top"><small><font color="#c0c0c0">Resolves to:</small></font></td><td valign="top"><small><ASP:Label id="Label_distribution_list" runat="server" forecolor="Silver"></ASP:Label></small></td>
					<td></td>
				  </tr>
			  </table></td>
		  </tr>
	  </table></td>
  </tr>
</table>
	 <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
