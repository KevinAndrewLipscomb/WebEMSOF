<%@ Page language="c#" Debug="true" Codebehind="regional_staffer_overview.pas" AutoEventWireup="false" Inherits="regional_staffer_overview.TWebForm_regional_staffer_overview" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_print_div" Src="~/usercontrol/ki/UserControl_print_div.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head><title id="Title" runat="server"></title>
      <!-- $Id$ -->
    <script type="text/javascript" src="../js/gradient.js"></script>
  </head>

  <body>
     <form runat="server">
	  <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p>
	  </p>
<div id="Div_print_area">
	  <p>
        <table cellspacing="0" cellpadding="10" border="0">
            <tr>
			  <td><p>
                                <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
                                    <tr>
                                      <td>
                                        <table cellspacing="0" cellpadding="10" width="100%" border="0">
                                            <tr>
                                              <td bgcolor="#f5f5f5"><strong>Financial snapshot&nbsp;of current cycle
</strong></td>
                                            </tr>
                                            <tr>
                                              <td align="center">
                                                <table cellspacing="0" cellpadding="5" border="0">
                                                    <tr>
													  <td align="right">
                                                        <ASP:Label id="Label_parent_appropriation" runat="server"></ASP:Label></td>
                                                      <td>allocated to region
</td>
                                                    </tr>
                                                    <tr>
													  <td align="right">
                                                        <ASP:Label id="Label_sum_of_appropriations" runat="server"></ASP:Label></td>
                                                      <td>allocated to counties
</td>
                                                    </tr>
													<tr>
													  <td align="right">
														<ASP:Label id="Label_appropriated_to_services" runat="server"></ASP:Label></td>
													  <td>allocated to services
</td>
													</tr>
													<tr>
													  <td align="right">
														<ASP:Label id="Label_requested_by_services" runat="server"></ASP:Label></td>
													  <td>requested by services
</td>
													</tr>
													<tr>
													  <td align="right">
														<ASP:Label id="Label_actually_spent" runat="server"></ASP:Label></td>
                                                      <td>actually spent
</td>
                                                    </tr>
                                                    <tr>
													  <td align="right">
                                                        <ASP:Label id="Label_remaining" runat="server" font-bold="True"></ASP:Label></td>
                                                      <td><strong>remaining
</strong></td>
                                                    </tr>
                                                </table></td>
                                            </tr>
                                        </table></td>
                                    </tr>
                                </table></p><p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" width="100%">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0" width="100%">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>
                                    <table cellspacing="0" cellpadding="5" width="100%" border="0">
                                        <tr>
                                          <td><strong>EMSOF workflow items
</strong></td>
                                          <td>
                                            <p align="right">
                                              <ASP:LinkButton id="LinkButton_all" runat="server">All
</ASP:LinkButton>
                                            </p></td>
                                        </tr>
                                    </table></strong></td>
                    </tr>
                    <tr>
                      <td>
						<ul>
						  <li>
							<p><ASP:LinkButton id="LinkButton_num_requests_needing_development" runat="server"> request(s) need to be started by services
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_num_requests_needing_finalization" runat="server"> request(s) need to be finished by services
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_num_requests_needing_county_approval" runat="server"> request(s) need County Coordinator approval
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_regional_compliance" runat="server"> request(s) need regional compliance check
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_exec_dir_approval" runat="server"> request(s) need Executive Director approval
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_transmittal" runat="server"> request(s) need transmittal to PA DOH EMSO
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_state_approval" runat="server"> request(s) need PA DOH EMSO approval
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_invoice_collection" runat="server"> request(s) need invoice collection
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_canceled_check_collection" runat="server"> request(s) need canceled check collection
</ASP:LinkButton></p></li>
						  <li>
							<p><ASP:LinkButton id="LinkButton_reimbursement" runat="server"> request(s) need reimbursement issuance
</ASP:LinkButton></p>
						  </li>
						</ul>
					  </td>
					</tr>
				</table></td>
			</tr>
		</table></p>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
	<tr>
	  <td>
						<table cellspacing="0" cellpadding="10" width="100%" border="0">
							<tr>
							  <td bgcolor="#f5f5f5"><strong>EMSOF awareness items in this cycle
</strong></td>
							</tr>
							<tr>
							  <td>
								<ul>
								  <li><p><ASP:LinkButton id="LinkButton_completed" runat="server"> request(s) COMPLETED
</ASP:LinkButton></p></li>
								  <li><p><ASP:LinkButton id="LinkButton_missed_deadlines" runat="server"> request(s) FAILED DEADLINE
</ASP:LinkButton></p></li>
								  <li><p><ASP:LinkButton id="LinkButton_withdrawn" runat="server"> request(s) WITHDRAWN
</ASP:LinkButton></p></li>
								  <li><p><ASP:LinkButton id="LinkButton_rejected" runat="server"> request(s) REJECTED
</ASP:LinkButton></p></li>
								</ul>
							  </td>
							</tr>
						</table></td>
	</tr>
</table></td>
			  <td valign="top">
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="10" width="100%" border="1">
  <tr>
    <td bgcolor="#f5f5f5">
      <strong><ASP:LinkButton id="LinkButton_analyses" runat="server">Analyses
</ASP:LinkButton></strong>
    </td>
  </tr>
</table>
                  <p>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
    <tr>
      <td>
                        <table cellspacing="0" cellpadding="10" width="100%" border="0">
                            <tr>
                              <td bgcolor="#f5f5f5"><strong>Prior EMSOF cycle projects
</strong></td>
                            </tr>
                            <tr>
                              <td>
                                <ul><li><p>
									  <ASP:LinkButton id="LinkButton_deployed" runat="server"> projects currently deployed
</ASP:LinkButton></p></li><li><p>
									  <ASP:LinkButton id="LinkButton_archived" runat="server"> projects archived
</ASP:LinkButton></p></li>
                                </ul></td>
                            </tr>
                        </table>
    </td>
  </tr>
</table></p>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
	<tr>
	  <td>
				  <table cellspacing="0" cellpadding="10" width="100%" border="0">
					<tr>
						<td bgcolor="#f5f5f5"><strong>WebEMSOF administration
</strong></td>
					</tr>
					<tr>
					  <td>
						<ul>
						  <li><p>
								<ASP:LinkButton id="LinkButton_maintain_service_accounts" runat="server" enabled="False">Maintain service accounts
</ASP:LinkButton></p></li>
						  <li><p>
								<ASP:LinkButton id="LinkButton_maintain_county_accounts" runat="server" enabled="False">Maintain county coordinator accounts
</ASP:LinkButton></p></li>
						  <li><p>
								<ASP:LinkButton id="LinkButton_maintain_regional_staffer_accounts" runat="server" enabled="False">Maintain regional staffer accounts
</ASP:LinkButton></p></li>
						</ul>
					  </td>
					</tr>
				  </table></td>
	</tr>
		  </table>
                <p>
                </p>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" width="100%" border="1">
	<tr>
	  <td>
				<table cellspacing="0" cellpadding="10" border="0" width="100%">
					<tr>
					  <td bgcolor="#f5f5f5"><strong>Annual EMSOF setup tasks
</strong></td>
					</tr>
					<tr>
					  <td>
						<ul>
						  <li><p><ASP:LinkButton id="LinkButton_init_new_fy" runat="server" enabled="False">Initialize new fiscal year
</ASP:LinkButton></p></li>
						  <li><p><ASP:LinkButton id="LinkButton_maintain_epels" runat="server" enabled="False">Maintain Eligible Provider Equipment Lists
</ASP:LinkButton></p></li>
						  <li><p>
                                      <ASP:LinkButton id="LinkButton_set_deadlines" runat="server" enabled="False">Set deadlines
</ASP:LinkButton></p></li>
						  <li><ASP:LinkButton id="LinkButton_maintain_region_dictated_appropriations" runat="server" enabled="False">Maintain county fund allocations
</ASP:LinkButton></li>
						</ul></td>
					</tr>
				</table>
	  </td>
	</tr>
</table>
                  </td>
                <td valign="top"><uc1:UserControl_print_div id="UserControl_print_div" runat="server"></uc1:UserControl_print_div></td>
            </tr>
        </table></p>
	  <p>&nbsp;
	  </p>

</div>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
	 <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
