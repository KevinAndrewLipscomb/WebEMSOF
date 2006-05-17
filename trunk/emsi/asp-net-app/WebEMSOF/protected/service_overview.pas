
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
    procedure DataGrid_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
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
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    TableRow_separator: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_item_requests_section: System.Web.UI.HtmlControls.HtmlTableRow;
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
  Include(Self.DataGrid.ItemCommand, Self.DataGrid_ItemCommand);
  Include(Self.DataGrid.ItemDataBound, Self.DataGrid_ItemDataBound);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  dgi_id: cardinal;
  dgi_fy_designator: cardinal;
  dgi_county_name: cardinal;
  dgi_county_dictated_appropriation_id: cardinal;
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
  be_stale_password: string;
//  make_item_requests_deadline: system.datetime;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    appcommon.DbOpen;
    //
    be_stale_password := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT be_stale_password FROM service_user where id=' + session.item['service_user_id'].tostring,
      appcommon.db
      )
      .ExecuteScalar.tostring;
    if be_stale_password = '1' then begin
      appcommon.DbClose;
      server.Transfer('change_password.aspx');
    end;
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - service_overview';
    //
    // Initialize implementation-scoped vars.
    //
    be_before_deadline := TRUE;
    dgi_id := 0;
    dgi_fy_designator := 1;
    dgi_county_name := 2;
    dgi_county_dictated_appropriation_id := 3;
    dgi_county_dictated_appropriation_amount := 4;
    dgi_status_code := 5;
    dgi_status := 6;
    dgi_value := 7;
    dgi_linkbutton := 8;
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
      ,appcommon.db
      );
    if bc_get_profile_status.ExecuteScalar.ToString = '0' then begin
      Label_profile_status.Text := 'Not saved.';
      LinkButton_profile_action.Text := 'Create profile';
      TableRow_separator.visible := FALSE;
      TableRow_item_requests_section.visible := FALSE;
      appcommon.DbClose;
    end else begin
      Label_profile_status.Text := 'Saved.';
      LinkButton_profile_action.Text := 'Edit profile';
      //
      // Determine current fiscal year
      //
      max_fiscal_year_id_string := borland.data.provider.bdpcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        appcommon.db
        )
        .ExecuteScalar.tostring;
//    //
//    // Determine temporal location with respect to deadline.
//    //
//    make_item_requests_deadline := system.datetime
//      (
//      borland.data.provider.bdpcommand.Create
//        (
//        'select value'
//        + ' from fy_calendar'
//        +   ' join fiscal_year on (fiscal_year.id = fiscal_year_id)'
//        +   ' join milestone_code_name_map on (code = milestone_code)'
//        + ' where id = ' + max_fiscal_year_id_string
//        +   ' and name = "emsof-service-item-requests-deadline"',
//        appcommon.db
//        )
//        .ExecuteScalar
//      );
//    //
//    be_before_deadline := (datetime.Now <= make_item_requests_deadline);
      //
      appcommon.DbClose;
      //
      BindDataGrid;
    end;
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

procedure TWebForm_service_overview.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_service_overview.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_service_overview.DataGrid_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  session.Remove('emsof_request_master_id');
  session.Add('emsof_request_master_id',Safe(e.item.cells[dgi_id].text,NUM));
  session.Remove('emsof_request_master_status');
  session.Add('emsof_request_master_status',Safe(e.item.cells[dgi_status].text,NARRATIVE));
  session.Remove('fiscal_year_designator');
  session.Add('fiscal_year_designator',Safe(e.item.cells[dgi_fy_designator].text,ALPHANUM));
  session.Remove('sponsor_county');
  session.Add('sponsor_county',Safe(e.item.cells[dgi_county_name].text,POSTAL_CITY));
  session.Remove('county_dictated_appropriation_id');
  session.Add('county_dictated_appropriation_id',Safe(e.item.cells[dgi_county_dictated_appropriation_id].text,REAL_NUM));
  session.Remove('county_dictated_appropriation_amount');
  session.Add('county_dictated_appropriation_amount',Safe(e.item.cells[dgi_county_dictated_appropriation_amount].text,REAL_NUM));
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_service_overview.DataGrid_ItemDataBound(sender: System.Object;
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
    num_dg_items := num_dg_items + 1;
    //
    // Drop the appropriate LinkButton in the Action column.
    //
    if be_before_deadline then begin
      if e.item.cells[dgi_status_code].text = '1' then begin
        LinkButton(e.item.cells[dgi_linkbutton].controls.item[0]).text := 'Start making item requests';
      end else if e.item.cells[dgi_status_code].text = '2' then begin
        LinkButton(e.item.cells[dgi_linkbutton].controls.item[0]).text := 'Continue making item requests';
      end;
    end;
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
begin
  appcommon.DbOpen;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  DataGrid.DataSource := borland.data.provider.bdpcommand.Create
    (
    'SELECT emsof_request_master.id,'                                                  // column 0
    + ' designator as fy_designator,'                                                  // column 1
    + ' name as county_name,'                                                          // column 2
    + ' county_dictated_appropriation.id as county_dictated_appropriation_id,'         // column 3
    + ' county_dictated_appropriation.amount as county_dictated_appropriation_amount,' // column 4
    + ' status_code,'                                                                  // column 5
    + ' request_status_code_description_map.description as status,'                    // column 6
    + ' emsof_request_master.value as value'                                           // column 7
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
    + ' WHERE service_id = ' + session.item['service_user_id'].tostring
    +   ' and fiscal_year.id >= (' + max_fiscal_year_id_string + ' - 1)'
    + ' order by fy_designator,county_name',
    appcommon.db
    )
    .ExecuteReader;
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
  appcommon.DbClose;
end;

end.

