unit UserControl_analyses_binder;

interface

uses
  ki_web_ui,
  Microsoft.Web.UI.WebControls,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls,
  UserControl_equipment_procurement_overview,
  UserControl_values_to_services
//  ,UserControl3
  ;

type
  p_type =
    RECORD
    be_loaded: boolean;
    content_id: string;
    tab_index: cardinal;
    END;
  TWebUserControl_analyses_binder = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_analyses_binder_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure TabStrip_control_SelectedIndexChange(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    TabStrip_control: Microsoft.Web.UI.WebControls.TabStrip;
    PlaceHolder_content: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: System.EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  published
    function Fresh: TWebUserControl_analyses_binder;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

const
  TSSI_EQUIPMENT_PROCUREMENT_OVERVIEW = 0;
  TSSI_VALUES_TO_SERVICES = 1;
//  TSSI_2 = 2;

procedure TWebUserControl_analyses_binder.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    //
    p.be_loaded := TRUE;
    //
  end;
  //
end;

procedure TWebUserControl_analyses_binder.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_analyses_binder.p'] <> nil then begin
    p := p_type(session['UserControl_analyses_binder.p']);
    p.be_loaded := IsPostBack;
    //
    // Dynamic controls must be re-added on each postback.
    //
    case p.tab_index of
    TSSI_EQUIPMENT_PROCUREMENT_OVERVIEW:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_equipment_procurement_overview(LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx')),
        'UserControl_equipment_procurement_overview',
        PlaceHolder_content
        );
    TSSI_VALUES_TO_SERVICES:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_values_to_services(LoadControl('~/usercontrol/app/UserControl_values_to_services.ascx')),
        'UserControl_values_to_services',
        PlaceHolder_content
        );
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
    p.tab_index := TSSI_EQUIPMENT_PROCUREMENT_OVERVIEW;
    //
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_equipment_procurement_overview(LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx')).Fresh,
      'UserControl_equipment_procurement_overview',
      PlaceHolder_content
      );
    //
  end;
  //
end;

procedure TWebUserControl_analyses_binder.TabStrip_control_SelectedIndexChange(sender: System.Object;
  e: System.EventArgs);
begin
  //
  p.tab_index := TabStrip_control.selectedindex;
  //
  PlaceHolder_content.controls.Clear;
  //
  case p.tab_index of
  TSSI_EQUIPMENT_PROCUREMENT_OVERVIEW:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_equipment_procurement_overview(LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx')).Fresh,
      'UserControl_equipment_procurement_overview',
      PlaceHolder_content
      );
  TSSI_VALUES_TO_SERVICES:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_values_to_services(LoadControl('~/usercontrol/app/UserControl_values_to_services.ascx')).Fresh,
      'UserControl_values_to_services',
      PlaceHolder_content
      );
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
procedure TWebUserControl_analyses_binder.InitializeComponent;
begin
  Include(Self.TabStrip_control.SelectedIndexChange, Self.TabStrip_control_SelectedIndexChange);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_analyses_binder_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_analyses_binder.TWebUserControl_analyses_binder_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
  // not it is already loaded in the user's browser.
  //
  SessionSet(PlaceHolder_content.clientid,p.content_id);
  //
  SessionSet('UserControl_analyses_binder.p',p);
  //
end;

function TWebUserControl_analyses_binder.Fresh: TWebUserControl_analyses_binder;
begin
  session.Remove('UserControl_analyses_binder.p');
  Fresh := self;
end;

end.
