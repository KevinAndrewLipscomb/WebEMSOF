
unit regional_compliance_check_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  borland.data.provider;

type
  TWebForm_regional_compliance_check_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
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
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_regional_compliance_check_overview.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var be_sort_order_ascending: boolean;
var dgi_id: cardinal; // dgi = DataGrid Index
var dgi_county_approval_timestamp: cardinal;
var dgi_affiliate_num: cardinal;
var dgi_service_name: cardinal;
var dgi_sponsor_county: cardinal;
var dgi_emsof_ante: cardinal;
var sort_order: string;

procedure TWebForm_regional_compliance_check_overview.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - regional_compliance_check_overview';
    Label_account_descriptor.text := session.item['regional_staffer_role'].tostring;
    //
    // Initialize implementation-wide vars.
    //
    be_sort_order_ascending := TRUE;
    dgi_id := 1;
    dgi_county_approval_timestamp := 2;
    dgi_affiliate_num := 3;
    dgi_service_name := 4;
    dgi_sponsor_county := 5;
    dgi_emsof_ante := 6;
    sort_order := 'county_approval_datetime';
    //
    Bind;
    //
  end;
end;

procedure TWebForm_regional_compliance_check_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_regional_compliance_check_overview.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_regional_compliance_check_overview.Bind;
var cmdText: string;
begin
  appcommon.DbOpen;
  cmdText := 'select emsof_request_master.id,'         // column 1
  + ' emsof_request_master.county_approval_timestamp,' // column 2
  + ' service.affiliate_num,'                          // column 3
  + ' service.name as service_name,'                   // column 4
  + ' county_code_name_map.name as sponsor_county'     // column 5
  + ' emsof_request_master.value as emsof_ante'        // column 6
  + ' from emsof_request_master'
  +   ' join region_dictated_appropriation'
  +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
  +   ' join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)'
  +   ' join county_dictated_appropriation'
  +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
  +   ' join service on (service.id=county_dictated_appropriation.service_id)'
  +   ' join state_dictated_appropriation'
  +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
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
  appcommon.DbClose;
end;

end.

