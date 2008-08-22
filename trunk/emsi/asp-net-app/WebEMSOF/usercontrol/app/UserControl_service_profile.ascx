<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_service_profile.pas" Inherits="UserControl_service_profile.TWebUserControl_service_profile"%>
<%@ Register TagPrefix="uc1" TagName="UserControl_print_div" Src="~/usercontrol/ki/UserControl_print_div.ascx" %>
<div id="Div_print_area">



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td valign="top"><font class="">Affiliate #:
</font></td>
            <td valign="top"><font class="">
                <asp:TextBox runat="server" columns="5" maxlength="5" id="TextBox_affiliate_num" enabled="false"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp; <asp:LinkButton runat="server" causesvalidation="False" id="LinkButton_search" visible="false">Lookup
</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp; <asp:LinkButton
                                runat="server" causesvalidation="False" id="LinkButton_reset" visible="false">Reset
</asp:LinkButton><br>
                <asp:DropDownList runat="server" autopostback="True" id="DropDownList_affiliate_num" visible="False"></asp:DropDownList><br>
              


</font></td>
            <td valign="top">
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_affiliate_num" errormessage="Please enter Affiliate num." display="Dynamic" font-bold="True" id="RequiredFieldValidator_affiliate_num">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Service name:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_name"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_name" errormessage="Please enter Name." display="Dynamic" font-bold="True" id="RequiredFieldValidator_name">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">County in EMSI region in which you are headquartered:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" id="TextBox_county_code"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_county_code" errormessage="Please enter County code." display="Dynamic" font-bold="True" id="RequiredFieldValidator_county_code">!ERR!
</asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_county_code" errormessage="Please enter a valid County code." display="Dynamic" font-bold="True" id="RegularExpressionValidator_county_code">!ERR!
</asp:RegularExpressionValidator></td>
          </tr>
          <tr>
            <td><font class="">Business phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_business_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Business fax #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_business_fax_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Website address:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_website_address"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Charter kind:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" id="TextBox_charter_kind"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_charter_kind" errormessage="Please enter Charter kind." display="Dynamic" font-bold="True" id="RequiredFieldValidator_charter_kind">!ERR!
</asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_charter_kind" errormessage="Please enter a valid Charter kind." display="Dynamic" font-bold="True" id="RegularExpressionValidator_charter_kind">!ERR!
</asp:RegularExpressionValidator></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Corpadmin contact name:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_corpadmin_contact_name"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_corpadmin_contact_name" errormessage="Please enter Corpadmin contact name." display="Dynamic" font-bold="True" id="RequiredFieldValidator_corpadmin_contact_name">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Corpadmin primary phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_corpadmin_primary_phone_num"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_corpadmin_primary_phone_num" errormessage="Please enter Corpadmin primary phone num." display="Dynamic" font-bold="True" id="RequiredFieldValidator_corpadmin_primary_phone_num">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Corpadmin secondary phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_corpadmin_secondary_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Corpadmin email address:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_corpadmin_email_address"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Be emsof participant:
</font></td>
            <td><font class="">
                <asp:CheckBox runat="server" id="CheckBox_be_emsof_participant"></asp:CheckBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Emsof nonparticipation reason:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" textmode="MultiLine" rows="2" id="TextBox_emsof_nonparticipation_reason"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Emsof contact name:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_emsof_contact_name"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Emsof contact email address:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_emsof_contact_email_address"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Emsof contact primary phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_emsof_contact_primary_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Emsof contact sms phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_emsof_contact_sms_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Coo name:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_coo_name"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_coo_name" errormessage="Please enter Coo name." display="Dynamic" font-bold="True" id="RequiredFieldValidator_coo_name">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Coo work phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_work_phone_num"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_coo_work_phone_num" errormessage="Please enter Coo work phone num." display="Dynamic" font-bold="True" id="RequiredFieldValidator_coo_work_phone_num">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Coo home phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_home_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Coo email address:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_coo_email_address"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Coo mobile phone or pager #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_mobile_phone_or_pager_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Md name:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_md_name"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Md office phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_office_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Md home phone #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_home_phone_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Md email address:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_md_email_address"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Md mobile phone or pager #:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_mobile_phone_or_pager_num"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Physical street address line 1:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_street_address_line_1"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_street_address_line_1" errormessage="Please enter Physical street address line 1." display="Dynamic" font-bold="True" id="RequiredFieldValidator_physical_street_address_line_1">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Physical street address line 2:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_street_address_line_2"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Physical city:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_city"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_city" errormessage="Please enter Physical city." display="Dynamic" font-bold="True" id="RequiredFieldValidator_physical_city">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Physical state:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="2" maxlength="2" id="TextBox_physical_state"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_state" errormessage="Please enter Physical state." display="Dynamic" font-bold="True" id="RequiredFieldValidator_physical_state">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Physical zip code:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_physical_zip_code"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_zip_code" errormessage="Please enter Physical zip code." display="Dynamic" font-bold="True" id="RequiredFieldValidator_physical_zip_code">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td><font class="">Mail address line 1:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_address_line_1"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_address_line_1" errormessage="Please enter Mail address line 1." display="Dynamic" font-bold="True" id="RequiredFieldValidator_mail_address_line_1">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Mail address line 2:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_address_line_2"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Mail city:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_city"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_city" errormessage="Please enter Mail city." display="Dynamic" font-bold="True" id="RequiredFieldValidator_mail_city">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Mail state:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="2" maxlength="2" id="TextBox_mail_state"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_state" errormessage="Please enter Mail state." display="Dynamic" font-bold="True" id="RequiredFieldValidator_mail_state">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td><font class="">Mail zip code:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="9" maxlength="9" id="TextBox_mail_zip_code"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_zip_code" errormessage="Please enter Mail zip code." display="Dynamic" font-bold="True" id="RequiredFieldValidator_mail_zip_code">!ERR!
</asp:RequiredFieldValidator></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td valign="top" nowrap="true">
              <p align="right">Type of service provided:<br>
                <small>(Check all that apply.)
</small>
              


</p></td>
            <td>
              <asp:CheckBox runat="server" text="QRS (recognized)" id="CheckBox_be_qrs"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="BLS Ambulance" id="CheckBox_be_bls_amb"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="ALS Ambulance" id="CheckBox_be_als_amb"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="ALS squad" id="CheckBox_be_als_squad"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="Air ambulance" id="CheckBox_be_air_amb"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="Rescue (recognized)" id="CheckBox_be_rescue"></asp:CheckBox><br>
              <asp:CheckBox runat="server" text="PA Turnpike contracted responses" id="CheckBox_be_pa_turnpike_contractor"></asp:CheckBox></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Num DOH-licensed vehicles:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" id="TextBox_num_doh_licensed_vehicles"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_doh_licensed_vehicles" errormessage="Please enter Num doh licensed vehicles." display="Dynamic" font-bold="True" id="RequiredFieldValidator_num_doh_licensed_vehicles">!ERR!
</asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_doh_licensed_vehicles" errormessage="Please enter a valid Num doh licensed vehicles." display="Dynamic" font-bold="True"
                                              id="RegularExpressionValidator_num_doh_licensed_vehicles">!ERR!
</asp:RegularExpressionValidator></td>
          </tr>
          <tr>
            <td><font class="">Num ambulances:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" id="TextBox_num_ambulances"></asp:TextBox>
              </font></td>
            <td>
              <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_ambulances" errormessage="Please enter Num ambulances." display="Dynamic" font-bold="True" id="RequiredFieldValidator_num_ambulances">!ERR!
</asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_ambulances" errormessage="Please enter a valid Num ambulances." display="Dynamic" font-bold="True" id="RegularExpressionValidator_num_ambulances">!ERR!
</asp:RegularExpressionValidator></td>
          </tr>
          <tr>
            <td><font class="">Be dera:
</font></td>
            <td><font class="">
                <asp:CheckBox runat="server" id="CheckBox_be_dera"></asp:CheckBox>
              </font></td>
            <td></td>
          </tr>
          <tr>
            <td><font class="">Charter other kind:
</font></td>
            <td><font class="">
                <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_charter_other_kind"></asp:TextBox>
              </font></td>
            <td></td>
          </tr>
        </table>



        <table cellspacing="0" cellpadding="10" border="0">
          <tr>
            <td>
              <p>By submitting this form to WebEMSOF, you are affirming that you are the contact person listed above, and you are agreeing to serve as the above service's EMSOF point of contact for this EMSOF cycle.&nbsp; You further affirm that if you must relinquish your responsibilities as the service's EMSOF point of contact during this cycle, you will give reasonable advanced notice to the service and to the regional council.
</p></td>
          </tr>
        </table>



</div>
<ASP:Button id="Button_submit" text="Submit" runat="server"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False"></ASP:Button>&nbsp;&nbsp;&nbsp;&nbsp; <uc1:UserControl_print_div id="UserControl_print_div" runat="server"></uc1:UserControl_print_div>
