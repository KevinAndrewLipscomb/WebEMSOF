<%@ Page language="c#" Debug="true" Codebehind="regional_staffer_fiscal_year_selection.pas" AutoEventWireup="false" Inherits="regional_staffer_fiscal_year_selection.TWebForm_account_overview"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <title id="Title" runat="server"></title>
  </head>
  <body>
    <form runat="server">
      <p>
        <asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
      </p>
	  <p><small>[
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ 
		  Change 
		  <ASP:HyperLink id="HyperLink_change_password" runat="server" navigateurl="change_password.aspx">password</ASP:HyperLink>&nbsp;| <ASP:HyperLink id="HyperLink_change_email_address" runat="server" navigateurl="change_password.aspx">email address</ASP:HyperLink>&nbsp;
		       ]</small>
	  </p>
	  <p>
        <ASP:Label id="Label_regional_staffer_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>
      </p>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Available cycles</strong></td>
                    </tr>
                    <tr>
                      <td>
<p>Which allocation do you want to work with?&nbsp; <ASP:RequiredFieldValidator id="RequiredFieldValidator_appropriation" runat="server" errormessage="Please choose an appropriation." font-bold="True" controltovalidate="RadioButtonList_appropriation">!ERR!</ASP:RequiredFieldValidator></p>
<p>
        <ASP:RadioButtonList id="RadioButtonList_appropriation" runat="server"></ASP:RadioButtonList></p>
<p>
        <ASP:Button id="Button_continue" runat="server" text="Continue"></ASP:Button></p></td>
                    </tr>
                </table></td>
            </tr>
        </table>
      </p>
      <p>
      </p>
	  <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
