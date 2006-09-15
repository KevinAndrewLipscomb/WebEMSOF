
unit emsof_request_status_filter;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common, system.configuration, system.web.security,
  borland.data.provider,
  system.io,
  Class_biz_emsof_requests;

const ID = '$Id$';

type
  p_type =
    RECORD
    be_sort_order_ascending: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    num_qualifying_requests: cardinal;
    sort_order: string;
    END;
  TWebForm_emsof_request_status_filter = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure TWebForm_emsof_request_status_filter_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_retransmit_to_state_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   target_user_table: string
  //   (target_user_table)_name: string
  //   status_of_interest: Class_biz_emsof_requests.status_type
  //   waypoint_stack: system.collections.stack;
  //
  //
  strict private
    p: p_type;
    procedure BindOverview;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    DataGrid_requests: System.Web.UI.WebControls.DataGrid;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_status: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    TableRow_spreadsheet: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_retransmit_to_state: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  end;

implementation

const
  TCCI_LINKBUTTON_SELECT = 14;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_emsof_request_status_filter.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_retransmit_to_state.Click, Self.LinkButton_retransmit_to_state_Click);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_emsof_request_status_filter_PreRender);
end;
{$ENDREGION}

procedure TWebForm_emsof_request_status_filter.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - emsof_request_status_filter';
    Label_account_descriptor.text := session[session['target_user_table'].tostring + '_name'].tostring;
    Label_status.text := session['status_of_interest'].tostring;
    LinkButton_retransmit_to_state.visible := (status_type(session['status_of_interest']) = NEEDS_PA_DOH_EMSO_APPROVAL);
    //
    // Initialize instance private data members.
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.be_sort_order_ascending := TRUE;
    p.num_qualifying_requests := 0;
    p.sort_order := 'affiliate_num';
    //
    BindOverview;
    //
  end;
end;

procedure TWebForm_emsof_request_status_filter.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_retransmit_to_state_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('state_required_report.aspx');
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_back_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_emsof_request_status_filter.TWebForm_emsof_request_status_filter_PreRender
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemDataBound
  (
  sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs
  );
begin
  //
  // Manage column visibility
  //
  e.item.cells[tcci_linkbutton_select].visible :=
    p.biz_emsof_requests.BeOkToDrillDown(Class_biz_emsof_requests.status_type(session['status_of_interest']));
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_qualifying_requests := p.num_qualifying_requests + 1;
    //
  end;
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs
  );
begin
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    system.collections.stack(session['waypoint_stack']).Push('emsof_request_status_filter.aspx');
    session.Remove('account_descriptor');
    session.Add('account_descriptor',session['regional_staffer_name'].ToString);
    session.Remove('e_item');
    session.Add('e_item',e.item);
    //
    server.Transfer('full_request_review_approve.aspx');
  end;
  //
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_SortCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs
  );
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  DataGrid_requests.EditItemIndex := -1;
  BindOverview;
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_logout_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_emsof_request_status_filter.BindOverview;
var
  be_datagrid_empty: boolean;
begin
  //
  p.biz_emsof_requests.BindOverviewByStatus
    (
    Class_biz_emsof_requests.status_type(session['status_of_interest']),
    p.sort_order,
    p.be_sort_order_ascending,
    DataGrid_requests
    );
  //
  // Manage control visibilities.
  //
  be_datagrid_empty := (p.num_qualifying_requests = 0);
  TableRow_none.visible := be_datagrid_empty;
  Datagrid_requests.visible := not be_datagrid_empty;
  LinkButton_retransmit_to_state.enabled := not be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_qualifying_requests := 0;
  //
end;

end.

