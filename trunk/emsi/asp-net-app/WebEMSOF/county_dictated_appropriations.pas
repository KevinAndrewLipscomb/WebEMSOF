
unit county_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, borland.data.provider, appcommon;

type
  TWebForm_county_dictated_appropriations = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure EditCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure CancelCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure UpdateCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_service_appropriations_ItemDataBound(sender: System.Object; 
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Bind_service_appropriations;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    DataGrid_service_appropriations: System.Web.UI.WebControls.DataGrid;
    Label_literal_county: System.Web.UI.WebControls.Label;
    HyperLink_new_appropriation: System.Web.UI.WebControls.HyperLink;
    Label_sum_of_service_appropriations: System.Web.UI.WebControls.Label;
    Label_note_deadline: System.Web.UI.WebControls.Label;
    Label_make_appropriations_deadline: System.Web.UI.WebControls.Label;
    procedure SortCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure OnInit(e: EventArgs); override;
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_dictated_appropriations.InitializeComponent;
begin
  Include(Self.DataGrid_service_appropriations.CancelCommand, Self.CancelCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.EditCommand, Self.EditCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.UpdateCommand, Self.UpdateCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.ItemDataBound, Self.DataGrid_service_appropriations_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_sort_order_ascending: boolean = TRUE;
  num_appropriations: integer = 0;
  region_dictated_appropriation_amount: decimal;
  service_appropriations_sort_order: string = 'name';
  sum_of_service_appropriations: decimal = 0;

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  accumulated_service_appropriation_amount: decimal;
  bc_get_appropriation_attribs: borland.data.provider.BdpCommand;
  bc_get_make_appropriations_deadline: borland.data.provider.BdpCommand;
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
begin
  accumulated_service_appropriation_amount := 0.0;
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_dictated_appropriations';
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    AppCommon.BdpConnection.Open;
    //
    // Set parent appropriation labels.
    //
    bc_get_appropriation_attribs := borland.data.provider.bdpcommand.Create
      (
      'select fiscal_year.designator,region_dictated_appropriation.amount,region_code_name_map.name '
      + 'from region_dictated_appropriation '
      +   'join state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id) '
      +   'join fiscal_year on (fiscal_year.id = fiscal_year_id) '
      +   'join region_code_name_map on (region_code_name_map.code = region_code) '
      + 'where region_dictated_appropriation.id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      AppCommon.BdpConnection
      );
    bdr_appropriation_attribs := bc_get_appropriation_attribs.ExecuteReader;
    bdr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := bdr_appropriation_attribs['designator'].tostring;
    region_dictated_appropriation_amount := decimal(bdr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := region_dictated_appropriation_amount.ToString('C');
    Label_region_name.Text := bdr_appropriation_attribs['name'].tostring;
    bdr_appropriation_attribs.Close;
    //
    // Set Label_make_appropriations_deadline.
    //
    bc_get_make_appropriations_deadline := borland.data.provider.bdpcommand.Create
      (
      'select value'
      + ' from fy_calendar'
      +   ' join fiscal_year on (fiscal_year.id = fiscal_year_id)'
      +   ' join milestone_code_name_map on (code = milestone_code)'
      + ' where designator = "' + Safe(Label_fiscal_year_designator.Text,ALPHANUM) + '"'
      +   ' and name = "emsof-county-dictated-appropriation-deadline"',
      appcommon.bdpconnection
      );
    Label_make_appropriations_deadline.text := bc_get_make_appropriations_deadline.ExecuteScalar.tostring;
    //
    AppCommon.BdpConnection.Close;
    //
    Bind_service_appropriations;
    //
  end;
end;

procedure TWebForm_county_dictated_appropriations.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    num_appropriations := num_appropriations + 1;
    sum_of_service_appropriations :=
      sum_of_service_appropriations + decimal.Parse(databinder.Eval(e.item.dataitem,'amount').tostring);
  end;
end;

procedure TWebForm_county_dictated_appropriations.UpdateCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  amount: decimal;
  amount_string: string;
  bc : borland.data.provider.BdpCommand;
  be_delete: boolean;
begin
  AppCommon.BdpConnection.Open;
  amount_string := Safe(TextBox(e.Item.Cells[3].Controls[0]).Text.Trim,REAL_NUM);
  if amount_string = system.string.EMPTY then begin
    be_delete := TRUE;
  end else begin
    amount := decimal.Parse(amount_string);
    be_delete := (amount = 0);
  end;
  if be_delete then begin
    bc := borland.data.provider.bdpcommand.Create
      (
      'delete from county_dictated_appropriation where id = ' + Safe(e.Item.Cells[0].Text,NUM),
      AppCommon.BdpConnection
      );
  end else begin
    bc := borland.data.provider.bdpcommand.Create
      (
      'update county_dictated_appropriation'
      + ' set amount = ' + amount.tostring
      + ' where id = ' + Safe(e.Item.Cells[0].Text,NUM),
      AppCommon.BdpConnection
      );
  end;
  bc.ExecuteNonQuery;
  AppCommon.BdpConnection.Close;
  //
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.CancelCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.EditCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_service_appropriations.EditItemIndex := e.Item.ItemIndex;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.Bind_service_appropriations;
var
  bc_get_appropriations: borland.data.provider.BdpCommand;
  bdr: borland.data.provider.BdpDataReader;
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  AppCommon.BdpConnection.Open;
  cmdText := 'select county_dictated_appropriation.id,affiliate_num,name,county_dictated_appropriation.amount '
    + 'from county_dictated_appropriation '
    +   'join service on (service.id=service_id) '
    + 'where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString + ' '
    + 'order by ' + service_appropriations_sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  bc_get_appropriations := borland.data.provider.bdpcommand.Create(cmdText,AppCommon.BdpConnection);
  bdr := bc_get_appropriations.ExecuteReader;
  DataGrid_service_appropriations.DataSource := bdr;
  DataGrid_service_appropriations.DataBind;
  be_datagrid_empty := (num_appropriations = 0);
  //
  // Manage control visibilities.
  //
  Label_no_appropriations.Visible := be_datagrid_empty;
  DataGrid_service_appropriations.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  Label_sum_of_service_appropriations.text := sum_of_service_appropriations.ToString('C');
  Label_unappropriated_amount.Text := (region_dictated_appropriation_amount - sum_of_service_appropriations).tostring('C');
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_appropriations := 0;
  sum_of_service_appropriations := 0;
  AppCommon.BdpConnection.Close;
end;

procedure TWebForm_county_dictated_appropriations.SortCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = service_appropriations_sort_order then begin
    be_sort_order_ascending := not be_sort_order_ascending;
  end else begin
    service_appropriations_sort_order := e.SortExpression;
    be_sort_order_ascending := TRUE;
  end;
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

end.

