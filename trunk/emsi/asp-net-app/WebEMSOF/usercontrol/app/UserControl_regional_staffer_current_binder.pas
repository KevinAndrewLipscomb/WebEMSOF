unit UserControl_regional_staffer_current_binder;

interface

uses
  AjaxControlToolkit,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  p_type =
    RECORD
    be_loaded: boolean;
    content_id: string;
    tab_index: cardinal;
    END;
  TWebUserControl_regional_staffer_current_binder = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_regional_staffer_current_binder_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure TabContainer_control_ActiveTabChanged(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    TabContainer_control: AjaxControlToolkit.TabContainer;
    PlaceHolder_content: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_regional_staffer_current_binder;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration,
  UserControl_financial_snapshot,
  UserControl_outcomes,
  UserControl_workflow;

const
  TSSI_SNAPSHOT = 0;
  TSSI_WORKFLOW = 1;
  TSSI_OUTCOMES = 2;

procedure TWebUserControl_regional_staffer_current_binder.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    TabContainer_control.activetabindex := p.tab_index;
    //
    p.be_loaded := TRUE;
    //
  end;
  //
end;

procedure TWebUserControl_regional_staffer_current_binder.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_regional_staffer_current_binder.p'] <> nil then begin
    p := p_type(session['UserControl_regional_staffer_current_binder.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_regional_staffer_binder_PlaceHolder_content']) = 'UserControl_regional_staffer_current_binder');
    //
    if assigned(session['UserControl_regional_staffer_current_binder_selected_tab']) then begin
      p.tab_index := session['UserControl_regional_staffer_current_binder_selected_tab'].GetHashCode;
      session.Remove('UserControl_regional_staffer_current_binder_selected_tab');
    end;
    //
    // Dynamic controls must be re-added on each postback.
    //
    case p.tab_index of
    TSSI_SNAPSHOT:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_financial_snapshot(LoadControl('~/usercontrol/app/UserControl_financial_snapshot.ascx')),
        'UserControl_financial_snapshot',
        PlaceHolder_content
        );
    TSSI_WORKFLOW:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_workflow(LoadControl('~/usercontrol/app/UserControl_workflow.ascx')),
        'UserControl_workflow',
        PlaceHolder_content
        );
    TSSI_OUTCOMES:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_outcomes(LoadControl('~/usercontrol/app/UserControl_outcomes.ascx')),
        'UserControl_outcomes',
        PlaceHolder_content
        );
    end;
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.tab_index := TSSI_SNAPSHOT;
    //
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_financial_snapshot(LoadControl('~/usercontrol/app/UserControl_financial_snapshot.ascx')).Fresh,
      'UserControl_financial_snapshot',
      PlaceHolder_content
      );
    //
  end;
  //
end;

procedure TWebUserControl_regional_staffer_current_binder.TabContainer_control_ActiveTabChanged(sender: System.Object;
  e: System.EventArgs);
begin
  //
  p.tab_index := TabContainer_control.activetabindex;
  //
  PlaceHolder_content.controls.Clear;
  //
  case p.tab_index of
  TSSI_SNAPSHOT:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_financial_snapshot(LoadControl('~/usercontrol/app/UserControl_financial_snapshot.ascx')).Fresh,
      'UserControl_financial_snapshot',
      PlaceHolder_content
      );
  TSSI_WORKFLOW:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_workflow(LoadControl('~/usercontrol/app/UserControl_workflow.ascx')).Fresh,
      'UserControl_workflow',
      PlaceHolder_content
      );
  TSSI_OUTCOMES:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_outcomes(LoadControl('~/usercontrol/app/UserControl_outcomes.ascx')).Fresh,
      'UserControl_outcomes',
      PlaceHolder_content
      );
  end;
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_regional_staffer_current_binder.InitializeComponent;
begin
  Include(Self.TabContainer_control.ActiveTabChanged, Self.TabContainer_control_ActiveTabChanged);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_regional_staffer_current_binder_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_regional_staffer_current_binder.TWebUserControl_regional_staffer_current_binder_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
  // not it is already loaded in the user's browser.
  //
  SessionSet(PlaceHolder_content.clientid,p.content_id);
  //
  SessionSet('UserControl_regional_staffer_current_binder.p',p);
  //
end;

function TWebUserControl_regional_staffer_current_binder.Fresh: TWebUserControl_regional_staffer_current_binder;
begin
  session.Remove('UserControl_regional_staffer_current_binder.p');
  Fresh := self;
end;

end.
