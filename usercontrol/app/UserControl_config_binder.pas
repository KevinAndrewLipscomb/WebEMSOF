unit UserControl_config_binder;

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
  TWebUserControl_config_binder = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_config_binder_PreRender(sender: System.Object;
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
    function Fresh: TWebUserControl_config_binder;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration,
  UserControl_charter_kind //,
// ,UserControl_1
// ,UserControl_2
  ;

const
  TSSI_CHARTER_KINDS = 0;
//  TSSI_1 = 1;
//  TSSI_2 = 2;

procedure TWebUserControl_config_binder.Page_Load(sender: System.Object; e: System.EventArgs);
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

procedure TWebUserControl_config_binder.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_config_binder.p'] <> nil then begin
    p := p_type(session['UserControl_config_binder.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_regional_staffer_binder_PlaceHolder_content']) = 'UserControl_config_binder');
    //
    if assigned(session['UserControl_config_binder_selected_tab']) then begin
      p.tab_index := session['UserControl_config_binder_selected_tab'].GetHashCode;
      session.Remove('UserControl_config_binder_selected_tab');
    end;
    //
    // Dynamic controls must be re-added on each postback.
    //
    case p.tab_index of
    TSSI_CHARTER_KINDS:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_charter_kind(LoadControl('~/usercontrol/app/UserControl_charter_kind.ascx')),
        'UserControl_charter_kind',
        PlaceHolder_content
        );
//    TSSI_1:
//      p.content_id := AddIdentifiedControlToPlaceHolder
//        (
//        TWebUserControl2(LoadControl('~/usercontrol/app/UserControl2.ascx')),
//        'UserControl2',
//        PlaceHolder_content
//        );
//    TSSI_2:
//      p.content_id := AddIdentifiedControlToPlaceHolder
//        (
//        TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')),
//        'UserControl3',
//        PlaceHolder_content
//        );
    end;
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.tab_index := TSSI_CHARTER_KINDS;
    //
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_charter_kind(LoadControl('~/usercontrol/app/UserControl_charter_kind.ascx')).Fresh,
      'UserControl_charter_kind',
      PlaceHolder_content
      );
    //
  end;
  //
end;

procedure TWebUserControl_config_binder.TabContainer_control_ActiveTabChanged(sender: System.Object;
  e: System.EventArgs);
begin
  //
  p.tab_index := TabContainer_control.activetabindex;
  //
  PlaceHolder_content.controls.Clear;
  //
  case p.tab_index of
  TSSI_CHARTER_KINDS:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_charter_kind(LoadControl('~/usercontrol/app/UserControl_charter_kind.ascx')).Fresh,
      'UserControl_charter_kind',
      PlaceHolder_content
      );
//  TSSI_1:
//    p.content_id := AddIdentifiedControlToPlaceHolder
//      (
//      TWebUserControl2(LoadControl('~/usercontrol/app/UserControl2.ascx')).Fresh,
//      'UserControl2',
//      PlaceHolder_content
//      );
//  TSSI_2:
//    p.content_id := AddIdentifiedControlToPlaceHolder
//      (
//      TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')).Fresh,
//      'UserControl3',
//      PlaceHolder_content
//      );
  end;
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_config_binder.InitializeComponent;
begin
  Include(Self.TabContainer_control.ActiveTabChanged, Self.TabContainer_control_ActiveTabChanged);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_config_binder_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_config_binder.TWebUserControl_config_binder_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
  // not it is already loaded in the user's browser.
  //
  SessionSet(PlaceHolder_content.clientid,p.content_id);
  //
  SessionSet('UserControl_config_binder.p',p);
  //
end;

function TWebUserControl_config_binder.Fresh: TWebUserControl_config_binder;
begin
  session.Remove('UserControl_config_binder.p');
  Fresh := self;
end;

end.
