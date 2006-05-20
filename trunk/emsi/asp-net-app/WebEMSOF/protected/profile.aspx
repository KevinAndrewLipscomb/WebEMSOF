<%@ Page language="c#" Debug="true" Codebehind="profile.pas" AutoEventWireup="false" Inherits="profile.TWebForm_profile" %>
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
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:HyperLink id="HyperLink_service_overview" runat="server" navigateurl="service_overview.aspx">service overview</ASP:HyperLink>&nbsp;form ]</small></p>
      <p>
        <ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label></p>
<p><strong>
          <ASP:Label id="Label_application_name" runat="server"></ASP:Label>&nbsp;profile</strong></p>
<p>
        <table cellspacing="0" cellpadding="0" width="%" border="1">
            <tr><td>
                <table cellspacing="0" cellpadding="5" width="%" border="0">
	  <tr>
		<td nowrap="true">
                        <p align="right">Affiliate #:</p></td>
		<td><ASP:Label id="Label_affiliate_num" runat="server"></ASP:Label></td>
                      <td></td>
	  </tr>
	  <tr>
		<td nowrap="true">
                        <p align="right">Service name:</p></td>
		<td>
                        <ASP:TextBox id="TextBox_service_name" runat="server" maxlength="127"></ASP:TextBox></td>
					  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_service_name" runat="server" errormessage="Service name is required." controltovalidate="TextBox_service_name" font-bold="True">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_service_name" runat="server" errormessage="Please leave disallowed punctuation out of your service name." font-bold="True" controltovalidate="TextBox_service_name" validationexpression="[0-9a-zA-z\.,'#%&amp;()-_ ]+">!ERR!</ASP:RegularExpressionValidator></td>
	  </tr>
	  <tr>
							  <td valign="top" nowrap="true">
						<p align="right">Type of license/recognition:<br><small>(Check all that apply.)</small></p></td>
		<td>
		  <p>
						  <ASP:CheckBox id="CheckBox_qrs" runat="server" text="QRS"></ASP:CheckBox>&nbsp;&nbsp; 
						  <ASP:CheckBox id="CheckBox_bls_amb" runat="server" text="BLS Ambulance"></ASP:CheckBox>&nbsp;&nbsp; 
						  <ASP:CheckBox id="CheckBox_als_amb" runat="server" text="ALS Ambulance"></ASP:CheckBox>&nbsp;&nbsp; 
						  <ASP:CheckBox id="CheckBox_als_squad" runat="server" text="ALS Squad"></ASP:CheckBox>&nbsp;&nbsp; 
						  <ASP:CheckBox id="CheckBox_air_amb" runat="server" text="Air Ambulance"></ASP:CheckBox>&nbsp;&nbsp; 
						  <ASP:CheckBox id="CheckBox_rescue" runat="server" text="Rescue"></ASP:CheckBox>
		  </p></td>
                      <td></td>
	  </tr>
	  <tr>
		<td valign="top" nowrap="true">
                        <p align="right">Address:</p></td>
		<td>
						<ASP:TextBox id="TextBox_address_line_1" runat="server" maxlength="127"></ASP:TextBox><br>
                        <ASP:TextBox id="TextBox_address_line_2" runat="server" maxlength="127"></ASP:TextBox></td>
                      <td valign="top">
                        <ASP:RequiredFieldValidator id="RequiredFieldValidator_address_line_1" runat="server" font-bold="True" controltovalidate="TextBox_address_line_1" errormessage="At least one address line is required.">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_address_line_1" runat="server" font-bold="True" controltovalidate="TextBox_address_line_1" errormessage="Please leave disallowed characters out of the first address line."
                                validationexpression="[0-9a-zA-Z\.,#%&amp;()-_' ]*">!ERR!</ASP:RegularExpressionValidator>
  <br><ASP:RegularExpressionValidator id="RegularExpressionValidator_address_line_2" runat="server" font-bold="True" controltovalidate="TextBox_address_line_2" errormessage="Please leave disallowed characters out of the second address line."
                                validationexpression="[0-9a-zA-Z\.,#%&amp;()-_' ]*">!ERR!</ASP:RegularExpressionValidator></td>
	  </tr>
	  <tr>
		<td nowrap="true">
						<p align="right">City:</p></td>
		<td>
						<ASP:TextBox id="TextBox_city" runat="server" maxlength="127"></ASP:TextBox></td>
					  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_city" runat="server" errormessage="City is required." controltovalidate="TextBox_city" font-bold="True">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_city" runat="server" font-bold="True" controltovalidate="TextBox_city" errormessage="Please leave disallowed characters out of the city name." validationexpression="[a-zA-Z\.' ]+">!ERR!</ASP:RegularExpressionValidator></td>
	  </tr>
	  <tr>
		<td nowrap="true">
						<p align="right">State:</p></td>
		<td>
						<strong>PA</strong></td>
					  <td></td>
	  </tr>
	  <tr>
		<td nowrap="true">
						<p align="right">Zip code:
  <br><small>(5 or 9 numerals only)</small></p></td>
		<td>
						<ASP:TextBox id="TextBox_zip_code" runat="server" maxlength="9"></ASP:TextBox></td>
					  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_zip_code" runat="server" errormessage="Zip code is required." controltovalidate="TextBox_zip_code" font-bold="True">!ERR!</ASP:RequiredFieldValidator>
						<ASP:RegularExpressionValidator id="RegularExpressionValidator_zip_code" runat="server" errormessage="Invalid zip code." controltovalidate="TextBox_zip_code" validationexpression="\d{5}(\d{4})?" font-bold="True">!ERR!</ASP:RegularExpressionValidator></td>
	  </tr>
	  <tr>
		<td nowrap="true">						<p align="right">Federal Employer (tax) ID #:
  <br><small>(numerals only)</small></p></td>
</td>
		<td>
                        <ASP:TextBox id="TextBox_federal_tax_id_num" runat="server" maxlength="9"></ASP:TextBox></td>
                      <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_federal_tax_id_num" runat="server" errormessage="Federal Employer (tax) ID is required." controltovalidate="TextBox_contact_person_name" font-bold="True">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_federal_tax_id_num" runat="server" errormessage="Invalid Federal Employer (tax) ID number." controltovalidate="TextBox_federal_tax_id_num" validationexpression="\d{9}" font-bold="True">!ERR!</ASP:RegularExpressionValidator></td></tr>
	  <tr>
		<td nowrap="true">
                        <p align="right">Contact person's name:</p></td>
        <td>
                        <ASP:TextBox id="TextBox_contact_person_name" runat="server" maxlength="127"></ASP:TextBox></td>
                      <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_contact_person_name" runat="server" errormessage="Contact person's name is required." controltovalidate="TextBox_contact_person_name" font-bold="True">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_contact_person_name" runat="server" errormessage="Please leave disallowed characters out of contact person's name." font-bold="True" controltovalidate="TextBox_contact_person_name" validationexpression="[a-zA-Z\., ]+">!ERR!</ASP:RegularExpressionValidator></td>
      </tr>
      <tr>
		<td nowrap="true">
						<p align="right">Contact person's phone #:
  <br><small>(Include area code, numerals only)</small></p></td>
        <td>
                        <ASP:TextBox id="TextBox_contact_person_phone_num" runat="server" maxlength="10"></ASP:TextBox></td>
                      <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_contact_person_phone_num" runat="server" errormessage="Contact person's phone number is required." controltovalidate="TextBox_contact_person_phone_num" font-bold="True">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_contact_person_phone_num" runat="server" errormessage="Invalid phone number." controltovalidate="TextBox_contact_person_phone_num" validationexpression="\d{10}" font-bold="True">!ERR!</ASP:RegularExpressionValidator></td>
      </tr>
                    <tr>
                      <td></td>
                      <td>
                        <ASP:Button id="Button_submit" runat="server" text="Submit"></ASP:Button></td>
                      <td></td>
                    </tr></table></td></tr></tbody></table></p>
	<asp:placeholder id="PlaceHolder_postcontent" runat="server">
	</asp:placeholder></form></body></html>
