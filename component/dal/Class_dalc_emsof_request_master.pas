unit Class_dalc_emsof_request_master;

interface

uses
  borland.data.provider,
  Class_dalc_base;

type status_type =
  (
  INITIALIZED = 1,
  NEEDS_SERVICE_FINALIZATION = 2,
  NEEDS_COUNTY_APPROVAL = 3,
  NEEDS_REGIONAL_COMPLIANCE_CHECK = 4,
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL = 5,
  NEEDS_SENT_TO_PA_DOH_EMSO = 6,
  NEEDS_PA_DOH_EMSO_APPROVAL = 7,
  NEEDS_INVOICE_COLLECTION = 8,
  NEEDS_CANCELED_CHECK_COLLECTION = 9,
  NEEDS_REIMBURSEMENT_ISSUANCE = 10,
  REJECTED = 11,
  WITHDRAWN = 12,
  REIMBURSEMENT_ISSUED = 13,
  DEPLOYED = 14,
  ARCHIVED = 15
  );
const
  STATUS_TYPE_FIRST = INITIALIZED;
  STATUS_TYPE_LAST = ARCHIVED;

type
  tally_by_status_type = array[status_type] of cardinal;

type
  TClass_dalc_emsof_request_master = class(Class_dalc_base.TClass_dalc_base)
  private
    { Private Declarations }
  public
    constructor Create;
    function TallyByStatus: tally_by_status_type;
  end;

implementation

constructor TClass_dalc_emsof_request_master.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_emsof_request_master.TallyByStatus: tally_by_status_type;
var
  bdr: borland.data.provider.bdpdatareader;
  i: status_type;
begin
  for i := STATUS_TYPE_FIRST to STATUS_TYPE_LAST do begin
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
    TallyByStatus[status_type(bdr['status_code'].GetHashCode)] := bdr['count'].GetHashCode;
  end;
  connection.Close;
end;

end.
