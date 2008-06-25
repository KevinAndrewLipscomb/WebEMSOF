unit UserControl_equipment_procurement_overview;

interface

uses
  Class_biz_emsof_requests,
  Class_biz_fiscal_years,
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
    be_interactive: boolean;
    be_loaded: boolean;
    be_sort_order_ascending: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    biz_fiscal_years: TClass_biz_fiscal_years;
    cycle: string;
    sort_order: string;
    END;
  TWebUserControl_equipment_procurement_overview = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_equipment_procurement_overview_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DropDownList_cycle_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure GridView_control_Sorting(sender: System.Object; e: System.Web.UI.WebControls.GridViewSortEventArgs);
    procedure GridView_control_RowDataBound(sender: System.Object; e: System.Web.UI.WebControls.GridViewRowEventArgs);
    procedure GridView_control_SelectedIndexChanged(sender: System.Object; e: System.EventArgs);
    procedure GridView_control_RowCreated(sender: System.Object; e: System.Web.UI.WebControls.GridViewRowEventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Label_application_name: System.Web.UI.WebControls.Label;
    GridView_control: System.Web.UI.WebControls.GridView;
    DropDownList_cycle: System.Web.UI.WebControls.DropDownList;
  protected
    procedure OnInit(e: System.EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  published
    function Fresh: TWebUserControl_equipment_procurement_overview;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

const
  TCI_SELECT = 0;
  TCI_CODE = 1;

procedure TWebUserControl_equipment_procurement_overview.InjectPersistentClientSideScript;
begin
{$REGION 'Persistent client-side script'}
//  EstablishClientSideFunction(EL);
//  EstablishClientSideFunction(KGS_TO_LBS);
//  EstablishClientSideFunction(LBS_TO_KGS);
//  EstablishClientSideFunction
//    (
//    'RecalculateDependentValues()',
//    EMPTY
//    + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
//    +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
//    + NEW_LINE
//    + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
//    );
//  //
//  TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
//  TextBox_gross_landed_weight_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_gross_landed_weight_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
{$ENDREGION}
end;

procedure TWebUserControl_equipment_procurement_overview.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    p.biz_fiscal_years.BindListControl(DropDownList_cycle);
    p.cycle := Safe(DropDownList_cycle.selectedvalue,NUM);
    //
    if not p.be_interactive then begin
      DropDownList_cycle.enabled := FALSE;
      GridView_control.allowsorting := FALSE;
    end;
    //
    Bind;
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

procedure TWebUserControl_equipment_procurement_overview.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_equipment_procurement_overview.p'] <> nil then begin
    p := p_type(session['UserControl_equipment_procurement_overview.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_analyses_binder_PlaceHolder_content']) = 'UserControl_equipment_procurement_overview');
  end else begin
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.biz_fiscal_years := TClass_biz_fiscal_years.Create;
    //
    p.be_interactive := not assigned(session['mode:report']);
    p.be_loaded := FALSE;
    p.be_sort_order_ascending := FALSE;
    p.sort_order := 'emsof_part%';
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_equipment_procurement_overview.InitializeComponent;
begin
  Include(Self.DropDownList_cycle.SelectedIndexChanged, Self.DropDownList_cycle_SelectedIndexChanged);
  Include(Self.GridView_control.Sorting, Self.GridView_control_Sorting);
  Include(Self.GridView_control.RowDataBound, Self.GridView_control_RowDataBound);
  Include(Self.GridView_control.SelectedIndexChanged, Self.GridView_control_SelectedIndexChanged);
  Include(Self.GridView_control.RowCreated, Self.GridView_control_RowCreated);
  Include(Self.PreRender, Self.TWebUserControl_equipment_procurement_overview_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_equipment_procurement_overview.TWebUserControl_equipment_procurement_overview_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_equipment_procurement_overview.p',p);
end;

function TWebUserControl_equipment_procurement_overview.Fresh: TWebUserControl_equipment_procurement_overview;
begin
  session.Remove('UserControl_equipment_procurement_overview.p');
  Fresh := self;
end;

procedure TWebUserControl_equipment_procurement_overview.GridView_control_RowCreated(sender: System.Object;
  e: System.Web.UI.WebControls.GridViewRowEventArgs);
begin
  if e.row.rowtype <> datacontrolrowtype.EMPTYDATAROW then begin
    e.row.cells.item[TCI_CODE].visible := FALSE;
  end;
end;

procedure TWebUserControl_equipment_procurement_overview.GridView_control_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('equipment_procurement_cycle',p.cycle);
  SessionSet('equipment_procurement_code',Safe(GridView_control.selectedrow.cells.item[TCI_CODE].text,NUM));
  DropCrumbAndTransferTo('equipment_procurement_detail.aspx');
end;

procedure TWebUserControl_equipment_procurement_overview.GridView_control_RowDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.GridViewRowEventArgs);
begin
  if p.be_interactive then begin
    if e.row.rowtype = datacontrolrowtype.datarow then begin
      linkbutton(e.row.cells.item[TCI_SELECT].controls.item[0]).text :=
        ExpandTildePath(linkbutton(e.row.cells.item[TCI_SELECT].controls.item[0]).text);
    end;
  end else begin
    e.row.cells.item[TCI_SELECT].visible := FALSE;
  end;
end;

procedure TWebUserControl_equipment_procurement_overview.GridView_control_Sorting(sender: System.Object;
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

procedure TWebUserControl_equipment_procurement_overview.DropDownList_cycle_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.cycle := Safe(DropDownList_cycle.selectedvalue,NUM);
  Bind;
end;

procedure TWebUserControl_equipment_procurement_overview.Bind;
begin
  p.biz_emsof_requests.BindEquipmentProcurementOverview
    (
    p.cycle,
    p.sort_order,
    p.be_sort_order_ascending,
    GridView_control,
    not p.be_interactive
    );
end;

end.
