<%@ Page language="c#" Debug="true" Codebehind="main.pas" AutoEventWireup="false" Inherits="main.TWebForm_main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
  </head>

  <body>
     <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder>
<p>To log into 
        <ASP:Label id="Label_application_name" runat="server"></ASP:Label>, please indicate what kind of user you are:</p>
      <ul>
        <li>
<p><strong><a href="login.aspx">Service (ambulance, QRS, rescue, helicopter, etc)<br>
              </a>
            </strong></p></li>
        <li>
<p><strong><a href="login_county_coord.aspx">County Coordinator<br>
              </a>
            </strong></p></li>
        <li>
<p><strong><a href="login_regional_staffer.aspx">Regional staffer</a>
            </strong></p>
        </li>
      </ul>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
     </form>
  </body>
</html>
