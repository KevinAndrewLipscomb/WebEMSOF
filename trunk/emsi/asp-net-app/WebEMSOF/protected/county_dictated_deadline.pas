
unit county_dictated_deadline;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki, system.configuration, borland.data.provider,
  system.web.security,
  Class_db,
  Class_biz_appropriations,
  Class_biz_emsof_requests;

const ID = '$Id$';

type
  p_type =
    RECORD
    biz_appropriations: TClass_biz_appropriations;
    biz_emsof_requests: TClass_biz_emsof_requests;
    db: TClass_db;
    END;
  TWebForm_county_dictated_deadline = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Calendar_SelectionChanged(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_county_dictated_appropriations_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_cancel_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_county_dictated_deadline_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
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
    LinkButton_county_dictated_appropriations: System.Web.UI.WebControls.LinkButton;
    LinkButton_cancel: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  appcommon;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_dictated_deadline.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_county_dictated_appropriations.Click, Self.LinkButton_county_dictated_appropriations_Click);
  Include(Self.LinkButton_cancel.Click, Self.LinkButton_cancel_Click);
  Include(Self.Calendar.SelectionChanged, Self.Calendar_SelectionChanged);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_county_dictated_deadline_PreRender);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_deadline.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  appcommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - county_dictated_deadline';
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.db := TClass_db.Create;
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

procedure TWebForm_county_dictated_deadline.TWebForm_county_dictated_deadline_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_county_dictated_deadline.LinkButton_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
end;

procedure TWebForm_county_dictated_deadline.LinkButton_county_dictated_appropriations_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('county_dictated_appropriations.aspx');
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
  p.biz_appropriations.SetServiceToCountySubmissionDeadline
    (session['region_dictated_appropriation_id'].tostring,Calendar.selecteddate);
  if (datetime.Parse(session['county_dictated_deadline'].tostring) < datetime.Now)
    and ((Calendar.selecteddate + timespan.Parse('23:59:59')) > datetime.Now)
    and p.biz_emsof_requests.BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation
      (session['region_dictated_appropriation_id'].tostring)
  then begin
    server.Transfer('county_unrejection.aspx');
  end else begin
    server.Transfer('county_dictated_appropriations.aspx');
  end;
end;

end.
