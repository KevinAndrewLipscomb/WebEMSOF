<%@ Page language="c#" Debug="true" Codebehind="new_password.pas" AutoEventWireup="false" Inherits="new_password.TWebForm_new_password" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <title id="Title" runat="server"></title>
  </head>

  <body>
     <form runat="server">
      <p>
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder></p>
      <p>
        <ASP:Label id="Label_account_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p></p>
      <p>
        <table cellspacing="0" cellpadding="5" width="%" border="1">
            <tr>
              <td>A temporary WebEMSOF password has been sent to 
                <ASP:Label id="Label_email_address" runat="server" font-bold="True"></ASP:Label>.&nbsp; Please log in again after you receive it.&nbsp; You will receive further instructions at that time.</td>
            </tr>
        </table></p>
      <p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder></p>
     </form>
  </body>
</html>
