<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserControl_coned_offering.ascx.cs" Inherits="UserControl_coned_offering.TWebUserControl_coned_offering"%>
<!-- Derived from KiAspdotnetFramework/usercontrol/app/UserControl~template~kicrudhelped~item.ascx-template -->
<%@ Register TagPrefix="uc1" TagName="UserControl_drop_down_date" Src="~/usercontrol/ki/UserControl_drop_down_date.ascx" %>
<table cellspacing="0" cellpadding="5" width="100%" border="0">
  <tr>
    <td valign="top">
      <table cellspacing="0" cellpadding="5" border="0">
  <tr runat="server" id="TableRow_class_id" visible="false">
    <td bgcolor="gainsboro" valign="top"><font class="">class_id:</font></td>
    <td valign="top"><font class="">
      <table cellspacing="0" cellpadding="0" border="0">
         <tr>
           <td valign="middle">
             <table cellspacing="0" cellpadding="0" border="0">
               <tr>
                 <td>
      <ASP:TextBox id="TextBox_class_id" runat="server"  cssclass=""></ASP:TextBox><ASP:Button id="Button_lookup" runat="server" causesvalidation="False" text="LOOKUP" onclick="Button_lookup_Click"></ASP:Button>
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
            <div style="width:0px;white-space:nowrap;"><ASP:DropDownList id="DropDownList_class_id" runat="server" visible="False" autopostback="True" onselectedindexchanged="DropDownList_class_id_SelectedIndexChanged"></ASP:DropDownList></div>
          </td>
        </tr>
      </table>
    </font>
    </td>
    <td nowrap="nowrap" valign="top">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_class_id" runat="server" errormessage="Please enter class_id." font-bold="True" controltovalidate="TextBox_class_id">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Class number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_class_number" runat="server" columns="14" maxlength="14" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Course title:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_course_title" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_course_title" runat="server" errormessage="Please enter Course title." font-bold="True" controltovalidate="TextBox_course_title">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Location:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location address 1:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_address_1" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location address 2:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_address_2" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location city:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_city" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location state:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_state" runat="server" columns="2" maxlength="2" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location zip:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_zip" runat="server" columns="5" maxlength="5" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location zip plus 4:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_zip_plus_4" runat="server" columns="4" maxlength="4" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Location email:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_email" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Start date time:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_start_date_time" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Start time:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_start_time" runat="server" columns="15" maxlength="15" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">End date time:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_end_date_time" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">End time:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_end_time" runat="server" columns="15" maxlength="15" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Other dates and times:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_other_dates_and_times" runat="server" columns="72" maxlength="510" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_course_id" visible="false">
    <td><font class="">Course id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_course_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_course_id" runat="server" errormessage="Please enter Course id." font-bold="True" controltovalidate="TextBox_course_id">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_course_id" runat="server" errormessage="Please enter a valid Course id." font-bold="True" controltovalidate="TextBox_course_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr runat="server" id="TableRow_created_by" visible="false">
    <td><font class="">Created by:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_created_by" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_created_by" runat="server" errormessage="Please enter Created by." font-bold="True" controltovalidate="TextBox_created_by">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_created_by" runat="server" errormessage="Please enter a valid Created by." font-bold="True" controltovalidate="TextBox_created_by" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Created by first name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_created_by_first_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_created_by_first_name" runat="server" errormessage="Please enter Created by first name." font-bold="True" controltovalidate="TextBox_created_by_first_name">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Created by last name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_created_by_last_name" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_created_by_last_name" runat="server" errormessage="Please enter Created by last name." font-bold="True" controltovalidate="TextBox_created_by_last_name">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Date created:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_created" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_last_edited_by" visible="false">
    <td><font class="">Last edited by:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_last_edited_by" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_last_edited_by" runat="server" errormessage="Please enter Last edited by." font-bold="True" controltovalidate="TextBox_last_edited_by">!ERR!</ASP:RequiredFieldValidator>
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_last_edited_by" runat="server" errormessage="Please enter a valid Last edited by." font-bold="True" controltovalidate="TextBox_last_edited_by" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Date last edited:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_last_edited" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_sponsor_id" visible="false">
    <td><font class="">Sponsor id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_sponsor_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_sponsor_id" runat="server" errormessage="Please enter a valid Sponsor id." font-bold="True" controltovalidate="TextBox_sponsor_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr runat="server" id="TableRow_sponsor_number" visible="false">
    <td><font class="">Sponsor number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_sponsor_number" runat="server" columns="7" maxlength="7" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Document status:</font></td>
    <td>
      <asp:DropDownList ID="DropDownList_document_status" runat="server">
      </asp:DropDownList>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_document_status" runat="server" errormessage="Please select a Document status." font-bold="True" controltovalidate="DropDownList_document_status">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Class final status:</font></td>
    <td>
      <asp:DropDownList ID="DropDownList_class_final_status" runat="server">
      </asp:DropDownList>
    </td>
    <td nowrap="nowrap">
      &nbsp;</td>
  </tr>
  <tr runat="server" id="TableRow_course_number" visible="false">
    <td><font class="">Course number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_course_number" runat="server" columns="6" maxlength="6" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_course_number" runat="server" errormessage="Please enter Course number." font-bold="True" controltovalidate="TextBox_course_number">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Student cost:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_student_cost" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_student_cost" runat="server" errormessage="Please enter a valid Student cost." font-bold="True" controltovalidate="TextBox_student_cost" validationexpression="\d*\.?\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Tuition includes:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_tuition_includes" runat="server" columns="72" maxlength="510" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Closed:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_closed" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Estimated students:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_estimated_students" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_estimated_students" runat="server" errormessage="Please enter a valid Estimated students." font-bold="True" controltovalidate="TextBox_estimated_students" validationexpression="\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Instructors:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_instructors" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Instructor qualifications:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_instructor_qualifications" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Public contact name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_name" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Public contact phone:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_phone" runat="server" columns="31" maxlength="31" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Public contact email:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_email" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Public contact website:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_website" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Public contact notes:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_public_contact_notes" runat="server" columns="72" maxlength="510" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date submitted to region:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_submitted_to_region" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date received by region:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_received_by_region" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date sponsor notified:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_sponsor_notified" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date registration sent to state:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_registration_sent_to_state" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date cards sent to sponsor:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_cards_sent_to_sponsor" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Date materials to be returned:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_materials_to_be_returned" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Approved:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_approved" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Region comments:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_region_comments" runat="server" columns="72" maxlength="255" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Region council:</font></td>
    <td>
      <asp:DropDownList ID="DropDownList_region_council" runat="server">
      </asp:DropDownList>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_region_council_num" runat="server" errormessage="Please select a Region council." font-bold="True" controltovalidate="DropDownList_region_council">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Class county:</font></td>
    <td>
      <asp:DropDownList ID="DropDownList_class_county" runat="server">
      </asp:DropDownList>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_class_county_code" runat="server" errormessage="Please select a Class county." font-bold="True" controltovalidate="DropDownList_class_county">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Total class hours:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_total_class_hours" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_total_class_hours" runat="server" errormessage="Please enter a valid Total class hours." font-bold="True" controltovalidate="TextBox_total_class_hours" validationexpression="\d*\.?\d*">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Location of registration:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_location_of_registration" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Primary text:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_primary_text" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Additional texts:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_additional_texts" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Final registration date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_final_registration_date" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Offered as college credit:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_offered_as_college_credit" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Practical exam date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_practical_exam_date" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Written exam date:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_written_exam_date" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_disapproval_reason_id" visible="false">
    <td><font class="">Disapproval reason id:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_disapproval_reason_id" runat="server"  cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RegularExpressionValidator id="RegularExpressionValidator_disapproval_reason_id" runat="server" errormessage="Please enter a valid Disapproval reason id." font-bold="True" controltovalidate="TextBox_disapproval_reason_id" validationexpression="-?\d+">!ERR!</ASP:RegularExpressionValidator>
    </td>
  </tr>
  <tr>
    <td><font class="">Date final paperwork received:</font></td>
    <td>
      <font class="">
        <uc1:UserControl_drop_down_date id="UserControl_drop_down_date_date_final_paperwork_received" runat="server"></uc1:UserControl_drop_down_date>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Signed hardcopy:</font></td>
    <td>
      <font class="">
        <ASP:CheckBox id="CheckBox_signed_hardcopy" runat="server"  cssclass="" enabled="False"></ASP:CheckBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr>
    <td><font class="">Class disapproval reason description:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_class_disapproval_reason_description" runat="server" columns="63" maxlength="63" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_sponsor_name" visible="false">
    <td><font class="">Sponsor name:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_sponsor_name" runat="server" columns="72" maxlength="127" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
    </td>
  </tr>
  <tr runat="server" id="TableRow_courses_course_number" visible="false">
    <td><font class="">Courses course number:</font></td>
    <td>
      <font class="">
        <ASP:TextBox id="TextBox_courses_course_number" runat="server" columns="6" maxlength="6" cssclass="" enabled="False"></ASP:TextBox>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_courses_course_number" runat="server" errormessage="Please enter Courses course number." font-bold="True" controltovalidate="TextBox_courses_course_number">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
  <tr runat="server" id="TableRow_status">
    <td><font class="">Status:</font></td>
    <td>
      <font class="">
        <asp:DropDownList ID="DropDownList_status" runat="server" Enabled="false"></asp:DropDownList>
      </font>
    </td>
    <td nowrap="nowrap">
      <ASP:RequiredFieldValidator id="RequiredFieldValidator_status" runat="server" errormessage="Please select a Status." font-bold="True" controltovalidate="DropDownList_status">!ERR!</ASP:RequiredFieldValidator>
    </td>
  </tr>
      </table>
    </td>
  </tr>
</table>
<ASP:Button id="Button_submit" text="Submit" runat="server" enabled="False" onclick="Button_submit_Click" visible="false"></ASP:Button>&nbsp;&nbsp;<ASP:Button id="Button_delete" text="Delete" runat="server" enabled="False" onclick="Button_delete_Click" visible="false"></ASP:Button>

