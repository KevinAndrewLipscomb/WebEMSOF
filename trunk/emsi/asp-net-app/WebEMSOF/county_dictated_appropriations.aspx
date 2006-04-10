<%@ Page language="c#" Debug="true" Codebehind="county_dictated_appropriations.pas" AutoEventWireup="false" Inherits="county_dictated_appropriations.TWebForm_county_dictated_appropriations" %>
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
		<ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label><strong>&nbsp;
          <ASP:Label id="Label_literal_county" runat="server" font-bold="True" font-size="Large">County</ASP:Label></strong></p>
<p>Parent appropriation:&nbsp; <ASP:Label id="Label_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;from
		<ASP:Label id="Label_region_name" runat="server"></ASP:Label>&nbsp;for <ASP:Label id="Label_fiscal_year_designator" runat="server"></ASP:Label></p>
<p>Service appropriations:</p>
	  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
		  <ASP:Label id="Label_no_appropriations" runat="server" font-bold="True" visible="False" height="2pc">-- NONE --</ASP:Label>
		  <table cellspacing="0" cellpadding="1" border="0" bgcolor="#c0c0c0">
			  <tr>
				<td><strong>Create new appropriation:&nbsp; </strong></td>
			  <td>Service:</td>
			  <td><ASP:DropDownList id="DropDownList_services" runat="server"></ASP:DropDownList></td>
			  <td></td>
			  </tr>
			<tr>
			  <td></td>
			  <td>Amount:&nbsp; $</td>
			  <td><ASP:TextBox id="TextBox_new_amount" runat="server" width="6pc"></ASP:TextBox></td>
			  <td><ASP:RegularExpressionValidator id="RegularExpressionValidator_new_amount" runat="server" font-bold="True" errormessage="Please leave disallowed characters out of the new amount." validationexpression="[0-9$,\.]+" controltovalidate="TextBox_new_amount">!ERR!</ASP:RegularExpressionValidator></td>
			</tr>
			<tr>
			  <td></td>
			  <td></td>
			  <td><ASP:Button id="Button_add_appropriation" runat="server" text="Add"></ASP:Button></td>
			  <td></td>
			</tr>
		  </table>
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
			OnSortCommand="SortCommand_service_appropriations" visible="False" showfooter="True">
            <FooterStyle forecolor="Black" backcolor="#CCCC99"></FooterStyle>
            <SelectedItemStyle font-bold="True" forecolor="White" backcolor="#CC3333"></SelectedItemStyle>
            <HeaderStyle font-bold="True" forecolor="White" backcolor="#333333"></HeaderStyle>
            <Columns>
              <ASP:BoundColumn visible="False" datafield="id" sortexpression="id" readonly="True" headertext="Id"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="affiliate_num" sortexpression="affiliate_num" readonly="True" headertext="Affiliate #"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="name" sortexpression="name" readonly="True" headertext="Name"></ASP:BoundColumn>
              <ASP:BoundColumn datafield="amount" sortexpression="amount" headertext="Amount" dataformatstring="{0:C}">
                <ItemStyle horizontalalign="Right"></ItemStyle>
              </ASP:BoundColumn>
              <ASP:EditCommandColumn buttontype="LinkButton" updatetext="Update" canceltext="Cancel" edittext="Edit">
                <ItemStyle forecolor="Blue"></ItemStyle>
              </ASP:EditCommandColumn>
            </Columns>
            <PagerStyle horizontalalign="Right" forecolor="Black" backcolor="White"></PagerStyle></ASP:DataGrid>
        </p>
	  </blockquote>
<p>From the above county appropriation, you have <ASP:Label id="Label_unappropriated_amount" runat="server" font-bold="True"></ASP:Label>&nbsp;left to appropriate to services by the regional deadline of
		<ASP:Label id="Label_regional_county_dictated_appropriation_deadline_date" runat="server" font-bold="True" font-underline="True"></ASP:Label>.</p>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
