<%@ Page language="c#" Debug="true" Codebehind="exception.pas" AutoEventWireup="false" Inherits="exception.TWebForm_exception" %>
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
      <p>
        <table bordercolor="#e00000" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
					  <td bgcolor="#f5f5f5"><h1><em><font color="#ff0000">Oops...</font></em></h1></td>
                    </tr>
                    <tr>
					  <td>
<h3>The application has encountered an unexpected problem and cannot continue normally.</h3>
<p>The Application Administrator has been notified by pager and email.</p>
	  <ul>
	  </ul>
	  <p>It would be a tremendous help if you could describe what you were doing when this problem occurred:</p>
	  <blockquote dir="ltr" style="MARGIN-RIGHT: 0px">
<p><textarea id="TextArea_user_comment" rows="5" cols="60" runat="server"></textarea></p>
<p><ASP:Button id="Button_submit" runat="server" text="Submit and return to Login page"></ASP:Button></p>
	  </blockquote>
					  </td>
                    </tr>
                </table></td>
            </tr>
        </table>
      </p>

	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
