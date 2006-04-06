
unit county_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_county_dictated_appropriations = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    Label_regional_county_dictated_appropriation_deadline_date_string: System.Web.UI.WebControls.Label;
    Table_service_appropriations: System.Web.UI.WebControls.Table;
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
procedure TWebForm_county_dictated_appropriations.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  service_appropriation_amount: decimal;
  accumulated_service_appropriation_amount: decimal;
  BdpCommand_get_appropriation_attribs: borland.data.provider.BdpCommand;
  BdpCommand_get_service_appropriations: borland.data.provider.BdpCommand;
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
  bdr_service_appropriations: borland.data.provider.BdpDataReader;
  region_dictated_appropriation_amount: decimal;
  TableRow_current: system.web.ui.webcontrols.TableRow;
  TableCell_edit_link: system.web.ui.webcontrols.TableCell;
  TableCell_only: system.web.ui.webcontrols.TableCell;
  TableCell_service_name: system.web.ui.webcontrols.TableCell;
  TableCell_amount: system.web.ui.webcontrols.TableCell;
begin
  accumulated_service_appropriation_amount := 0.0;
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_dictated_appropriations';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    BdpCommand_get_appropriation_attribs := borland.data.provider.bdpcommand.Create
      (
      'select fiscal_year.designator,region_dictated_appropriation.amount,region_code_name_map.name '
      + 'from region_dictated_appropriation '
      +   'join state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id) '
      +   'join fiscal_year on (fiscal_year.id = fiscal_year_id) '
      +   'join region_code_name_map on (region_code_name_map.code = region_code) '
      + 'where region_dictated_appropriation.id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      AppCommon.BdpConnection
      );
    bdr_appropriation_attribs := BdpCommand_get_appropriation_attribs.ExecuteReader;
    bdr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text :=
      bdr_appropriation_attribs.GetValue(bdr_appropriation_attribs.GetOrdinal('designator')).ToString;
    region_dictated_appropriation_amount :=
      bdr_appropriation_attribs.GetDecimal(bdr_appropriation_attribs.GetOrdinal('amount'));
    Label_amount.Text := region_dictated_appropriation_amount.ToString;
    Label_region_name.Text := bdr_appropriation_attribs.GetValue(bdr_appropriation_attribs.GetOrdinal('name')).ToString;
    bdr_appropriation_attribs.Close;
    //
    BdpCommand_get_service_appropriations := borland.data.provider.bdpcommand.Create
      (
      'select county_dictated_appropriation.id,service.name,county_dictated_appropriation.amount '
      + 'from county_dictated_appropriation '
      +   'join service on (service.id=service_id) '
      + 'where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      AppCommon.BdpConnection
      );
    bdr_service_appropriations := BdpCommand_get_service_appropriations.ExecuteReader;
    if bdr_service_appropriations.FieldCount < 1 then
      begin
      TableRow_current := system.web.ui.webcontrols.tablerow.Create;
      TableCell_only := system.web.ui.webcontrols.tablecell.Create;
      TableCell_only.Text := 'None';
      TableRow_current.Cells.Add(TableCell_only);
      Table_service_appropriations.Rows.Add(TableRow_current);
      end
    else
      begin
      //
      // Build header row.
      //
      // Header for the column that holds the Edit links will be empty.
      TableRow_current := system.web.ui.webcontrols.tablerow.Create;
      TableRow_current.Cells.Add(system.web.ui.webcontrols.tablecell.Create);
      // Service name
      TableCell_service_name := system.web.ui.webcontrols.tablecell.Create;
      TableCell_service_name.Text := 'Service';
      TableCell_service_name.Font.Bold := TRUE;
      TableCell_service_name.Font.Underline := TRUE;
      TableRow_current.Cells.Add(TableCell_service_name);
      // Amount
      TableCell_amount := system.web.ui.webcontrols.tablecell.Create;
      TableCell_amount.Text := 'Amount';
      TableCell_amount.Font.Bold := TRUE;
      TableCell_amount.Font.Underline := TRUE;
      TableRow_current.Cells.Add(TableCell_amount);
      //
      Table_service_appropriations.Rows.Add(TableRow_current);
      //
      while bdr_service_appropriations.Read do
        begin
        //
        // Build the row.
        //
        // Edit link
        TableRow_current := system.web.ui.webcontrols.tablerow.Create;
        TableCell_edit_link := system.web.ui.webcontrols.tablecell.Create;
        session.Remove('county_dictated_appropriation_id');
        session.Add
          (
          'county_dictated_appropriation_id',
          bdr_service_appropriations.GetInt32(bdr_service_appropriations.GetOrdinal('id')).ToString
          );
        TableCell_edit_link.Text := '<a href="">Edit</a>';
        TableRow_current.Cells.Add(TableCell_edit_link);
        // Service name
        TableCell_service_name := system.web.ui.webcontrols.tablecell.Create;
        TableCell_service_name.Text :=
        bdr_service_appropriations.GetString(bdr_service_appropriations.GetOrdinal('name'));
        TableRow_current.Cells.Add(TableCell_service_name);
        // Amount
        TableCell_amount := system.web.ui.webcontrols.tablecell.Create;
        service_appropriation_amount := bdr_service_appropriations.GetDecimal(bdr_service_appropriations.GetOrdinal('amount'));
        TableCell_amount.Text := '$' + service_appropriation_amount.ToString;
        TableRow_current.Cells.Add(TableCell_amount);
        Table_service_appropriations.Rows.Add(TableRow_current);
        //
        // Accumulate the amount.
        //
        accumulated_service_appropriation_amount := accumulated_service_appropriation_amount + service_appropriation_amount;
        //
        end;
      end;
    //
    // Set Label_remainder
    //
    Label_unappropriated_amount.Text := (region_dictated_appropriation_amount - accumulated_service_appropriation_amount).ToString;
    bdr_service_appropriations.Close;
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_county_dictated_appropriations.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

end.

