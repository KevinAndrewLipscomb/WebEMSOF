unit Class_biz_emsof_requests;

interface

uses
  borland.data.provider,
  Class_db_emsof_requests,
  system.security.principal,
  system.web;

const
  ID = '$Id$';

type status_type =
  (
  ALLOCATED = 1,
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
  TClass_biz_emsof_requests = class
  private
    db_emsof_requests: TClass_db_emsof_requests;
  public
    constructor Create;
    function AffiliateNumOf(e_item: system.object): string;
    procedure Approve
      (
      e_item: system.object;
      promoter: string
      );
    function BeOkToApproveEmsofRequest(status: status_type): boolean;
    function BeOkToDrillDown(status: status_type): boolean;
    function BeOkToMarkDone(status: status_type): boolean;
    function BeValidRegionalExecDirApprovalTimestampOf
      (
      master_id: string;
      out timestamp: datetime
      )
      : boolean;
    function BeValidRegionalPlannerApprovalTimestampOf
      (
      master_id: string;
      out timestamp: datetime
      )
      : boolean;
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
    function CountyApprovalTimestampOf(master_id: string): datetime;
    procedure Demote
      (
      e_item: system.object;
      demoter: string;
      reason: string;
      emsof_ante: string
      );
    procedure Finalize(master_id: string);
    function FyDesignatorOf(e_item: system.object): string;
    function IdOf(e_item: system.object): string;
    procedure MarkDone
      (
      e_item: system.object;
      promoter: string
      );
    function NextReviewer(status: status_type): string;
    function PropertyNameOfEmsofAnte: string;
    function ReworkDeadline(e_item: system.object): datetime;
    function ServiceIdOf(e_item: system.object): string;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyCodeOf(e_item: system.object): string;
    function SponsorCountyNameOf(e_item: system.object): string;
    function SponsorRegionNameOf(master_id: string): string;
    function StatusOf(e_item: system.object): status_type;
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

uses
  Class_biz_accounts,
  Class_biz_fiscal_years,
  Class_biz_user;

constructor TClass_biz_emsof_requests.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_emsof_requests := TClass_db_emsof_requests.Create;
end;

function TClass_biz_emsof_requests.AffiliateNumOf(e_item: system.object): string;
begin
  AffiliateNumOf := db_emsof_requests.AffiliateNumOf(e_item);
end;

procedure TClass_biz_emsof_requests.Approve
  (
  e_item: system.object;
  promoter: string
  );
var
  approval_timestamp_column: Class_db_emsof_requests.approval_timestamp_column_type;
  next_approver_role: string;
  next_status: status_type;
  reviewer_descriptor: string;
begin
  approval_timestamp_column := NONE;
  next_status := StatusOf(e_item); // Better initialize it to something.
  case StatusOf(e_item) of
  NEEDS_COUNTY_APPROVAL:
    BEGIN
    approval_timestamp_column := COUNTY;
    next_approver_role := 'emsof-planner';
    reviewer_descriptor := 'The ' + promoter + ' County EMSOF Coordinator';
    next_status := NEEDS_REGIONAL_COMPLIANCE_CHECK;
    END;
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    BEGIN
    approval_timestamp_column := REGIONAL_PLANNER;
    next_approver_role := 'director';
    reviewer_descriptor := 'Regional planner ' + promoter;
    next_status := NEEDS_REGIONAL_EXEC_DIR_APPROVAL;
    END;
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    BEGIN
    approval_timestamp_column := REGIONAL_DIRECTOR;
    next_approver_role := 'emsof-coordinator';
    reviewer_descriptor := 'Regional Executive Director ' + promoter;
    next_status := NEEDS_SENT_TO_PA_DOH_EMSO;
    END;
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BEGIN
    approval_timestamp_column := STATE;
    next_approver_role := system.string.EMPTY;
    reviewer_descriptor := 'State staffer ' + promoter;
    next_status := NEEDS_INVOICE_COLLECTION;
    END;
  end;
  if approval_timestamp_column <> NONE then begin
    db_emsof_requests.Approve(IdOf(e_item),ord(next_status),TClass_biz_user.Create.Kind,approval_timestamp_column);
    if next_status <> NEEDS_INVOICE_COLLECTION then begin
      TClass_biz_accounts.Create.MakePromotionNotification
        (
        next_approver_role,
        reviewer_descriptor,
        system.object(next_status).tostring,
        ServiceIdOf(e_item),
        ServiceNameOf(e_item),
        FyDesignatorOf(e_item)
        );
//    end else begin
//      TClass_biz_accounts.Create.MakeFinalApprovalNotification;
    end;
  end;
  //
end;

function TClass_biz_emsof_requests.BeOkToApproveEmsofRequest(status: status_type): boolean;
begin
  BeOkToApproveEmsofRequest := FALSE;
  case status of
  NEEDS_COUNTY_APPROVAL:
    BeOkToApproveEmsofRequest := (TClass_biz_user.Create.Kind = 'county');
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    BeOkToApproveEmsofRequest := httpcontext.current.user.IsInRole('director')
      or httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('emsof-planner');
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    BeOkToApproveEmsofRequest :=
      httpcontext.current.user.IsInRole('director');
  end;
end;

function TClass_biz_emsof_requests.BeOkToDrillDown(status: status_type): boolean;
begin
  BeOkToDrillDown := FALSE;
  if httpcontext.current.user.IsInRole('director')
    or httpcontext.current.user.IsInRole('emsof-coordinator')
    or httpcontext.current.user.IsInRole('emsof-planner')
  then begin
    BeOkToDrillDown := (status <> ALLOCATED);
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

function TClass_biz_emsof_requests.BeOkToMarkDone(status: status_type): boolean;
begin
  BeOkToMarkDone := FALSE;
  case status of
  NEEDS_SENT_TO_PA_DOH_EMSO:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-clerk')
      or httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('director');
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('director');
  NEEDS_REIMBURSEMENT_ISSUANCE:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-accountant')
      or httpcontext.current.user.IsInRole('director');
  end;
end;

procedure TClass_biz_emsof_requests.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  db_emsof_requests.BindDetail(master_id,target);
end;

procedure TClass_biz_emsof_requests.BindOverviewAll
  (
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindOverviewAll(order_by_field_name,be_order_ascending,target);
end;

procedure TClass_biz_emsof_requests.BindOverviewByRegionDictatedAppropriation
  (
  region_dictated_appropriation_id: string;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindOverviewByRegionDictatedAppropriation
    (region_dictated_appropriation_id,order_by_field_name,be_order_ascending,target);
end;

procedure TClass_biz_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus
  (
  region_dictated_appropriation_id: string;
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus
    (region_dictated_appropriation_id,ord(status),order_by_field_name,be_order_ascending,target);
end;


procedure TClass_biz_emsof_requests.BindOverviewByStatus
  (
  status: status_type;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindOverviewByStatus(ord(status),order_by_field_name,be_order_ascending,target);
end;

function TClass_biz_emsof_requests.CountyApprovalTimestampOf(master_id: string): system.datetime;
begin
  CountyApprovalTimestampOf := db_emsof_requests.CountyApprovalTimestampOf(master_id);
end;

procedure TClass_biz_emsof_requests.Demote
  (
  e_item: system.object;
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
  case StatusOf(e_item) of
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
  db_emsof_requests.Demote(IdOf(e_item),ord(next_status),TClass_biz_user.Create.Kind,role);
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

procedure TClass_biz_emsof_requests.Finalize(master_id: string);
begin
  db_emsof_requests.Finalize(master_id);
end;

function TClass_biz_emsof_requests.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := db_emsof_requests.FyDesignatorOf(e_item);
end;

function TClass_biz_emsof_requests.IdOf(e_item: system.object): string;
begin
  IdOf := db_emsof_requests.IdOf(e_item);
end;

procedure TClass_biz_emsof_requests.MarkDone
  (
  e_item: system.object;
  promoter: string
  );
var
  next_status: status_type;
  reviewer_descriptor: string;
begin
  reviewer_descriptor := db_emsof_requests.SponsorRegionNameOf(db_emsof_requests.IdOf(e_item));
  next_status := StatusOf(e_item); // Better initialize it to something.
  case StatusOf(e_item) of
  NEEDS_SENT_TO_PA_DOH_EMSO:
    BEGIN
    next_status := NEEDS_PA_DOH_EMSO_APPROVAL;
    END;
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BEGIN
    next_status := NEEDS_INVOICE_COLLECTION;
    END;
  NEEDS_REIMBURSEMENT_ISSUANCE:
    BEGIN
    next_status := REIMBURSEMENT_ISSUED;
    END;
  end;
  db_emsof_requests.MarkDone(IdOf(e_item),ord(next_status),TClass_biz_user.Create.Kind);
  TClass_biz_accounts.Create.MakePromotionNotification
    (
    system.string.EMPTY,
    reviewer_descriptor,
    system.object(next_status).tostring,
    ServiceIdOf(e_item),
    ServiceNameOf(e_item),
    FyDesignatorOf(e_item)
    );
  //
end;

function TClass_biz_emsof_requests.NextReviewer(status: status_type): string;
begin
  case status of
  NEEDS_COUNTY_APPROVAL:
    NextReviewer := 'Regional Council EMSOF Coordinator';
  NEEDS_REGIONAL_COMPLIANCE_CHECK:
    NextReviewer := 'Regional Council Executive Director';
  NEEDS_REGIONAL_EXEC_DIR_APPROVAL:
    NextReviewer := 'Regional Council EMSOF Coordinator (for transmittal to PA DOH EMSO)';
  end;
end;

function TClass_biz_emsof_requests.PropertyNameOfEmsofAnte: string;
begin
  PropertyNameOfEmsofAnte := db_emsof_requests.PropertyNameOfEmsofAnte;
end;

function TClass_biz_emsof_requests.BeValidRegionalExecDirApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
begin
  BeValidRegionalExecDirApprovalTimestampOf := db_emsof_requests.BeValidRegionalExecDirApprovalTimestampOf(master_id,timestamp);
end;

function TClass_biz_emsof_requests.BeValidRegionalPlannerApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
begin
  BeValidRegionalPlannerApprovalTimestampOf := db_emsof_requests.BeValidRegionalPlannerApprovalTimestampOf(master_id,timestamp);
end;

function TClass_biz_emsof_requests.ReworkDeadline(e_item: system.object): datetime;
begin
  ReworkDeadline := db_emsof_requests.ReworkDeadline(e_item);
end;

function TClass_biz_emsof_requests.ServiceIdOf(e_item: system.object): string;
begin
  ServiceIdOf := db_emsof_requests.ServiceIdOf(e_item);
end;

function TClass_biz_emsof_requests.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := db_emsof_requests.ServiceNameOf(e_item);
end;

function TClass_biz_emsof_requests.SponsorCountyCodeOf(e_item: system.object): string;
begin
  SponsorCountyCodeOf := db_emsof_requests.SponsorCountyCodeOf(e_item);
end;

function TClass_biz_emsof_requests.SponsorCountyNameOf(e_item: system.object): string;
begin
  SponsorCountyNameOf := db_emsof_requests.SponsorCountyNameOf(e_item);
end;

function TClass_biz_emsof_requests.SponsorRegionNameOf(master_id: string): string;
begin
  SponsorRegionNameOf := db_emsof_requests.SponsorRegionNameOf(master_id);
end;

function TClass_biz_emsof_requests.StatusOf(e_item: system.object): status_type;
begin
  StatusOf := status_type(db_emsof_requests.StatusCodeOf(e_item));
end;

function TClass_biz_emsof_requests.SumOfRequestValues(fy_id: string = ''): decimal;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  if fy_id = system.string.EMPTY then begin
    SumOfRequestValues := db_emsof_requests.SumOfRequestValues
      (biz_user.Kind,biz_user.IdNum,TClass_biz_fiscal_years.Create.IdOfCurrent);
  end else begin
    SumOfRequestValues := db_emsof_requests.SumOfRequestValues(biz_user.Kind,biz_user.IdNum,fy_id);
  end;
end;

function TClass_biz_emsof_requests.TallyOfStatus(status: status_type): string;
begin
  TallyOfStatus := db_emsof_requests.TallyByStatus(ord(status)).tostring;
end;

function TClass_biz_emsof_requests.TcciOfAppropriation: cardinal;
begin
  TcciOfAppropriation := db_emsof_requests.TcciOfAppropriation;
end;

function TClass_biz_emsof_requests.TcciOfId: cardinal;
begin
  TcciOfId := db_emsof_requests.TcciOfId;
end;

function TClass_biz_emsof_requests.TcciOfEmsofAnte: cardinal;
begin
  TcciOfEmsofAnte := db_emsof_requests.TcciOfEmsofAnte;
end;

function TClass_biz_emsof_requests.TcciOfPasswordResetEmailAddress: cardinal;
begin
  TcciOfPasswordResetEmailAddress := db_emsof_requests.TcciOfPasswordResetEmailAddress;
end;

function TClass_biz_emsof_requests.TcciOfServiceName: cardinal;
begin
  TcciOfServiceName := db_emsof_requests.TcciOfServiceName;
end;

function TClass_biz_emsof_requests.TcciOfStatusCode: cardinal;
begin
  TcciOfStatusCode := db_emsof_requests.TcciOfStatusCode;
end;

function TClass_biz_emsof_requests.TcciOfStatusDescription: cardinal;
begin
  TcciOfStatusDescription := db_emsof_requests.TcciOfStatusDescription;
end;

end.
