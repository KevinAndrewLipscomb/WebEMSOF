unit Class_dalc_emsof_request;

interface

uses
  borland.data.provider,
  Class_dalc_base;

const
  MIN_STATUS_CODE = 1;
  MAX_STATUS_CODE = 15;

type
  tally_by_status_type = array[MIN_STATUS_CODE..MAX_STATUS_CODE] of cardinal;

type
  TClass_dalc_emsof_request = class(Class_dalc_base.TClass_dalc_base)
  private
  public
    constructor Create;
    function MasterDataSource
      (
      status: cardinal;
      order_by_field_name: string;
      be_order_ascending: boolean
      )
      : borland.data.provider.bdpdatareader;
    function TallyByStatus: tally_by_status_type;
  end;

implementation

constructor TClass_dalc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_emsof_request.MasterDataSource
  (
  status: cardinal;
  order_by_field_name: string;
  be_order_ascending: boolean
  )
  : borland.data.provider.bdpdatareader;
var
  cmdText: string;
begin
  cmdText := 'select emsof_request_master.id,'           // column 0
  + ' service.affiliate_num,'                            // column 1
  + ' service.name as service_name,'                     // column 2
  + ' county_code_name_map.name as sponsor_county,'      // column 3
  + ' emsof_request_master.value as emsof_ante,'         // column 4
  + ' fiscal_year.designator as fiscal_year_designator,' // column 5
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
  +   ' and status_code = 4'
  + ' order by ' + order_by_field_name;
  if be_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  connection.Open;
  MasterDataSource := borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteReader;
  connection.Close;
end;

function TClass_dalc_emsof_request.TallyByStatus: tally_by_status_type;
var
  bdr: borland.data.provider.bdpdatareader;
  i: cardinal;
begin
  for i := MIN_STATUS_CODE to MAX_STATUS_CODE do begin
    TallyByStatus[i] := 0;
  end;
  connection.Open;
  bdr := borland.data.provider.bdpcommand.Create
      (
      'select status_code,'
      + ' count(*) as count'
      + ' from emsof_request_master'
      +   ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' group by status_code',
      connection
      )
      .ExecuteReader;
  while bdr.Read do begin
    TallyByStatus[bdr['status_code'].GetHashCode] := bdr['count'].GetHashCode;
  end;
  connection.Close;
end;

end.
