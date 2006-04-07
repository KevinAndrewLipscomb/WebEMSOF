<%@ Page language="c#" Debug="true" Codebehind="service_overview.pas" AutoEventWireup="false" Inherits="service_overview.TWebForm_account_overview"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
    <title id="Title" runat="server"></title>
  </head>
  <body>
    <form runat="server">
      <p>
        <asp:placeholder id="PlaceHolder_precontent" runat="server"></asp:placeholder>
      </p>
      <p>
        <ASP:Label id="Label_service_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>
      </p>
      <p><strong>Account overview</strong>
      </p>
      <p>
        <table cellspacing="0" cellpadding="0" width="%" border="1">
          <tr>
            <td>
              <table cellspacing="0" cellpadding="10" width="%" border="0">
                <tr>
                  <td></td>
                  <td>
                    <p align="center">Status</p></td>
                  <td>
                    <p align="center">Value</p></td>
                  <td>
                        <p align="center">Action</p></td>
                </tr>
                <tr>
                  <td>Your service's WebEMSOF profile is:</td>
                  <td>
                    <p align="center">
                      <ASP:Label id="Label_profile_status" runat="server" font-bold="True"></ASP:Label>
                    </p></td>
                  <td>
                    <p align="center">--</p></td>
                  <td>
                        <div align="center">
                    <ASP:LinkButton id="LinkButton_profile_action" runat="server" font-bold="True"></ASP:LinkButton>
                        </div></td>
                </tr>
                <tr>
                  <td><ASP:Label id="Label_last_fy_row_leader" runat="server" visible="False">Your request for <strong>last</strong> fiscal year is:</ASP:Label>
                        <ASP:Label id="Label_last_fy_request_id" runat="server" visible="False"></ASP:Label></td>
                  <td>
                    <div align="center">
                      <ASP:Label id="Label_last_fy_request_status" runat="server" font-bold="True"></ASP:Label>
                    </div></td>
                  <td>
                    <div align="center">
                      <ASP:Label id="Label_last_fy_request_value" runat="server" font-bold="True"></ASP:Label>
                    </div></td>
                  <td>
                        <div align="center">
                    <ASP:LinkButton id="LinkButton_last_fy_request_action" runat="server" font-bold="True"></ASP:LinkButton>
                        </div></td>
                </tr>
                <tr>
                  <td><ASP:Label id="Label_this_fy_row_leader" runat="server" visible="False">Your request for <strong>this</strong> fiscal year is:</ASP:Label>
                        <ASP:Label id="Label_this_fy_request_id" runat="server" visible="False"></ASP:Label></td>
                  <td>
                    <div align="center">
                      <ASP:Label id="Label_this_fy_request_status" runat="server" font-bold="True"></ASP:Label>
                    </div></td>
                  <td>
                    <div align="center">
                      <ASP:Label id="Label_this_fy_request_value" runat="server" font-bold="True"></ASP:Label>
                    </div></td>
                  <td>
                        <div align="center">
                    <ASP:LinkButton id="LinkButton_this_fy_request_action" runat="server" font-bold="True"></ASP:LinkButton>
                        </div></td>
                </tr>
              </table></td>
          </tr>
        </table>
      </p>
      <p>Change WebEMSOF 
        <ASP:LinkButton id="LinkButton_change_password" runat="server">password</ASP:LinkButton>&nbsp;| <ASP:LinkButton id="LinkButton_change_email_address" runat="server">email address</ASP:LinkButton>
      </p>
      <p></p>
      <asp:placeholder id="PlaceHolder_postcontent" runat="server"></asp:placeholder>
    </form>
  </body>
</html>
