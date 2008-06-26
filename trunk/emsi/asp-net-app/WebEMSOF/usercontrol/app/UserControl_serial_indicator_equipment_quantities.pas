unit UserControl_serial_indicator_equipment_quantities;

interface

uses
  Class_biz_equipment,
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
    biz_equipment: TClass_biz_equipment;
    image_control_src_base: string;
    END;
  TWebUserControl_serial_indicator_equipment_quantities = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_serial_indicator_equipment_quantities_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DropDownList_equipment_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Image_control: System.Web.UI.HtmlControls.HtmlImage;
    DropDownList_equipment: System.Web.UI.WebControls.DropDownList;
  protected
    procedure OnInit(e: System.EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  published
    function Fresh: TWebUserControl_serial_indicator_equipment_quantities;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration,
  system.io;

procedure TWebUserControl_serial_indicator_equipment_quantities.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    p.biz_equipment.BindDescriptionsOnlyToListControl(DropDownList_equipment);
    p.image_control_src_base := ExpandTildePath(Image_control.src);
    Image_control.src := p.image_control_src_base + server.UrlEncode(DropDownList_equipment.text);
    //
    p.be_loaded := TRUE;
    //
  end;
  //
end;

procedure TWebUserControl_serial_indicator_equipment_quantities.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if IsPostback
    and (session['UserControl_serial_indicator_equipment_quantities.p'] <> nil)
    and (session['UserControl_serial_indicator_equipment_quantities.p'].GetType.namespace = p.GetType.namespace)
  then begin
    p := p_type(session['UserControl_serial_indicator_equipment_quantities.p']);
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_equipment := TClass_biz_equipment.Create;
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_serial_indicator_equipment_quantities.InitializeComponent;
begin
  Include(Self.DropDownList_equipment.SelectedIndexChanged, Self.DropDownList_equipment_SelectedIndexChanged);
  Include(Self.PreRender, Self.TWebUserControl_serial_indicator_equipment_quantities_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_serial_indicator_equipment_quantities.TWebUserControl_serial_indicator_equipment_quantities_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_serial_indicator_equipment_quantities.p',p);
end;

function TWebUserControl_serial_indicator_equipment_quantities.Fresh: TWebUserControl_serial_indicator_equipment_quantities;
begin
  session.Remove('UserControl_serial_indicator_equipment_quantities.p');
  Fresh := self;
end;

procedure TWebUserControl_serial_indicator_equipment_quantities.DropDownList_equipment_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  Image_control.src := p.image_control_src_base + server.UrlEncode(DropDownList_equipment.text);
end;

end.
