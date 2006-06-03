unit Class_bc_emsof_request;

interface

uses
  Class_dalc_emsof_request;

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

type
  TClass_bc_emsof_request = class
  private
  public
    constructor Create;
    function TallyOfStatus(status: status_type): string;
  end;

implementation

var
  be_valid_tally_by_status: boolean;
  tally_by_status: tally_by_status_type;

procedure DoTallyByStatus;
begin
  if not be_valid_tally_by_status then begin
    tally_by_status := TClass_dalc_emsof_request.Create.TallyByStatus;
    be_valid_tally_by_status := TRUE;
  end;
end;

constructor TClass_bc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  be_valid_tally_by_status := FALSE;
end;

function TClass_bc_emsof_request.TallyOfStatus(status: status_type): string;
begin
  if not be_valid_tally_by_status then begin
    DoTallyByStatus;
  end;
  TallyOfStatus := tally_by_status[ord(status)].tostring;
end;

end.
