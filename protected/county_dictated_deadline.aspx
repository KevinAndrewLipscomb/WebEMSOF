<%@ Page language="c#" Debug="true" Codebehind="county_dictated_deadline.pas" AutoEventWireup="false" Inherits="county_dictated_deadline.TWebForm_county_dictated_deadline" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_precontent" Src="~/usercontrol/app/UserControl_precontent.ascx" %>
<%@ Register TagPrefix="uc1" TagName="UserControl_postcontent" Src="~/usercontrol/app/UserControl_postcontent.ascx" %>
<%@ Register TagPrefix="sstchur" Namespace="sstchur.web.SmartNav" Assembly="sstchur.web.smartnav" %>
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
      <p><sstchur:SmartScroller id="SmartScroller_control" runat="server" /></p>
      <uc2:UserControl_update_progress_blocker id="UserControl_update_progress_blocker_control" runat="server"></uc2:UserControl_update_progress_blocker>
    </form>
  </body>
</html>
