
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
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Label_sum_of_item_amounts: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_item_amounts: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
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
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  be_sort_order_ascending: boolean;
  county_dictated_appropriation_amount: decimal;
  dg_sort_order: string;
  num_items: cardinal;
  sum_of_item_amounts: decimal;

procedure TWebForm_request_overview.Page_Load(sender: System.Object; e: System.EventArgs);
//var
//  make_item_requests_deadline: system.datetime;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    // Initialize implementation-global variables.
    //
    be_before_deadline := TRUE;
    be_sort_order_ascending := TRUE;
    dg_sort_order := 'name';
    num_items := 0;
    sum_of_item_amounts := 0;
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - request_overview';
    appcommon.bdpconnection.Open;
    //
    // Set parent appropriation labels.
    //
    Label_service_name.text := session.Item['service_name'].ToString;
    Label_fiscal_year_designator.text := session.item['fiscal_year_designator'].tostring;
    Label_sponsor_county.text := session.item['sponsor_county'].tostring;
    Label_parent_appropriation_amount.Text :=
      decimal.Parse(session.item['county_dictated_appropriation_amount'].tostring).ToString('C');
//    //
//    // All further rendering is deadline-dependent.
//    //
//    make_item_requests_deadline := system.datetime
//      (
//      borland.data.provider.bdpcommand.Create
//        (
//        'select value'
//        + ' from fy_calendar'
//        +   ' join fiscal_year on (fiscal_year.id = fiscal_year_id)'
//        +   ' join milestone_code_name_map on (code = milestone_code)'
//        + ' where designator = "' + Safe(Label_fiscal_year_designator.Text,ALPHANUM) + '"'
//        +   ' and name = "emsof-service-make-item-requests-deadline"',
//        appcommon.bdpconnection
//        )
//        .ExecuteScalar
//      );
//    //
//    if datetime.Now > make_item_requests_deadline then begin
//      be_before_deadline := FALSE;
//      TableRow_sum_of_item_amounts.visible := FALSE;
//      TableRow_unrequested_amount.visible := FALSE;
//      Label_make_requests_deadline.visible := FALSE;
//      HyperLink_add_item_to_request.visible := FALSE;
//    end else begin
//      Label_make_requests_deadline.text := ' NOTE:  The deadline for making item requests is '
//      + make_item_requests_deadline.tostring('dddd, MMMM dd, yyyy ''at'' HH:mm:ss') + '. ';
//      //
//    end;
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

procedure TWebForm_request_overview.Bind_items;
var
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  AppCommon.BdpConnection.Open;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  cmdText := 'select county_dictated_appropriation.id,' // column 0
  + ' password_reset_email_address,'                    // column 1
  + ' affiliate_num,'                                   // column 2
  + ' name,'                                            // column 3
  + ' county_dictated_appropriation.amount'             // column 4
  + ' from county_dictated_appropriation'
  +   ' join service on (service.id=service_id)'
  +   ' join service_user on (service_user.id=service.id)'
  + ' where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString
  + ' order by ' + dg_sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  //
  DataGrid_items.DataSource :=
    borland.data.provider.bdpcommand.Create(cmdText,AppCommon.BdpConnection).ExecuteReader;
  DataGrid_items.DataBind;
  be_datagrid_empty := (num_items = 0);
  //
  // Manage control visibilities.
  //
  Label_no_appropriations.Visible := be_datagrid_empty;
  DataGrid_items.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  Label_sum_of_item_amounts.text := sum_of_item_amounts.ToString('C');
  Label_unappropriated_amount.Text := (county_dictated_appropriation_amount - sum_of_item_amounts).tostring('C');
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_items := 0;
  sum_of_item_amounts := 0;
  AppCommon.BdpConnection.Close;
end;

end.

