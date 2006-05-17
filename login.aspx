<%@ Page language="c#" Debug="true" Codebehind="login.pas" AutoEventWireup="false" Inherits="login.TWebForm_login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
	<!-- $Id$ -->
  </head>

  <body ms_positioning="FlowLayout">
  <form runat="server">
		  <asp:placeholder id="PlaceHolder_precontent" runat="server">
	  </asp:placeholder>
			<font color="red">
			  <ul id="invalid_credentials_warning" runat="server">
				<li>Invalid user/password combination. Please try again.</li>
			  </ul>
			</font>
		  <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
			  <tr>
				<td>
				  <table cellspacing="0" cellpadding="5" border="0">
					  <tr>
						<td bgcolor="#f5f5f5"><strong>Log in</strong></td>
					  </tr>
					  <tr>
						<td>
			<table cellspacing="0" cellpadding="5">
			  <tbody>
				<tr>
				  <td>What kind of
                              <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;user are you?</td>
				  <td>
									  <ASP:DropDownList id="DropDownList_user_kind" runat="server" autopostback="True">
                                <ASP:ListItem value="0">-- Select --</ASP:ListItem>
                                <ASP:ListItem value="service">Service (Ambulance, QRS, ALS Squad, etc)</ASP:ListItem>
                                <ASP:ListItem value="county">County Coordinator</ASP:ListItem>
                                <ASP:ListItem value="regional_staffer">Regional staffer</ASP:ListItem></ASP:DropDownList><ASP:RegularExpressionValidator id="RegularExpressionValidator_user_kind" runat="server" errormessage="Please select a user kind." font-bold="True" controltovalidate="DropDownList_user_kind" validationexpression="[a-z]+">!ERR!</ASP:RegularExpressionValidator>
									</td>
				</tr>
				<tr>
				  <td>
					<p align="right"><ASP:Label id="Label_user" runat="server" enabled="False">User</ASP:Label>:</p>
				  </td>
				  <td>
							<asp:dropdownlist id="DropDownList_user"
											  runat="server">
							</asp:dropdownlist><ASP:RangeValidator id="RangeValidator_username" runat="server" errormessage="Please select a user." font-bold="True" controltovalidate="DropDownList_user" minimumvalue="1" maximumvalue="99999">!ERR!</ASP:RangeValidator>
				  </td>
				</tr>
				<tr>
				  <td>
					<p align="right">Password:</p>
				  </td>
                  <td>
													<asp:textbox id="TextBox_password" runat="server" textmode="Password"></asp:textbox><ASP:RegularExpressionValidator id="RegularExpressionValidator_password" runat="server" errormessage='Please use only letters, numbers, and the underscore ("_") character (or local equivalents) in your password.' font-bold="True" controltovalidate="TextBox_password" validationexpression="\w+">!ERR!</ASP:RegularExpressionValidator>
											         </td>
				</tr>
                <tr>
				  <td>
                  </td>
				  <td>
                    <asp:checkbox id="CheckBox_keep_me_logged_in" 
								  runat="server"
                                  text="Keep me logged in on this computer">
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
				  </table>
				</td>
			  </tr>
		  </table>
      <p></p>
      <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>EMSOF documentation</strong></td>
                    </tr>
                    <tr>
                      <td>
<ul>
  <li>
	<a href="http://www.emsi.org/programs/emsof">Relevant sections of EMS Act </a>
  <li>
	  <a href="http://www.emsi.org/programs/emsof">Current EMSOF-related PA Bulletin(s)</a> <li>
		<a href="http://www.emsi.org/programs/emsof">Regional policies, deadlines, etc</a>
  </li>
</ul></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <p></p>
<h3>
</h3>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder>
</form>
</body>
</html>
