<%@ Page language="c#" Debug="true" Codebehind="finalize.pas" AutoEventWireup="false" Inherits="finalize.TWebForm_finalize" %>
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
        <ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p><strong>Request phase finalization</strong></p>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_sorry" runat="server">
			<tr>
			  <td>
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
					  <td bgcolor="#f5f5f5"><em><strong><font color="#ff0000">SORRY...</font></strong>
						</em></td>
					</tr>
					<tr>
					  <td>
						<p>You've requested too much.</p>
						<p>The specified EMSOF reimbursement is more than the appropriation you received from the sponsoring county.</p>
						<p>Please close this browser window.&nbsp; On the underlying window,&nbsp;adjust your request to fit your appropriation.</p>
						<p>HINT:&nbsp; Make a note of the negative "remaining" amount.&nbsp; Select one of your request items.&nbsp; Enter an equivalent (positive) amount in the field labeled, "<strong>Additional</strong> amount, if any, that your service&nbsp;will pay, <strong>unreimbursed</strong>".&nbsp; Your request will no longer exceed your appropriation, and finalization will proceed normally.</p></td>
					</tr>
				</table></td>
			</tr>
		</table>
		<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1" id="Table_summary" runat="server">
			<tr>
			  <td>
              <table cellspacing="0" cellpadding="10" border="0">
                  <tr>
                    <td bgcolor="#f5f5f5"><strong>SUMMARY</strong></td>
                  </tr>
                  <tr>
                    <td>
                      <p>This form allows you to&nbsp;~~~ your Requested Items List to your County EMSOF Coordinator for approval.</p>
                      <p>You must confirm the following before clicking the LOCK AND ~~~:</p>
                      <p>1. Grand Total Cost &amp; up-front payment to vendors.</p>
                      <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
                        <p>
                          <ASP:CheckBox id="CheckBox1" runat="server"></ASP:CheckBox>
                        </p>
                      </blockquote>
                      <p>2. Total EMSOF Reimbursement.</p>
                      <p>3. Amount that will not be reimbursed.</p>
                      <p>4. Terms &amp; Conditions.</p>
                      <p>5. WebEMSOF will notify County EMSOF Coordinator&nbsp;of finalization via&nbsp;email.</p>
                      <p>6. You will have read-only access to your request until your County EMSOF Coordinator dispositions it.</p>
                      <p>7. Other deadlines.</p></td>
                  </tr>
              </table></td>
			</tr>
        </table>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
