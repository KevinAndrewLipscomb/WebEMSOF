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
    dalc_emsof_request: Class_dalc_emsof_request.TClass_dalc_emsof_request;
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
      status: status_type;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    function FyDesignatorOf(e_item: system.object): string;
    function IdOf(e_item: system.object): string;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyOf(e_item: system.object): string;
    function TallyOfStatus(status: status_type): string;
  end;

implementation

constructor TClass_bc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  dalc_emsof_request := Class_dalc_emsof_request.TClass_dalc_emsof_request.Create;
end;

function TClass_bc_emsof_request.AffiliateNumOf(e_item: system.object): string;
begin
  AffiliateNumOf := dalc_emsof_request.AffiliateNumOf(e_item);
end;

procedure TClass_bc_emsof_request.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  dalc_emsof_request.BindDetail(master_id,target);
end;

procedure TClass_bc_emsof_request.BindOverview
  (
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  dalc_emsof_request.BindOverview(ord(status),order_by_field_name,be_order_ascending,target);
end;

function TClass_bc_emsof_request.IdOf(e_item: system.object): string;
begin
  IdOf := dalc_emsof_request.IdOf(e_item);
end;

function TClass_bc_emsof_request.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := dalc_emsof_request.FyDesignatorOf(e_item);
end;

function TClass_bc_emsof_request.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := dalc_emsof_request.ServiceNameOf(e_item);
end;

function TClass_bc_emsof_request.SponsorCountyOf(e_item: system.object): string;
begin
  SponsorCountyOf := dalc_emsof_request.SponsorCountyOf(e_item);
end;

function TClass_bc_emsof_request.TallyOfStatus(status: status_type): string;
begin
  TallyOfStatus := dalc_emsof_request.TallyByStatus(ord(status)).tostring;
end;

end.
