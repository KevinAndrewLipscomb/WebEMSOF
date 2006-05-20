<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriation_detail.pas" AutoEventWireup="false" Inherits="county_dictated_appropriation_detail.TWebForm_county_dictated_appropriation_detail" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
  </head>

  <body>
     <form runat="server">
	  <asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
	  <p>
		<small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;]
			             [ Back to <ASP:HyperLink id="HyperLink_back" runat="server" navigateurl="county_dictated_appropriations.aspx">county-dictated appropriation</ASP:HyperLink>&nbsp;form ]&nbsp;
			             [ Change your <asp:hyperlink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</asp:hyperlink>&nbsp;
			|
			<asp:hyperlink id="HyperLink_change_email_address" runat="server" navigateurl="change_email_address.aspx">email address</asp:hyperlink>&nbsp;]
		</small>
	  </p>
  <h3>
	  <p><asp:label id="Label_account_descriptor" runat="server" font-bold="True" font-size="Large"></asp:label></p>
	  <p><ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label>&nbsp;request from
		<ASP:Label id="Label_service_name" runat="server"></ASP:Label>&nbsp;(#
		<ASP:Label id="Label_affiliate_num" runat="server"></ASP:Label>)</p>
  </h3>
	  <p>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
              <tr>
				<td>
	  <table cellspacing="0" cellpadding="5" border="0">
			<tr>
			  <td bgcolor="#f5f5f5">
				<p align="right"><strong>Appropriation:</strong></p></td>
			  <td>
			  <p align="right"><ASP:Label id="Label_parent_appropriation_amount" runat="server"></ASP:Label></p></td>
			  <td>from
		<ASP:Label id="Label_sponsor_county" runat="server"></ASP:Label>&nbsp;County</td>
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
			  <td>unused</td>
			</tr>
		</table>
				</td>
			  </tr>
		  </table></p>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Items (<ASP:Label id="Label_num_items" runat="server"></ASP:Label>)</strong></td>
                    </tr>
                    <tr>
                      <td><ASP:DataGrid id="DataGrid_items" runat="server" autogeneratecolumns="False" useaccessibleheader="True" cellpadding="10" gridlines="Horizontal">
                          <HeaderStyle backcolor="WhiteSmoke"></HeaderStyle>
                          <Columns>
                            <ASP:BoundColumn datafield="priority" sortexpression="priority" readonly="True" headertext="Priority">
                              <ItemStyle font-size="Large" font-bold="True" horizontalalign="Center" verticalalign="Top"></ItemStyle>
                            </ASP:BoundColumn>
                            <ASP:TemplateColumn headertext="Detail">
                              <ItemStyle horizontalalign="Left" verticalalign="Top"></ItemStyle>
                              <ItemTemplate>
		<table cellpadding="2">
		  <tr>
			<td>Make/model:</td>
			<td><strong><%# DataBinder.Eval(Container.DataItem, "make_model") %></strong>&nbsp; <%# DataBinder.Eval(Container.DataItem, "be_refurbished") %></td>
		  </tr>
		  <tr>
			<td>Category:</td>
			<td><strong><%# DataBinder.Eval(Container.DataItem, "category") %></strong></td>
		  </tr>
		  <tr>
			<td>Place kept:</td>
			<td><%# DataBinder.Eval(Container.DataItem, "place_kept") %></td>
		  </tr>
		  <tr>
			<td>Qty/unit cost/subtotal:</td>
			<td><strong><%# DataBinder.Eval(Container.DataItem, "quantity") %></strong> @ <%# DataBinder.Eval(Container.DataItem, "unit_cost", "{0:C}") %> ea. = <strong><%# DataBinder.Eval(Container.DataItem, "subtotal", "{0:C}") %></strong></td>
		  </tr>
		  <tr>
			<td>Max unit cost supported by EMSOF:</td>
			<td><%# DataBinder.Eval(Container.DataItem, "allowable_cost", "{0:C}") %></td>
		  </tr>
		  <tr>
			<td>EMSOF ante/effective match level:</td>
			<td><strong><%# DataBinder.Eval(Container.DataItem, "emsof_ante", "{0:C}") %></strong> (<%# DataBinder.Eval(Container.DataItem, "effective_match_level", "{0:P0}") %>)</td>
		  </tr>
		</table>
                              </ItemTemplate>
                            </ASP:TemplateColumn>
                          </Columns>
</ASP:DataGrid></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
     </form>
  </body>
</html>
