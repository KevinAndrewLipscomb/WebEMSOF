unit UserControl_responding_services;
  // Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.pas

interface

uses
  Class_biz_services,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_responding_services = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_responding_services_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DataGrid_control_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_control_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_control_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_interactive: boolean;
        be_loaded: boolean;
        be_sort_order_ascending: boolean;
        biz_services: TClass_biz_services;
        num_participants: cardinal;
        num_nonparticipants: cardinal;
        sort_order: string;
        END;
  strict private
    p: p_type;
    procedure Bind;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    DataGrid_control: System.Web.UI.WebControls.DataGrid;
    UpdatePanel_control: System.Web.UI.UpdatePanel;
    Label_num_respondents: System.Web.UI.WebControls.Label;
    Label_num_participants: System.Web.UI.WebControls.Label;
    Label_num_nonparticipants: System.Web.UI.WebControls.Label;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_responding_services;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

const
  TCI_SELECT = 0;
  TCI_AFFILIATE_NUM = 1;
  TCI_SERVICE_NAME = 2;
  TCI_COUNTY_NAME = 3;
  TCI_BE_EMSOF_PARTICIPANT = 4;

procedure TWebUserControl_responding_services.InjectPersistentClientSideScript;
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

procedure TWebUserControl_responding_services.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    if not p.be_interactive then begin
      DataGrid_control.allowsorting := FALSE;
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

procedure TWebUserControl_responding_services.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_responding_services.p'] <> nil then begin
    p := p_type(session['UserControl_responding_services.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_regional_staffer_binder_control_UserControl_regional_staffer_current_binder_PlaceHolder_content']) = 'UserControl_responding_services');
  end else begin
    //
    p.biz_services := TClass_biz_services.Create;
    //
    p.be_interactive := not assigned(session['mode:report']);
    p.be_loaded := FALSE;
    p.be_sort_order_ascending := TRUE;
    p.num_participants := 0;
    p.num_nonparticipants := 0;
    p.sort_order := 'service_name%';
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_responding_services.InitializeComponent;
begin
  Include(Self.DataGrid_control.ItemDataBound, Self.DataGrid_control_ItemDataBound);
  Include(Self.DataGrid_control.SortCommand, Self.DataGrid_control_SortCommand);
  Include(Self.DataGrid_control.ItemCommand, Self.DataGrid_control_ItemCommand);
  Include(Self.PreRender, Self.TWebUserControl_responding_services_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_responding_services.TWebUserControl_responding_services_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_responding_services.p',p);
end;

function TWebUserControl_responding_services.Fresh: TWebUserControl_responding_services;
begin
  session.Remove('UserControl_responding_services.p');
  Fresh := self;
end;

procedure TWebUserControl_responding_services.DataGrid_control_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.item.itemtype in [listitemtype.ALTERNATINGITEM,listitemtype.ITEM,listitemtype.EDITITEM,listitemtype.SELECTEDITEM] then begin
    SessionSet('affiliate_num',Safe(e.item.cells.item[TCI_AFFILIATE_NUM].text,NUM));
    DropCrumbAndTransferTo('responding_services_detail.aspx');
  end;
end;

procedure TWebUserControl_responding_services.DataGrid_control_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
var
  link_button: linkbutton;
begin
  if p.be_interactive then begin
    if e.item.itemtype in [listitemtype.ALTERNATINGITEM,listitemtype.ITEM,listitemtype.EDITITEM,listitemtype.SELECTEDITEM] then begin
      link_button := linkbutton(e.item.cells.item[TCI_SELECT].controls.item[0]);
      link_button.text := ExpandTildePath(link_button.text);
      scriptmanager.GetCurrent(page).RegisterPostBackControl(link_button);
      if e.item.cells.item[TCI_BE_EMSOF_PARTICIPANT].text = 'YES' then begin
        p.num_participants := p.num_participants + 1;
      end else begin
        p.num_nonparticipants := p.num_nonparticipants + 1;
      end;
    end;
  end else begin
    e.item.cells.item[TCI_SELECT].visible := FALSE;
  end;
end;

procedure TWebUserControl_responding_services.DataGrid_control_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := Safe(e.SortExpression,KI_SORT_EXPRESSION);
    p.be_sort_order_ascending := TRUE;
  end;
  DataGrid_control.edititemindex := -1;
  Bind;
end;

procedure TWebUserControl_responding_services.Bind;
begin
  //
  p.biz_services.BindAnnualRespondents
    (
    p.sort_order,
    p.be_sort_order_ascending,
    DataGrid_control
    );
  //
  Label_num_respondents.text := uint32(p.num_participants + p.num_nonparticipants).tostring;
  Label_num_participants.text := p.num_participants.tostring;
  Label_num_nonparticipants.text := p.num_nonparticipants.tostring;
  //
  p.num_participants := 0;
  p.num_nonparticipants := 0;
  //
end;

end.
