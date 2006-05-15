
unit request_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_request_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_items_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_items_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_finalize_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Bind_items;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_make_requests_deadline: System.Web.UI.WebControls.Label;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    HyperLink_add_item_to_request: System.Web.UI.WebControls.HyperLink;
    DataGrid_items: System.Web.UI.WebControls.DataGrid;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    HyperLink_service_overview: System.Web.UI.WebControls.HyperLink;
    LinkButton_finalize: System.Web.UI.WebControls.LinkButton;
    Label_master_status: System.Web.UI.WebControls.Label;
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
procedure TWebForm_request_overview.InitializeComponent;
begin
  Include(Self.LinkButton_finalize.Click, Self.LinkButton_finalize_Click);
  Include(Self.DataGrid_items.ItemCommand, Self.DataGrid_items_ItemCommand);
  Include(Self.DataGrid_items.ItemDataBound, Self.DataGrid_items_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  be_completely_approved: boolean;
  be_finalized: boolean;
  dgi_master_id: cardinal;
  dgi_priority: cardinal;
  dgi_code: cardinal;
  dgi_item_description: cardinal;
  dgi_status: cardinal;
  dgi_linkbutton_select: cardinal;
  dgi_linkbutton_increase_priority: cardinal;
  dgi_linkbutton_decrease_priority: cardinal;
  dgi_emsof_ante: cardinal;
  num_items: cardinal;
  sum_of_emsof_antes: decimal;
  unused_amount: decimal;

procedure TWebForm_request_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.bdpdatareader;
  county_dictated_appropriation_amount: decimal;
  make_item_requests_deadline: system.datetime;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    // Initialize implementation-global variables.
    //
    be_before_deadline := TRUE;
    be_completely_approved := FALSE;
    county_dictated_appropriation_amount := decimal.Parse(session.item['county_dictated_appropriation_amount'].tostring);
    dgi_master_id := 0;
    dgi_priority := 1;
    dgi_code := 2;
    dgi_item_description := 3;
    dgi_emsof_ante := 4;
    dgi_status := 5;
    dgi_linkbutton_select := 6;
    dgi_linkbutton_increase_priority := 7;
    dgi_linkbutton_decrease_priority := 8;
    num_items := 0;
    sum_of_emsof_antes := 0;
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - request_overview';
    appcommon.bdpconnection.Open;
    //
    // Set parent appropriation labels.
    //
    Label_service_name.text := session.Item['service_name'].ToString;
    Label_fiscal_year_designator.text := session.item['fiscal_year_designator'].tostring;
    Label_sponsor_county.text := session.item['sponsor_county'].tostring;
    Label_parent_appropriation_amount.Text := county_dictated_appropriation_amount.ToString('C');
    Label_master_status.text := session.item['emsof_request_master_status'].tostring;
    //
    // All further rendering is deadline-dependent.
    //
    make_item_requests_deadline := system.datetime
      (
      borland.data.provider.bdpcommand.Create
        (
        'select service_to_county_submission_deadline'
        + ' from county_dictated_appropriation join region_dictated_appropriation'
        +   ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
        + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring,
        appcommon.bdpconnection
        )
        .ExecuteScalar
      );
    //
    be_before_deadline := (datetime.Now <= make_item_requests_deadline);
    //
    be_finalized := '1' = borland.data.provider.bdpcommand.Create
      (
      'select (status_code > 2) from emsof_request_master where id = ' + session.item['emsof_request_master_id'].tostring,
      appcommon.bdpconnection
      )
      .ExecuteScalar.tostring;
    //
    if (not be_before_deadline) or be_finalized then begin
      TableRow_sum_of_emsof_antes.visible := FALSE;
      TableRow_unrequested_amount.visible := FALSE;
      Table_deadlines.visible := FALSE;
      HyperLink_add_item_to_request.visible := FALSE;
      LinkButton_finalize.visible := FALSE;
    end else begin
      Label_make_requests_deadline.text := make_item_requests_deadline.tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      session.Remove('emsof_request_item_priority');
      session.Add('emsof_request_item_priority',system.string.EMPTY);
    end;
    //
    session.Remove('be_before_service_to_county_submission_deadline');
    session.Add('be_before_service_to_county_submission_deadline',be_before_deadline.tostring);
    session.Remove('be_finalized');
    session.Add('be_finalized',be_finalized.tostring);
    //
    // Determine the number of items in this request so that during the Bind call we can recognize the last item and manage the
    // visibility of its "Decrease priority" LinkButton.  It is cheap at this point to also set Label_sum_of_emsof_antes.
    //
    bdr := borland.data.provider.bdpcommand.Create
      (
      'select num_items,value from emsof_request_master where id = ' + session.item['emsof_request_master_id'].tostring,
      appcommon.bdpconnection
      )
      .ExecuteReader;
    bdr.Read;
    num_items := bdr['num_items'].GetHashCode;
    if be_before_deadline and (not be_finalized) then begin
      sum_of_emsof_antes := decimal.Parse(bdr['value'].tostring);
      unused_amount := county_dictated_appropriation_amount - sum_of_emsof_antes;
      //
      Label_sum_of_emsof_antes.text := sum_of_emsof_antes.tostring('C');
      Label_unused_amount.Text := unused_amount.tostring('C');
      if unused_amount < 0 then begin
        Label_unused_amount.font.bold := TRUE;
        Label_unused_amount.forecolor := color.red;
      end;
    end;
    bdr.Close;
    //
    if num_items = 0 then begin
      Label_no_appropriations.Visible := TRUE;
    end else begin
      DataGrid_items.Visible := TRUE;
    end;
    //
    if be_finalized then begin
      be_completely_approved := '1' = borland.data.provider.bdpcommand.Create
        (
        'select (status_code between 8 and 10) from emsof_request_master where id = ' + session.item['emsof_request_master_id'].tostring,
        appcommon.bdpconnection
        )
        .ExecuteScalar.tostring;
    end;
    //
    AppCommon.BdpConnection.Close;
    //
    Bind_items;  // also affected by be_before_deadline
  end;
end;

procedure TWebForm_request_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_request_overview.LinkButton_finalize_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('sum_of_emsof_antes');
  session.Add('sum_of_emsof_antes',sum_of_emsof_antes);
  session.Remove('unused_amount');
  session.Add('unused_amount',unused_amount);
  server.Transfer('finalize.aspx');
end;

procedure TWebForm_request_overview.DataGrid_items_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'IncreasePriority' then begin
    appcommon.bdpconnection.Open;
    borland.data.provider.bdpcommand.Create
      (
      'START TRANSACTION;'
      + 'update emsof_request_detail set priority = 0'
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = ' + Safe(e.item.cells[dgi_priority].text,NUM)
      + ';'
      + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[dgi_priority].text,NUM)
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = ' + Safe(e.item.cells[dgi_priority].text,NUM) + ' - 1'
      + ';'
      + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[dgi_priority].text,NUM) + ' - 1'
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = 0;'
      + 'COMMIT;',
      appcommon.bdpconnection
      )
      .ExecuteNonQuery;
    appcommon.bdpconnection.Close;
  end else if e.commandname = 'DecreasePriority' then begin
    appcommon.bdpconnection.Open;
    borland.data.provider.bdpcommand.Create
      (
      'START TRANSACTION;'
      + 'update emsof_request_detail set priority = 0'
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = ' + Safe(e.item.cells[dgi_priority].text,NUM)
      + ';'
      + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[dgi_priority].text,NUM)
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = ' + Safe(e.item.cells[dgi_priority].text,NUM) + ' + 1'
      + ';'
      + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[dgi_priority].text,NUM) + ' + 1'
      + ' where master_id = ' + session.item['emsof_request_master_id'].tostring
      +   ' and priority = 0;'
      + 'COMMIT;',
      appcommon.bdpconnection
      )
      .ExecuteNonQuery;
    appcommon.bdpconnection.Close;
  end else begin // e.commandname = 'Select'
    session.Remove('emsof_request_item_priority');
    session.Add('emsof_request_item_priority',Safe(e.item.cells[dgi_priority].text,NUM));
    session.Remove('emsof_request_item_code');
    session.Add('emsof_request_item_code',Safe(e.item.cells[dgi_code].text,NUM));
    session.Remove('emsof_request_item_equipment_category');
    session.Add('emsof_request_item_equipment_category',Safe(e.item.cells[dgi_item_description].text,NARRATIVE));
    server.Transfer('request_item_detail.aspx');
  end;
  Bind_items;
end;

procedure TWebForm_request_overview.DataGrid_items_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  //
  // Manage column visibility.
  //
  e.item.Cells[dgi_status].visible := be_completely_approved;
  //
  // Manage cells in visible columns.
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    e.item.Cells[dgi_linkbutton_increase_priority].controls.item[0].visible :=
      (e.item.itemindex > 0) and be_before_deadline and not be_finalized;
    e.item.Cells[dgi_linkbutton_decrease_priority].controls.item[0].visible :=
      (e.item.itemindex < integer(num_items) - 1) and be_before_deadline and not be_finalized;
  end;
end;

procedure TWebForm_request_overview.Bind_items;
var
  cmdText: string;
begin
  AppCommon.BdpConnection.Open;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  cmdText := 'select master_id,'                                         // column 0
  + ' priority,'                                                         // column 1
  + ' eligible_provider_equipment_list.code,'                            // column 2
  + ' eligible_provider_equipment_list.description as item_description,' // column 3
  + ' emsof_ante,'                                                       // column 4
  + ' item_status_code_description_map.description as status'            // column 5
  + ' from emsof_request_detail'
  +   ' join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
  +   ' join item_status_code_description_map on (item_status_code_description_map.code=emsof_request_detail.status_code)'
  + ' where master_id = ' + session.Item['emsof_request_master_id'].ToString
  + ' order by priority';
  //
  DataGrid_items.DataSource :=
    borland.data.provider.bdpcommand.Create(cmdText,AppCommon.BdpConnection).ExecuteReader;
  DataGrid_items.DataBind;
  //
  // Clear aggregation vars for next bind, if any.
  //
  AppCommon.BdpConnection.Close;
end;

end.

