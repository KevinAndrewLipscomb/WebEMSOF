<%@ Page language="c#" Debug="true" Codebehind="add_proof_of_payment.aspx.cs" AutoEventWireup="True" Inherits="add_proof_of_payment.TWebForm_add_proof_of_payment" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<%@ Register TagPrefix="uc2" TagName="UserControl_update_progress_blocker" Src="~/usercontrol/app/UserControl_update_progress_blocker.ascx" %>
<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
    <link href="../css/standard.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <style type="text/css">@import "../css/standard-overrides-for-ie6.css";</style><![endif]-->
  </head>

  <body bgcolor="white">
     <form runat="server">
	  <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent>
	  <p>
        <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">
            <tr>
              <td>
                <table cellspacing="0" cellpadding="10" border="0">
                    <tr>
                      <td bgcolor="#f5f5f5"><strong>Add a proof of payment record</strong></td>
                    </tr>
                    <tr>
					  <td>
						<table cellspacing="0" cellpadding="5" border="0">
							<tr>
							  <td>Payment made by:</td>
							  <td><ASP:Label id="Label_service_name" runat="server"></ASP:Label></td>
							  <td></td>
							</tr>
                            <tr>
							  <td valign="top">Date of payment:</td>
							  <td>
								<ASP:Calendar id="Calendar_date_of_payment" runat="server" backcolor="White" width="200px" daynameformat="FirstLetter" forecolor="Black" height="180px" font-size="8pt" font-names="Verdana" bordercolor="#999999" cellpadding="4">
                                  <TodayDayStyle forecolor="Black" backcolor="#CCCCCC"></TodayDayStyle>
                                  <SelectorStyle backcolor="#CCCCCC"></SelectorStyle>
                                  <NextPrevStyle verticalalign="Bottom"></NextPrevStyle>
                                  <DayHeaderStyle font-size="7pt" font-bold="True" backcolor="#CCCCCC"></DayHeaderStyle>
                                  <SelectedDayStyle font-bold="True" forecolor="White" backcolor="#666666"></SelectedDayStyle>
                                  <TitleStyle font-bold="True" bordercolor="Black" backcolor="#999999"></TitleStyle>
                                  <WeekendDayStyle backcolor="#FFFFCC"></WeekendDayStyle>
                                  <OtherMonthDayStyle forecolor="#808080"></OtherMonthDayStyle></ASP:Calendar></td>
							  <td valign="top"><small><p><em>Cannot be prior to date of state approval.&nbsp; Cannot be after today.</em></p></small></td>
							</tr>
							<tr>
							  <td>Method:</td>
							  <td><ASP:DropDownList id="DropDownList_methods" runat="server"></ASP:DropDownList></td>
							  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_method" runat="server" errormessage="Please specify the method of the payment." font-bold="True" controltovalidate="DropDownList_methods">!ERR!</ASP:RequiredFieldValidator></td>
							</tr>
							<tr>
							  <td>Amount:</td>
							  <td><ASP:TextBox id="TextBox_amount" runat="server" width="6pc"></ASP:TextBox></td>
							  <td><ASP:RequiredFieldValidator id="RequiredFieldValidator_amount" runat="server" errormessage="Please specify the amount of the payment." font-bold="True" controltovalidate="TextBox_amount">!ERR!</ASP:RequiredFieldValidator><ASP:RegularExpressionValidator id="RegularExpressionValidator_amount" runat="server" errormessage="Please specify a valid amount." font-bold="True" controltovalidate="TextBox_amount" validationexpression="[$0\.]*[1-9][0-9,\.]*">!ERR!</ASP:RegularExpressionValidator><ASP:CustomValidator id="CustomValidator_amount" runat="server" errormessage="Please enter a valid amount." controltovalidate="TextBox_amount" font-bold="True" onservervalidate="CustomValidator_amount_ServerValidate">!ERR!</ASP:CustomValidator></td>
							</tr>
							<tr>
							  <td>Note:</td>
							  <td><ASP:TextBox id="TextBox_note" runat="server" columns="40" maxlength="255"></ASP:TextBox></td>
							  <td></td>
							</tr>
							<tr>
							  <td></td>
							  <td><ASP:Button id="Button_submit" runat="server" text="Submit" onclick="Button_submit_Click"></ASP:Button>&nbsp; <ASP:Button id="Button_cancel" runat="server" text="Cancel" causesvalidation="False" onclick="Button_cancel_Click"></ASP:Button></td>
							  <td></td>
							</tr>
						</table></td>
                    </tr>
                </table></td>
            </tr>
        </table></p>
	  <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
