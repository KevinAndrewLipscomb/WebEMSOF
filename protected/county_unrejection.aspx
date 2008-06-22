<%@ Page language="c#" Debug="true" Codebehind="county_unrejection.pas" AutoEventWireup="false" Inherits="county_unrejection.TWebForm_county_unrejection" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body bgcolor="white">
     <form runat="server">
	  <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p>The new deadline has been recorded.</p>
	  <p>
        <table bordercolor="#ffd700" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#ffd700">
                        <h3>Note</h3></td>
                    </tr>
                    <tr>
                      <td>Now that you have moved your deadline from the past to the future, you may wish to let work continue on any or all of the following requests, which are currently in a REJECTED status.

	  <p>When you click <strong>UN-reject</strong> next to a request, the request will disappear from the list and the service can continue to work on it.&nbsp; When you are finished, click Done.</p>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>
                          <table cellspacing="0" cellpadding="10" width="100%" border="0">
                              <tr>
                                <td><strong>Requests eligible for UN-rejection</strong></td><td><strong><ASP:LinkButton id="LinkButton_unreject_all" runat="server">UN-reject ALL</ASP:LinkButton></strong></td>
                                <td><ASP:LinkButton id="LinkButton_done" runat="server">Done</ASP:LinkButton></td>
                              </tr>
                          </table>&nbsp;</strong></td>
					</tr>
					<tr id="TableRow_none" runat="server">
					  <td><em>--&nbsp;NONE&nbsp;--</em></td>
					</tr>
                    <tr>
					  <td>
		<asp:datagrid id="DataGrid_unrejectable_requests" runat="server"
		bordercolor="Gainsboro" borderstyle="None" borderwidth="1px" backcolor="White" cellpadding="10" gridlines="Horizontal" forecolor="Black"
		allowsorting="True" useaccessibleheader="True" autogeneratecolumns="False" visible="False">
                                            <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
                                            <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
                                            <HeaderStyle forecolor="Blue" backcolor="WhiteSmoke"></HeaderStyle>
                                            <Columns>
                                              <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="WebEMSOF ID#">
                                                <ItemStyle horizontalalign="Center" forecolor="Gray"></ItemStyle>
                                              </ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="service_id" sortexpression="service_id" readonly="True"></ASP:BoundColumn>
                                              <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
                                              <ASP:BoundColumn datafield="service_name" sortexpression="service_name" readonly="True" headertext="Name"></ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="county_code" sortexpression="county_code" readonly="True"></ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="sponsor_county" sortexpression="sponsor_county" readonly="True" headertext="Sponsor county"></ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="fiscal_year_designator" sortexpression="fiscal_year_designator" readonly="True" headertext="Cycle"></ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="emsof_ante" sortexpression="emsof_ante" readonly="True" headertext="EMSOF amount" dataformatstring="{0:C}">
                                                <ItemStyle horizontalalign="Right"></ItemStyle>
                                              </ASP:BoundColumn>
                                              <ASP:BoundColumn datafield="appropriation" sortexpression="appropriation" headertext="Amount" dataformatstring="{0:C}">
                                                <ItemStyle font-bold="True"></ItemStyle>
                                              </ASP:BoundColumn>
                                              <ASP:BoundColumn datafield="leftover_or_shortage" sortexpression="leftover_or_shortage" readonly="True" headertext="+Leftover / -Shortage">
                                                <HeaderStyle horizontalalign="Center"></HeaderStyle>
                                                <ItemStyle horizontalalign="Center"></ItemStyle>
                                              </ASP:BoundColumn>
                                              <ASP:BoundColumn datafield="has_wish_list" sortexpression="has_wish_list" readonly="True" headertext="Wish list">
                                                <ItemStyle horizontalalign="Center"></ItemStyle>
                                              </ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="password_reset_email_address" sortexpression="password_reset_email_address" readonly="True"></ASP:BoundColumn>
                                              <ASP:BoundColumn visible="False" datafield="status_code" sortexpression="status_code" readonly="True"></ASP:BoundColumn>
                                              <ASP:ButtonColumn text="UN-reject" commandname="Unreject">
                                                <ItemStyle horizontalalign="Center" forecolor="Blue"></ItemStyle>
                                              </ASP:ButtonColumn>
                                            </Columns>
                                            <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle>
                        </asp:datagrid>
					  </td>
                    </tr>
                </table></td>
            </tr>
        </table></p></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent></p>
     <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
