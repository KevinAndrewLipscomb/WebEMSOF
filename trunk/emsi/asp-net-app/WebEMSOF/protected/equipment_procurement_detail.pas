unit equipment_procurement_detail;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  Class_biz_emsof_requests,
  Class_biz_equipment,
  Class_biz_fiscal_years,
  ki_web_ui,
  UserControl_print_div;

type
  p_type =
    RECORD
    be_sort_order_ascending: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    biz_equipment: TClass_biz_equipment;
    biz_fiscal_years: TClass_biz_fiscal_years;
    sort_order: string;
    END;
  TWebForm_equipment_procurement_detail = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_equipment_procurement_detail_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DropDownList_cycle_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure DropDownList_equipment_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure GridView_control_Sorting(sender: System.Object; e: System.Web.UI.WebControls.GridViewSortEventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   waypoint_stack: system.collections.stack;
  //
  //
  strict private
    p: p_type;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    UserControl_print_div: TWebUserControl_print_div;
    GridView_control: System.Web.UI.WebControls.GridView;
    DropDownList_equipment: System.Web.UI.WebControls.DropDownList;
    DropDownList_cycle: System.Web.UI.WebControls.DropDownList;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  kix;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_equipment_procurement_detail.InitializeComponent;
begin
  Include(Self.DropDownList_cycle.SelectedIndexChanged, Self.DropDownList_cycle_SelectedIndexChanged);
  Include(Self.DropDownList_equipment.SelectedIndexChanged, Self.DropDownList_equipment_SelectedIndexChanged);
  Include(Self.GridView_control.Sorting, Self.GridView_control_Sorting);
  Include(Self.PreRender, Self.TWebForm_equipment_procurement_detail_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_equipment_procurement_detail.Page_Load(sender: System.Object; e: System.EventArgs);
var
  cycle: string;
begin
  if not IsPostback then begin
    //
    Title.innertext := configurationmanager.appsettings['application_name'] + ' - equipment_procurement_detail';
    //
    cycle := session['equipment_procurement_cycle'].tostring;
    //
    p.biz_equipment.BindListControl(cycle,DropDownList_equipment);
    p.biz_fiscal_years.BindListControl(DropDownList_cycle);
    DropDownList_cycle.selectedvalue := cycle;
    DropDownList_equipment.selectedvalue := session['equipment_procurement_code'].tostring;
    //
    Bind;
    //
  end;
end;

procedure TWebForm_equipment_procurement_detail.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if IsPostback and (session['equipment_procurement_detail.p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['equipment_procurement_detail.p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end else begin
      //
      p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
      p.biz_equipment := TClass_biz_equipment.Create;
      p.biz_fiscal_years := TClass_biz_fiscal_years.Create;
      //
      p.be_sort_order_ascending := FALSE;
      p.sort_order := 'name';
      //
    end;
  end;
  //
end;

procedure TWebForm_equipment_procurement_detail.GridView_control_Sorting(sender: System.Object;
  e: System.Web.UI.WebControls.GridViewSortEventArgs);
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  GridView_control.editindex := -1;
  Bind;
end;

procedure TWebForm_equipment_procurement_detail.DropDownList_equipment_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  Bind;
end;

procedure TWebForm_equipment_procurement_detail.DropDownList_cycle_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_equipment.BindListControl(Safe(DropDownList_cycle.selectedvalue,NUM),DropDownList_equipment);
  Bind;
end;

procedure TWebForm_equipment_procurement_detail.TWebForm_equipment_procurement_detail_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('equipment_procurement_detail.p',p);
end;

procedure TWebForm_equipment_procurement_detail.Bind;
begin
  p.biz_emsof_requests.BindEquipmentProcurementDetail
    (
    Safe(DropDownList_cycle.selectedvalue,NUM),
    Safe(DropDownList_equipment.selectedvalue,NUM),
    p.sort_order,
    p.be_sort_order_ascending,
    GridView_control
    );
end;

end.

