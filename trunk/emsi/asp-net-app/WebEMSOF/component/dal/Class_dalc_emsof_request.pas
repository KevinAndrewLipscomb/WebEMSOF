unit Class_dalc_emsof_request;

interface

uses
  appcommon,
  borland.data.provider,
  Class_dalc_base,
  System.Web.UI.WebControls;

type
  TClass_dalc_emsof_request = class(Class_dalc_base.TClass_dalc_base)
  private
  public
    constructor Create;
    function AffiliateNumOf(e_item: system.object): string;
    procedure BindDetail
      (
      master_id: string;
      target: system.object
      );
    procedure BindOverview
      (
      status: cardinal;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    function FyDesignatorOf(e_item: system.object): string;
    function IdOf(e_item: system.object): string;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyOf(e_item: system.object): string;
    function TallyByStatus(status: cardinal): cardinal;
  end;

implementation

const
  DGI_ID = 0;
  DGI_AFFILIATE_NUM = 1;
  DGI_SERVICE_NAME = 2;
  DGI_SPONSOR_COUNTY = 3;
  DGI_FISCAL_YEAR_DESIGNATOR = 4;
  DGI_EMSOF_ANTE = 5;
  DGI_LINKBUTTON_SELECT = 6;

constructor TClass_dalc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_emsof_request.AffiliateNumOf(e_item: system.object): string;
begin
  AffiliateNumOf := Safe(DataGridItem(e_item).cells[DGI_AFFILIATE_NUM].text,NUM);
end;

procedure TClass_dalc_emsof_request.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  connection.Open;
  DataGrid(target).datasource := borland.data.provider.bdpcommand.Create
    (
    'select priority'
    + ' ,make_model'
    + ' ,if(be_refurbished,"(refurbished)","") as be_refurbished'
    + ' ,description as category'
    + ' ,place_kept'
    + ' ,quantity'
    + ' ,unit_cost'
    + ' ,(quantity*unit_cost) as subtotal'
    + ' ,allowable_cost'
    + ' ,emsof_ante'
    + ' ,(emsof_ante/(quantity*unit_cost)) as effective_match_level'
    + ' from emsof_request_detail'
    +   ' join eligible_provider_equipment_list'
    +     ' on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    + ' where master_id = ' + master_id
    + ' order by priority',
    connection
    )
    .ExecuteReader;
  DataGrid(target).DataBind;
  connection.Close;
end;

procedure TClass_dalc_emsof_request.BindOverview
  (
  status: cardinal;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
var
  cmdText: string;
begin
  cmdText := 'select emsof_request_master.id'             // column 0
  + ' , service.affiliate_num'                            // column 1
  + ' , service.name as service_name'                     // column 2
  + ' , county_code_name_map.name as sponsor_county'      // column 3
  + ' , fiscal_year.designator as fiscal_year_designator' // column 4
  + ' , emsof_request_master.value as emsof_ante'         // column 5
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
  + ' where status_code = ' + status.tostring
  + ' order by ' + order_by_field_name;
  if be_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  connection.Open;
  DataGrid(target).datasource := borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteReader;
  DataGrid(target).DataBind;
  connection.Close;
end;

function TClass_dalc_emsof_request.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := Safe(DataGridItem(e_item).cells[DGI_FISCAL_YEAR_DESIGNATOR].text,ALPHANUM);
end;

function TClass_dalc_emsof_request.IdOf(e_item: system.object): string;
begin
  IdOf := Safe(DataGridItem(e_item).cells[DGI_ID].text,NUM);
end;

function TClass_dalc_emsof_request.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := Safe(DataGridItem(e_item).cells[DGI_SERVICE_NAME].text,ORG_NAME);
end;

function TClass_dalc_emsof_request.SponsorCountyOf(e_item: system.object): string;
begin
  SponsorCountyOf := Safe(DataGridItem(e_item).cells[DGI_SPONSOR_COUNTY].text,ALPHA);
end;

function TClass_dalc_emsof_request.TallyByStatus(status: cardinal): cardinal;
begin
  connection.Open;
  TallyByStatus := borland.data.provider.bdpcommand.Create
      (
      'select count(*) as count'
      + ' from emsof_request_master'
      +   ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' where status_code = ' + status.tostring,
      connection
      )
      .ExecuteScalar.GetHashCode;
  connection.Close;
end;

end.
