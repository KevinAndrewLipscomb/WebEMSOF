<%@ Page language="c#" Debug="true" Codebehind="login.pas" AutoEventWireup="false" Inherits="login.TWebForm_login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
    <title id="Title" runat="server"></title>
  </head>

  <body ms_positioning="FlowLayout">
  <form runat="server">
		  <asp:placeholder id="PlaceHolder_precontent" runat="server">
	  </asp:placeholder>
			<font color="red">
			  <ul id="invalid_credentials_warning" runat="server">
				<li>Invalid service/password combination. Please try again.</li>
			  </ul>
			</font>
	<table cellspacing="0" cellpadding="0" border="1">
      <tbody>
        <tr>
          <td>
            <table cellspacing="0" cellpadding="5">
              <tbody>
                <tr>
                  <td>
                    <p align="right">Account:
                    </p>
                  </td>
                  <td>
                    <table cellspacing="0" cellpadding="5">
                      <tbody>
                        <tr>
                          <td>
                            <asp:dropdownlist id="DropDownList_account_descriptor" 
                                              runat="server">
                            </asp:dropdownlist>
                          </td>
                          <td><ASP:RangeValidator id="RangeValidator_account" runat="server" errormessage="Please select an account." font-bold="True" controltovalidate="DropDownList_account_descriptor" minimumvalue="1" maximumvalue="MAXINT">!ERR!</ASP:RangeValidator>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <p align="right">Password:
					</p>
                  </td>
                  <td>
													<asp:textbox id="TextBox_password" runat="server" textmode="Password"></asp:textbox>
											         </td>
                </tr>
                <tr>
                  <td>
                  </td>
                  <td>
                    <asp:checkbox id="CheckBox_keep_me_logged_in" 
                                  runat="server" 
                                  text="Keep me logged in on this computer" enabled="False">
                    </asp:checkbox>
                  </td>
                </tr>
                <tr>
                  <td>
                  </td>
				  <td>
                    
						<table cellspacing="0" cellpadding="5" width="1%">
                            <tr>
                              <td><asp:button id="Button_log_in" 
                                runat="server" text="Log in" font-bold="True">
                    </asp:button></td>
                              <td nowrap="true">
								<ASP:button id="Button_new_password" runat="server" text="Email new password"></ASP:button></td>
							</tr>
                        </table>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
	</table>
      <p></p>
<h3>EMSOF documentation:
</h3>
<ul>
  <li>
	<a href="http://www.emsi.org/programs/emsof">Relevant sections of EMS Act </a>
  <li>
	  <a href="http://www.emsi.org/programs/emsof">Current EMSOF-related PA Bulletin(s)</a> <li>
		<a href="http://www.emsi.org/programs/emsof">Regional policies, deadlines, etc</a>
  </li>
</ul>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
</form>
</body>
</html>
