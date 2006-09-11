<%@ Page language="c#" Debug="true" Codebehind="withdraw_request_item.pas" AutoEventWireup="false" Inherits="withdraw_request_item.TWebForm_withdraw_request_item" %>
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
      <p><small>[ 
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:HyperLink id="HyperLink_request_item_detail" runat="server" navigateurl="request_item_detail.aspx">request item detail</ASP:HyperLink>&nbsp;form ]</small></p>
<p>
        <table bordercolor="#ffd700" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                      <td bgcolor="#ffd700">
        <ASP:Label id="Label_literal_warning" runat="server" font-bold="True" font-size="Large">&nbsp;Warning!&nbsp;</ASP:Label></td>
                    </tr>
                    <tr>
					  <td>
<p>Withdrawing an item from your request at this point is an <strong>irreversible</strong> action.</p>
<p>Are you sure you want to withdraw&nbsp;your <strong>Priority</strong>
		<ASP:Label id="Label_priority" runat="server" font-bold="True"></ASP:Label>&nbsp;item
		         (<ASP:Label id="Label_description" runat="server" font-bold="True"></ASP:Label>) from your request, and surrender
		<ASP:Label id="Label_emsof_ante" runat="server" font-bold="True"></ASP:Label>&nbsp;of EMSOF funds for use by others?</p>
<p>
		<table cellspacing="0" cellpadding="10" border="0">
			<tr>
			  <td>
				<div align="center">
		<ASP:Button id="Button_yes" runat="server" text="Yes"></ASP:Button>
				</div></td>
              <td>-- Withdraw the item from my request.</td>
			</tr>
            <tr>
			  <td>
                <div align="center"><ASP:Button id="Button_no" runat="server" text="No"></ASP:Button>
				</div></td>
              <td>-- Leave the item the way it is.</td>
			</tr>
        </table>
		</p>
					  </td>
					</tr>
				</table></td>
			</tr>
		</table></p>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
	 </form>
  </body>
</html>
