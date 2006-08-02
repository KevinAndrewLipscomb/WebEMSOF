<%@ Page language="c#" Debug="true" Codebehind="state_required_report.pas" AutoEventWireup="false" Inherits="state_required_report.TWebForm_state_required_report" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
      <p><asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder></p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
			<tr>
			  <td>
              <table cellspacing="0" cellpadding="10" border="0">
                  <tr>
					<td bgcolor="#f5f5f5"><strong>
                        <table cellspacing="0" cellpadding="5" width="100%" border="0">
                            <tr>
							  <td><strong>State-required report</strong></td>
                              <td>
                                <p align="right"><ASP:LinkButton id="LinkButton_print_version" runat="server">Print version</ASP:LinkButton></p></td>
                            </tr>
                        </table></strong></td>
				  </tr>
				  <tr>
					<td>
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td>
				<p align="right">Regional EMS council name:</p></td>
			  <td><strong>EMERGENCY MEDICAL SERVICE INSTITUTE</strong></td>
			  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			  <td>
				<p align="right">Funding Round:</p></td>
			  <td><ASP:Label id="Label_funding_round" runat="server"></ASP:Label></td>
			</tr>
			<tr>
			  <td>
				<p align="right">ME:</p></td>
			  <td>__________________________________</td>
			  <td></td>
			  <td>
				<p align="right">Submission Date:</p></td>
			  <td><ASP:Label id="Label_submission_date" runat="server"></ASP:Label></td>
			</tr>
			<tr>
			  <td>
				<p align="right">Reviewed and Recommended<br>by Regional EMS Council (name):</p></td>
			  <td><strong>William E. Groft<br>
			  </strong>President</td>
			  <td></td>
			  <td>
				<p align="right">Review Date:</p></td>
			  <td></td>
			</tr>
			<tr>
			  <td></td>
			  <td><strong>Thomas J. McElree</strong><br>Regional EMS Council Director</td>
			  <td></td>
			  <td>
				<p align="right">Approval Date:</p></td>
			  <td></td>
			</tr>
		</table>
	  <p>Total amount available:&nbsp; <ASP:Label id="Label_amount_available" runat="server"></ASP:Label></p>
				<table cellspacing="0" cellpadding="0" border="0">
					<tr id="TableRow_none" runat="server">
					  <td><em>--&nbsp;NONE&nbsp;--</em></td>
					</tr>
					<tr>
					  <td>
					  <ASP:DataGrid id="DataGrid_state_export_batch" runat="server" autogeneratecolumns="False" visible="False" font-size="X-Small" showfooter="True" bordercolor="Gainsboro">
				<FooterStyle font-bold="True" backcolor="LightGray"></FooterStyle>
				<AlternatingItemStyle backcolor="WhiteSmoke"></AlternatingItemStyle>
				<HeaderStyle backcolor="LightGray"></HeaderStyle>
				<Columns>
				  <ASP:BoundColumn datafield="service_name" readonly="True" headertext="Organization Name"></ASP:BoundColumn>
				  <ASP:BoundColumn datafield="life_support_level" readonly="True" headertext="Type of Organization"></ASP:BoundColumn>
				  <ASP:BoundColumn datafield="equipment_description" readonly="True" headertext="Equipment/Program">
					<FooterStyle horizontalalign="Right"></FooterStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="quantity" readonly="True" headertext="# Units">
					<ItemStyle horizontalalign="Right"></ItemStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="unit_cost" readonly="True" headertext="Unit Cost" dataformatstring="{0:C}">
					<ItemStyle horizontalalign="Right"></ItemStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="total_cost" readonly="True" headertext="Total Cost Amount" dataformatstring="{0:C}">
					<HeaderStyle horizontalalign="Center"></HeaderStyle>
					<ItemStyle horizontalalign="Right"></ItemStyle>
					<FooterStyle horizontalalign="Right"></FooterStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="emsof_ante" readonly="True" headertext="EMSOF Amount" dataformatstring="{0:C}">
					<HeaderStyle horizontalalign="Center"></HeaderStyle>
					<ItemStyle horizontalalign="Right"></ItemStyle>
					<FooterStyle horizontalalign="Right"></FooterStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="provider_match" readonly="True" headertext="Provider Match" dataformatstring="{0:C}">
					<HeaderStyle horizontalalign="Center"></HeaderStyle>
					<ItemStyle horizontalalign="Right"></ItemStyle>
					<FooterStyle horizontalalign="Right"></FooterStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn datafield="recommendation" readonly="True" headertext="Recomm*">
					<HeaderStyle horizontalalign="Center"></HeaderStyle>
					<ItemStyle horizontalalign="Center"></ItemStyle>
				  </ASP:BoundColumn>
				  <ASP:BoundColumn readonly="True" headertext="EMSOF Approved"></ASP:BoundColumn>
				  <ASP:BoundColumn readonly="True" headertext="Actual Total Cost" dataformatstring="{0:C}">
					<HeaderStyle horizontalalign="Center"></HeaderStyle>
					<ItemStyle horizontalalign="Right"></ItemStyle>
					<FooterStyle horizontalalign="Right"></FooterStyle>
				  </ASP:BoundColumn>
				</Columns></ASP:DataGrid></td>
					</tr>
				</table>
<p></p>
		<table cellspacing="0" cellpadding="1" width="300" border="0">
			<tr>
			  <td><small><small>*</small></small></td>
			  <td><small><small>1)</small></small></td>
			  <td><small><small>Outside of regional/state development plan</small></small></td>
			</tr>
			<tr>
			  <td><small><small></small></small></td>
			  <td><small><small>2)</small></small></td>
			  <td><small><small>Insufficient funds</small></small></td>
			</tr>
			<tr>
			  <td><small><small></small></small></td>
			  <td><small><small>3)</small></small></td>
			  <td><small><small>Request received after deadline</small></small></td>
			</tr>
			<tr>
			  <td><small><small></small></small></td>
			  <td><small><small>4)</small></small></td>
			  <td><small><small>Outside of funding priorities</small></small></td>
			</tr>
			<tr>
			  <td><small><small></small></small></td>
			  <td><small><small>5)</small></small></td>
			  <td><small><small>No request received by the organization</small></small></td>
			</tr>
			<tr>
			  <td><small><small></small></small></td>
			  <td><small><small>6)</small></small></td>
			  <td><small><small>Not in compliance with regulations</small></small></td>
			</tr>
		</table>
	  <p>DOH Approval: ______________________________________&nbsp;&nbsp;&nbsp;&nbsp; Date: ___________________________________</p>
			  </td>
			</tr>
		</table>
					</td>
				  </tr>
			  </table>
	  <p><asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder></p>
	 </form>
  </body>
</html>
