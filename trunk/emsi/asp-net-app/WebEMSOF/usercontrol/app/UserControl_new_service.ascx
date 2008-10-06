<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserControl_new_service.pas" Inherits="UserControl_new_service.TWebUserControl_new_service"%>
<asp:UpdatePanel id="UpdatePanel_control" runat="server" updatemode="Conditional">
  <ContentTemplate>
    <table cellspacing="0" cellpadding="20" border="0">
      <tr>
        <td>
          <table cellspacing="0" cellpadding="10" border="0">
            <tr>
              <td valign="top">Service name:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_service_name" runat="server" columns="60" maxlength="127"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_service_name" runat="server" errormessage="Please enter a Service name." font-bold="True" controltovalidate="TextBox_service_name">!ERR!</asp:RequiredFieldValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">Affiliate #:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_affiliate_num" runat="server" columns="5" maxlength="5"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_affiliate_num" runat="server" errormessage="Please enter an Affiliate number." font-bold="True" controltovalidate="TextBox_affiliate_num">!ERR!</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator id="RegularExpressionValidator_affiliate_num" runat="server" errormessage="Please enter a valid Affiliate number." font-bold="True" controltovalidate="TextBox_affiliate_num" validationexpression="\d{5}">!ERR!</asp:RegularExpressionValidator>
                <asp:CustomValidator id="CustomValidator_affiliate_num" runat="server" errormessage="This Affiliate number is already in use in the system." font-bold="True" controltovalidate="TextBox_affiliate_num">!ERR!</asp:CustomValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">Point of contact email address:</td>
              <td valign="top">
                <asp:TextBox id="TextBox_email_address" runat="server" columns="60" maxlength="255"></asp:TextBox>
              </td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_email_address" runat="server" errormessage="Please enter a Point of contact email address." font-bold="True" controltovalidate="TextBox_email_address">!ERR!</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator id="RegularExpressionValidator_email_address" runat="server" errormessage="Please enter a valid Point of contact email address." font-bold="True" controltovalidate="TextBox_email_address" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">!ERR!</asp:RegularExpressionValidator>
                <asp:CustomValidator id="CustomValidator_email_address" runat="server" errormessage='Please enter a Point of contac email address with a valid domain name (the part after the "@").' font-bold="True" controltovalidate="TextBox_email_address">!ERR!</asp:CustomValidator>
              </td>
            </tr>
            <tr>
              <td valign="top">County in which service is headquartered:</td>
              <td valign="top"><asp:DropDownList id="DropDownList_county" runat="server"></asp:DropDownList></td>
              <td valign="top">
                <asp:RequiredFieldValidator id="RequiredFieldValidator_county" runat="server" errormessage="Please select a County." font-bold="True" controltovalidate="DropDownList_county">!ERR!</asp:RequiredFieldValidator>
              </td>
            </tr>
            <tr>
              <td></td>
              <td>
                <asp:Button id="Button_submit" runat="server" text="Submit"></asp:Button></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </ContentTemplate>
</asp:UpdatePanel>
