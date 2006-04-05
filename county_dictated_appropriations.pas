
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
  BdpCommand_get_appropriation_attribs: borland.data.provider.BdpCommand;
  BdpCommand_get_service_appropriations: borland.data.provider.BdpCommand;
  BdpDataReader_appropriation_attribs: borland.data.provider.BdpDataReader;
  BdpDataReader_service_appropriations: borland.data.provider.BdpDataReader;
  TableRow_current: system.web.ui.webcontrols.TableRow;
  TableCell_edit_link: system.web.ui.webcontrols.TableCell;
  TableCell_service_name: system.web.ui.webcontrols.TableCell;
  TableCell_amount: system.web.ui.webcontrols.TableCell;
begin
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
    BdpDataReader_appropriation_attribs := BdpCommand_get_appropriation_attribs.ExecuteReader;
    BdpDataReader_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := BdpDataReader_appropriation_attribs.GetString(0);
    Label_amount.Text := BdpDataReader_appropriation_attribs.GetDecimal(1).ToString;
    Label_region_name.Text := BdpDataReader_appropriation_attribs.GetString(2);
    BdpDataReader_appropriation_attribs.Close;
    //
    BdpCommand_get_service_appropriations := borland.data.provider.bdpcommand.Create
      (
      'select county_dictated_appropriation.id,service.name,county_dictated_appropriation.amount '
      + 'from county_dictated_appropriation '
      +   'join service on (service.id=service_id) '
      + 'where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      AppCommon.BdpConnection
      );
    BdpDataReader_service_appropriations := BdpCommand_get_service_appropriations.ExecuteReader;
    while BdpDataReader_service_appropriations.Read do
      begin
      TableRow_current := system.web.ui.webcontrols.tablerow.Create;
      TableCell_edit_link := system.web.ui.webcontrols.tablecell.Create;
      session.Remove('county_dictated_appropriation_id');
      session.Add('county_dictated_appropriation_id',BdpDataReader_service_appropriations.GetInt16(0).ToString);
      TableCell_edit_link.Text := '<a href="">Edit</a>';
      TableRow_current.Cells.Add(TableCell_edit_link);
      TableCell_service_name := system.web.ui.webcontrols.tablecell.Create;
      TableCell_service_name.Text := BdpDataReader_service_appropriations.GetString(1);
      TableRow_current.Cells.Add(TableCell_service_name);
      TableCell_amount := system.web.ui.webcontrols.tablecell.Create;
      TableCell_amount.Text := BdpDataReader_service_appropriations.GetDecimal(2).ToString;
      TableRow_current.Cells.Add(TableCell_amount);
      Table_service_appropriations.Rows.Add(TableRow_current);
      end;
    BdpDataReader_service_appropriations.Close;
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

