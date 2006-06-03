unit Class_bc_emsof_request;

interface

uses
  borland.data.provider,
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
    function MasterDataSource
      (
      status: status_type;
      order_by_field_name: string;
      be_order_ascending: boolean
      )
      : borland.data.provider.bdpdatareader;
    function TallyOfStatus(status: status_type): string;
  end;

implementation

constructor TClass_bc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_emsof_request.MasterDataSource
  (
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean
  )
  : borland.data.provider.bdpdatareader;
begin
  MasterDataSource := TClass_dalc_emsof_request.Create.MasterDataSource(ord(status),order_by_field_name,be_order_ascending);
end;

function TClass_bc_emsof_request.TallyOfStatus(status: status_type): string;
begin
  TallyOfStatus := TClass_dalc_emsof_request.Create.TallyByStatus[ord(status)].tostring;
end;

end.
