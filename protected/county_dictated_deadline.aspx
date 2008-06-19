<%@ Page language="c#" Debug="true" Codebehind="county_dictated_deadline.pas" AutoEventWireup="false" Inherits="county_dictated_deadline.TWebForm_county_dictated_deadline" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
  <head>
	<title id="Title" runat="server"></title>
      <!-- $Id$ -->
    <script type="text/javascript" src="../js/gradient.js"></script>
  </head>

  <body bgcolor="white">
     <form runat="server">
      <p>
      <uc1:UserControl_precontent id="UserControl_precontent" runat="server"></uc1:UserControl_precontent></p>
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
    <uc1:UserControl_postcontent id="UserControl_postcontent" runat="server"></uc1:UserControl_postcontent></p>
     <sstchur:SmartScroller runat="server" /></form>
  </body>
</html>
