<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_new_service.ascx.cs" Inherits="UserControl_new_service.TWebUserControl_new_service"%>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table cellspacing="0" cellpadding="20" border="0">
      <tr>
        <td>
          <p>
            Use this form to add a new Service to the drop-down list of services that appears on the login page.&nbsp;Afterward,
            when the Service logs into the system, the application will require the Service to create a profile (submit the annual
            survey).&nbsp; Only then can a county allocate funds to the service.
          </p>
          <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td valign="top">Service name:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_service_name" runat="server" maxlength="127" columns="60"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_service_name" runat="server" controltovalidate="TextBox_service_name" font-bold="True" errormessage="Please enter a Service name.">!ERR!</asp:RequiredFieldValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">Affiliate #:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_affiliate_num" runat="server" maxlength="5" columns="5"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_affiliate_num" runat="server" controltovalidate="TextBox_affiliate_num" font-bold="True" errormessage="Please enter an Affiliate number.">!ERR!</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator id="RegularExpressionValidator_affiliate_num" runat="server" controltovalidate="TextBox_affiliate_num" font-bold="True" errormessage="Please enter a valid Affiliate number." validationexpression="\d{5}">!ERR!</asp:RegularExpressionValidator>
                <asp:CustomValidator id="CustomValidator_affiliate_num" runat="server" controltovalidate="TextBox_affiliate_num" font-bold="True" errormessage="This Affiliate number is already in use in the system.">!ERR!</asp:CustomValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">Point of contact email address:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_email_address" runat="server" maxlength="255" columns="60"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_email_address" runat="server" controltovalidate="TextBox_email_address" font-bold="True" errormessage="Please enter a Point of contact email address.">!ERR!</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator id="RegularExpressionValidator_email_address" runat="server" controltovalidate="TextBox_email_address" font-bold="True" errormessage="Please enter a valid Point of contact email address." validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
                <asp:CustomValidator id="CustomValidator_email_address" runat="server" controltovalidate="TextBox_email_address" font-bold="True" errormessage='Please enter a Point of contac email address with a valid domain name (the part after the "@").'>!ERR!</asp:CustomValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">County in which service is headquartered:</td>
              <td valign="top"><asp:DropDownList id="DropDownList_county" runat="server"></asp:DropDownList></td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_county" runat="server" controltovalidate="DropDownList_county" font-bold="True" errormessage="Please select a County.">!ERR!</asp:RequiredFieldValidator>
              </td>
            </tr>
            <tr>
              <td></td>
              <td><asp:Button id="Button_submit" runat="server" text="Submit"></asp:Button></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
