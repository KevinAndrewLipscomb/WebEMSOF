
unit state_required_report;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  borland.data.provider,
  Class_biz_emsof_requests,
  ki.common;

const ID = '$Id$';

type
  p_type =
    RECORD
    be_datagrid_empty: boolean;
    biz_emsof_requests: Class_biz_emsof_requests.TClass_biz_emsof_requests;
    grand_total_cost: decimal;
    num_datagrid_rows: cardinal;
    total_emsof_ante: decimal;
    total_provider_match: decimal;
    END;
  TWebForm_state_required_report = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_state_export_batch_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure TWebForm_state_required_report_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_funding_round: System.Web.UI.WebControls.Label;
    Label_submission_date: System.Web.UI.WebControls.Label;
    Label_amount_available: System.Web.UI.WebControls.Label;
    DataGrid_state_export_batch: System.Web.UI.WebControls.DataGrid;
    LinkButton_print_version: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_state_required_report.InitializeComponent;
begin
  Include(Self.DataGrid_state_export_batch.ItemDataBound, Self.DataGrid_state_export_batch_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_state_required_report_PreRender);
end;
{$ENDREGION}

procedure TWebForm_state_required_report.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback then begin
    p := p_type(session['p']);
  end else begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - state_required_report';
    //
    // Initialize implementation-wide vars.
    //
    p.grand_total_cost := 0;
    p.num_datagrid_rows := 0;
    p.total_emsof_ante := 0;
    p.total_provider_match := 0;
    //
    Bind;
    //
  end;
end;

procedure TWebForm_state_required_report.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_state_required_report.DataGrid_state_export_batch_ItemDataBound
  (
  sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs
  );
begin
  //
  // Manage column visibility
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_datagrid_rows := p.num_datagrid_rows + 1;
    p.grand_total_cost := p.grand_total_cost + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'total_cost'));
    p.total_emsof_ante := p.total_emsof_ante + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'emsof_ante'));
    p.total_provider_match := p.total_provider_match + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'provider_match'));
    //
  end else if (e.item.itemtype = listitemtype.footer) then begin
    e.item.cells[2].text := 'TOTALS:';
    e.item.cells[5].text := p.grand_total_cost.tostring('C');
    e.item.cells[6].text := p.total_emsof_ante.tostring('C');
    e.item.cells[7].text := p.total_provider_match.tostring('C');
  end;
end;

procedure TWebForm_state_required_report.TWebForm_state_required_report_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_state_required_report.Bind;
begin
  TClass_biz_emsof_requests.Create.BindStateExportBatch(DataGrid_state_export_batch,status_type(session['status_of_interest']));
  //
  // Manage control visibilities.
  //
  p.be_datagrid_empty := (p.num_datagrid_rows = 0);
  TableRow_none.visible := p.be_datagrid_empty;
  DataGrid_state_export_batch.visible := not p.be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_datagrid_rows := 0;
  //
end;

end.

