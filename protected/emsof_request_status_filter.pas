
unit emsof_request_status_filter;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  borland.data.provider,
  Class_bc_emsof_request;

const ID = '$Id$';

type TWebForm_emsof_request_status_filter = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   target_user_table: string
  //   (target_user_table)_name: string
  //   bc_emsof_request: Class_bc_emsof_request.TClass_bc_emsof_request
  //   status_of_interest: Class_bc_emsof_request.status_type
  //
  //
  strict private
    bc_emsof_request: Class_bc_emsof_request.TClass_bc_emsof_request;
    be_sort_order_ascending: boolean;
    dgi_id: cardinal; // dgi = DataGrid Index
    dgi_affiliate_num: cardinal;
    dgi_service_name: cardinal;
    dgi_sponsor_county: cardinal;
    dgi_emsof_ante: cardinal;
    dgi_fiscal_year_designator: cardinal;
    dgi_county_dictated_appropriation_amount: cardinal;
    dgi_county_dictated_appropriation_id: cardinal;
    dgi_service_to_county_submission_deadline: cardinal;
    dgi_linkbutton_select: cardinal;
    num_qualifying_requests: cardinal;
    sort_order: string;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    HyperLink_back: System.Web.UI.WebControls.HyperLink;
    DataGrid_requests: System.Web.UI.WebControls.DataGrid;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_status: System.Web.UI.WebControls.Label;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_emsof_request_status_filter.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_emsof_request_status_filter.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - emsof_request_status_filter';
    Label_account_descriptor.text := session.item[session.item['target_user_table'].tostring + '_name'].tostring;
    Label_status.text := session.item['status_of_interest'].tostring;
    //
    // Initialize implementation-wide vars.
    //
    be_sort_order_ascending := TRUE;
    dgi_id := 0;
    dgi_affiliate_num := 1;
    dgi_service_name := 2;
    dgi_sponsor_county := 3;
    dgi_emsof_ante := 4;
    dgi_fiscal_year_designator := 5;
    dgi_linkbutton_select := 6;
    num_qualifying_requests := 0;
    sort_order := 'affiliate_num';
    //
    bc_emsof_request := TClass_bc_emsof_request.Create;
    Bind;
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

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemDataBound(sender: System.Object;
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
    num_qualifying_requests := num_qualifying_requests + 1;
  end;
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs
  );
begin
  //
  session.Remove('calling_form');
  session.Add('calling_form','emsof_request_status_filter.aspx');
  session.Remove('account_descriptor');
  session.Add('account_descriptor',session.Item['regional_staffer_name'].ToString);
  session.Remove('fiscal_year_designator');
  session.Add('fiscal_year_designator',Safe(e.item.cells[dgi_fiscal_year_designator].text,ALPHANUM));
  session.Remove('service_name');
  session.Add('service_name',Safe(e.item.cells[dgi_service_name].text,ORG_NAME));
  session.Remove('affiliate_num');
  session.Add('affiliate_num',Safe(e.item.cells[dgi_affiliate_num].text,NUM));
  session.Remove('appropriation_amount');
  session.Add('appropriation_amount',Safe(e.item.cells[dgi_county_dictated_appropriation_amount].text,REAL_NUM));
  session.Remove('county_name');
  session.Add('county_name',Safe(e.item.cells[dgi_sponsor_county].text,ALPHA));
  session.Remove('county_dictated_appropriation_id');
  session.Add('county_dictated_appropriation_id',Safe(e.item.cells[dgi_county_dictated_appropriation_id].text,NUM));
  session.Remove('emsof_request_master_status_code');
  session.Add('emsof_request_master_status_code','4');
  session.Remove('request_status_this_session_may_approve');
  session.Add('request_status_this_session_may_approve','4');
  session.Remove('next_approver_descriptor');
  session.Add('next_approver_descriptor','Regional Council Executive Director');
  session.Remove('county_dictated_deadline');
  session.Add('county_dictated_deadline',Safe(e.item.cells[dgi_service_to_county_submission_deadline].text,DATE_TIME));
  session.Remove('promotion_status');
  session.Add('promotion_status','5');
  //
  server.Transfer('full_request_review_approve.aspx');
  //
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = sort_order then begin
    be_sort_order_ascending := not be_sort_order_ascending;
  end else begin
    sort_order := e.SortExpression;
    be_sort_order_ascending := TRUE;
  end;
  DataGrid_requests.EditItemIndex := -1;
  Bind;
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_emsof_request_status_filter.Bind;
var
  be_datagrid_empty: boolean;
begin
  DataGrid_requests.DataSource := bc_emsof_request.MasterDataSource
    (
    Class_bc_emsof_request.status_type(session.item['status_of_interest']),
    sort_order,
    be_sort_order_ascending
    );
  DataGrid_requests.DataBind;
  //
  // Manage control visibilities.
  //
  be_datagrid_empty := (num_qualifying_requests = 0);
  TableRow_none.visible := be_datagrid_empty;
  Datagrid_requests.visible := not be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_qualifying_requests := 0;
  //
end;

end.

