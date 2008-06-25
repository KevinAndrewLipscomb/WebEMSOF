unit Class_biz_emsof_requests;

interface

uses
  mysql.data.mysqlclient,
  Class_db_appropriations,
  Class_db_emsof_requests,
  Class_biz_accounts,
  Class_biz_appropriations,
  Class_biz_equipment,
  Class_biz_match_level,
  Class_biz_milestones,
  Class_biz_regional_staffers,
  Class_biz_user,
  system.collections,
  system.security.principal,
  system.web;

type
  status_type =
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
    ARCHIVED = 15,
    FAILED_DEADLINE = 16
    );
  item_status_type =
    (
    MASTER_NOT_YET_APPROVED = 1,
    REGION_NEEDS_INVOICE = 2,
    REGION_NEEDS_PROOF_OF_PAYMENT = 4,
    ITEM_WITHDRAWN = 6
    );

type
  TClass_biz_emsof_requests = class
  private
    db_appropriations: TClass_db_appropriations;
    db_emsof_requests: TClass_db_emsof_requests;
    biz_accounts: TClass_biz_accounts;
    biz_equipment: TClass_biz_equipment;
    biz_appropriations: TClass_biz_appropriations;
    biz_match_level: TClass_biz_match_level;
    biz_milestones: TClass_biz_milestones;
    biz_regional_staffers: TClass_biz_regional_staffers;
    biz_user: TClass_biz_user;
  public
    constructor Create;
    function ActualValueOf(master_id: string): decimal;
    procedure AddProofOfPayment
      (
      request_id: string;
      date_of_payment: datetime;
      method_code: string;
      amount: decimal;
      note: string
      );
    function AffiliateNumOf(e_item: system.object): string;
    procedure Approve
      (
      e_item: system.object;
      promoter: string
      );
    function ArchiveMatured: queue;
    function BeDeadlineExempt(master_id: string): boolean;
    function BeOkToApproveEmsofRequest(status: status_type): boolean;
    function BeOkToDrillDown(status: status_type): boolean;
    function BeOkToForceOpen(e_item: system.object): boolean;
    function BeOkToMarkDone(status: status_type): boolean;
    function BeOkToMarkFailed(status: status_type): boolean;
    function BeOkToRevokeDeadlineExemption(e_item: system.object): boolean;
    function BeOkToTrackInvoices(status: status_type): boolean;
    function BeOkToTrackPayments(status: status_type): boolean;
    function BeOkToViewInvoices(status: status_type): boolean;
    function BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation
      (
      region_dictated_appropriation_id: string
      )
      : boolean;
    function BeValidCountyApprovalTimestampOf
      (
      master_id: string;
      out timestamp: datetime
      )
      : boolean;
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
    function BeValidStateApprovalTimestampOf
      (
      master_id: string;
      out timestamp: datetime
      )
      : boolean;
    function BeWithdrawable(status_code: cardinal): boolean;
    procedure BindEquipmentProcurementDetail
      (
      fy_id: string;
      equipment_code: string;
      sort_order: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindEquipmentProcurementOverview
      (
      fy_id: string;
      sort_order: string;
      be_order_ascending: boolean;
      target: system.object;
      do_log: boolean = TRUE
      );
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
    procedure BindProofsOfPayment
      (
      request_id: string;
      target: system.object
      );
    procedure BindStateExportBatch
      (
      target: system.object;
      status: status_type;
      amendment_num_string: string;
      regional_staffer_user_id: string
      );
    procedure BindValuesToServices
      (
      sort_order: string;
      be_order_ascending: boolean;
      target: system.object
      );
    function CountyApprovalTimestampOf(master_id: string): datetime;
    function CountyCodeOfMasterId(master_id: string): string;
    function CountyDictumIdOf(master_id: string): string;
    procedure DeleteProofOfPayment(id: string);
    procedure Demote
      (
      e_item: system.object;
      demoter: string;
      reason: string;
      emsof_ante: string
      );
    function DeployCompleted: queue;
    function EmsofAnteOfItem
      (
      master_id: string;
      priority: string
      )
      : decimal;
    function EquipmentCodeOf
      (
      master_id: string;
      priority: string
      )
      : string;
    function FailUncompleted: queue;
    function FailUnfinalized: queue;
    procedure Finalize(master_id: string);
    procedure ForceClosed(master_id: string);
    procedure ForceOpen(master_id: string);
    function FyDesignatorOf(e_item: system.object): string;
    function HasWishList(master_id: string): boolean;
    function IdOf(e_item: system.object): string;
    function IdOfProofOfPayment(e_item: system.object): string;
    function LeftoverOrShortageOf(e_item: system.object): decimal;
    procedure MarkDone
      (
      e_item: system.object;
      promoter: string
      );
    procedure MarkFailed
      (
      e_item: system.object;
      failer: string
      );
    function NextReviewer(status: status_type): string;
    function NumRequestsInStateExportBatch
      (
      status: status_type;
      amendment_num_string: string;
      regional_staffer_user_id: string
      )
      : cardinal;
    function PropertyNameOfAppropriation: string;
    function PropertyNameOfEmsofAnte: string;
    function ReworkDeadline(e_item: system.object): datetime;
    function ServiceIdOf(e_item: system.object): string;
    function ServiceIdOfMasterId(master_id: string): string;
    function ServiceNameOf(e_item: system.object): string;
    procedure SetActuals
      (
      master_id: string;
      priority: string;
      invoice_designator: string;
      quantity: string;
      subtotal_cost: string
      );
    procedure SetHasWishList
      (
      master_id: string;
      value: boolean
      );
    function SponsorCountyCodeOf(e_item: system.object): string;
    function SponsorCountyNameOf(e_item: system.object): string;
    function SponsorRegionNameOf(master_id: string): string;
    function StatusOf(e_item: system.object): status_type;
    procedure SubmitToState
      (
      Table_report: system.object;
      request_physical_path: string;
      status_of_interest: status_type;
      regional_staffer_user_id: string;
      amendment_num_string: string
      );
    function SusceptibleTo(milestone: milestone_type): queue;
    function SumOfActualCostsOfRequestItems(request_id: string): decimal;
    function SumOfActualValues(fy_id: string = ''): decimal;
    function SumOfProvenPaymentsOfRequest(request_id: string): decimal;
    function SumOfRequestValues(fy_id: string = ''): decimal;
    function TallyOfStatus(status: status_type): string;
    function TcciOfAppropriation: cardinal;
    function TcciOfId: cardinal;
    function TcciOfEmsofAnte: cardinal;
    function TcciOfFullRequestActuals: cardinal;
    function TcciOfFullRequestPriority: cardinal;
    function TcciOfPasswordResetEmailAddress: cardinal;
    function TcciOfServiceName: cardinal;
    function TcciOfLeftoverOrShortage: cardinal;
    function TcciOfSrrReplacementRowIndicator: cardinal;
    function TcciOfStatusCode: cardinal;
    function TcciOfStatusDescription: cardinal;
    procedure Unreject
      (
      e_item: system.object;
      role: string;
      reviewer_descriptor: string
      );
    procedure Withdraw(master_id: string);
  end;

implementation

uses
  Class_biz_fiscal_years,
  kix,
  system.configuration,
  system.io;

constructor TClass_biz_emsof_requests.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_appropriations := TClass_db_appropriations.Create;
  db_emsof_requests := TClass_db_emsof_requests.Create;
  biz_accounts := TClass_biz_accounts.Create;
  biz_appropriations := TClass_biz_appropriations.Create;
  biz_equipment := TClass_biz_equipment.Create;
  biz_match_level := TClass_biz_match_level.Create;
  biz_milestones := TClass_biz_milestones.Create;
  biz_regional_staffers := TClass_biz_regional_staffers.Create;
  biz_user := TClass_biz_user.Create;
end;

function TClass_biz_emsof_requests.ActualValueOf(master_id: string): decimal;
begin
  ActualValueOf := db_emsof_requests.ActualValueOf(master_id);
end;

procedure TClass_biz_emsof_requests.AddProofOfPayment
  (
  request_id: string;
  date_of_payment: datetime;
  method_code: string;
  amount: decimal;
  note: string
  );
begin
  db_emsof_requests.AddProofOfPayment(request_id,date_of_payment,method_code,amount,note);
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
  amount_to_return_to_county: decimal;
  approval_timestamp_column: Class_db_emsof_requests.approval_timestamp_column_type;
  leftover_or_shortage: decimal;
  master_id: string;
  next_approver_role: string;
  next_status: status_type;
  reviewer_descriptor: string;
  status: status_type;
begin
  amount_to_return_to_county := 0;
  approval_timestamp_column := Class_db_emsof_requests.approval_timestamp_column_type(NONE);
  leftover_or_shortage := 0;
  master_id := IdOf(e_item);
  status := StatusOf(e_item);
  next_status := status; // Better initialize it to something.
  case status of
  NEEDS_COUNTY_APPROVAL:
    BEGIN
    leftover_or_shortage := LeftoverOrShortageOf(e_item);
    if leftover_or_shortage > 0 then begin
      amount_to_return_to_county := leftover_or_shortage;
    end;
    approval_timestamp_column := COUNTY;
    next_approver_role := 'emsof-planner';
    reviewer_descriptor := 'The ' + promoter + ' EMSOF Coordinator';
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
    next_approver_role := EMPTY;
    reviewer_descriptor := SponsorRegionNameOf(master_id);
    next_status := NEEDS_INVOICE_COLLECTION;
    END;
  end;
  if approval_timestamp_column <> Class_db_emsof_requests.approval_timestamp_column_type(NONE) then begin
    db_emsof_requests.Approve(IdOf(e_item),ord(next_status),biz_user.Kind,approval_timestamp_column,amount_to_return_to_county);
    if next_status <> NEEDS_INVOICE_COLLECTION then begin
      biz_accounts.MakePromotionNotification
        (
        next_approver_role,
        reviewer_descriptor,
        system.object(next_status).tostring,
        ServiceIdOf(e_item),
        ServiceNameOf(e_item),
        FyDesignatorOf(e_item)
        );
    end else begin
      biz_accounts.IssueNoticeToProceed
        (
        ServiceIdOf(e_item),
        ServiceNameOf(e_item),
        FyDesignatorOf(e_item),
        reviewer_descriptor,
        SponsorCountyNameOf(e_item),
        master_id
        );
    end;
  end;
  //
end;

function TClass_biz_emsof_requests.ArchiveMatured: queue;
begin
  ArchiveMatured := db_emsof_requests.ArchiveMatured;
end;

function TClass_biz_emsof_requests.BeDeadlineExempt(master_id: string): boolean;
begin
  BeDeadlineExempt := db_emsof_requests.BeDeadlineExempt(master_id);
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
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BeOkToApproveEmsofRequest := httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('director');
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

function TClass_biz_emsof_requests.BeOkToForceOpen(e_item: system.object): boolean;
begin
  BeOkToForceOpen :=
    (
      (not db_emsof_requests.BeDeadlineExempt(db_emsof_requests.IdOf(e_item)))
    and
      (
      StatusOf(e_item) in
        [
        NEEDS_COUNTY_APPROVAL,
        NEEDS_SENT_TO_PA_DOH_EMSO,
        NEEDS_PA_DOH_EMSO_APPROVAL,
        NEEDS_INVOICE_COLLECTION,
        NEEDS_CANCELED_CHECK_COLLECTION,
        NEEDS_REIMBURSEMENT_ISSUANCE,
        REJECTED,
        FAILED_DEADLINE
        ]
      )
    and
      (
      httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator')
      )
    );
end;

function TClass_biz_emsof_requests.BeOkToMarkDone(status: status_type): boolean;
begin
  BeOkToMarkDone := FALSE;
  case status of
  NEEDS_SENT_TO_PA_DOH_EMSO:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-clerk')
      or httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('director');
  NEEDS_INVOICE_COLLECTION,
  NEEDS_CANCELED_CHECK_COLLECTION:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-coordinator')
      or httpcontext.current.user.IsInRole('emsof-accountant')
      or httpcontext.current.user.IsInRole('director');
  NEEDS_REIMBURSEMENT_ISSUANCE:
    BeOkToMarkDone := httpcontext.current.user.IsInRole('emsof-accountant')
      or httpcontext.current.user.IsInRole('director');
  end;
end;

function TClass_biz_emsof_requests.BeOkToMarkFailed(status: status_type): boolean;
begin
  BeOkToMarkFailed := FALSE;
  case status of
  NEEDS_INVOICE_COLLECTION:
    BeOkToMarkFailed := biz_milestones.BeProcessed(SERVICE_INVOICE_SUBMISSION_DEADLINE_MILESTONE)
      and (httpcontext.current.user.IsInRole('emsof-coordinator') or httpcontext.current.user.IsInRole('director'));
  NEEDS_CANCELED_CHECK_COLLECTION:
    BeOkToMarkFailed := biz_milestones.BeProcessed(SERVICE_CANCELED_CHECK_SUBMISSION_DEADLINE_MILESTONE)
      and (httpcontext.current.user.IsInRole('emsof-coordinator') or httpcontext.current.user.IsInRole('director'));
  end;
end;

function TClass_biz_emsof_requests.BeOkToRevokeDeadlineExemption(e_item: system.object): boolean;
begin
  BeOkToRevokeDeadlineExemption :=
    (
      (db_emsof_requests.BeDeadlineExempt(db_emsof_requests.IdOf(e_item)))
    and
      (
      httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator')
      )
    );
end;

function TClass_biz_emsof_requests.BeOkToTrackInvoices(status: status_type): boolean;
begin
  BeOkToTrackInvoices := (status = NEEDS_INVOICE_COLLECTION)
    and
      (
      httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator')
      );
end;

function TClass_biz_emsof_requests.BeOkToTrackPayments(status: status_type): boolean;
begin
  BeOkToTrackPayments := (status = NEEDS_CANCELED_CHECK_COLLECTION)
    and
      (
      httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator')
      );
end;

function TClass_biz_emsof_requests.BeOkToViewInvoices(status: status_type): boolean;
begin
  BeOkToViewInvoices := status in
    [
    NEEDS_INVOICE_COLLECTION,
    NEEDS_CANCELED_CHECK_COLLECTION,
    NEEDS_REIMBURSEMENT_ISSUANCE,
    REIMBURSEMENT_ISSUED,
    DEPLOYED,
    ARCHIVED
    ];
end;

function TClass_biz_emsof_requests.BeWithdrawable(status_code: cardinal): boolean;
begin
  BeWithdrawable := (status_type(status_code) in [NEEDS_COUNTY_APPROVAL..NEEDS_REIMBURSEMENT_ISSUANCE]);
end;

procedure TClass_biz_emsof_requests.BindEquipmentProcurementDetail
  (
  fy_id: string;
  equipment_code: string;
  sort_order: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindEquipmentProcurementDetail(fy_id,equipment_code,sort_order,be_order_ascending,target);
end;

procedure TClass_biz_emsof_requests.BindEquipmentProcurementOverview
  (
  fy_id: string;
  sort_order: string;
  be_order_ascending: boolean;
  target: system.object;
  do_log: boolean = TRUE
  );
begin
  db_emsof_requests.BindEquipmentProcurementOverview(fy_id,sort_order,be_order_ascending,target,do_log);
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
  db_emsof_requests.BindOverviewByStatus(ord(status),order_by_field_name,be_order_ascending,target,(status in [DEPLOYED,ARCHIVED]));
end;

function TClass_biz_emsof_requests.CountyApprovalTimestampOf(master_id: string): system.datetime;
begin
  CountyApprovalTimestampOf := db_emsof_requests.CountyApprovalTimestampOf(master_id);
end;

procedure TClass_biz_emsof_requests.BindProofsOfPayment
  (
  request_id: string;
  target: system.object
  );
begin
  db_emsof_requests.BindProofsOfPayment(request_id,target);
end;

procedure TClass_biz_emsof_requests.BindStateExportBatch
  (
  target: system.object;
  status: status_type;
  amendment_num_string: string;
  regional_staffer_user_id: string
  );
begin
  db_emsof_requests.BindStateExportBatch
    (
    target,
    ord(status),
    amendment_num_string,
    biz_regional_staffers.RegionCodeOf(regional_staffer_user_id)
    );
end;

procedure TClass_biz_emsof_requests.BindValuesToServices
  (
  sort_order: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_emsof_requests.BindValuesToServices(sort_order,be_order_ascending,target);
end;

function TClass_biz_emsof_requests.CountyCodeOfMasterId(master_id: string): string;
begin
  CountyCodeOfMasterId := db_emsof_requests.CountyCodeOfMasterId(master_id);
end;

function TClass_biz_emsof_requests.CountyDictumIdOf(master_id: string): string;
begin
  CountyDictumIdOf := db_emsof_requests.CountyDictumIdOf(master_id);
end;

procedure TClass_biz_emsof_requests.DeleteProofOfPayment(id: string);
begin
  db_emsof_requests.DeleteProofOfPayment(id);
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
  db_emsof_requests.Demote(IdOf(e_item),ord(next_status));
  biz_accounts.MakeDemotionNotification
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

function TClass_biz_emsof_requests.DeployCompleted: queue;
begin
  DeployCompleted := db_emsof_requests.DeployCompleted;
end;

function TClass_biz_emsof_requests.EmsofAnteOfItem
  (
  master_id: string;
  priority: string
  )
  : decimal;
begin
  EmsofAnteOfItem := db_emsof_requests.EmsofAnteOfItem(master_id,priority);
end;

function TClass_biz_emsof_requests.EquipmentCodeOf
  (
  master_id: string;
  priority: string
  )
  : string;
begin
  EquipmentCodeOf := db_emsof_requests.EquipmentCodeOf(master_id,priority);
end;

function TClass_biz_emsof_requests.FailUncompleted: queue;
begin
  FailUncompleted := db_emsof_requests.FailUncompleted;
end;

function TClass_biz_emsof_requests.FailUnfinalized: queue;
begin
  FailUnfinalized := db_emsof_requests.FailUnfinalized;
end;

procedure TClass_biz_emsof_requests.Finalize(master_id: string);
begin
  db_emsof_requests.Finalize(master_id);
end;

procedure TClass_biz_emsof_requests.ForceClosed(master_id: string);
begin
  db_emsof_requests.ForceClosed(master_id);
end;

procedure TClass_biz_emsof_requests.ForceOpen(master_id: string);
begin
  db_emsof_requests.ForceOpen(master_id);
  biz_accounts.IssueForcedOpenNotice(ServiceIdOfMasterId(master_id),SponsorRegionNameOf(master_id),CountyCodeOfMasterId(master_id));
end;

function TClass_biz_emsof_requests.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := db_emsof_requests.FyDesignatorOf(e_item);
end;

function TClass_biz_emsof_requests.HasWishList(master_id: string): boolean;
begin
  HasWishList := db_emsof_requests.HasWishList(master_id);
end;

function TClass_biz_emsof_requests.IdOf(e_item: system.object): string;
begin
  IdOf := db_emsof_requests.IdOf(e_item);
end;

function TClass_biz_emsof_requests.IdOfProofOfPayment(e_item: system.object): string;
begin
  IdOfProofOfPayment := db_emsof_requests.IdOfProofOfPayment(e_item);
end;

function TClass_biz_emsof_requests.LeftoverOrShortageOf(e_item: system.object): decimal;
begin
  LeftoverOrShortageOf := db_emsof_requests.LeftoverOrShortageOf(e_item);
end;

procedure TClass_biz_emsof_requests.MarkDone
  (
  e_item: system.object;
  promoter: string
  );
var
  master_id: string;
  next_status: status_type;
  reviewer_descriptor: string;
begin
  master_id := IdOf(e_item);
  reviewer_descriptor := SponsorRegionNameOf(master_id);
  case StatusOf(e_item) of
  NEEDS_SENT_TO_PA_DOH_EMSO:
    BEGIN
    next_status := NEEDS_PA_DOH_EMSO_APPROVAL;
    db_emsof_requests.MarkDone(IdOf(e_item),ord(next_status),biz_user.Kind);
    biz_accounts.MakePromotionNotification
      (
      EMPTY,
      reviewer_descriptor,
      system.object(next_status).tostring,
      ServiceIdOf(e_item),
      ServiceNameOf(e_item),
      FyDesignatorOf(e_item)
      );
    END;
  NEEDS_INVOICE_COLLECTION:
    BEGIN
    next_status := NEEDS_CANCELED_CHECK_COLLECTION;
    db_emsof_requests.RollUpActualValue(master_id);
    db_emsof_requests.MarkDone(master_id,ord(next_status),biz_user.Kind);
    biz_accounts.MakePromotionNotification
      (
      EMPTY,
      reviewer_descriptor,
      system.object(next_status).tostring,
      ServiceIdOf(e_item),
      ServiceNameOf(e_item),
      FyDesignatorOf(e_item),
      FALSE
      );
    END;
  NEEDS_CANCELED_CHECK_COLLECTION:
    BEGIN
    next_status := NEEDS_REIMBURSEMENT_ISSUANCE;
    db_emsof_requests.MarkDone(master_id,ord(next_status),biz_user.Kind);
    biz_accounts.MakePromotionNotification
      (
      'emsof-accountant',
      reviewer_descriptor,
      system.object(next_status).tostring,
      ServiceIdOf(e_item),
      ServiceNameOf(e_item),
      FyDesignatorOf(e_item),
      FALSE
      );
    END;
  NEEDS_REIMBURSEMENT_ISSUANCE:
    BEGIN
    if biz_milestones.BeProcessed(END_OF_CYCLE_MILESTONE) then begin
      next_status := DEPLOYED;
    end else begin
      next_status := REIMBURSEMENT_ISSUED;
    end;
    db_emsof_requests.MarkDone(master_id,ord(next_status),biz_user.Kind);
    END;
  end;
  //
end;

procedure TClass_biz_emsof_requests.MarkFailed
  (
  e_item: system.object;
  failer: string
  );
var
  master_id: string;
begin
  master_id := IdOf(e_item);
  //
  db_emsof_requests.MarkFailed(master_id);
  //
  case StatusOf(e_item) of
  NEEDS_INVOICE_COLLECTION:
    BEGIN
    db_emsof_requests.RollUpActualValue(master_id);
    biz_accounts.MakeDeadlineFailureNotification
      (
      SERVICE_INVOICE_SUBMISSION_DEADLINE_MILESTONE,
      ServiceIdOf(e_item),
      CountyCodeOfMasterId(master_id)
      );
    END;
  NEEDS_CANCELED_CHECK_COLLECTION:
    BEGIN
    biz_accounts.MakeDeadlineFailureNotification
      (
      SERVICE_CANCELED_CHECK_SUBMISSION_DEADLINE_MILESTONE,
      ServiceIdOf(e_item),
      CountyCodeOfMasterId(master_id)
      );
    END;
  end;
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
  NEEDS_PA_DOH_EMSO_APPROVAL:
    NextReviewer := 'Regional Council EMSOF Coordinator (for invoice collection)';
  end;
end;

function TClass_biz_emsof_requests.NumRequestsInStateExportBatch
  (
  status: status_type;
  amendment_num_string: string;
  regional_staffer_user_id: string
  )
  : cardinal;
begin
  NumRequestsInStateExportBatch := db_emsof_requests.NumRequestsInStateExportBatch
    (
    ord(status),
    amendment_num_string,
    biz_regional_staffers.RegionCodeOf(regional_staffer_user_id)
    );
end;

function TClass_biz_emsof_requests.PropertyNameOfAppropriation: string;
begin
  PropertyNameOfAppropriation := db_emsof_requests.PropertyNameOfAppropriation;
end;

function TClass_biz_emsof_requests.PropertyNameOfEmsofAnte: string;
begin
  PropertyNameOfEmsofAnte := db_emsof_requests.PropertyNameOfEmsofAnte;
end;

function TClass_biz_emsof_requests.BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation
  (
  region_dictated_appropriation_id: string
  )
  : boolean;
begin
  BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation :=
    db_emsof_requests.BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation(region_dictated_appropriation_id);
end;

function TClass_biz_emsof_requests.BeValidCountyApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
begin
  BeValidCountyApprovalTimestampOf := db_emsof_requests.BeValidCountyApprovalTimestampOf(master_id,timestamp);
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

function TClass_biz_emsof_requests.BeValidStateApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
begin
  BeValidStateApprovalTimestampOf := db_emsof_requests.BeValidStateApprovalTimestampOf(master_id,timestamp);
end;

function TClass_biz_emsof_requests.ReworkDeadline(e_item: system.object): datetime;
begin
  ReworkDeadline := db_emsof_requests.ReworkDeadline(e_item);
end;

function TClass_biz_emsof_requests.ServiceIdOf(e_item: system.object): string;
begin
  ServiceIdOf := db_emsof_requests.ServiceIdOf(e_item);
end;

function TClass_biz_emsof_requests.ServiceIdOfMasterId(master_id: string): string;
begin
  ServiceIdOfMasterId := db_emsof_requests.ServiceIdOfMasterId(master_id);
end;

function TClass_biz_emsof_requests.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := db_emsof_requests.ServiceNameOf(e_item);
end;

procedure TClass_biz_emsof_requests.SetActuals
  (
  master_id: string;
  priority: string;
  invoice_designator: string;
  quantity: string;
  subtotal_cost: string
  );
var
  county_dictum_id: string;
  item_status_code: cardinal;
  val2: decimal;
begin
  county_dictum_id := CountyDictumIdOf(master_id);
  if biz_equipment.BeMatchExempt
    (
    EquipmentCodeOf(master_id,priority),
    biz_match_level.EnumOfId(biz_appropriations.MatchLevelIdOf(county_dictum_id))
    )
  then begin
    val2 := decimal.Parse(subtotal_cost);
  end else begin
    val2 := decimal.Parse(subtotal_cost)*biz_appropriations.MatchFactorOf(county_dictum_id);
  end;
  if (decimal.Parse(quantity) > 0) and (decimal.Parse(subtotal_cost) > 0) then begin
    item_status_code := ord(REGION_NEEDS_PROOF_OF_PAYMENT);
  end else begin
    item_status_code := ord(REGION_NEEDS_INVOICE);
  end;
  db_emsof_requests.SetActuals
    (
    master_id,
    priority,
    invoice_designator,
    quantity,
    subtotal_cost,
    math.Min(EmsofAnteOfItem(master_id,priority),val2),
    item_status_code
    );
end;

procedure TClass_biz_emsof_requests.SetHasWishList
  (
  master_id: string;
  value: boolean
  );
begin
  db_emsof_requests.SetHasWishList(master_id,value);
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

procedure TClass_biz_emsof_requests.SubmitToState
  (
  Table_report: system.object;
  request_physical_path: string;
  status_of_interest: status_type;
  regional_staffer_user_id: string;
  amendment_num_string: string
  );
var
  body: string;
  qualifier: string;
  region_name: string;
begin
  body := 'Dear PA DOH EMSO EMSOF Coordinator,' + NEW_LINE
    + NEW_LINE
    + 'The attached Excel spreadsheet contains ';
  case status_of_interest of
  NEEDS_SENT_TO_PA_DOH_EMSO:
    BEGIN
    qualifier := 'fresh';
    body := body + 'new';
    END;
  NEEDS_PA_DOH_EMSO_APPROVAL:
    BEGIN
    qualifier := 'repeat';
    body := body + 'a RE-TRANSMISSION of'
    END;
  end;
  region_name := biz_regional_staffers.RegionNameOf(regional_staffer_user_id);
  body := body + ' EMSOF request items that have been approved by the Executive Director of ' + region_name + '.  Please process '
  + 'this report at your earliest convenience.' + NEW_LINE
  + NEW_LINE
  + 'Replies to this message will be addressed to the ' + region_name + ' EMSOF Coordinator.' + NEW_LINE
  + NEW_LINE
  + '-- ' + configurationmanager.AppSettings['application_name'];
  kix.SendControlAsAttachmentToEmailMessage
    (
    Table_report,
    path.GetDirectoryName(request_physical_path) + '/' + configurationmanager.appsettings['scratch_folder'] + '/'
    + 'WebEmsofDohExport-' + qualifier + HYPHEN + datetime.Now.tostring('yyyyMMddHHmmssf') + '.xls',
    biz_accounts.EmailTargetByRole('emsof-coordinator'),
    configurationmanager.AppSettings['state_report_to_target'],
    configurationmanager.AppSettings['state_report_cc_target'],
    'EMSOF requests from ' + region_name + ' region',
    body
    );
  if status_of_interest = NEEDS_SENT_TO_PA_DOH_EMSO then begin
    db_emsof_requests.MarkSubmittedToState
      (
      biz_regional_staffers.RegionCodeOf(regional_staffer_user_id),
      amendment_num_string,
      ord(NEEDS_SENT_TO_PA_DOH_EMSO),
      ord(NEEDS_PA_DOH_EMSO_APPROVAL)
      );
    db_appropriations.IncFundingRoundsGenerated(regional_staffer_user_id,amendment_num_string);
  end;
end;

function TClass_biz_emsof_requests.SusceptibleTo(milestone: milestone_type): queue;
begin
  SusceptibleTo := db_emsof_requests.SusceptibleTo(milestone);
end;

function TClass_biz_emsof_requests.SumOfActualValues(fy_id: string = ''): decimal;
begin
  if fy_id = EMPTY then begin
    SumOfActualValues := db_emsof_requests.SumOfActualValues
      (biz_user.Kind,biz_user.IdNum,TClass_biz_fiscal_years.Create.IdOfCurrent);
  end else begin
    SumOfActualValues := db_emsof_requests.SumOfActualValues(biz_user.Kind,biz_user.IdNum,fy_id);
  end;
end;

function TClass_biz_emsof_requests.SumOfActualCostsOfRequestItems(request_id: string): decimal;
begin
  SumOfActualCostsOfRequestItems := db_emsof_requests.SumOfActualCostsOfRequestItems(request_id);
end;

function TClass_biz_emsof_requests.SumOfProvenPaymentsOfRequest(request_id: string): decimal;
begin
  SumOfProvenPaymentsOfRequest := db_emsof_requests.SumOfProvenPaymentsOfRequest(request_id);
end;

function TClass_biz_emsof_requests.SumOfRequestValues(fy_id: string = ''): decimal;
begin
  if fy_id = EMPTY then begin
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

function TClass_biz_emsof_requests.TcciOfFullRequestActuals: cardinal;
begin
  TcciOfFullRequestActuals := db_emsof_requests.TcciOfFullRequestActuals;
end;

function TClass_biz_emsof_requests.TcciOfFullRequestPriority: cardinal;
begin
  TcciOfFullRequestPriority := db_emsof_requests.TcciOfFullRequestPriority;
end;

function TClass_biz_emsof_requests.TcciOfPasswordResetEmailAddress: cardinal;
begin
  TcciOfPasswordResetEmailAddress := db_emsof_requests.TcciOfPasswordResetEmailAddress;
end;

function TClass_biz_emsof_requests.TcciOfServiceName: cardinal;
begin
  TcciOfServiceName := db_emsof_requests.TcciOfServiceName;
end;

function TClass_biz_emsof_requests.TcciOfLeftoverOrShortage: cardinal;
begin
  TcciOfLeftoverOrShortage := db_emsof_requests.TcciOfLeftoverOrShortage;
end;

function TClass_biz_emsof_requests.TcciOfSrrReplacementRowIndicator: cardinal;
begin
  TcciOfSrrReplacementRowIndicator := db_emsof_requests.TcciOfSrrReplacementRowIndicator;
end;

function TClass_biz_emsof_requests.TcciOfStatusCode: cardinal;
begin
  TcciOfStatusCode := db_emsof_requests.TcciOfStatusCode;
end;

function TClass_biz_emsof_requests.TcciOfStatusDescription: cardinal;
begin
  TcciOfStatusDescription := db_emsof_requests.TcciOfStatusDescription;
end;

procedure TClass_biz_emsof_requests.Unreject
  (
  e_item: system.object;
  role: string;
  reviewer_descriptor: string
  );
begin
  db_emsof_requests.Unreject(IdOf(e_item));
  biz_accounts.MakeUnrejectionNotification
    (
    role,
    reviewer_descriptor,
    ServiceIdOf(e_item),
    ServiceNameOf(e_item),
    FyDesignatorOf(e_item),
    SponsorCountyCodeOf(e_item)
    );
end;

procedure TClass_biz_emsof_requests.Withdraw(master_id: string);
begin
  biz_accounts.IssueWithdrawalNotice(master_id,ServiceIdOfMasterId(master_id),CountyCodeOfMasterId(master_id));
  db_emsof_requests.Withdraw(master_id);
end;

end.
