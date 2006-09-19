
unit county_dictated_deadline;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common, system.configuration, borland.data.provider,
  system.web.security;

const ID = '$Id$';

type
  TWebForm_county_dictated_deadline = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Calendar_SelectionChanged(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    Label_literal_county: System.Web.UI.WebControls.Label;
    Calendar: System.Web.UI.WebControls.Calendar;
    Label_current_deadline: System.Web.UI.WebControls.Label;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_county_dictated_appropriations: System.Web.UI.WebControls.HyperLink;
    HyperLink_cancel: System.Web.UI.WebControls.HyperLink;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_dictated_deadline.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Calendar.SelectionChanged, Self.Calendar_SelectionChanged);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_deadline.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if (session['county_name'] = nil)
    or (session['county_dictated_deadline'] = nil)
    or (session['region_dictated_appropriation_id'] = nil)
  then begin
    server.Transfer('~/login.aspx');
  end;
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - county_dictated_deadline';
    //
    Label_county_name.text := session['county_name'].tostring;
    Label_current_deadline.text := session['county_dictated_deadline'].tostring;
    Calendar.selecteddate := datetime.Parse(session['county_dictated_deadline'].tostring);
    Calendar.visibledate := datetime.Parse(session['county_dictated_deadline'].tostring);
    //
  end;
end;

procedure TWebForm_county_dictated_deadline.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_dictated_deadline.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_county_dictated_deadline.Calendar_SelectionChanged(sender: System.Object;
  e: System.EventArgs);
begin
  ki.common.DbOpen;
  borland.data.provider.bdpcommand.Create
    (
    'update region_dictated_appropriation'
    + ' set service_to_county_submission_deadline = "' + Calendar.selecteddate.tostring('yyyyMMdd') + '235959"'
    + ' where id = ' + session['region_dictated_appropriation_id'].tostring,
    ki.common.db
    )
    .ExecuteNonQuery;
  ki.common.DbClose;
  server.Transfer('county_dictated_appropriations.aspx');
end;

end.

