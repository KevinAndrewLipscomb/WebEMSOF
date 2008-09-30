unit state_required_report;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  mysql.data.mysqlclient,
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  kix;

type
  TWebForm_state_required_report = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_state_export_batch_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure TWebForm_state_required_report_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_transmit_to_state_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_amendment_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_export_scratch_copy_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        amendment_num_string: string;
        be_datagrid_empty: boolean;
        be_replacement_rows_present: boolean;
        biz_appropriations: TClass_biz_appropriations;
        biz_emsof_requests: TClass_biz_emsof_requests;
        grand_total_cost: decimal;
        num_datagrid_rows: cardinal;
        total_emsof_ante: decimal;
        total_provider_match: decimal;
        END;
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
    Table_report: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    LinkButton_transmit_to_state: System.Web.UI.WebControls.LinkButton;
    TableRow_this_is_everything: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_this_is_just_some: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_total_num_requests_2: System.Web.UI.WebControls.Label;
    Label_num_filtered_requests: System.Web.UI.WebControls.Label;
    DropDownList_amendment: System.Web.UI.WebControls.DropDownList;
    Label_total_num_requests: System.Web.UI.WebControls.Label;
    LinkButton_export_scratch_copy: System.Web.UI.WebControls.LinkButton;
    Table_replacement_note: System.Web.UI.HtmlControls.HtmlTable;
  protected
    procedure OnInit(e: EventArgs); override;
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_state_required_report.InitializeComponent;
begin
  Include(Self.LinkButton_export_scratch_copy.Click, Self.LinkButton_export_scratch_copy_Click);
  Include(Self.LinkButton_transmit_to_state.Click, Self.LinkButton_transmit_to_state_Click);
  Include(Self.DropDownList_amendment.SelectedIndexChanged, Self.DropDownList_amendment_SelectedIndexChanged);
  Include(Self.DataGrid_state_export_batch.ItemDataBound, Self.DataGrid_state_export_batch_ItemDataBound);
  Include(Self.PreRender, Self.TWebForm_state_required_report_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_state_required_report.Page_Load(sender: System.Object; e: System.EventArgs);
var
  i: cardinal;
  num_active_amendments: cardinal;
begin
  if IsPostback then begin
    if assigned(session['state_required_report.p']) then begin
      p := p_type(session['state_required_report.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - state_required_report';
    //
    // Initialize implementation-wide vars.
    //
    p.amendment_num_string := '0';
    p.be_replacement_rows_present := FALSE;
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.grand_total_cost := 0;
    p.num_datagrid_rows := 0;
    p.total_emsof_ante := 0;
    p.total_provider_match := 0;
    //
    Label_total_num_requests.text := p.biz_emsof_requests.TallyOfStatus(NEEDS_SENT_TO_PA_DOH_EMSO);
    num_active_amendments := p.biz_appropriations.NumActiveAmendments(session['regional_staffer_user_id'].tostring);
    if num_active_amendments = 0 then begin
      TableRow_this_is_everything.visible := TRUE;
      Label_total_num_requests_2.text := Label_total_num_requests.text;
    end else begin
      TableRow_this_is_just_some.visible := TRUE;
      DropDownList_amendment.items.Add(listitem.Create('the original contract','0'));
      for i := 1 to num_active_amendments do
        BEGIN
        DropDownList_amendment.items.Add(listitem.Create('contract amendment #' + i.tostring,i.tostring));
        END;
      Label_num_filtered_requests.text := p.biz_emsof_requests.NumRequestsInStateExportBatch
        (status_type(session['status_of_interest']),p.amendment_num_string,session['regional_staffer_user_id'].tostring).tostring;
    end;
    Label_funding_round.text :=
      cardinal(p.biz_appropriations.FundingRoundsGenerated(session['regional_staffer_user_id'].tostring) + 1).tostring;
    //
    Bind;
    //
    Label_submission_date.text := datetime.Today.tostring('d MMM yyyy');
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

procedure TWebForm_state_required_report.LinkButton_export_scratch_copy_Click(sender: System.Object;
  e: System.EventArgs);
begin
  ExportToExcel(page,'WebEmsof-UNOFFICIAL-' + datetime.Now.tostring('yyyyMMddHHmmssf'),StringOfControl(Table_report));
end;

procedure TWebForm_state_required_report.DropDownList_amendment_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.amendment_num_string := Safe(DropDownList_amendment.selectedvalue,NUM);
  Label_num_filtered_requests.text := p.biz_emsof_requests.NumRequestsInStateExportBatch
    (status_type(session['status_of_interest']),p.amendment_num_string,session['regional_staffer_user_id'].tostring).tostring;
  Label_funding_round.text := cardinal
    (1 + p.biz_appropriations.FundingRoundsGenerated(session['regional_staffer_user_id'].tostring,p.amendment_num_string)).tostring;
  Bind;
end;

procedure TWebForm_state_required_report.LinkButton_transmit_to_state_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  p.biz_emsof_requests.SubmitToState
    (
    Table_report,
    request.physicalpath,
    status_type(session['status_of_interest']),
    session['regional_staffer_user_id'].tostring,
    p.amendment_num_string
    );
  DropCrumbAndTransferTo('state_transmittal_complete.aspx');
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
    p.be_replacement_rows_present := p.be_replacement_rows_present
      or (e.item.cells[p.biz_emsof_requests.TcciOfSrrReplacementRowIndicator].text <> '&nbsp;');
    p.grand_total_cost := p.grand_total_cost + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'total_cost'));
    p.total_emsof_ante := p.total_emsof_ante + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'emsof_ante'));
    p.total_provider_match := p.total_provider_match + convert.ToDecimal(databinder.Eval(e.item.dataitem, 'provider_match'));
    //
  end else if (e.item.itemtype = listitemtype.footer) then begin
    e.item.cells[4].text := 'TOTALS:';
    e.item.cells[7].text := p.grand_total_cost.tostring('C');
    e.item.cells[8].text := p.total_emsof_ante.tostring('C');
    e.item.cells[9].text := p.total_provider_match.tostring('C');
  end;
end;

procedure TWebForm_state_required_report.TWebForm_state_required_report_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('state_required_report.p',p);
end;

procedure TWebForm_state_required_report.Bind;
begin
  p.biz_emsof_requests.BindStateExportBatch
    (
    DataGrid_state_export_batch,
    status_type(session['status_of_interest']),
    p.amendment_num_string,
    session['regional_staffer_user_id'].tostring
    );
  //
  // Manage control visibilities.
  //
  p.be_datagrid_empty := (p.num_datagrid_rows = 0);
  TableRow_none.visible := p.be_datagrid_empty;
  DataGrid_state_export_batch.visible := not p.be_datagrid_empty;
  LinkButton_transmit_to_state.enabled := not p.be_datagrid_empty;
  LinkButton_export_scratch_copy.enabled := not p.be_datagrid_empty;
  Table_replacement_note.visible := p.be_replacement_rows_present;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_datagrid_rows := 0;
  //
end;

end.

