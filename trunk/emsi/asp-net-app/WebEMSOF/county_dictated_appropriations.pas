
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
    bdr_service_appropriations: borland.data.provider.BdpDataReader;
    Label_regional_county_dictated_appropriation_deadline_date: System.Web.UI.WebControls.Label;
    DataGrid_service_appropriations: System.Web.UI.WebControls.DataGrid;
    procedure OnInit(e: EventArgs); override;
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

const ID = '$Id$';

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  accumulated_service_appropriation_amount: decimal;
  BdpCommand_get_appropriation_attribs: borland.data.provider.BdpCommand;
  BdpCommand_get_service_appropriations: borland.data.provider.BdpCommand;
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
  region_dictated_appropriation_amount: decimal;
  service_appropriation_amount: decimal;
begin
  accumulated_service_appropriation_amount := 0.0;
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_dictated_appropriations';
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
    Label_fiscal_year_designator.Text := bdr_appropriation_attribs['designator'].tostring;
    region_dictated_appropriation_amount := decimal(bdr_appropriation_attribs['amount']);
    Label_amount.Text := region_dictated_appropriation_amount.ToString;
    Label_region_name.Text := bdr_appropriation_attribs['name'].tostring;
    bdr_appropriation_attribs.Close;
    //
    BdpCommand_get_service_appropriations := borland.data.provider.bdpcommand.Create
      (
      'select county_dictated_appropriation.id,affiliate_num,service.name,county_dictated_appropriation.amount '
      + 'from county_dictated_appropriation '
      +   'join service on (service.id=service_id) '
      + 'where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      AppCommon.BdpConnection
      );
    bdr_service_appropriations := BdpCommand_get_service_appropriations.ExecuteReader;
    DataGrid_service_appropriations.DataSource := bdr_service_appropriations;
    DataGrid_service_appropriations.DataBind;
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

