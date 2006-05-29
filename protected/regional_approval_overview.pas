
unit regional_approval_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  borland.data.provider;

const ID = '$Id$';

type TWebForm_regional_approval_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Bind;
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
procedure TWebForm_regional_approval_overview.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

var be_sort_order_ascending: boolean;
var dgi_id: cardinal; // dgi = DataGrid Index
var dgi_county_approval_timestamp: cardinal;
var dgi_affiliate_num: cardinal;
var dgi_service_name: cardinal;
var dgi_sponsor_county: cardinal;
var dgi_emsof_ante: cardinal;
var dgi_fiscal_year_designator: cardinal;
var dgi_county_dictated_appropriation_amount: cardinal;
var dgi_county_dictated_appropriation_id: cardinal;
var dgi_service_to_county_submission_deadline: cardinal;
var dgi_linkbutton_select: cardinal;
var num_qualifying_requests: cardinal;
var sort_order: string;

procedure TWebForm_regional_approval_overview.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - regional_approval_overview';
    Label_account_descriptor.text := session.item['regional_staffer_name'].tostring;
    //
    // Initialize implementation-wide vars.
    //
    be_sort_order_ascending := TRUE;
    dgi_id := 0;
    dgi_county_approval_timestamp := 1;
    dgi_affiliate_num := 2;
    dgi_service_name := 3;
    dgi_sponsor_county := 4;
    dgi_emsof_ante := 5;
    dgi_fiscal_year_designator := 6;
    dgi_county_dictated_appropriation_amount := 7;
    dgi_county_dictated_appropriation_id := 8;
    dgi_service_to_county_submission_deadline := 9;
    dgi_linkbutton_select := 10;
    num_qualifying_requests := 0;
    sort_order := 'county_approval_timestamp';
    //
    Bind;
    //
  end;
end;

procedure TWebForm_regional_approval_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_regional_approval_overview.DataGrid_requests_ItemDataBound(sender: System.Object;
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

procedure TWebForm_regional_approval_overview.DataGrid_requests_ItemCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs
  );
begin
  //
  session.Remove('calling_form');
  session.Add('calling_form','regional_approval_overview.aspx');
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

procedure TWebForm_regional_approval_overview.DataGrid_requests_SortCommand(source: System.Object;
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

procedure TWebForm_regional_approval_overview.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_regional_approval_overview.Bind;
var be_datagrid_empty: boolean;
var cmdText: string;
begin
  appcommon.DbOpen;
  cmdText := 'select emsof_request_master.id,'                                       // column 0
  + ' emsof_request_master.county_approval_timestamp,'                               // column 1
  + ' service.affiliate_num,'                                                        // column 2
  + ' service.name as service_name,'                                                 // column 3
  + ' county_code_name_map.name as sponsor_county,'                                  // column 4
  + ' emsof_request_master.value as emsof_ante,'                                     // column 5
  + ' fiscal_year.designator as fiscal_year_designator,'                             // column 6
  + ' county_dictated_appropriation.amount as county_dictated_appropriation_amount,' // column 7
  + ' county_dictated_appropriation.id as county_dictated_appropriation_id,'         // column 8
  + ' service_to_county_submission_deadline'                                         // column 9
  + ' from emsof_request_master'
  +   ' join county_dictated_appropriation'
  +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
  +   ' join region_dictated_appropriation'
  +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
  +   ' join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)'
  +   ' join service on (service.id=county_dictated_appropriation.service_id)'
  +   ' join state_dictated_appropriation'
  +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
  +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
  + ' where state_dictated_appropriation_id = ' + session.item['state_dictated_appropriation_id'].tostring
  +   ' and status_code = 4'
  + ' order by ' + sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  DataGrid_requests.DataSource := borland.data.provider.bdpcommand.Create(cmdText,appcommon.db).ExecuteReader;
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
  appcommon.DbClose;
end;

end.

