<%@ Page language="c#" Debug="true" Codebehind="county_dictated_deadline.pas" AutoEventWireup="false" Inherits="county_dictated_deadline.TWebForm_county_dictated_deadline" %>
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
		  <ASP:LinkButton id="LinkButton_logout" runat="server" causesvalidation="False">Logout</ASP:LinkButton>&nbsp;] [ Back to <ASP:LinkButton id="LinkButton_county_dictated_appropriations" runat="server">county-dictated allocations</ASP:LinkButton>&nbsp;form ]</small></p>
<p>
        <ASP:Label id="Label_county_name" runat="server" font-bold="True" font-size="Large"></ASP:Label>&nbsp;<ASP:Label id="Label_literal_county" runat="server" font-bold="True"
                   font-size="Large">County</ASP:Label></p>
<p>The last day you will accept EMSOF request submissions&nbsp;from your county's services is:</p>
<blockquote>
  <ASP:Label id="Label_current_deadline" runat="server" font-bold="True"></ASP:Label></blockquote>
<p>Use the calendar to change this setting, or <ASP:LinkButton id="LinkButton_cancel" runat="server">click here to cancel</ASP:LinkButton>.</p>
<blockquote><ASP:Calendar id="Calendar" runat="server" font-size="8pt" backcolor="White" width="200px" daynameformat="FirstTwoLetters" forecolor="Black" height="180px" font-names="Verdana" bordercolor="Gainsboro" cellpadding="4">
          <TodayDayStyle forecolor="Black" backcolor="#CCCCCC"></TodayDayStyle>
          <SelectorStyle backcolor="#CCCCCC"></SelectorStyle>
          <NextPrevStyle forecolor="Blue" verticalalign="Bottom"></NextPrevStyle>
          <DayHeaderStyle font-size="7pt" font-bold="True" backcolor="WhiteSmoke"></DayHeaderStyle>
          <SelectedDayStyle font-bold="True" forecolor="White" backcolor="#666666"></SelectedDayStyle>
          <TitleStyle font-bold="True" bordercolor="Black" backcolor="Gainsboro"></TitleStyle>
          <WeekendDayStyle backcolor="#FFFFCC"></WeekendDayStyle>
          <OtherMonthDayStyle forecolor="#808080"></OtherMonthDayStyle></ASP:Calendar></blockquote>
      <p>The deadline will be set to 23:59:59 (one second before midnight) on the selected date.</p>
      <p>
    <asp:placeholder id="PlaceHolder_postcontent" runat="server">
    </asp:placeholder></p>
     </form>
  </body>
</html>
