unit Class_bc_emsof_request;

interface

uses
  borland.data.provider,
  Class_bc_fiscal_years,
  Class_bc_user,
  Class_dalc_emsof_request,
  system.security.principal,
  system.web;

const
  ID = '$Id$';

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
    function AffiliateNumOf(e_item: system.object): string;
    function BeOkToApproveEmsofRequest(status: status_type): boolean;
    function BeOkToDrillDown(status: status_type): boolean;
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
    function NextApprover(status: status_type): string;
    function ReworkDeadline(e_item: system.object): datetime;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyOf(e_item: system.object): string;
    function SumOfRequestValues(fy_id: string = ''): decimal;
    function TallyOfStatus(status: status_type): string;
    function TcciOfId: cardinal;
    function TcciOfLinkButtonSelect: cardinal;
  end;

implementation

constructor TClass_bc_emsof_request.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_emsof_request.AffiliateNumOf(e_item: system.object): string;
begin
  AffiliateNumOf := TClass_dalc_emsof_request.Create.AffiliateNumOf(e_item);
end;

function TClass_bc_emsof_request.BeOkToApproveEmsofRequest(status: status_type): boolean;
begin
  BeOkToApproveEmsofRequest := FALSE;
  case status of
  NEEDS_COUNTY_APPROVAL:
    BeOkToApproveEmsofRequest := httpcontext.current.user.IsInRole('county-coord');
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    BeOkToApproveEmsofRequest := httpcontext.current.user.IsInRole('director')
      or httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('emsof-planner');
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    BeOkToApproveEmsofRequest :=
      httpcontext.current.user.IsInRole('director');
  end;
end;

function TClass_bc_emsof_request.BeOkToDrillDown(status: status_type): boolean;
begin
  BeOkToDrillDown := FALSE;
  if httpcontext.current.user.IsInRole('director')
    or httpcontext.current.user.IsInRole('emsof-coordinator')
    or httpcontext.current.user.IsInRole('emsof-planner')
  then begin
    BeOkToDrillDown := (status <> INITIALIZED);
  end else if httpcontext.current.user.IsInRole('emsof-clerk') then begin
    BeOkToDrillDown := status in
      [
      NEEDS_SENT_TO_PA_DOH_EMSO,
      NEEDS_INVOICE_COLLECTION,
      NEEDS_CANCELED_CHECK_COLLECTION,
      DEPLOYED
      ];
  end else if httpcontext.current.user.IsInRole('emsof-accountant') then begin
    BeOkToDrillDown := (status = NEEDS_REIMBURSEMENT_ISSUANCE);
  end;
end;

procedure TClass_bc_emsof_request.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindDetail(master_id,target);
end;

procedure TClass_bc_emsof_request.BindOverview
  (
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindOverview(ord(status),order_by_field_name,be_order_ascending,target);
end;

function TClass_bc_emsof_request.IdOf(e_item: system.object): string;
begin
  IdOf := TClass_dalc_emsof_request.Create.IdOf(e_item);
end;

function TClass_bc_emsof_request.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := TClass_dalc_emsof_request.Create.FyDesignatorOf(e_item);
end;

function TClass_bc_emsof_request.NextApprover(status: status_type): string;
begin
  case status of
  NEEDS_COUNTY_APPROVAL:
    NextApprover := 'Regional Council EMSOF Coordinator';
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    NextApprover := 'Regional Council Executive Director';
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    NextApprover := 'Regional Council EMSOF Coordinator (for transmittal to PA DOH EMSO)';
  end;
end;

function TClass_bc_emsof_request.ReworkDeadline(e_item: system.object): datetime;
begin
  ReworkDeadline := TClass_dalc_emsof_request.Create.ReworkDeadline(e_item);
end;

function TClass_bc_emsof_request.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := TClass_dalc_emsof_request.Create.ServiceNameOf(e_item);
end;

function TClass_bc_emsof_request.SponsorCountyOf(e_item: system.object): string;
begin
  SponsorCountyOf := TClass_dalc_emsof_request.Create.SponsorCountyOf(e_item);
end;

function TClass_bc_emsof_request.SumOfRequestValues(fy_id: string = ''): decimal;
var
  bc_user: TClass_bc_user;
begin
  bc_user := TClass_bc_user.Create;
  if fy_id = system.string.EMPTY then begin
    SumOfRequestValues := TClass_dalc_emsof_request.Create.SumOfRequestValues
      (bc_user.Kind,bc_user.IdNum,TClass_bc_fiscal_years.Create.IdOfCurrent);
  end else begin
    SumOfRequestValues := TClass_dalc_emsof_request.Create.SumOfRequestValues(bc_user.Kind,bc_user.IdNum,fy_id);
  end;
end;

function TClass_bc_emsof_request.TallyOfStatus(status: status_type): string;
begin
  TallyOfStatus := TClass_dalc_emsof_request.Create.TallyByStatus(ord(status)).tostring;
end;

function TClass_bc_emsof_request.TcciOfId: cardinal;
begin
  TcciOfId := TClass_dalc_emsof_request.Create.TcciOfId;
end;

function TClass_bc_emsof_request.TcciOfLinkButtonSelect: cardinal;
begin
  TcciOfLinkButtonSelect := TClass_dalc_emsof_request.Create.TcciOfLinkButtonSelect;
end;

end.
