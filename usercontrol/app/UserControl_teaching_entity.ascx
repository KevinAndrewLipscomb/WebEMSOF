<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_teaching_entity.ascx.cs" Inherits="UserControl_teaching_entity.TWebUserControl_teaching_entity"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~kicrudhelped~item.ascx-template -->
<%@ Register TagPrefix="uc1" TagName="UserControl_drop_down_date" Src="~/usercontrol/ki/UserControl_drop_down_date.ascx" %>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
  <tr>
    <td bgcolor="gainsboro" valign="top"><font class="">id:</font></td>
    <td valign="top"><font class="">
      <table cellspacing="0" cellpadding="0" border="0">
         <tr>
           <td valign="middle">
             <table cellspacing="0" cellpadding="0" border="0">
               <tr>
                 <td>
      <ASP:TextBox id="TextBox_id" runat="server"  cssclass=""></ASP:TextBox><ASP:Button id="Button_lookup" runat="server" causesvalidation="False" text="LOOKUP" onclick="Button_lookup_Click"></ASP:Button>
                </td>
                <td nowrap="nowrap"><small><small><asp:Label id="Label_lookup_arrow" runat="server">&lt;--</asp:Label></small></small></td>
                <td><small><small><em><asp:Label id="Label_lookup_hint" runat="server">Lookup by partial or full field value</asp:Label></em></small></small></td>
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
          <td valign="middle">
            <small>
              <ASP:LinkButton id="LinkButton_new_record" runat="server" causesvalidation="False" visible="False" onclick="LinkButton_new_record_Click">Enter&nbsp;brand&nbsp;new&nbsp;record</ASP:LinkButton>
            </small>
          </td>
        </tr>
      </table>
      <table>
        <tr>
          <td><asp:Panel ID="Panel_match_numbers" runat="server" Visible="False"><small>(<asp:Literal ID="Literal_match_index" runat="server"></asp:Literal>/<asp:Literal ID="Literal_num_matches" runat="server"></asp:Literal>)</small></asp:Panel></td>
          <td>
            <asp:LinkButton id="LinkButton_go_to_match_first" runat="server" text="<IMG src=&quot;~/protected/image/first_track_blue16_h.png&quot; alt=&quot;First match&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; />" causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_first_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_prior" runat="server" text="<IMG src=&quot;~/protected/image/play_blue16_h-flipped.png&quot; alt=&quot;Prior match&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; />" causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_prior_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_next" runat="server" text="<IMG src=&quot;~/protected/image/play_blue16_h.png&quot; alt=&quot;Next match&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; />" causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_next_Click"></asp:LinkButton><asp:LinkButton id="LinkButton_go_to_match_last" runat="server" text="<IMG src=&quot;~/protected/image/last_track_blue16_h.png&quot; alt=&quot;Last match&quot; border=&quot;0&quot; height=&quot;16&quot; width=&quot;16&quot; />" causesvalidation="False" visible="False" onclick="LinkButton_go_to_match_last_Click"></asp:LinkButton>
          </td>
          <td>
            <div style="width:0px;white-space:nowrap;"><ASP:DropDownList id="DropDownList_id" runat="server" visible="False" autopostback="True" onselectedindexchanged="DropDownList_id_SelectedIndexChanged"></ASP:DropDownList></div>
          </td>
        </tr>
      </table>
    </font>
    </td>
    <td nowrap="nowrap" valign="top">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_id" runat="server" errormessage="Please enter id." font-bold="True" controltovalidate="TextBox_id">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Emsrs&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_emsrs_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_emsrs_id" runat="server" errormessage="Please enter Emsrs&nbsp;id." font-bold="True" controltovalidate="TextBox_emsrs_id">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_emsrs_id" runat="server" errormessage="Please enter a valid Emsrs&nbsp;id." font-bold="True" controltovalidate="TextBox_emsrs_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Date&nbsp;created:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_created" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Date&nbsp;last&nbsp;edited:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_last_edited" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Sponsor&nbsp;number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_sponsor_number" runat="server" columns="7" maxlength="7" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Training&nbsp;ins&nbsp;accred&nbsp;num:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_training_ins_accred_num" runat="server" columns="9" maxlength="9" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_name" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Short&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_short_name" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Address&nbsp;1:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_address_1" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Address&nbsp;2:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_address_2" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">City:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_city" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">State:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_state" runat="server" columns="2" maxlength="2" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Zip:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_zip" runat="server" columns="10" maxlength="10" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">County&nbsp;code:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_county_code" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_county_code" runat="server" errormessage="Please enter a valid County&nbsp;code." font-bold="True" controltovalidate="TextBox_county_code" validationexpression="\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Region:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_region" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_region" runat="server" errormessage="Please enter a valid Region." font-bold="True" controltovalidate="TextBox_region" validationexpression="\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Email:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_email" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Website:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_website" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Daytime&nbsp;phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_daytime_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Evening&nbsp;phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_evening_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Fax:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_fax" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Business&nbsp;type&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_business_type_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_business_type_id" runat="server" errormessage="Please enter a valid Business&nbsp;type&nbsp;id." font-bold="True" controltovalidate="TextBox_business_type_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Con&nbsp;ed&nbsp;level&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_con_ed_level_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_con_ed_level_id" runat="server" errormessage="Please enter a valid Con&nbsp;ed&nbsp;level&nbsp;id." font-bold="True" controltovalidate="TextBox_con_ed_level_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Certification&nbsp;level:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_certification_level" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_certification_level" runat="server" errormessage="Please enter a valid Certification&nbsp;level." font-bold="True" controltovalidate="TextBox_certification_level" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;first&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_first_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;last&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_last_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;title:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_title" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;address&nbsp;1:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_address_1" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;address&nbsp;2:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_address_2" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;city:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_city" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;state:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_state" runat="server" columns="2" maxlength="2" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;zip:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_zip" runat="server" columns="10" maxlength="10" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;daytime&nbsp;phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_daytime_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;evening&nbsp;phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_evening_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;fax:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_fax" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Contact&nbsp;email:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_contact_email" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Public&nbsp;contact&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_name" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Public&nbsp;contact&nbsp;phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Public&nbsp;contact&nbsp;email:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_email" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Public&nbsp;contact&nbsp;website:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_website" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Public&nbsp;contact&nbsp;notes:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_notes" runat="server" columns="72" maxlength="510" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Application&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_application_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Application&nbsp;received:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_application_received" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Coned&nbsp;sponsor&nbsp;status&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_coned_sponsor_status_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_coned_sponsor_status_id" runat="server" errormessage="Please enter a valid Coned&nbsp;sponsor&nbsp;status&nbsp;id." font-bold="True" controltovalidate="TextBox_coned_sponsor_status_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Training&nbsp;inst&nbsp;status&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_training_inst_status_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_training_inst_status_id" runat="server" errormessage="Please enter a valid Training&nbsp;inst&nbsp;status&nbsp;id." font-bold="True" controltovalidate="TextBox_training_inst_status_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Issue&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_issue_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Prev&nbsp;expiration&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_prev_expiration_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Expiration&nbsp;date&nbsp;sponsor:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_expiration_date_sponsor" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Expiration&nbsp;date&nbsp;training&nbsp;inst:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_expiration_date_training_inst" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Process&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_process_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Corrective&nbsp;action:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_corrective_action" runat="server" columns="72" textmode="MultiLine" rows="2" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_corrective_action" runat="server" errormessage="Please restrict the Corrective&nbsp;action entry to 65535 characters." font-bold="True" controltovalidate="TextBox_corrective_action" validationexpression="^[\s\S]{0,65535}$">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Compliance&nbsp;by&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_compliance_by_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Initial&nbsp;accred&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_initial_accred_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Accepted&nbsp;provisional&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_accepted_provisional_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Completed&nbsp;provisional&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_completed_provisional_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Withdrawal&nbsp;challenge&nbsp;due&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_withdrawal_challenge_due_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Letter&nbsp;for&nbsp;expiration:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_letter_for_expiration" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Letter&nbsp;f&nbsp;for&nbsp;ppwk&nbsp;non&nbsp;compliance:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_letter_f_for_ppwk_non_compliance" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">Other&nbsp;letter:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_other_letter" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="True">
    </td>
  </tr>
  <tr>
    <td><font class="">History:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_history" runat="server" columns="72" textmode="MultiLine" rows="2" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="True">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_history" runat="server" errormessage="Please restrict the History entry to 65535 characters." font-bold="True" controltovalidate="TextBox_history" validationexpression="^[\s\S]{0,65535}$">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
      </table>
    </td>
  </tr>
</table>
<ASP:Button id="Button_submit" text="Submit" runat="server" enabled="False" onclick="Button_submit_Click"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False" onclick="Button_delete_Click"></ASP:Button>

