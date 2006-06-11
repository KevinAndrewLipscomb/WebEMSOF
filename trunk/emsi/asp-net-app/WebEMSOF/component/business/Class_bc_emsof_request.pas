unit Class_bc_emsof_request;

interface

uses
  borland.data.provider,
  Class_biz_accounts,
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
    procedure BindOverviewAll
      (
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindOverviewByRegionDictatedAppropriation
      (
      region_dictated_appropriation_id: string;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindOverviewByRegionDictatedAppropriationAndStatus
      (
      region_dictated_appropriation_id: string;
      status: status_type;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindOverviewByStatus
      (
      status: status_type;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure Demote
      (
      e_item: system.object;
      status: status_type;
      demoter: string;
      reason: string;
      emsof_ante: string
      );
    function FyDesignatorOf(e_item: system.object): string;
    function IdOf(e_item: system.object): string;
    function NextApprover(status: status_type): string;
    procedure Promote
      (
      e_item: system.object;
      status: status_type;
      promoter: string
      );
    function PropertyNameOfEmsofAnte: string;
    function ReworkDeadline(e_item: system.object): datetime;
    function ServiceIdOf(e_item: system.object): string;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyCodeOf(e_item: system.object): string;
    function SponsorCountyNameOf(e_item: system.object): string;
    function SumOfRequestValues(fy_id: string = ''): decimal;
    function TallyOfStatus(status: status_type): string;
    function TcciOfAppropriation: cardinal;
    function TcciOfId: cardinal;
    function TcciOfEmsofAnte: cardinal;
    function TcciOfPasswordResetEmailAddress: cardinal;
    function TcciOfServiceName: cardinal;
    function TcciOfStatusCode: cardinal;
    function TcciOfStatusDescription: cardinal;
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
    BeOkToApproveEmsofRequest := (TClass_bc_user.Create.Kind = 'county');
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

procedure TClass_bc_emsof_request.BindOverviewAll
  (
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindOverviewAll(order_by_field_name,be_order_ascending,target);
end;

procedure TClass_bc_emsof_request.BindOverviewByRegionDictatedAppropriation
  (
  region_dictated_appropriation_id: string;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindOverviewByRegionDictatedAppropriation
    (region_dictated_appropriation_id,order_by_field_name,be_order_ascending,target);
end;

procedure TClass_bc_emsof_request.BindOverviewByRegionDictatedAppropriationAndStatus
  (
  region_dictated_appropriation_id: string;
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindOverviewByRegionDictatedAppropriationAndStatus
    (region_dictated_appropriation_id,ord(status),order_by_field_name,be_order_ascending,target);
end;


procedure TClass_bc_emsof_request.BindOverviewByStatus
  (
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  TClass_dalc_emsof_request.Create.BindOverviewByStatus(ord(status),order_by_field_name,be_order_ascending,target);
end;

function TClass_bc_emsof_request.IdOf(e_item: system.object): string;
begin
  IdOf := TClass_dalc_emsof_request.Create.IdOf(e_item);
end;

procedure TClass_bc_emsof_request.Demote
  (
  e_item: system.object;
  status: status_type;
  demoter: string;
  reason: string;
  emsof_ante: string
  );
var
  be_ok_to_rework: boolean;
  next_status: status_type;
  reviewer_descriptor: string;
  role: string;
begin
  //
  be_ok_to_rework := (datetime.Now <= ReworkDeadline(e_item));
  //
  case status of
  NEEDS_COUNTY_APPROVAL:
    BEGIN
    role := 'county';
    reviewer_descriptor := 'The ' + demoter + ' County EMSOF Coordinator';
    END;
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    BEGIN
    role := 'regional_planner';
    reviewer_descriptor := 'Regional planner ' + demoter;
    END;
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    BEGIN
    role := 'regional_director';
    reviewer_descriptor := 'Regional Executive Director ' + demoter;
    END;
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BEGIN
    role := 'state';
    reviewer_descriptor := 'State staffer ' + demoter;
    END;
  end;
  //
  if be_ok_to_rework then begin
    next_status := NEEDS_SERVICE_FINALIZATION;
  end else begin
    next_status := REJECTED;
  end;
  //
  TClass_dalc_emsof_request.Create.Demote(IdOf(e_item),ord(next_status),TClass_bc_user.Create.Kind,role);
  TClass_biz_accounts.Create.MakeDemotionNotification
    (
    role,
    reviewer_descriptor,
    system.object(next_status).tostring,
    ServiceIdOf(e_item),
    ServiceNameOf(e_item),
    FyDesignatorOf(e_item),
    be_ok_to_rework,
    reason,
    SponsorCountyCodeOf(e_item),
    emsof_ante
    );
  //
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

function TClass_bc_emsof_request.PropertyNameOfEmsofAnte: string;
begin
  PropertyNameOfEmsofAnte := TClass_dalc_emsof_request.Create.PropertyNameOfEmsofAnte;
end;

procedure TClass_bc_emsof_request.Promote
  (
  e_item: system.object;
  status: status_type;
  promoter: string
  );
var
  next_status: status_type;
  reviewer_descriptor: string;
  role: string;
begin
  next_status := status; // Better initialize it to something.
  case status of
  NEEDS_COUNTY_APPROVAL:
    BEGIN
    role := 'county';
    reviewer_descriptor := 'The ' + promoter + ' County EMSOF Coordinator';
    next_status := NEEDS_REGIONAL_COMPLIANCE_CHECK;
    END;
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    BEGIN
    role := 'regional_planner';
    reviewer_descriptor := 'Regional planner ' + promoter;
    next_status := NEEDS_REGIONAL_EXEC_DIR_APPROVAL;
    END;
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    BEGIN
    role := 'regional_director';
    reviewer_descriptor := 'Regional Executive Director ' + promoter;
    next_status := NEEDS_SENT_TO_PA_DOH_EMSO;
    END;
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BEGIN
    role := 'state';
    reviewer_descriptor := 'State staffer ' + promoter;
    next_status := NEEDS_INVOICE_COLLECTION;
    END;
  end;
  TClass_dalc_emsof_request.Create.Promote(IdOf(e_item),ord(next_status),TClass_bc_user.Create.Kind,role);
  TClass_biz_accounts.Create.MakePromotionNotification
    (
    role,
    reviewer_descriptor,
    system.object(next_status).tostring,
    ServiceIdOf(e_item),
    ServiceNameOf(e_item),
    FyDesignatorOf(e_item)
    );
  //
end;

function TClass_bc_emsof_request.ReworkDeadline(e_item: system.object): datetime;
begin
  ReworkDeadline := TClass_dalc_emsof_request.Create.ReworkDeadline(e_item);
end;

function TClass_bc_emsof_request.ServiceIdOf(e_item: system.object): string;
begin
  ServiceIdOf := TClass_dalc_emsof_request.Create.ServiceIdOf(e_item);
end;

function TClass_bc_emsof_request.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := TClass_dalc_emsof_request.Create.ServiceNameOf(e_item);
end;

function TClass_bc_emsof_request.SponsorCountyCodeOf(e_item: system.object): string;
begin
  SponsorCountyCodeOf := TClass_dalc_emsof_request.Create.SponsorCountyCodeOf(e_item);
end;

function TClass_bc_emsof_request.SponsorCountyNameOf(e_item: system.object): string;
begin
  SponsorCountyNameOf := TClass_dalc_emsof_request.Create.SponsorCountyNameOf(e_item);
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

function TClass_bc_emsof_request.TcciOfAppropriation: cardinal;
begin
  TcciOfAppropriation := TClass_dalc_emsof_request.Create.TcciOfAppropriation;
end;

function TClass_bc_emsof_request.TcciOfId: cardinal;
begin
  TcciOfId := TClass_dalc_emsof_request.Create.TcciOfId;
end;

function TClass_bc_emsof_request.TcciOfEmsofAnte: cardinal;
begin
  TcciOfEmsofAnte := TClass_dalc_emsof_request.Create.TcciOfEmsofAnte;
end;

function TClass_bc_emsof_request.TcciOfPasswordResetEmailAddress: cardinal;
begin
  TcciOfPasswordResetEmailAddress := TClass_dalc_emsof_request.Create.TcciOfPasswordResetEmailAddress;
end;

function TClass_bc_emsof_request.TcciOfServiceName: cardinal;
begin
  TcciOfServiceName := TClass_dalc_emsof_request.Create.TcciOfServiceName;
end;

function TClass_bc_emsof_request.TcciOfStatusCode: cardinal;
begin
  TcciOfStatusCode := TClass_dalc_emsof_request.Create.TcciOfStatusCode;
end;

function TClass_bc_emsof_request.TcciOfStatusDescription: cardinal;
begin
  TcciOfStatusDescription := TClass_dalc_emsof_request.Create.TcciOfStatusDescription;
end;

end.
