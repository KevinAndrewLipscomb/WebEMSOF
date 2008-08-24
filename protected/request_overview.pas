unit request_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, mysql.data.mysqlclient,
  system.web.security,
  Class_biz_emsof_requests,
  Class_db,
  Class_db_trail,
  ki_web_ui,
  UserControl_print_div;

type
  p_type =
    RECORD
    be_before_deadline: boolean;
    be_completely_approved: boolean;
    be_finalized: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    db: TClass_db;
    db_trail: TClass_db_trail;
    tcci_master_id: cardinal;
    tcci_priority: cardinal;
    tcci_code: cardinal;
    tcci_item_description: cardinal;
    tcci_status: cardinal;
    tcci_linkbutton_select: cardinal;
    tcci_linkbutton_increase_priority: cardinal;
    tcci_linkbutton_decrease_priority: cardinal;
    tcci_emsof_ante: cardinal;
    num_items: cardinal;
    sum_of_emsof_antes: decimal;
    unused_amount: decimal;
    END;
  TWebForm_request_overview = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_items_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_items_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_finalize_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_request_overview_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure CheckBox_has_wish_list_CheckedChanged(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_add_item_to_request_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_withdraw_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind_items;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_make_requests_deadline: System.Web.UI.WebControls.Label;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    DataGrid_items: System.Web.UI.WebControls.DataGrid;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_finalize: System.Web.UI.WebControls.LinkButton;
    Label_master_status: System.Web.UI.WebControls.Label;
    Table_parent_appropriation_outer: System.Web.UI.HtmlControls.HtmlTable;
    CheckBox_has_wish_list: System.Web.UI.WebControls.CheckBox;
    LinkButton_add_item_to_request: System.Web.UI.WebControls.LinkButton;
    Table_withdrawal: System.Web.UI.HtmlControls.HtmlTable;
    CheckBox_withdraw: System.Web.UI.WebControls.CheckBox;
    Button_withdraw: System.Web.UI.WebControls.Button;
    UserControl_print_div: TWebUserControl_print_div;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_request_overview.InitializeComponent;
begin
  Include(Self.LinkButton_add_item_to_request.Click, Self.LinkButton_add_item_to_request_Click);
  Include(Self.LinkButton_finalize.Click, Self.LinkButton_finalize_Click);
  Include(Self.DataGrid_items.ItemCommand, Self.DataGrid_items_ItemCommand);
  Include(Self.DataGrid_items.ItemDataBound, Self.DataGrid_items_ItemDataBound);
  Include(Self.CheckBox_has_wish_list.CheckedChanged, Self.CheckBox_has_wish_list_CheckedChanged);
  Include(Self.Button_withdraw.Click, Self.Button_withdraw_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_request_overview_PreRender);
end;
{$ENDREGION}

procedure TWebForm_request_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr: mysqldatareader;
  be_deadline_exempt: boolean;
  county_dictated_appropriation_amount: decimal;
  make_item_requests_deadline: system.datetime;
begin
  if IsPostback then begin
    if assigned(session['request_overview.p']) then begin
      p := p_type(session['request_overview.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    // Initialize implementation-global variables.
    //
    p.be_before_deadline := TRUE;
    p.be_completely_approved := FALSE;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    county_dictated_appropriation_amount := decimal.Parse(session['county_dictated_appropriation_amount'].tostring);
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    p.tcci_master_id := 0;
    p.tcci_priority := 1;
    p.tcci_code := 2;
    p.tcci_item_description := 3;
    p.tcci_emsof_ante := 4;
    p.tcci_status := 5;
    p.tcci_linkbutton_select := 6;
    p.tcci_linkbutton_increase_priority := 7;
    p.tcci_linkbutton_decrease_priority := 8;
    p.num_items := 0;
    p.sum_of_emsof_antes := 0;
    //
    be_deadline_exempt := p.biz_emsof_requests.BeDeadlineExempt(session['emsof_request_master_id'].tostring);
    //
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - request_overview';
    
    p.db.Open;
    //
    Label_master_status.text := session['emsof_request_master_status'].tostring;
    //
    // All further rendering is deadline-dependent.
    //
    make_item_requests_deadline := system.datetime
      (
      mysqlcommand.Create
        (
        'select service_to_county_submission_deadline'
        + ' from county_dictated_appropriation join region_dictated_appropriation'
        +   ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
        + ' where county_dictated_appropriation.id = ' + session['county_dictated_appropriation_id'].tostring,
        p.db.connection
        )
        .ExecuteScalar
      );
    //
    p.be_before_deadline := (datetime.Now <= make_item_requests_deadline) or be_deadline_exempt;
    //
    p.be_finalized := '1' = mysqlcommand.Create
      (
      'select (status_code > 2) from emsof_request_master where id = ' + session['emsof_request_master_id'].tostring,
      p.db.connection
      )
      .ExecuteScalar.tostring;
    //
    if (not p.be_before_deadline) or p.be_finalized then begin
      Table_parent_appropriation_outer.visible := FALSE;
      Table_deadlines.visible := FALSE;
      LinkButton_add_item_to_request.visible := FALSE;
      LinkButton_finalize.visible := FALSE;
    end else begin
      Label_fiscal_year_designator.text := session['fiscal_year_designator'].tostring;
      Label_sponsor_county.text := session['sponsor_county'].tostring;
      Label_parent_appropriation_amount.Text := county_dictated_appropriation_amount.ToString('C');
      Label_make_requests_deadline.text := make_item_requests_deadline.tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      SessionSet('emsof_request_item_priority',EMPTY);
    end;
    //
    SessionSet('be_before_service_to_county_submission_deadline',p.be_before_deadline.tostring);
    SessionSet('be_finalized',p.be_finalized.tostring);
    //
    // Determine the number of items in this request so that during the Bind call we can recognize the last item and manage the
    // visibility of its "Decrease priority" LinkButton.  It is cheap at this point to also set Label_sum_of_emsof_antes.
    //
    dr := mysqlcommand.Create
      (
      'select num_items,value from emsof_request_master where id = ' + session['emsof_request_master_id'].tostring,
      p.db.connection
      )
      .ExecuteReader;
    dr.Read;
    p.num_items := dr['num_items'].GetHashCode;
    if p.be_before_deadline and (not p.be_finalized) then begin
      p.sum_of_emsof_antes := decimal.Parse(dr['value'].tostring);
      p.unused_amount := county_dictated_appropriation_amount - p.sum_of_emsof_antes;
      //
      Label_sum_of_emsof_antes.text := p.sum_of_emsof_antes.tostring('C');
      Label_unused_amount.Text := p.unused_amount.tostring('C');
      if p.unused_amount < 0 then begin
        Label_unused_amount.font.bold := TRUE;
        Label_unused_amount.forecolor := color.red;
      end;
    end;
    dr.Close;
    //
    if p.num_items = 0 then begin
      Label_no_appropriations.Visible := TRUE;
    end else begin
      DataGrid_items.Visible := TRUE;
    end;
    //
    if p.be_finalized then begin
      p.be_completely_approved := '1' = mysqlcommand.Create
        (
        'select (status_code between 8 and 10) from emsof_request_master where id = ' + session['emsof_request_master_id'].tostring,
        p.db.connection
        )
        .ExecuteScalar.tostring;
    end;
    //
    p.db.Close;
    //
    Bind_items;  // also affected by be_before_deadline
    //
    CheckBox_has_wish_list.checked := p.biz_emsof_requests.HasWishList(session['emsof_request_master_id'].tostring);
    CheckBox_has_wish_list.enabled := (uint32.Parse(session['status_code'].tostring) < 11);
    //
    Table_withdrawal.visible := p.biz_emsof_requests.BeWithdrawable(uint32.Parse(session['status_code'].tostring));
    //
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

procedure TWebForm_request_overview.Button_withdraw_Click(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_emsof_requests.Withdraw(session['emsof_request_master_id'].tostring);
  BackTrack;
end;

procedure TWebForm_request_overview.LinkButton_add_item_to_request_Click(sender: System.Object;
  e: System.EventArgs);
begin
  DropCrumbAndTransferTo('request_item_detail.aspx');
end;

procedure TWebForm_request_overview.CheckBox_has_wish_list_CheckedChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_emsof_requests.SetHasWishList(session['emsof_request_master_id'].tostring,CheckBox_has_wish_list.checked);
end;

procedure TWebForm_request_overview.TWebForm_request_overview_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('request_overview.p',p);
end;

procedure TWebForm_request_overview.LinkButton_finalize_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('sum_of_emsof_antes',p.sum_of_emsof_antes);
  SessionSet('unused_amount',p.unused_amount);
  DropCrumbAndTransferTo('finalize.aspx');
end;

procedure TWebForm_request_overview.DataGrid_items_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'IncreasePriority' then begin
    p.db.Open;
    mysqlcommand.Create
      (
      p.db_trail.Saved
        (
        'START TRANSACTION;'
        + 'update emsof_request_detail set priority = 0'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM)
        + ';'
        + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM)
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM) + ' - 1'
        + ';'
        + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM) + ' - 1'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = 0;'
        + 'COMMIT;'
        ),
      p.db.connection
      )
      .ExecuteNonQuery;
    p.db.Close;
  end else if e.commandname = 'DecreasePriority' then begin
    p.db.Open;
    mysqlcommand.Create
      (
      p.db_trail.Saved
        (
        'START TRANSACTION;'
        + 'update emsof_request_detail set priority = 0'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM)
        + ';'
        + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM)
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM) + ' + 1'
        + ';'
        + 'update emsof_request_detail set priority = ' + Safe(e.item.cells[p.tcci_priority].text,NUM) + ' + 1'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = 0;'
        + 'COMMIT;'
        ),
      p.db.connection
      )
      .ExecuteNonQuery;
    p.db.Close;
  end else begin // e.commandname = 'Select'
    SessionSet('emsof_request_item_priority',Safe(e.item.cells[p.tcci_priority].text,NUM));
    SessionSet('emsof_request_item_code',Safe(e.item.cells[p.tcci_code].text,NUM));
    SessionSet('emsof_request_item_equipment_category',Safe(e.item.cells[p.tcci_item_description].text,PUNCTUATED));
    DropCrumbAndTransferTo('request_item_detail.aspx');
  end;
  Bind_items;
end;

procedure TWebForm_request_overview.DataGrid_items_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  //
  // Manage column visibility.
  //
  e.item.Cells[p.tcci_status].visible := p.be_completely_approved;
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
    if e.item.cells[p.tcci_status].text = 'WITHDRAWN' then begin
      e.item.cells[p.tcci_priority].enabled := FALSE;
      e.item.cells[p.tcci_item_description].enabled := FALSE;
      e.item.cells[p.tcci_emsof_ante].enabled := FALSE;
      LinkButton(e.item.cells[p.tcci_linkbutton_select].controls.item[0]).text := 'WITHDRAWN';
      LinkButton(e.item.cells[p.tcci_linkbutton_select].controls.item[0]).enabled := FALSE;
    end;
    //
    e.item.Cells[p.tcci_linkbutton_increase_priority].controls.item[0].visible :=
      (e.item.itemindex > 0) and p.be_before_deadline and not p.be_finalized;
    e.item.Cells[p.tcci_linkbutton_decrease_priority].controls.item[0].visible :=
      (e.item.itemindex < integer(p.num_items) - 1) and p.be_before_deadline and not p.be_finalized;
  end;
end;

procedure TWebForm_request_overview.Bind_items;
var
  cmdText: string;
begin
  p.db.Open;
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
  + ' where master_id = ' + session['emsof_request_master_id'].ToString
  + ' order by priority';
  //
  DataGrid_items.DataSource :=
    mysqlcommand.Create(cmdText,p.db.connection).ExecuteReader;
  DataGrid_items.DataBind;
  mysqldatareader(DataGrid_items.datasource).Close;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.db.Close;
end;

end.

