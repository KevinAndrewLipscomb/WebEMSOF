unit county_dictated_deadline;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, mysql.data.mysqlclient,
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
    Calendar: System.Web.UI.WebControls.Calendar;
    Label_current_deadline: System.Web.UI.WebControls.Label;
    LinkButton_county_dictated_appropriations: System.Web.UI.WebControls.LinkButton;
    LinkButton_cancel: System.Web.UI.WebControls.LinkButton;
  protected
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
  Include(Self.LinkButton_cancel.Click, Self.LinkButton_cancel_Click);
  Include(Self.Calendar.SelectionChanged, Self.Calendar_SelectionChanged);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_county_dictated_deadline_PreRender);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_deadline.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback then begin
    if assigned(session['county_dictated_deadline.p']) then begin
      p := p_type(session['county_dictated_deadline.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - county_dictated_deadline';
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.db := TClass_db.Create;
    //
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
  SessionSet('county_dictated_deadline.p',p);
end;

procedure TWebForm_county_dictated_deadline.LinkButton_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
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
    DropCrumbAndTransferTo('county_unrejection.aspx');
  end else begin
    BackTrack;
  end;
end;

end.
