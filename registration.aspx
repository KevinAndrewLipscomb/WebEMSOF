<%@ Page language="c#" Debug="true" Codebehind="registration.pas" AutoEventWireup="false" Inherits="registration.TWebForm_registration" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <title></title>
  </head>

  <body>
     <form runat="server">
      <asp:placeholder id="PlaceHolder_precontent" runat="server">
      </asp:placeholder>
<p>Initial registration form</p>
    <p>
    <table cellspacing="0" cellpadding="0" border="1">
      <tbody>
        <tr>
          <td>
            <table cellspacing="0" cellpadding="5">
              <tbody>
                <tr>
                  <td>
                    <p align="right">Service name:
                    </p>
                  </td>
                  <td>
                        <ASP:Label id="Label_service_name" runat="server" font-bold="True"></ASP:Label>
                  </td>
                </tr>
                <tr>
                  <td>
                    <p align="right">Enter&nbsp;the password you would like to use for this system:
  <br><small>(Read the <a href="password_details.aspx">important details</a>.)</small></p>
                  </td>
                  <td>
                    <table cellspacing="0" cellpadding="5">
                      <tbody>
                        <tr>
                          <td>
							<asp:textbox id="TextBox_nominal_password"
                                         runat="server" textmode="Password">
                            </asp:textbox>
                          </td>
                          <td>
							<asp:requiredfieldvalidator id="RequiredFieldValidator_nominal_password"
                                                        runat="server" 
                                                        enableclientscript="False" 
                                                        font-bold="True" 
														errormessage="Nominal password is required."
														controltovalidate="TextBox_nominal_password">!ERR!</asp:requiredfieldvalidator>
                                <ASP:CompareValidator id="CompareValidator_passwords" runat="server" errormessage="Password values do not match.  Please try again." font-bold="True" controltocompare="TextBox_nominal_password"
                                                      controltovalidate="TextBox_confirmation_password" enableclientscript="False">!ERR!</ASP:CompareValidator>
                                <ASP:RegularExpressionValidator id="RegularExpressionValidator_password_sql_safe" runat="server" errormessage="Password contains unacceptable characters.  Please remove special characters." validationexpression="\w+([-+.]\w+)*" font-bold="True"
                                                                controltovalidate="TextBox_nominal_password" enableclientscript="False">!ERR!</ASP:RegularExpressionValidator>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
					<p align="right">Re-enter the password to prevent typing mistakes:</p>
                  </td>
				  <td>
					<table cellspacing="0" cellpadding="5">
					  <tbody>
						<tr>
						  <td>
							<asp:textbox id="TextBox_confirmation_password"
										 runat="server" textmode="Password">
							</asp:textbox>
						  </td>
						  <td>
							<asp:requiredfieldvalidator id="RequiredFieldValidator_confirmation_password"
														runat="server"
														enableclientscript="False"
														font-bold="True"
														errormessage="Confirmation password is required."
														controltovalidate="TextBox_confirmation_password">!ERR!</asp:requiredfieldvalidator>
						  </td>
						</tr>
					  </tbody>
					</table>
				  </td>
				</tr>
				<tr>
				  <td>
						<p align="right">Enter your email address:</p>
				  </td>
				  <td>
											<table cellspacing="0" cellpadding="5">
					  <tbody>
						<tr>
						  <td>
							<asp:textbox id="TextBox_nominal_email_address"
										 runat="server">
							</asp:textbox>
						  </td>
						  <td>
							<asp:requiredfieldvalidator id="RequiredFieldValidator_nominal_email_address"
														runat="server"
														enableclientscript="False"
														font-bold="True"
														errormessage="Nominal email address is required."
														controltovalidate="TextBox_nominal_email_address">!ERR!</asp:requiredfieldvalidator><ASP:CompareValidator id="CompareValidator_email_addresses" runat="server" errormessage="Email address values do not match.  Please try again." font-bold="True" controltocompare="TextBox_nominal_email_address" controltovalidate="TextBox_confirmation_email_address" enableclientscript="False">!ERR!</ASP:CompareValidator>
                                <ASP:RegularExpressionValidator id="RegularExpressionValidator_email_address_rfc_legal" runat="server" errormessage="Invalid email address.  Please check your typing." validationexpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                font-bold="True" controltovalidate="TextBox_nominal_email_address" enableclientscript="False">!ERR!</ASP:RegularExpressionValidator>
						  </td>
						</tr>
					  </tbody>
					</table>
				  </td>
				</tr>
				<tr>
				  <td>
						<p align="right">Re-enter your email address:</p>
				  </td>
				  <td>
					<table cellspacing="0" cellpadding="5">
					  <tbody>
						<tr>
						  <td>
							<asp:textbox id="TextBox_confirmation_email_address"
										 runat="server">
							</asp:textbox>
						  </td>
						  <td>
							<asp:requiredfieldvalidator id="RequiredFieldValidator_confirmation_email_address"
														runat="server"
														enableclientscript="False"
														font-bold="True"
														errormessage="Confirmation email address is required."
														controltovalidate="TextBox_confirmation_email_address">!ERR!</asp:requiredfieldvalidator>
						  </td>
						</tr>
					  </tbody>
					</table>
				  </td>
				</tr>
				<tr>
				  <td>
				  </td>
				  <td>&nbsp;
					<asp:button id="Button_main_submit"
								runat="server" text="Register">
					</asp:button>
				  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
</p>
<p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder>
</p>
     </form>
  </body>
</html>
