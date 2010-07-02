<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_service_profile.ascx.cs" Inherits="UserControl_service_profile.TWebUserControl_service_profile"%>
<style type="text/css">
  .style1 {
    text-align: center;
  }
</style>
<table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr>
          <td bgcolor="#f5f5f5"><strong>Introduction</strong></td>
        </tr>
        <tr>
          <td>
            <small>
              <ul>
                <li><p>Changes will <em>not</em> be saved until you press the Submit button at the bottom of the page.</p></li>
                <li><p>Asterisks ("*") indicate required items.</p></li>
                <li><p>For the Regional Annual Survey, this profile...<br/>
                  <asp:RadioButtonList id="RadioButtonList_be_valid_profile" runat="server">
                    <asp:ListItem value="FALSE">has NOT yet been accepted</asp:ListItem>
                    <asp:ListItem value="TRUE">HAS been accepted</asp:ListItem>
                  </asp:RadioButtonList><br/>...by WebEMSOF and the Regional Council.</p></li>
                <li><p>This service...<br/>
                  <asp:RadioButtonList id="RadioButtonList_be_distressed" runat="server">
                    <asp:ListItem value="FALSE">does NOT qualify</asp:ListItem>
                    <asp:ListItem value="TRUE">DOES qualify</asp:ListItem>
                  </asp:RadioButtonList><br/>...for DISTRESSED status under EMSOF rules.</p></li>
              </ul>
            </small>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellspacing="0" cellpadding="10" border="0">
        <tr><td bgcolor="whitesmoke"><strong>Basic identification information</strong></td></tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right" bgcolor="gainsboro" valign="top"><font class="">Affiliate #:</font></td>
          <td valign="top"><font class="">
              <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                  <td valign="middle">
                    <table cellspacing="0" cellpadding="0" border="0">
                      <tr>
                        <td>
              <asp:TextBox runat="server" columns="5" maxlength="5" id="TextBox_affiliate_num" enabled="false"></asp:TextBox>*<ASP:Button id="Button_lookup" runat="server" causesvalidation="False" text="LOOKUP" onclick="Button_lookup_Click"></ASP:Button>
                        </td>
                        <td nowrap><small><small><asp:Label id="Label_lookup_arrow" runat="server">&lt;--</asp:Label></small></small></td>
                        <td><small><small><em><asp:Label id="Label_lookup_hint" runat="server">Lookup by partial or full Affiliate # or Name</asp:Label></em></small></small></td>
                      </tr>
                    </table>
                  </td>
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td valign="middle">
                    <small>
                      <ASP:LinkButton id="LinkButton_reset" runat="server" causesvalidation="False" enabled="False" onclick="LinkButton_reset_Click">New lookup</ASP:LinkButton>
                    </small>
                  </td>
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td valign="middle"></td>
                </tr>
              </table>
              <asp:LinkButton id="LinkButton_go_to_match_first" runat="server" text='<IMG src="~/protected/image/first_track_blue16_h.png" alt="First match" border="0" height="16" width="16" />' causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_first_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_prior" runat="server" text='<IMG src="~/protected/image/play_blue16_h-flipped.png" alt="Prior match" border="0" height="16" width="16" />' causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_prior_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_next" runat="server" text='<IMG src="~/protected/image/play_blue16_h.png" alt="Next match" border="0" height="16" width="16" />' causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_next_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_last" runat="server" text='<IMG src="~/protected/image/last_track_blue16_h.png" alt="Last match" border="0" height="16" width="16" />' causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_last_Click"></asp:LinkButton>
              <asp:DropDownList runat="server" autopostback="True" id="DropDownList_affiliate_num" visible="False" onselectedindexchanged="DropDownList_affiliate_num_SelectedIndexChanged"></asp:DropDownList><br/></font></td>
          <td nowrap valign="top">
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_affiliate_num" errormessage="Please enter Affiliate num." font-bold="True" id="RequiredFieldValidator_affiliate_num">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Service name:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_name" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_name" errormessage="Please enter service Name." font-bold="True" id="RequiredFieldValidator_name">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Federal Employer (tax) ID #:<br/><small>(numerals only)</small></font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="9" maxlength="9" id="TextBox_federal_tax_id" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_federal_tax_id" errormessage="Please enter a Federal Employer (tax) ID #." font-bold="True" id="RequiredFieldValidator_federal_tax_id">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_federal_tax_id" runat="server" errormessage="Please enter a valid Federal Employer (tax) ID # using numerals only." font-bold="True" controltovalidate="TextBox_federal_tax_id"
              validationexpression="\d{9}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">County in EMSI region in which you are headquartered:</font></td>
          <td><font class="">
          <asp:DropDownList id="DropDownList_county" runat="server" enabled="False"></asp:DropDownList>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="DropDownList_county" errormessage="Please enter County." font-bold="True" id="RequiredFieldValidator_county_code">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Business phone #:<br/><small>(numerals only)</small></font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_business_phone_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap><asp:RegularExpressionValidator id="RegularExpressionValidator_business_phone_num" runat="server" errormessage="Please enter a valid Business phone # using numerals only." font-bold="True" controltovalidate="TextBox_business_phone_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Business fax #: <br/><small>(numerals only)</small></font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_business_fax_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap><asp:RegularExpressionValidator id="RegularExpressionValidator_business_fax_num" runat="server" errormessage="Please enter a valid Business fax # using numerals only." font-bold="True" controltovalidate="TextBox_business_fax_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Website address:</font></td>
          <td>
                        <tt>http://</tt><asp:TextBox runat="server" columns="40" maxlength="127" id="TextBox_website_address" enabled="False"></asp:TextBox></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_website_address" runat="server" errormessage="Please enter a valid Website address." font-bold="True" controltovalidate="TextBox_website_address" validationexpression="[0-9a-zA-Z\-_./]+">!ERR!</asp:RegularExpressionValidator>
        <asp:CustomValidator id="CustomValidator_website_address" runat="server" errormessage="Please enter a valid Website address domain name." font-bold="True" controltovalidate="TextBox_website_address" onservervalidate="CustomValidator_website_address_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right" valign="top"><font class="">Choose the value that best describes your organization:</font></td>
          <td><font class="">
          <asp:UpdatePanel id="UpdatePanel_charter_kind" runat="server" updatemode="Conditional">
                            <ContentTemplate>
                              <asp:DropDownList id="DropDownList_charter_kind" runat="server" autopostback="True" enabled="False" onselectedindexchanged="DropDownList_charter_kind_SelectedIndexChanged"></asp:DropDownList>*
                        <asp:RequiredFieldValidator id="RequiredFieldValidator_charter_other_kind" runat="server" errormessage="Please describe what Other kind of organization you are." font-bold="True" controltovalidate="TextBox_charter_other_kind">!ERR!</asp:RequiredFieldValidator><br/>
                              <asp:Label id="Label_charter_other_kind" runat="server" enabled="False" font-size="X-Small" text="If Other, specify:"></asp:Label>
                              <asp:TextBox id="TextBox_charter_other_kind" runat="server" enabled="false" maxlength="255" columns="56"></asp:TextBox>
                            </ContentTemplate>
          </asp:UpdatePanel></font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="DropDownList_charter_kind" errormessage="Please enter Charter kind." font-bold="True" id="RequiredFieldValidator_charter_kind">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Contact information for Corporate/Administrative direction</strong></p>
            <p><small>These questions refer to your service's primary CORPORATE or ADMINISTRATIVE officer. This should be your President, Chairman of the Board, Owner, etc.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">Name:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_corpadmin_contact_name" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_corpadmin_contact_name" errormessage="Please enter Corporate/Admin contact name." font-bold="True" id="RequiredFieldValidator_corpadmin_contact_name">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Primary phone #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_corpadmin_primary_phone_num" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_corpadmin_primary_phone_num" errormessage="Please enter Corporate/Admin primary phone num." font-bold="True" id="RequiredFieldValidator_corpadmin_primary_phone_num">!ERR!</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_corpadmin_primary_phone_num" runat="server" errormessage="Please enter a valid Corporate/Admin primary phone number using numerals only." font-bold="True"
                                        controltovalidate="TextBox_corpadmin_primary_phone_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Secondary phone #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_corpadmin_secondary_phone_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_corpadmin_secondary_phone_num" runat="server" errormessage="Please enter a valid Corporate/Admin secondary phone number using numerals only." font-bold="True"
                                        controltovalidate="TextBox_corpadmin_secondary_phone_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Email address:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_corpadmin_email_address" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_corpadmin_email_address" runat="server" errormessage="Please enter a valid Corporate/Admin email address" font-bold="True" controltovalidate="TextBox_corpadmin_email_address"
          validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
        <asp:CustomValidator id="CustomValidator_corpadmin_email_address" runat="server" errormessage='Please enter a Corporate/Admin email address with a valid Domain Name (the part after the "@").' font-bold="True"
          controltovalidate="TextBox_corpadmin_email_address" onservervalidate="CustomValidator_corpadmin_email_address_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Contact information for EMSOF program</strong></p>
            <p><small>These questions tell EMSI which member of your service is the primary Point Of Contact for matters concerning the EMSOF grant program.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><asp:UpdatePanel id="UpdatePanel_be_emsof_particpant" runat="server" updatemode="Conditional"><ContentTemplate>
        <table cellspacing="0" cellpadding="5" border="0"><!-- + -->
          <tr>
            <td valign="top" align="right"><font class="">Does your service plan to participate in this year's EMSOF Provider Equipment grant program?*</font></td>
            <td><font class="">
                <asp:RadioButtonList id="RadioButtonList_be_emsof_participant" runat="server" autopostback="True" repeatdirection="Horizontal" enabled="False" onselectedindexchanged="RadioButtonList_be_emsof_participant_SelectedIndexChanged">
                  <asp:ListItem selected="True" value="TRUE">Yes</asp:ListItem>
                  <asp:ListItem value="FALSE">No</asp:ListItem>
                </asp:RadioButtonList>
                <p>
                  <asp:Label id="Label_emsof_nonparticipation_reason" enabled="False" runat="server" text="If no, why not?" font-size="X-Small"></asp:Label><br/>
                  <asp:TextBox id="TextBox_emsof_nonparticipation_reason" enabled="False" columns="50" runat="server" rows="2" textmode="MultiLine"></asp:TextBox>
                </p>
              </font></td>
            <td nowrap>
              <asp:RequiredFieldValidator id="RequiredFieldValidator_be_emsof_participant" runat="server" font-bold="True" errormessage="Please answer the question about EMSOF participation." controltovalidate="RadioButtonList_be_emsof_participant">!ERR!</asp:RequiredFieldValidator></td>
          </tr>
          <tr id="TableRow_emsof_contact_name" runat="server">
            <td align="right"><font class="">EMSOF contact person's name:</font></td>
            <td nowrap><font class="">
                <asp:TextBox id="TextBox_emsof_contact_name" maxlength="127" columns="60" runat="server" enabled="False"></asp:TextBox>*</font></td>
            <td nowrap>
              <asp:RequiredFieldValidator id="RequiredFieldValidator_emsof_contact_name" runat="server" font-bold="True" errormessage="Please enter an EMSOF Contact name." controltovalidate="TextBox_emsof_contact_name">!ERR!</asp:RequiredFieldValidator></td>
          </tr>
          <tr id="TableRow_emsof_contact_primary_phone_num" runat="server">
            <td align="right"><font class="">Primary phone #:</font></td>
            <td><font class="">
                <asp:TextBox id="TextBox_emsof_contact_primary_phone_num" maxlength="10" columns="10" runat="server" enabled="False"></asp:TextBox>*</font></td>
            <td nowrap>
              <asp:RequiredFieldValidator id="RequiredFieldValidator_emsof_contact_primary_phone_num" runat="server" font-bold="True" errormessage="Please enter an EMSOF Contact primary phone number."
                                          controltovalidate="TextBox_emsof_contact_primary_phone_num">!ERR!</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator_emsof_contact_primary_phone_num" runat="server" font-bold="True" errormessage="Please enter a valid EMSOF Contact primary phone number using numerals only."
                                              controltovalidate="TextBox_emsof_contact_primary_phone_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
          </tr>
          <tr id="TableRow_emsof_contact_sms_phone_num" runat="server">
            <td valign="bottom" align="right">
              <p><font class="">In the future, WebEMSOF may be able to send a text message to your cellphone when the status of your EMSOF request changes.</font>
              </p>
              <p><font class="">What is your cellphone number?</font>
              </p></td>
            <td valign="bottom"><font class="">
                <asp:TextBox id="TextBox_emsof_contact_sms_phone_num" maxlength="10" columns="10" runat="server" enabled="False"></asp:TextBox>
              </font></td>
            <td nowrap><asp:RegularExpressionValidator id="RegularExpressionValidator_emsof_contact_sms_phone_num" runat="server" font-bold="True" errormessage="Please enter a valid EMSOF Contact cellphone number using numerals only."
                                              controltovalidate="TextBox_emsof_contact_sms_phone_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
          </tr>
      <!-- - --></table></ContentTemplate></asp:UpdatePanel></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Contact information for operations direction</strong></p>
            <p><small>The following questions refer to your service's primary OPERATIONS officer. This should be your Chief, Operations Director, etc. This person typically possesses rank insignia and is ultimately&nbsp;in charge of&nbsp;field operations.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">Primary operations officer name:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_coo_name" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_coo_name" errormessage="Please enter Operations officer name." font-bold="True" id="RequiredFieldValidator_coo_name">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Work phone #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_work_phone_num" enabled="False"></asp:TextBox>*</font></td>
          <td nowrap><asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_coo_work_phone_num" errormessage="Please enter Operations officer work phone num." font-bold="True" id="RequiredFieldValidator_coo_work_phone_num">!ERR!</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_coo_work_phone_num" runat="server" errormessage="Please enter a valid operations officer work phone number, using numerals only." font-bold="True" controltovalidate="TextBox_coo_work_phone_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Home phone #:</font></td><td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_home_phone_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_coo_home_phone_num" runat="server" errormessage="Please enter a valid operations officer home phone number, using numerals only." font-bold="True" controltovalidate="TextBox_coo_home_phone_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Email address:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_coo_email_address" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_coo_email_address" runat="server" errormessage="Please enter a valid operations officer email address." font-bold="True" controltovalidate="TextBox_coo_email_address"
                                        validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
        <asp:CustomValidator id="CustomValidator_coo_email_address" runat="server" errormessage='Please enter an operations officer email address with a valid domain name (the part after the "@").' font-bold="True" controltovalidate="TextBox_coo_email_address" onservervalidate="CustomValidator_coo_email_address_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mobile phone/pager #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_coo_mobile_phone_or_pager_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_coo_mobile_phone_or_pager_num" runat="server" errormessage="Please enter a valid operations officer cellphone/pager number, using numerals only." font-bold="True"
                                        controltovalidate="TextBox_coo_mobile_phone_or_pager_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Contact information for medical direction</strong></p>
            <p><small>The following questions refer to your service's Medical Director. ALS services, please provide at least one way to contact your Medical Director.&nbsp; If your service does not have a Medical Director, leave these fields blank.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">Medical&nbsp;Director name:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_md_name" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:CustomValidator id="CustomValidator_be_als_medical_director_name" runat="server" errormessage="Medical Director name is required for an ALS service." font-bold="True" onservervalidate="CustomValidator_be_als_medical_director_name_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Office phone #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_office_phone_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_md_office_phone_num" runat="server" errormessage="Please enter a valid Medical director office phone number using only numerals." font-bold="True" controltovalidate="TextBox_md_office_phone_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Home phone #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_home_phone_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_md_home_phone_num" runat="server" errormessage="Please enter a valid Medical director home phone number using only numerals." font-bold="True" controltovalidate="TextBox_md_home_phone_num"
                                        validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Email address:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="255" id="TextBox_md_email_address" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_md_email_address" runat="server" errormessage="Please enter a valid Medical director email address." font-bold="True" controltovalidate="TextBox_md_email_address"
                                        validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
        <asp:CustomValidator id="CustomValidator_md_email_address" runat="server" errormessage='Please enter a Medical director email address with a valid domain name (the part after the "@").' font-bold="True" controltovalidate="TextBox_md_email_address" onservervalidate="CustomValidator_md_email_address_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mobile phone or pager #:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_md_mobile_phone_or_pager_num" enabled="False"></asp:TextBox>
            </font></td>
          <td nowrap>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_md_mobile_phone_or_pager_num" runat="server" errormessage="Please enter a valid Medical director cellphone or pager number using only numerals." font-bold="True"
                                        controltovalidate="TextBox_md_mobile_phone_or_pager_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Physical location of headquarters</strong></p>
            <p><small>The questions in this section refer to the PHYSICAL LOCATION of your headquarters or primary base of operations.&nbsp; DO NOT SPECIFY A P.O. BOX OR A PERSONAL ADDRESS.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">Street address line 1:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_street_address_line_1" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_street_address_line_1" errormessage="Please enter Physical street address line 1." font-bold="True" id="RequiredFieldValidator_physical_street_address_line_1">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Street address line 2:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_street_address_line_2" enabled="False"></asp:TextBox>
            </font></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><font class="">City:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_physical_city" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_city" errormessage="Please enter Physical city." font-bold="True" id="RequiredFieldValidator_physical_city">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">State:</font></td>
          <td><font class=""><strong>PA</strong>
            </font></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><font class="">Zip code:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="10" maxlength="10" id="TextBox_physical_zip_code" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_physical_zip_code" errormessage="Please enter Physical zip code." font-bold="True" id="RequiredFieldValidator_physical_zip_code">!ERR!</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_physical_zip_code" runat="server" errormessage="Please enter a valid zip code using only numerals." font-bold="True" controltovalidate="TextBox_physical_zip_code"
                                        validationexpression="\d{5,9}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Headquarters mailing address</strong></p>
            <p><small>The questions in this section refer to the MAILING ADDRESS of your headquarters or primary base of operations.</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">Mailing address line 1:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_address_line_1" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_address_line_1" errormessage="Please enter Mailing address line 1." font-bold="True" id="RequiredFieldValidator_mail_address_line_1">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mailing address line 2:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_address_line_2" enabled="False"></asp:TextBox>
            </font></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><font class="">City:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="72" maxlength="127" id="TextBox_mail_city" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_city" errormessage="Please enter Mailing address city." font-bold="True" id="RequiredFieldValidator_mail_city">!ERR!</asp:RequiredFieldValidator></td>
        </tr><tr>
          <td align="right"><font class="">State:</font></td>
          <td><font class=""><strong>PA</strong>
            </font></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><font class="">Zip code:</font></td>
          <td><font class="">
              <asp:TextBox runat="server" columns="9" maxlength="9" id="TextBox_mail_zip_code" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_mail_zip_code" errormessage="Please enter Mailing address zip code." font-bold="True" id="RequiredFieldValidator_mail_zip_code">!ERR!</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator id="RegularExpressionValidator_mail_zip_code" runat="server" errormessage="Please enter a valid Mailing zip code." font-bold="True" controltovalidate="TextBox_mail_zip_code" validationexpression="\d{5,9}">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - --></table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Nature of service</strong></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right" valign="top" nowrap>
            <p align="right">Which of these services do you provide?<br/>
              <small>(Check all that apply.)</small></p></td>
          <td nowrap>
            <asp:CheckBox runat="server" text="QRS (unrecognized)" id="CheckBox_be_qrs_unrecognized" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="QRS (recognized)" id="CheckBox_be_qrs" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="BLS Ambulance" id="CheckBox_be_bls_amb" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="ALS Ambulance" id="CheckBox_be_als_amb" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="ALS squad" id="CheckBox_be_als_squad" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="Air ambulance" id="CheckBox_be_air_amb" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="Rescue (unrecognized)" id="CheckBox_be_rescue_unrecognized" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="Rescue (recognized)" id="CheckBox_be_rescue" enabled="False"></asp:CheckBox><br/>
            <asp:CheckBox runat="server" text="PA Turnpike contracted responses" id="CheckBox_be_pa_turnpike_contractor" enabled="False"></asp:CheckBox></td>
          <td></td>
        </tr>
        <tr>
          <td align="right"><font class="">Has a local government body designated you as the primary EMS response agency for a specific geographic area?*</font></td>
          <td><font class="">
          <asp:RadioButtonList id="RadioButtonList_be_dera" runat="server" repeatdirection="Horizontal" enabled="False">
            <asp:ListItem value="TRUE">Yes</asp:ListItem>
            <asp:ListItem value="FALSE">No</asp:ListItem>
          </asp:RadioButtonList>
            </font></td>
          <td nowrap>
        <asp:RequiredFieldValidator id="RequiredFieldValidator_be_dera" runat="server" errormessage="Please answer the question about local government designating you to respond to a specific area." font-bold="True" controltovalidate="RadioButtonList_be_dera">!ERR!</asp:RequiredFieldValidator></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Inventory</strong></p>
            <p><small>How many of the following items does your service possess?</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td align="right"><font class="">DOH-licensed vehicles?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_doh_licensed_vehicles" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_doh_licensed_vehicles" errormessage="Please enter Number of DOH licensed vehicles." font-bold="True" id="RequiredFieldValidator_num_doh_licensed_vehicles">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_doh_licensed_vehicles" errormessage="Please enter a valid Number of DOH licensed vehicles." font-bold="True"
                                            id="RegularExpressionValidator_num_doh_licensed_vehicles">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">DOH-licensed AMBULANCES (including air ambulances)?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_ambulances" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_ambulances" errormessage="Please enter Number of ambulances." font-bold="True" id="RequiredFieldValidator_num_ambulances">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_ambulances" errormessage="Please enter a valid Number of ambulances." font-bold="True" id="RegularExpressionValidator_num_ambulances">!ERR!</asp:RegularExpressionValidator><asp:CustomValidator id="CustomValidator_num_ambulances" runat="server" errormessage="Please enter a number of ambulances no higher than the number of your vehicles." font-bold="True"
                             controltovalidate="TextBox_num_ambulances" onservervalidate="CustomValidator_num_ambulances_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">DOH-licensed 4-WHEEL-DRIVE ambulances?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_4wd_ambulances" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_4wd_ambulances" errormessage="Please enter Number of 4WD ambulances." font-bold="True" id="RequiredFieldValidator_num_4wd_ambulances">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_4wd_ambulances" errormessage="Please enter a valid Number of 4WD ambulances." font-bold="True" id="RegularExpressionValidator_num_4wd_ambulances">!ERR!</asp:RegularExpressionValidator><asp:CustomValidator id="CustomValidator_num_4wd_ambulances" runat="server" errormessage="Please enter a number of 4WD ambulances no higher than the number of your vehicles." font-bold="True"
                             controltovalidate="TextBox_num_4wd_ambulances" onservervalidate="CustomValidator_num_4wd_ambulances_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Bariatric-equipped ambulances?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_bariatric_equipped_units" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_bariatric_equipped_units" errormessage="Please enter Number of bariatric-equipped units." font-bold="True" id="RequiredFieldValidator_num_bariatric_equipped_units">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_bariatric_equipped_units" errormessage="Please enter a valid Number of bariatric-equipped units." font-bold="True" id="RegularExpressionValidator_num_bariatric_equipped_units">!ERR!</asp:RegularExpressionValidator><asp:CustomValidator id="CustomValidator_num_bariatric_equipped_units" runat="server" errormessage="Please enter a number of bariatric-equipped units no higher than the number of your vehicles." font-bold="True"
                             controltovalidate="TextBox_num_bariatric_equipped_units" onservervalidate="CustomValidator_num_bariatric_equipped_units_ServerValidate">!ERR!</asp:CustomValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Wheelchair vans?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_wheelchair_vans" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_wheelchair_vans" errormessage="Please enter Number of wheelchair vans." font-bold="True" id="RequiredFieldValidator_num_wheelchair_vans">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_wheelchair_vans" errormessage="Please enter a valid Number of wheelchair vans." font-bold="True" id="RegularExpressionValidator_num_wheelchair_vans">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Recognized QRS vehicles?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_recognized_qrs_units" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_recognized_qrs_units" errormessage="Please enter Number of recognized QRS vehicles." font-bold="True" id="RequiredFieldValidator_num_recognized_qrs_units">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_recognized_qrs_units" errormessage="Please enter a valid Number of recognized QRS vehicles." font-bold="True" id="RegularExpressionValidator_num_recognized_qrs_units">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Unrecognized QRS vehicles?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_unrecognized_qrs_units" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_unrecognized_qrs_units" errormessage="Please enter Number of unrecognized QRS vehicles." font-bold="True" id="RequiredFieldValidator_num_unrecognized_qrs_units">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_unrecognized_qrs_units" errormessage="Please enter a valid Number of unrecognized QRS vehicles." font-bold="True" id="RegularExpressionValidator_num_unrecognized_qrs_units">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Recognized rescue vehicles?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_recognized_rescue_units" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_recognized_rescue_units" errormessage="Please enter Number of recognized rescue vehicles." font-bold="True" id="RequiredFieldValidator_num_recognized_rescue_units">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_recognized_rescue_units" errormessage="Please enter a valid Number of recognized rescue vehicles." font-bold="True" id="RegularExpressionValidator_num_recognized_rescue_units">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">MCI/Special event trailers?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_mci_special_event_trailers" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_mci_special_event_trailers" errormessage="Please enter Number of MCI/special event trailers." font-bold="True" id="RequiredFieldValidator_num_mci_special_event_trailers">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_mci_special_event_trailers" errormessage="Please enter a valid Number of MCI/special event trailers." font-bold="True" id="RegularExpressionValidator_num_mci_special_event_trailers">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Golf carts?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_golf_carts" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_golf_carts" errormessage="Please enter Number of golf carts." font-bold="True" id="RequiredFieldValidator_num_golf_carts">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_golf_carts" errormessage="Please enter a valid Number of golf carts." font-bold="True" id="RegularExpressionValidator_num_golf_carts">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Gators?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_gators" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_gators" errormessage="Please enter Number of gators." font-bold="True" id="RequiredFieldValidator_num_gators">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_gators" errormessage="Please enter a valid Number of gators." font-bold="True" id="RegularExpressionValidator_num_gators">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Quads?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_quads" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_quads" errormessage="Please enter Number of quads." font-bold="True" id="RequiredFieldValidator_num_quads">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_quads" errormessage="Please enter a valid Number of quads." font-bold="True" id="RegularExpressionValidator_num_quads">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Boats?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_boats" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_boats" errormessage="Please enter Number of boats." font-bold="True" id="RequiredFieldValidator_num_boats">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_boats" errormessage="Please enter a valid Number of boats." font-bold="True" id="RegularExpressionValidator_num_boats">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr><td colspan="3"><hr size="1"/></td></tr>
        <tr>
          <td align="right"><font class="">PA-STARNet (OpenSky) radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_opensky_radios" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_opensky_radios" errormessage="Please enter Number of PA-STARNet (OpenSky) radios." font-bold="True" id="RequiredFieldValidator_num_opensky_radios">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_opensky_radios" errormessage="Please enter a valid Number of PA-STARNet (OpenSky) radios." font-bold="True" id="RegularExpressionValidator_num_opensky_radios">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Portable UHF radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_uhf_portables" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_uhf_portables" errormessage="Please enter Number of UHF portables." font-bold="True" id="RequiredFieldValidator_num_uhf_portables">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_uhf_portables" errormessage="Please enter a valid Number of UHF portables." font-bold="True" id="RegularExpressionValidator_num_uhf_portables">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mobile UHF radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_uhf_mobiles" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_uhf_mobiles" errormessage="Please enter Number of UHF mobiles." font-bold="True" id="RequiredFieldValidator_num_uhf_mobiles">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_uhf_mobiles" errormessage="Please enter a valid Number of UHF mobiles." font-bold="True" id="RegularExpressionValidator_num_uhf_mobiles">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Portable VHF radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_vhf_portables" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_vhf_portables" errormessage="Please enter Number of VHF portables." font-bold="True" id="RequiredFieldValidator_num_vhf_portables">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_vhf_portables" errormessage="Please enter a valid Number of VHF portables." font-bold="True" id="RegularExpressionValidator_num_vhf_portables">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mobile VHF radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_vhf_mobiles" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_vhf_mobiles" errormessage="Please enter Number of VHF mobiles." font-bold="True" id="RequiredFieldValidator_num_vhf_mobiles">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_vhf_mobiles" errormessage="Please enter a valid Number of VHF mobiles." font-bold="True" id="RegularExpressionValidator_num_vhf_mobiles">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">County 800 radios?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_trunked_radios" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_trunked_radios" errormessage="Please enter Number of county 800 radios." font-bold="True" id="RequiredFieldValidator_num_trunked_radios">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_trunked_radios" errormessage="Please enter a valid Number of county 800 radios." font-bold="True" id="RegularExpressionValidator_num_trunked_radios">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr><td colspan="3"><hr size="1"/></td></tr>
        <tr>
          <td align="right"><font class="">GPS units?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_gps_receivers" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_gps_receivers" errormessage="Please enter Number of GPS receivers." font-bold="True" id="RequiredFieldValidator_num_gps_receivers">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_gps_receivers" errormessage="Please enter a valid Number of GPS receivers." font-bold="True" id="RegularExpressionValidator_num_gps_receivers">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Mark 1 kits?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_mark_1_kits" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_mark_1_kits" errormessage="Please enter Number of Mark 1 kits." font-bold="True" id="RequiredFieldValidator_num_mark_1_kits">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_mark_1_kits" errormessage="Please enter a valid Number of Mark 1 kits." font-bold="True" id="RegularExpressionValidator_num_mark_1_kits">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">N95 masks?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_n95_masks" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_n95_masks" errormessage="Please enter Number of N95 masks." font-bold="True" id="RequiredFieldValidator_num_n95_masks">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_n95_masks" errormessage="Please enter a valid Number of N95 masks." font-bold="True" id="RegularExpressionValidator_num_n95_masks">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">SCBA?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_scba" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_scba" errormessage="Please enter Number of SCBA." font-bold="True" id="RequiredFieldValidator_num_scba">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_scba" errormessage="Please enter a valid Number of SCBA." font-bold="True" id="RegularExpressionValidator_num_scba">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">PFDs?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_pfd" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_pfd" errormessage="Please enter Number of PFDs." font-bold="True" id="RequiredFieldValidator_num_pfd">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_pfd" errormessage="Please enter a valid Number of PFDs." font-bold="True" id="RegularExpressionValidator_num_pfd">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Portable vents?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_portable_vents" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_portable_vents" errormessage="Please enter Number of portable vents." font-bold="True" id="RequiredFieldValidator_num_portable_vents">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_portable_vents" errormessage="Please enter a valid Number of portable vents." font-bold="True" id="RegularExpressionValidator_num_portable_vents">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Infusion pumps?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_infusion_pumps" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_infusion_pumps" errormessage="Please enter Number of infusion pumps." font-bold="True" id="RequiredFieldValidator_num_infusion_pumps">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_infusion_pumps" errormessage="Please enter a valid Number of infusion pumps." font-bold="True" id="RegularExpressionValidator_num_infusion_pumps">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Bariatric stretchers?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_bariatric_stretchers" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_bariatric_stretchers" errormessage="Please enter Number of bariatric stretchers." font-bold="True" id="RequiredFieldValidator_num_bariatric_stretchers">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_bariatric_stretchers" errormessage="Please enter a valid Number of bariatric stretchers." font-bold="True" id="RegularExpressionValidator_num_bariatric_stretchers">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Ballistic vests?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_ballistic_vests" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_ballistic_vests" errormessage="Please enter Number of ballistic vests." font-bold="True" id="RequiredFieldValidator_num_ballistic_vests">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_ballistic_vests" errormessage="Please enter a valid Number of ballistic vests." font-bold="True" id="RegularExpressionValidator_num_ballistic_vests">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Potable water (cases)?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_cases_potable_h2o" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_cases_potable_h2o" errormessage="Please enter Number of potable water (cases)." font-bold="True" id="RequiredFieldValidator_num_cases_potable_h2o">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_cases_potable_h2o" errormessage="Please enter a valid Number of potable water (cases)." font-bold="True" id="RegularExpressionValidator_num_cases_potable_h2o">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr>
          <td align="right"><font class="">Meals Ready to Eat (MRE) cases?</font></td>
          <td><font class="">
              <asp:TextBox runat="server" id="TextBox_num_cases_mre" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_cases_mre" errormessage="Please enter Number of MRE cases." font-bold="True" id="RequiredFieldValidator_num_cases_mre">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_cases_mre" errormessage="Please enter a valid Number of MRE cases." font-bold="True" id="RegularExpressionValidator_num_cases_mre">!ERR!</asp:RegularExpressionValidator></td>
        </tr>
        <tr><td colspan="3"><hr size="1"/></td></tr>
        <tr>
          <td colspan="3">
            <font class="">Other (as/if requested by Regional Council under separate cover)?</font>
            <blockquote><asp:TextBox runat="server" id="TextBox_inventory_memo" columns="60" enabled="False" Rows="4" TextMode="MultiLine"></asp:TextBox></blockquote>            
          </td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Depth of service</strong></p>
            <p><small>How many of the following does your service provide at the indicated times?</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr>
          <td></td>
          <td class="style1"><font class="">Staffing levels</font></td>
          <td></td>
          <td class="style1"><font class="">Avg # of vehicles</font></td>
          <td></td>
        </tr>
        <tr>
          <td colspan="5" class=""><font class=""><strong>ALS</strong></font></td>
        </tr>
        <tr>
          <td align="right"><font class="">8am-4pm</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_als_08_16" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_als_08_16" errormessage="Please enter Number of typical ALS staff 8am-4pm." font-bold="True" id="RequiredFieldValidator_num_staff_typical_ls__">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_als_08_16" errormessage="Please enter a valid Number of typical ALS staff 8am-4pm." font-bold="True" id="RegularExpressionValidator_num_staff_typical_als_08_16">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_als_08_16" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_als_08_16" errormessage="Please enter Number of typical ALS vehicles 8am-4pm." font-bold="True" id="RequiredFieldValidator_num_units_typical_als_08_16">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_als_08_16" errormessage="Please enter a valid Number of typical ALS vehicles 8am-4pm." font-bold="True" id="RegularExpressionValidator_num_units_typical_als_08_16">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td align="right"><font class="">4pm-midnight</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_als_16_00" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_als_16_00" errormessage="Please enter Number of typical ALS staff 4pm-midnight." font-bold="True" id="RequiredFieldValidator_num_staff_typical_ls_16_00">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_als_16_00" errormessage="Please enter a valid Number of typical ALS staff 4pm-midnight." font-bold="True" id="RegularExpressionValidator_num_staff_typical_als_16_00">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_als_16_00" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_als_16_00" errormessage="Please enter Number of typical ALS vehicles 4pm-midnight." font-bold="True" id="RequiredFieldValidator_num_units_typical_als_16_00">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_als_16_00" errormessage="Please enter a valid Number of typical ALS vehicles 4pm-midnight." font-bold="True" id="RegularExpressionValidator_num_units_typical_als_16_00">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td align="right"><font class="">Midnight-8am</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_als_00_08" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_als_00_08" errormessage="Please enter Number of typical ALS staff Midnight-8am." font-bold="True" id="RequiredFieldValidator_num_staff_typical_ls_00_08">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_als_00_08" errormessage="Please enter a valid Number of typical ALS staff Midnight-8am." font-bold="True" id="RegularExpressionValidator_num_staff_typical_als_00_08">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_als_00_08" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_als_00_08" errormessage="Please enter Number of typical ALS vehicles Midnight-8am." font-bold="True" id="RequiredFieldValidator_num_units_typical_als_00_08">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_als_00_08" errormessage="Please enter a valid Number of typical ALS vehicles Midnight-8am." font-bold="True" id="RegularExpressionValidator_num_units_typical_als_00_08">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td colspan="5" class=""><font class=""><strong>BLS</strong></font></td>
        </tr>
        <tr>
          <td align="right"><font class="">8am-4pm</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_bls_08_16" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_bls_08_16" errormessage="Please enter Number of typical BLS staff 8am-4pm." font-bold="True" id="RequiredFieldValidator_num_staff_typical_bls_08_16">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_bls_08_16" errormessage="Please enter a valid Number of typical BLS staff 8am-4pm." font-bold="True" id="RegularExpressionValidator_num_staff_typical_bls_08_16">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_bls_08_16" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_bls_08_16" errormessage="Please enter Number of typical BLS vehicles 8am-4pm." font-bold="True" id="RequiredFieldValidator_num_units_typical_bls_08_16">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_bls_08_16" errormessage="Please enter a valid Number of typical BLS vehicles 8am-4pm." font-bold="True" id="RegularExpressionValidator_num_units_typical_ls_08_16">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td align="right"><font class="">4pm-midnight</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_bls_16_00" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_bls_16_00" errormessage="Please enter Number of typical BLS staff 4pm-midnight." font-bold="True" id="RequiredFieldValidator_num_staff_typical_bls_16_00">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_bls_16_00" errormessage="Please enter a valid Number of typical BLS staff 4pm-midnight." font-bold="True" id="RegularExpressionValidator_num_staff_typical_bls_16_00">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_bls_16_00" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_bls_16_00" errormessage="Please enter Number of typical BLS vehicles 4pm-midnight." font-bold="True" id="RequiredFieldValidator_num_units_typical_bls_16_00">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_bls_16_00" errormessage="Please enter a valid Number of typical BLS vehicles 4pm-midnight." font-bold="True" id="RegularExpressionValidator_num_units_typical_ls_16_00">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td align="right"><font class="">Midnight-8am</font></td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_staff_typical_bls_00_08" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_staff_typical_bls_00_08" errormessage="Please enter Number of typical BLS staff Midnight-8am." font-bold="True" id="RequiredFieldValidator_num_staff_typical_bls_00_08">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_staff_typical_bls_00_08" errormessage="Please enter a valid Number of typical BLS staff Midnight-8am." font-bold="True" id="RegularExpressionValidator_num_staff_typical_bls_00_08">!ERR!</asp:RegularExpressionValidator>
          </td>
          <td class="style1"><font class=""><asp:TextBox runat="server" id="TextBox_num_units_typical_bls_00_08" columns="3" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_num_units_typical_bls_00_08" errormessage="Please enter Number of typical BLS vehicles Midnight-8am." font-bold="True" id="RequiredFieldValidator_num_units_typical_bls_00_08">!ERR!</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" validationexpression="\d*" controltovalidate="TextBox_num_units_typical_bls_00_08" errormessage="Please enter a valid Number of typical BLS vehicles Midnight-8am." font-bold="True" id="RegularExpressionValidator_num_units_typical_ls_00_08">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Communications</strong></p>
            <p><small>How can your service be contacted...</small></p>
          </td>
        </tr>
        <!-- + --><tr><td><table cellspacing="0" cellpadding="5" border="0"><!-- + -->
        <tr><td colspan="4"><font class=""><strong>Via cellphone?</strong></font></td></tr>
        <tr>
          <td></td>
          <td align="center"><font class="">Number</font></td>
          <td align="center"><font class="">Assignee</font></td>
          <td></td>
        </tr>
        <tr>
          <td><font class="">Number 1:</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_1_num" columns="10" enabled="False"></asp:TextBox>* </font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_1_assignee" columns="40" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_1_num" runat="server" errormessage="Please enter a valid Key cellphone 1 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_1_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_key_cell_phone_1_num" errormessage="Please enter Key cellphone 1 number." font-bold="True" id="RequiredFieldValidator_key_cellphone_1_num">!ERR!</asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_key_cell_phone_1_assignee" errormessage="Please enter Key cellphone 1 assignee." font-bold="True" id="RequiredFieldValidator_key_cellphone_1_assignee">!ERR!</asp:RequiredFieldValidator>
          </td>
        </tr>
        <tr>
          <td><font class="">Number 2:</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_2_num" columns="10" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_2_assignee" columns="40" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_2_num" runat="server" errormessage="Please enter a valid Key cellphone 2 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_2_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td><font class="">Number 3:</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_3_num" columns="10" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_3_assignee" columns="40" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_3_num" runat="server" errormessage="Please enter a valid Key cellphone 3 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_3_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td><font class="">Number 4:</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_4_num" columns="10" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_4_assignee" columns="40" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_4_num" runat="server" errormessage="Please enter a valid Key cellphone 4 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_4_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td><font class="">Number 5:</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_5_num" columns="10" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_5_assignee" columns="40" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_5_num" runat="server" errormessage="Please enter a valid Key cellphone 5 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_5_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td>Number 6:</td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_6_num" columns="10" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td><font class=""><asp:TextBox runat="server" id="TextBox_key_cell_phone_6_assignee" columns="40" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td>
            <asp:RegularExpressionValidator id="RegularExpressionValidator_key_cell_phone_6_num" runat="server" errormessage="Please enter a valid Key cellphone 6 number using only numerals." font-bold="True" controltovalidate="TextBox_key_cell_phone_6_num" validationexpression="\d{10}">!ERR!</asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr><td colspan="4"><font class=""><strong>Via radio?</strong></font></td></tr>
        <tr>
          <td></td>
          <td align="center" colspan="2"><font class="">County/PSAP & Zone/name/frequency</font></td>
          <td></td>
        </tr>
        <tr>
          <td><font class="">Channel 1:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_1" columns="60" enabled="False"></asp:TextBox>* </font></td>
          <td nowrap>
            <asp:RequiredFieldValidator runat="server" controltovalidate="TextBox_radio_channel_1" errormessage="Please enter Radio channel 1." font-bold="True" id="RequiredFieldValidator_radio_channel_1">!ERR!</asp:RequiredFieldValidator>
          </td>
        </tr>
        <tr>
          <td><font class="">Channel 2:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_2" columns="60" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td nowrap></td>
        </tr>
        <tr>
          <td><font class="">Channel 3:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_3" columns="60" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td nowrap></td>
        </tr>
        <tr>
          <td><font class="">Channel 4:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_4" columns="60" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td nowrap></td>
        </tr>
        <tr>
          <td><font class="">Channel 5:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_5" columns="60" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td nowrap></td>
        </tr>
        <tr>
          <td><font class="">Channel 6:</font></td>
          <td colspan="2"><font class=""><asp:TextBox runat="server" id="TextBox_radio_channel_6" columns="60" enabled="False"></asp:TextBox>&nbsp;</font></td>
          <td nowrap></td>
        </tr>
        <!-- - --></table></td></tr><!-- - -->
      </table>
    </td>
  </tr>
</table>
<br/>
<table cellspacing="0" cellpadding="0" border="1" bordercolor="gainsboro">
  <tr>
    <td>
      <table cellpadding="10" cellspacing="0" border="0">
        <tr>
          <td bgcolor="whitesmoke">
            <p><strong>Wrap-up</strong></p>
          </td>
        </tr>
        <tr>
          <td>
            <table cellspacing="0" cellpadding="5" border="0"><!-- + -->
              <tr>
                <td colspan="3">
                  <p>By submitting this form to WebEMSOF, you are affirming that you are the contact person listed above, and you are agreeing to serve as the above service's EMSOF point of contact for this EMSOF cycle.&nbsp; You further affirm that if you must relinquish your responsibilities as the service's EMSOF point of contact during this cycle, you will give reasonable advanced notice to the service and to the regional council.</p>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br/>
<ASP:Button id="Button_submit" text="SUBMIT profile for Annual Survey" runat="server" enabled="False" onclick="Button_submit_Click"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False" onclick="Button_delete_Click"></ASP:Button>
