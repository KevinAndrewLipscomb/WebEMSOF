unit UserControl_equipment_procurement_binder;

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
  UserControl_serial_indicator_equipment_quantities
//  ,UserControl3
;

type
  p_type =
    RECORD
    be_loaded: boolean;
    content_id: string;
    tab_index: cardinal;
    END;
  TWebUserControl_equipment_procurement_binder = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_equipment_procurement_binder_PreRender(sender: System.Object;
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
    function Fresh: TWebUserControl_equipment_procurement_binder;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

const
  TSSI_SNAPSHOT = 0;
  TSSI_SERIAL = 1;
//  TSSI_2 = 2;

procedure TWebUserControl_equipment_procurement_binder.Page_Load(sender: System.Object; e: System.EventArgs);
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

procedure TWebUserControl_equipment_procurement_binder.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_equipment_procurement_binder.p'] <> nil then begin
    p := p_type(session['UserControl_equipment_procurement_binder.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_analyses_binder_PlaceHolder_content']) = 'UserControl_equipment_procurement_binder');
    //
    // Dynamic controls must be re-added on each postback.
    //
    case p.tab_index of
    TSSI_SNAPSHOT:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_equipment_procurement_overview(LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx')),
        'UserControl_equipment_procurement_overview',
        PlaceHolder_content
        );
    TSSI_SERIAL:
      p.content_id := AddIdentifiedControlToPlaceHolder
        (
        TWebUserControl_serial_indicator_equipment_quantities(LoadControl('~/usercontrol/app/UserControl_serial_indicator_equipment_quantities.ascx')),
        'UserControl_serial_indicator_equipment_quantities',
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
    p.tab_index := TSSI_SNAPSHOT;
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

procedure TWebUserControl_equipment_procurement_binder.TabStrip_control_SelectedIndexChange(sender: System.Object;
  e: System.EventArgs);
begin
  //
  p.tab_index := TabStrip_control.selectedindex;
  //
  PlaceHolder_content.controls.Clear;
  //
  case p.tab_index of
  TSSI_SNAPSHOT:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_equipment_procurement_overview(LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx')).Fresh,
      'UserControl_equipment_procurement_overview',
      PlaceHolder_content
      );
  TSSI_SERIAL:
    p.content_id := AddIdentifiedControlToPlaceHolder
      (
      TWebUserControl_serial_indicator_equipment_quantities(LoadControl('~/usercontrol/app/UserControl_serial_indicator_equipment_quantities.ascx')).Fresh,
      'UserControl_serial_indicator_equipment_quantities',
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
procedure TWebUserControl_equipment_procurement_binder.InitializeComponent;
begin
  Include(Self.TabStrip_control.SelectedIndexChange, Self.TabStrip_control_SelectedIndexChange);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_equipment_procurement_binder_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_equipment_procurement_binder.TWebUserControl_equipment_procurement_binder_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
  // not it is already loaded in the user's browser.
  //
  SessionSet(PlaceHolder_content.clientid,p.content_id);
  //
  SessionSet('UserControl_equipment_procurement_binder.p',p);
  //
end;

function TWebUserControl_equipment_procurement_binder.Fresh: TWebUserControl_equipment_procurement_binder;
begin
  session.Remove('UserControl_equipment_procurement_binder.p');
  Fresh := self;
end;

end.
