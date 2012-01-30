<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_practitioner.ascx.cs" Inherits="UserControl_practitioner.TWebUserControl_practitioner"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~kicrudhelped~item.ascx-template -->
<%@ Register TagPrefix="uc1" TagName="UserControl_drop_down_date" Src="~/usercontrol/ki/UserControl_drop_down_date.ascx" %>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
  <tr id="TableRow_id" runat="server" visible="false">
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
    <td><font class="">Last&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_last_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_last_name" runat="server" errormessage="Please enter Last&nbsp;name." font-bold="True" controltovalidate="TextBox_last_name">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">First&nbsp;name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_first_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_first_name" runat="server" errormessage="Please enter First&nbsp;name." font-bold="True" controltovalidate="TextBox_first_name">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Middle&nbsp;initial:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_middle_initial" runat="server" columns="1" maxlength="1" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Certification&nbsp;number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_certification_number" runat="server" columns="6" maxlength="6" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_certification_number" runat="server" errormessage="Please enter Certification&nbsp;number." font-bold="True" controltovalidate="TextBox_certification_number">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Level&nbsp;id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_level_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_level_id" runat="server" errormessage="Please enter Level&nbsp;id." font-bold="True" controltovalidate="TextBox_level_id">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_level_id" runat="server" errormessage="Please enter a valid Level&nbsp;id." font-bold="True" controltovalidate="TextBox_level_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Regional&nbsp;council&nbsp;code:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_regional_council_code" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_regional_council_code" runat="server" errormessage="Please enter Regional&nbsp;council&nbsp;code." font-bold="True" controltovalidate="TextBox_regional_council_code">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_regional_council_code" runat="server" errormessage="Please enter a valid Regional&nbsp;council&nbsp;code." font-bold="True" controltovalidate="TextBox_regional_council_code" validationexpression="\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Residence&nbsp;county&nbsp;code:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_residence_county_code" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_residence_county_code" runat="server" errormessage="Please enter a valid Residence&nbsp;county&nbsp;code." font-bold="True" controltovalidate="TextBox_residence_county_code" validationexpression="\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Birth&nbsp;date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_birth_date" runat="server"  cssclass=""></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Be&nbsp;birth&nbsp;date&nbsp;confirmed:</font></td>
    <td>
      <asp:CheckBox ID="CheckBox_be_birth_date_confirmed" runat="server" />
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Email&nbsp;address:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_email_address" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <asp:RegularExpressionValidator id="RegularExpressionValidator_email_address" runat="server" errormessage="Please enter a valid Email address." font-bold="True" controltovalidate="TextBox_email_address" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
      <asp:CustomValidator id="CustomValidator_email_address" runat="server" errormessage='Please enter an Email address with a valid Domain Name (the part after the "@").' font-bold="True" controltovalidate="TextBox_email_address" onservervalidate="CustomValidator_email_address_ServerValidate">!ERR!</asp:CustomValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Street&nbsp;address&nbsp;1:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_street_address_1" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <asp:RegularExpressionValidator id="RegularExpressionValidator_street_address_1" runat="server" errormessage="Please enter a valid Street address 1." font-bold="True" controltovalidate="TextBox_street_address_1" validationexpression="[0-9a-zA-Z#\-,(). ]+">!ERR!</asp:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Street&nbsp;address&nbsp;2:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_street_address_2" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <asp:RegularExpressionValidator id="RegularExpressionValidator_street_address_2" runat="server" errormessage="Please enter a valid Street address 2." font-bold="True" controltovalidate="TextBox_street_address_2" validationexpression="[0-9a-zA-Z#\-,(). ]+">!ERR!</asp:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">City&nbsp;state&nbsp;zip:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_city_state_zip" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <asp:RegularExpressionValidator id="RegularExpressionValidator_city_state_zip" runat="server" errormessage="Please enter a valid City state zip." font-bold="True" controltovalidate="TextBox_city_state_zip" validationexpression="[a-zA-Z\-. ]+">!ERR!</asp:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Be&nbsp;instructor:</font></td>
    <td>
      <asp:CheckBox ID="CheckBox_be_instructor" runat="server" />
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Be&nbsp;stale:</font></td>
    <td>
      <asp:CheckBox ID="CheckBox_be_stale" runat="server" />
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
      </table>
    </td>
  </tr>
</table>
<ASP:Button id="Button_submit" text="Submit" runat="server" enabled="False" onclick="Button_submit_Click"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False" onclick="Button_delete_Click"></ASP:Button>

