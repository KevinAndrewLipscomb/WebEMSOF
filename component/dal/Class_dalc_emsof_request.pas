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
    function TallyByStatus: tally_by_status_type;
  end;

implementation

constructor TClass_dalc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
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
