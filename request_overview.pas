
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
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
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
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_sum_of_item_amounts: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
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
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  county_dictated_appropriation_amount: decimal;
  dgi_master_id: cardinal;
  dgi_priority: cardinal;
  dgi_item_description: cardinal;
  dgi_status: cardinal;
  dgi_emsof_ante: cardinal;
  num_items: cardinal;
  sum_of_emsof_antes: decimal;

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
    county_dictated_appropriation_amount := decimal.Parse(session.item['county_dictated_appropriation_amount'].tostring);
    dgi_master_id := 0;
    dgi_priority := 1;
    dgi_item_description := 2;
    dgi_emsof_ante := 3;
    dgi_status := 4;
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
//      TableRow_sum_of_emsof_antes.visible := FALSE;
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

procedure TWebForm_request_overview.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
      server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_request_overview.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
      server.Transfer('change_password.aspx');
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
  cmdText := 'select master_id,'                                         // column 0
  + ' priority,'                                                         // column 1
  + ' eligible_provider_equipment_list.description as item_description,' // column 2
  + ' emsof_ante,'                                                       // column 3
  + ' item_status_code_description_map.description as status'            // column 4
  + ' from emsof_request_detail'
  +   ' join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
  +   ' join item_status_code_description_map on (item_status_code_description_map.code=emsof_request_detail.status_code)'
  + ' where master_id = ' + session.Item['emsof_request_master_id'].ToString
  + ' order by priority';
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
  Label_sum_of_emsof_antes.text := sum_of_emsof_antes.ToString('C');
  Label_unused_amount.Text := (county_dictated_appropriation_amount - sum_of_emsof_antes).tostring('C');
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_items := 0;
  sum_of_emsof_antes := 0;
  AppCommon.BdpConnection.Close;
end;

end.

