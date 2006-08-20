
unit state_required_report;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  borland.data.provider,
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  ki.common;

const ID = '$Id$';

type
  p_type =
    RECORD
    amendment_num_string: string;
    be_datagrid_empty: boolean;
    biz_appropriations: TClass_biz_appropriations;
    biz_emsof_requests: TClass_biz_emsof_requests;
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
    procedure LinkButton_transmit_to_state_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_amendment_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   regional_stafer_user_id: string;
  //   status_of_interest: Class_biz_emsof_requests.status_type
  //   waypoint_stack: system.collections.stack;
  //
  //
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
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    LinkButton_transmit_to_state: System.Web.UI.WebControls.LinkButton;
    TableRow_this_is_everything: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_this_is_just_some: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_total_num_requests_2: System.Web.UI.WebControls.Label;
    Label_num_filtered_requests: System.Web.UI.WebControls.Label;
    DropDownList_amendment: System.Web.UI.WebControls.DropDownList;
    Label_total_num_requests: System.Web.UI.WebControls.Label;
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
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_transmit_to_state.Click, Self.LinkButton_transmit_to_state_Click);
  Include(Self.DropDownList_amendment.SelectedIndexChanged, Self.DropDownList_amendment_SelectedIndexChanged);
  Include(Self.DataGrid_state_export_batch.ItemDataBound, Self.DataGrid_state_export_batch_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_state_required_report_PreRender);
end;
{$ENDREGION}

procedure TWebForm_state_required_report.Page_Load(sender: System.Object; e: System.EventArgs);
var
  i: cardinal;
  num_active_amendments: cardinal;
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback then begin
    p := p_type(session['p']);
  end else begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - state_required_report';
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    //
    Label_total_num_requests.text := p.biz_emsof_requests.TallyOfStatus(NEEDS_PA_DOH_EMSO_APPROVAL);
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
      Label_num_filtered_requests.text := '(not yet implemented)';
    end;
    Label_funding_round.text :=
      cardinal(p.biz_appropriations.FundingRoundsGenerated(session['regional_staffer_user_id'].tostring) + 1).tostring;
    //
    // Initialize implementation-wide vars.
    //
    p.amendment_num_string := '0';
    p.grand_total_cost := 0;
    p.num_datagrid_rows := 0;
    p.total_emsof_ante := 0;
    p.total_provider_match := 0;
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

procedure TWebForm_state_required_report.DropDownList_amendment_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.amendment_num_string := Safe(DropDownList_amendment.selectedvalue,NUM);
  Label_funding_round.text := cardinal
    (1 + p.biz_appropriations.FundingRoundsGenerated(session['regional_staffer_user_id'].tostring,p.amendment_num_string)).tostring;
end;

procedure TWebForm_state_required_report.LinkButton_back_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_state_required_report.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
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
  server.Transfer('state_transmittal_complete.aspx');
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
  p.biz_emsof_requests.BindStateExportBatch
    (
    DataGrid_state_export_batch,
    status_type(session['status_of_interest']),
    p.amendment_num_string
    );
  //
  // Manage control visibilities.
  //
  p.be_datagrid_empty := (p.num_datagrid_rows = 0);
  TableRow_none.visible := p.be_datagrid_empty;
  DataGrid_state_export_batch.visible := not p.be_datagrid_empty;
  LinkButton_transmit_to_state.enabled := not p.be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_datagrid_rows := 0;
  //
end;

end.

