
unit service_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  System.Data.Common, Borland.Data.Provider, System.Globalization, 
  Borland.Data.Common, system.configuration;

type
  TWebForm_service_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_profile_action_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure BindDataGrid;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_profile_status: System.Web.UI.WebControls.Label;
    LinkButton_profile_action: System.Web.UI.WebControls.LinkButton;
    DataGrid: System.Web.UI.WebControls.DataGrid;
    Label_no_dg_items: System.Web.UI.WebControls.Label;
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
procedure TWebForm_service_overview.InitializeComponent;
begin
  Include(Self.LinkButton_profile_action.Click, Self.LinkButton_profile_action_Click);
  Include(Self.DataGrid.ItemDataBound, Self.DataGrid_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  be_sort_order_ascending: boolean;
  dg_sort_order: string;
  dgi_id: cardinal;
  dgi_fy_designator: cardinal;
  dgi_county_name: cardinal;
  dgi_county_dictated_appropriation_amount: cardinal;
  dgi_status_code: cardinal;
  dgi_status: cardinal;
  dgi_value: cardinal;
  dgi_linkbutton: cardinal;
  max_fiscal_year_id_string: string;
  num_dg_items: cardinal;

procedure TWebForm_service_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bc_get_profile_status: borland.data.provider.BdpCommand;
  bdr_last_fy_request_attributes: borland.data.provider.BdpDataReader;
  bdr_this_fy_request_attributes: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - account_overview';
    //
    // Initialize implementation-scoped vars.
    //
    be_before_deadline := TRUE;
    be_sort_order_ascending := TRUE;
    dg_sort_order := 'fy_designator,county_name';
    dgi_id := 0;
    dgi_fy_designator := 1;
    dgi_county_name := 2;
    dgi_county_dictated_appropriation_amount := 3;
    dgi_status_code := 4;
    dgi_status := 5;
    dgi_value := 6;
    dgi_linkbutton := 7;
    num_dg_items := 0;
    //
    // Set Label_service_name
    //
    Label_service_name.Text := session.Item['service_name'].ToString;
    //
    // Set Label_profile_status
    //
    bc_get_profile_status := borland.data.provider.bdpCommand.Create
      (
      'select be_valid_profile from service where id = "' + session.Item['service_user_id'].ToString + '"'
      ,AppCommon.BdpConnection
      );
    AppCommon.BdpConnection.Open;
    if bc_get_profile_status.ExecuteScalar.ToString = '0' then begin
      Label_profile_status.Text := 'Not saved.';
      LinkButton_profile_action.Text := 'Create profile';
    end else begin
      Label_profile_status.Text := 'Saved.';
      LinkButton_profile_action.Text := 'Edit profile';
      //
      // Determine current fiscal year
      //
      max_fiscal_year_id_string := borland.data.provider.bdpcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        AppCommon.BdpConnection
        )
        .ExecuteScalar.tostring;
    end;
    //
    AppCommon.BdpConnection.Close;
    //
    BindDataGrid;
  end;
end;

procedure TWebForm_service_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_service_overview.DataGrid_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
var
  link_button: System.Web.UI.WebControls.LinkButton;
begin
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    num_dg_items := num_dg_items + 1;
    //
    // Drop the appropriate LinkButton in the Action column.
    //
    link_button := System.Web.UI.WebControls.LinkButton.Create;
//    case e.item.cells[dgi_status_code].tostring of
//      '1':
//        e.item.cells[dgi_linkbutton].Controls.Add(link_button.);
//      '2':
//      '3':
//      '4':
//      '5':
//      '6':
//      '7':
//      '8':
//      '9':
//      '10':
//      '11':
//      '12':
//      '13':
//    end;
    e.item.Cells[dgi_linkbutton].controls.item[0].visible := be_before_deadline;
  end;
end;

procedure TWebForm_service_overview.LinkButton_profile_action_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('profile.aspx');
end;

procedure TWebForm_service_overview.BindDataGrid;
var
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  AppCommon.BdpConnection.Open;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  cmdText := 'SELECT emsof_request_master.id,'                                       // column 0
  + ' designator as fy_designator,'                                                  // column 1
  + ' name as county_name,'                                                          // column 2
  + ' county_dictated_appropriation.amount as county_dictated_appropriation_amount,' // column 3
  + ' status_code,'                                                                  // column 4
  + ' request_status_code_description_map.description as status,'                    // column 5
  + ' emsof_request_master.value as value'                                           // column 6
  + ' FROM emsof_request_master'
  +   ' JOIN county_dictated_appropriation'
  +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
  +   ' JOIN region_dictated_appropriation'
  +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
  +   ' JOIN state_dictated_appropriation'
  +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
  +   ' JOIN fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
  +   ' JOIN county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)'
  +   ' JOIN request_status_code_description_map on (emsof_request_master.status_code = request_status_code_description_map.code)'
  + ' WHERE fiscal_year.id > (' + max_fiscal_year_id_string + ' - 1)'
  + ' order by ' + dg_sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  //
  DataGrid.DataSource := borland.data.provider.bdpcommand.Create(cmdText,AppCommon.BdpConnection).ExecuteReader;
  DataGrid.DataBind;
  be_datagrid_empty := (num_dg_items = 0);
  //
  // Manage control visibilities.
  //
  Label_no_dg_items.Visible := be_datagrid_empty;
  DataGrid.Visible := not be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_dg_items := 0;
  AppCommon.BdpConnection.Close;
end;

end.

