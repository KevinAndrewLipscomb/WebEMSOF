unit UserControl_regional_staffer_binder;

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
  TWebUserControl_regional_staffer_binder = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_regional_staffer_binder_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure TabContainer_control_ActiveTabChanged(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        content_id: string;
        tab_index: cardinal;
        END;
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    TabContainer_control: AjaxControlToolkit.TabContainer;
    PlaceHolder_content: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_regional_staffer_binder;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration,
  UserControl_about,
  UserControl_analyses_binder,
  UserControl_config_binder,
  UserControl_regional_staffer_current_binder,
//  UserControl_new_binder,
  UserControl_regional_staffer_old_binder
  ;

const
  TSSI_CURRENT = 0;
  TSSI_OLD = 1;
  TSSI_NEW = 2;
  TSSI_ANALYSES = 3;
  TSSI_CONFIG = 4;
  TSSI_ABOUT = 5;

procedure TWebUserControl_regional_staffer_binder.Page_Load(sender: System.Object; e: System.EventArgs);
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

procedure TWebUserControl_regional_staffer_binder.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_regional_staffer_binder.p'] <> nil then begin
    p := p_type(session['UserControl_regional_staffer_binder.p']);
    p.be_loaded := IsPostBack;
    //
    if assigned(session['UserControl_regional_staffer_binder_selected_tab']) then begin
      p.tab_index := session['UserControl_regional_staffer_binder_selected_tab'].GetHashCode;
      session.Remove('UserControl_regional_staffer_binder_selected_tab');
    end;
    //
    // Dynamic controls must be re-added on each postback.
    //
    case p.tab_index of
    TSSI_CURRENT:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_regional_staffer_current_binder(LoadControl('~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx')),
        'UserControl_regional_staffer_current_binder',
        PlaceHolder_content
        );
    TSSI_OLD:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_regional_staffer_old_binder(LoadControl('~/usercontrol/app/UserControl_regional_staffer_old_binder.ascx')),
        'UserControl_regional_staffer_old_binder',
        PlaceHolder_content
        );
//    TSSI_NEW:
//      p.content_id := AddIdentifiedControlToPlaceHolder
//        (
//        TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')),
//        'UserControl3',
//        PlaceHolder_content
//        );
    TSSI_ANALYSES:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_analyses_binder(LoadControl('~/usercontrol/app/UserControl_analyses_binder.ascx')),
        'UserControl_analyses_binder',
        PlaceHolder_content
        );
    TSSI_CONFIG:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_config_binder(LoadControl('~/usercontrol/app/UserControl_config_binder.ascx')),
        'UserControl_config_binder',
        PlaceHolder_content
        );
    TSSI_ABOUT:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_about(LoadControl('~/usercontrol/app/UserControl_about.ascx')),
        'UserControl_about',
        PlaceHolder_content
        );
    end;
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.tab_index := TSSI_CURRENT;
    //
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_regional_staffer_current_binder(LoadControl('~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx')).Fresh,
      'UserControl_regional_staffer_current_binder',
      PlaceHolder_content
      );
    //
  end;
  //
end;

procedure TWebUserControl_regional_staffer_binder.TabContainer_control_ActiveTabChanged(sender: System.Object;
  e: System.EventArgs);
begin
  //
  p.tab_index := TabContainer_control.activetabindex;
  //
  PlaceHolder_content.controls.Clear;
  //
  case p.tab_index of
  TSSI_CURRENT:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_regional_staffer_current_binder(LoadControl('~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx')).Fresh,
      'UserControl_regional_staffer_current_binder',
      PlaceHolder_content
      );
  TSSI_OLD:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_regional_staffer_old_binder(LoadControl('~/usercontrol/app/UserControl_regional_staffer_old_binder.ascx')).Fresh,
      'UserControl_regional_staffer_old_binder',
      PlaceHolder_content
      );
//  TSSI_NEW:
//    p.content_id := AddIdentifiedControlToPlaceHolder
//      (
//      TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')).Fresh,
//      'UserControl3',
//      PlaceHolder_content
//      );
  TSSI_ANALYSES:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_analyses_binder(LoadControl('~/usercontrol/app/UserControl_analyses_binder.ascx')).Fresh,
      'UserControl_analyses_binder',
      PlaceHolder_content
      );
  TSSI_CONFIG:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_config_binder(LoadControl('~/usercontrol/app/UserControl_config_binder.ascx')).Fresh,
      'UserControl_config_binder',
      PlaceHolder_content
      );
  TSSI_ABOUT:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_about(LoadControl('~/usercontrol/app/UserControl_about.ascx')).Fresh,
      'UserControl_about',
      PlaceHolder_content
      );
  end;
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_regional_staffer_binder.InitializeComponent;
begin
  Include(Self.TabContainer_control.ActiveTabChanged, Self.TabContainer_control_ActiveTabChanged);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_regional_staffer_binder_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_regional_staffer_binder.TWebUserControl_regional_staffer_binder_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
  // not it is already loaded in the user's browser.
  //
  SessionSet(PlaceHolder_content.clientid,p.content_id);
  //
  SessionSet('UserControl_regional_staffer_binder.p',p);
  //
end;

function TWebUserControl_regional_staffer_binder.Fresh: TWebUserControl_regional_staffer_binder;
begin
  session.Remove('UserControl_regional_staffer_binder.p');
  Fresh := self;
end;

end.
