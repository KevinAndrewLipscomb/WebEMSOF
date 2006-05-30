unit Class_dalc_emsof_request_master;

interface

uses
  borland.data.provider,
  Class_dalc_base;

type
  status_type =
    (
    INITIALIZED = 1,
    NEEDS_COUNTY_APPROVAL = 2,
    NEEDS_REGIONAL_COMPLIANCE_CHECK = 3,
    NEEDS_REGIONAL_EXEC_DIR_APPROVAL = 4,
    NEEDS_SENT_TO_PA_DOH_EMSO = 5,
    NEEDS_PA_DOH_EMSO_APPROVAL = 6,
    NEEDS_INVOICE_COLLECTION = 7,
    NEEDS_CANCELED_CHECK_COLLECTION = 8,
    NEEDS_REIMBURSEMENT_ISSUANCE = 9
    );

type
  TClass_dalc_emsof_request_master = class(Class_dalc_base.TClass_dalc_base)
  private
    { Private Declarations }
  public
    constructor Create;
    function NumRecsInStatus
      (
      status: status_type;
      fiscal_year_id: cardinal
      )
      : cardinal;
  end;

implementation

constructor TClass_dalc_emsof_request_master.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_emsof_request_master.NumRecsInStatus
  (
  status: status_type;
  fiscal_year_id: cardinal
  )
  : cardinal;
begin
  NumRecsInStatus := cardinal
    (
    borland.data.provider.bdpcommand.Create
      (
      'select count(*)'
      + ' from emsof_request_master'
      +   ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' where status_code = ' + convert.toint16(ord(status)).tostring
      +   ' and fiscal_year_id = ' + fiscal_year_id.tostring,
      connection
      )
      .ExecuteScalar
    );
end;

end.
