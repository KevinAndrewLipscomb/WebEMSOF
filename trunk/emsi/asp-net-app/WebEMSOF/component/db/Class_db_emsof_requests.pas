unit Class_db_emsof_requests;

interface

uses
  kix,
  mysql.data.mysqlclient,
  Class_biz_milestones,
  Class_db,
  Class_db_fiscal_years,
  Class_db_trail,
  system.collections,
  System.Web.UI.WebControls;

type
  approval_timestamp_column_type =
    (
    NONE,
    COUNTY,
    REGIONAL_PLANNER,
    REGIONAL_DIRECTOR,
    STATE
    );
  TClass_db_emsof_requests = class(Class_db.TClass_db)
  private
    db_fiscal_years: TClass_db_fiscal_years;
    db_trail: TClass_db_trail;
    procedure BindOverview
      (
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object;
      where_parm: string = '';
      and_parm: string = ''
      );
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
      master_id: string;
      next_status: cardinal;
      user_kind: string;
      approval_timestamp_column: approval_timestamp_column_type;
      amount_to_return_to_county: decimal = 0
      );
    function ArchiveMatured: queue;
    function BeDeadlineExempt(master_id: string): boolean;
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
    procedure BindDetail
      (
      master_id: string;
      target: system.object
      );
    procedure BindEquipmentProcurementOverview
      (
      fy_id: string;
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
      status: cardinal;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindOverviewByStatus
      (
      status: cardinal;
      order_by_field_name: string;
      be_order_ascending: boolean;
      target: system.object;
      show_all_cycles: boolean = FALSE
      );
    procedure BindProofsOfPayment
      (
      request_id: string;
      target: system.object
      );
    procedure BindStateExportBatch
      (
      target: system.object;
      status: cardinal;
      amendment_num_string: string;
      region_code: string
      );
    function CountyApprovalTimestampOf(master_id: string): datetime;
    function CountyCodeOfMasterId(master_id: string): string;
    function CountyDictumIdOf(master_id: string): string;
    procedure DeleteProofOfPayment(id: string);
    procedure Demote
      (
      master_id: string;
      next_status: cardinal
      );
    function DetailText(master_id: string): string;
    function DeployCompleted: queue;
    function EmsofAnteOf(master_id: string): decimal;
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
      master_id: string;
      next_status: cardinal;
      user_kind: string
      );
    procedure MarkFailed(master_id: string);
    procedure MarkSubmittedToState
      (
      region_code: string;
      amendment_num_string: string;
      current_status: cardinal;
      next_status: cardinal
      );
    function NumRequestsInStateExportBatch
      (
      status: cardinal;
      amendment_num_string: string;
      region_code: string
      )
      : cardinal;
    function PropertyNameOfAppropriation: string;
    function PropertyNameOfEmsofAnte: string;
    function ReworkDeadline(e_item: system.object): datetime;
    procedure RollUpActualValue(master_id: string);
    function ServiceIdOf(e_item: system.object): string;
    function ServiceIdOfMasterId(master_id: string): string;
    function ServiceNameOf(e_item: system.object): string;
    procedure SetActuals
      (
      master_id: string;
      priority: string;
      invoice_designator: string;
      quantity: string;
      subtotal_cost: string;
      emsof_ante: decimal;
      item_status_code: cardinal
      );
    procedure SetHasWishList
      (
      master_id: string;
      value: boolean
      );
    function SponsorCountyCodeOf(e_item: system.object): string;
    function SponsorCountyNameOf(e_item: system.object): string;
    function SponsorRegionNameOf(master_id: string): string;
    function StatusCodeOf(e_item: system.object): cardinal;
    function SumOfActualCostsOfRequestItems(request_id: string): decimal;
    function SumOfActualValues
      (
      user_kind: string;
      user_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfProvenPaymentsOfRequest(request_id: string): decimal;
    function SumOfRequestValues
      (
      user_kind: string;
      user_id: string;
      fy_id: string
      )
      : decimal;
    function SusceptibleTo(milestone: milestone_type): queue;
    function TallyByStatus(status: cardinal): cardinal;
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
    procedure Unreject(master_id: string);
    procedure Withdraw(master_id: string);
  end;

implementation

const
  FULL_REQUEST_REVIEW_APPROVE_SELECT_FROM_EXPRESSION = 'select emsof_request_master.id' // column 0
  + ' , service.id as service_id'                                                       // column 1
  + ' , service.affiliate_num'                                                          // column 2
  + ' , service.name as service_name'                                                   // column 3
  + ' , county_code_name_map.code as county_code'                                       // column 4
  + ' , county_code_name_map.name as sponsor_county'                                    // column 5
  + ' , fiscal_year.designator as fiscal_year_designator'                               // column 6
  + ' , emsof_request_master.value as emsof_ante'                                       // column 7
  + ' , county_dictated_appropriation.amount as appropriation'                          // column 8
  + ' , if((county_dictated_appropriation.amount > emsof_request_master.value),(county_dictated_appropriation.amount - emsof_request_master.value),(-emsof_request_master.shortage)) as leftover_or_shortage'
                                                                                        // column 9
  + ' , if(has_wish_list,"YES","no") as has_wish_list'                                  // column 10
  + ' , password_reset_email_address'                                                   // column 11
  + ' , status_code'                                                                    // column 12
  + ' , request_status_code_description_map.description as status_description'          // column 13
  + ' from emsof_request_master'
  +   ' join county_dictated_appropriation'
  +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
  +   ' join region_dictated_appropriation'
  +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
  +   ' join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)'
  +   ' join service on (service.id=county_dictated_appropriation.service_id)'
  +   ' join service_user on (service_user.id=service.id)'
  +   ' join state_dictated_appropriation'
  +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
  +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
  +   ' join request_status_code_description_map on (request_status_code_description_map.code=status_code)';
  MAX_FULL_REQUEST_REVIEW_APPROVE_DGI_INDEX = 13;
  //
  TCCI_ID = 0;
  TCCI_SERVICE_ID = 1;
  TCCI_AFFILIATE_NUM = 2;
  TCCI_SERVICE_NAME = 3;
  TCCI_SPONSOR_COUNTY_ID = 4;
  TCCI_SPONSOR_COUNTY_NAME = 5;
  TCCI_FISCAL_YEAR_DESIGNATOR = 6;
  TCCI_EMSOF_ANTE = 7;
  TCCI_APPROPRIATION = 8;
  TCCI_LEFTOVER_OR_SHORTAGE = 9;
  TCCI_HAS_WISH_LIST = 10;
  TCCI_PASSWORD_RESET_EMAIL_ADDRESS = 11;
  TCCI_STATUS_CODE = 12;
  TCCI_STATUS_DESCRIPTION = 13;
  //
  TCCI_FULL_REQUEST_PRIORITY = 0;
  TCCI_FULL_REQUEST_ACTUALS = 2;
  //
  TCCI_PROOF_OF_PAYMENT_ID = 0;
  //
  TCCI_SRR_REPLACEMENT_ROW_INDICATOR = 1;

procedure TClass_db_emsof_requests.BindOverview
  (
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object;
  where_parm: string = '';
  and_parm: string = ''
  );
var
  cmdText: string;
  where_clause: string;
begin
  if where_parm = EMPTY then begin
    where_clause := EMPTY;
  end else begin
    where_clause := 'where ' + where_parm;
    if and_parm <> EMPTY then begin
      where_clause := where_clause + ' and ' + and_parm;
    end;
  end;
  cmdText := FULL_REQUEST_REVIEW_APPROVE_SELECT_FROM_EXPRESSION + where_clause + ' order by ' + order_by_field_name;
  if be_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  self.Open;
  DataGrid(target).datasource := mysqlcommand.Create(cmdText,connection).ExecuteReader;
  DataGrid(target).DataBind;
  mysqldatareader(DataGrid(target).datasource).Close;
  self.Close;
end;

constructor TClass_db_emsof_requests.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_trail := TClass_db_trail.Create;
  db_fiscal_years := TClass_db_fiscal_years.Create;
end;

function TClass_db_emsof_requests.ActualValueOf(master_id: string): decimal;
begin
  self.Open;
  ActualValueOf := decimal
    (mysqlcommand.Create('select actual_value from emsof_request_master where id = ' + master_id,connection).ExecuteScalar);
  self.Close;
end;

procedure TClass_db_emsof_requests.AddProofOfPayment
  (
  request_id: string;
  date_of_payment: datetime;
  method_code: string;
  amount: decimal;
  note: string
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'insert into emsof_purchase_payment'
      + ' set master_id = ' + request_id
      +   ' , date_of = "' + date_of_payment.tostring('yyyy-MM-dd') + '"'
      +   ' , method_code = ' + method_code
      +   ' , amount = ' + amount.tostring
      +   ' , note = "' + note + '"'
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.AffiliateNumOf(e_item: system.object): string;
begin
  AffiliateNumOf := Safe(DataGridItem(e_item).cells[TCCI_AFFILIATE_NUM].text,NUM);
end;

procedure TClass_db_emsof_requests.Approve
  (
  master_id: string;
  next_status: cardinal;
  user_kind: string;
  approval_timestamp_column: approval_timestamp_column_type;
  amount_to_return_to_county: decimal = 0
  );
var
  cmdText: string;
begin
  if approval_timestamp_column <> NONE then begin
    cmdText := EMPTY;
    if (amount_to_return_to_county > 0) or (user_kind = 'state-staffer') or (next_status = 8) then begin
      cmdText := 'START TRANSACTION; ';
    end;
    cmdText := cmdText
    + ' update emsof_request_master'
    + ' set status_code = ' + next_status.tostring
    +   ' , ' + system.object(approval_timestamp_column).tostring + '_approval_timestamp = now()';
    if next_status = 8 then begin
      cmdText := cmdText
      + ' , be_reopened_after_going_to_state = FALSE';
    end;
    cmdText := cmdText
    + ' where id = ' + master_id
    + '; ';
    if next_status = 8 then begin
      cmdText := cmdText
      + 'update emsof_request_detail'
      + ' set status_code = 2'
      + ' where master_id = ' + master_id
      + '; ';
    end;
    if amount_to_return_to_county > 0 then begin
      cmdText := cmdText
      + ' update county_dictated_appropriation'
      + ' set amount = amount - ' + amount_to_return_to_county.tostring
      + ' where id = '
      +   ' ('
      +   ' select county_dictated_appropriation_id'
      +   ' from emsof_request_master'
      +   ' where emsof_request_master.id = ' + master_id
      +   ' ); ';
    end;
    if (amount_to_return_to_county > 0) or (user_kind = 'state-staffer') or (next_status = 8) then begin
      cmdText := cmdText + ' COMMIT;';
    end;
    self.Open;
    mysqlcommand.Create(db_trail.Saved(cmdText),connection).ExecuteNonQuery;
    self.Close;
  end;
end;

function TClass_db_emsof_requests.ArchiveMatured: queue;
var
  id_q: queue;
  join_clause: string;
  where_deployed_clause: string;
begin
  id_q := queue.Create;
  join_clause := ' emsof_request_master'
  + ' join emsof_request_detail on'
    + ' (emsof_request_detail.master_id=emsof_request_master.id)'
  + ' join eligible_provider_equipment_list on'
    + ' (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)';
  where_deployed_clause := ' where emsof_request_master.status_code = 14';
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update' + join_clause
      + ' set emsof_request_master.status_code = 15'
      + where_deployed_clause
        + ' and emsof_request_master.id not in'
          + ' ('
          + ' select distinct emsof_request_master.id'
          + ' from ' + join_clause
            + where_deployed_clause
            + ' and ISNULL(life_expectancy_years)'
          + ' )'
        + ' and state_approval_timestamp + INTERVAL life_expectancy_years YEAR < CURDATE()'
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
  ArchiveMatured := id_q;
end;

function TClass_db_emsof_requests.BeDeadlineExempt(master_id: string): boolean;
begin
  self.Open;
  BeDeadlineExempt := '1' = mysqlcommand.Create
    (
    'select be_deadline_exempt from emsof_request_master where id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation
  (
  region_dictated_appropriation_id: string
  )
  : boolean;
begin
  self.Open;
  BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation := '0' < mysqlcommand.Create
    (
    'select count(*) from emsof_request_master'
    + ' join county_dictated_appropriation'
    +   ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' where status_code = 11'
    +   ' and region_dictated_appropriation_id = ' + region_dictated_appropriation_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.BeValidCountyApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  dr := mysqlcommand.Create
    ('select county_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
    .ExecuteReader;
  dr.Read;
  if dr.IsDbNull(0) then begin
    BeValidCountyApprovalTimestampOf := FALSE;
  end else begin
    BeValidCountyApprovalTimestampOf := TRUE;
    timestamp := datetime(dr['county_approval_timestamp']);
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_emsof_requests.BeValidRegionalExecDirApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  dr := mysqlcommand.Create
    ('select regional_director_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
    .ExecuteReader;
  dr.Read;
  if dr.IsDbNull(0) then begin
    BeValidRegionalExecDirApprovalTimestampOf := FALSE;
  end else begin
    BeValidRegionalExecDirApprovalTimestampOf := TRUE;
    timestamp := datetime(dr['regional_director_approval_timestamp']);
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_emsof_requests.BeValidRegionalPlannerApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  dr := mysqlcommand.Create
    ('select regional_planner_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
    .ExecuteReader;
  dr.Read;
  if dr.IsDbNull(0) then begin
    BeValidRegionalPlannerApprovalTimestampOf := FALSE;
  end else begin
    BeValidRegionalPlannerApprovalTimestampOf := TRUE;
    timestamp := datetime(dr['regional_planner_approval_timestamp']);
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_emsof_requests.BeValidStateApprovalTimestampOf
  (
  master_id: string;
  out timestamp: datetime
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  dr := mysqlcommand.Create
    ('select state_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
    .ExecuteReader;
  dr.Read;
  if dr.IsDbNull(0) then begin
    BeValidStateApprovalTimestampOf := FALSE;
  end else begin
    BeValidStateApprovalTimestampOf := TRUE;
    timestamp := datetime(dr['state_approval_timestamp']);
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_emsof_requests.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  self.Open;
  DataGrid(target).datasource := mysqlcommand.Create
    (
    'select priority'
    + ' ,make_model'
    + ' ,if(be_refurbished,"(refurbished)","") as be_refurbished'
    + ' ,description as category'
    + ' ,place_kept'
    + ' ,quantity'
    + ' ,unit_cost'
    + ' ,(quantity*unit_cost) as subtotal'
    + ' ,allowable_cost'
    + ' ,emsof_ante'
    + ' ,invoice_designator'
    + ' ,actual_quantity'
    + ' ,actual_subtotal_cost'
    + ' ,actual_emsof_ante'
    + ' from emsof_request_detail'
    +   ' join eligible_provider_equipment_list'
    +     ' on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    + ' where master_id = ' + master_id
    + ' order by priority',
    connection
    )
    .ExecuteReader;
  DataGrid(target).DataBind;
  self.Close;
end;

procedure TClass_db_emsof_requests.BindEquipmentProcurementOverview
  (
  fy_id: string;
  target: system.object
  );
begin
  self.Open;
  GridView(target).datasource := mysqlcommand.Create
    (
    'select description'
    + ' , sum(actual_quantity) as quantity'
    + ' , sum(actual_emsof_ante) as emsof_part'
    + ' , sum(actual_subtotal_cost) as overall_cost'
    + ' , (sum(actual_subtotal_cost)/sum(actual_quantity)) as avg_unit_cost'
    + ' from emsof_request_detail'
      + ' join eligible_provider_equipment_list on'
        + ' (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
      + ' join fiscal_year on'
        + ' (fiscal_year.id=eligible_provider_equipment_list.fiscal_year_id)'
    + ' where fiscal_year_id = "' + fy_id + '"'
    + ' group by eligible_provider_equipment_list.code'
    + ' order by emsof_part desc',
    connection
    )
    .ExecuteReader;
  GridView(target).DataBind;
  self.Close;
end;

procedure TClass_db_emsof_requests.BindOverviewAll
  (
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  BindOverview(order_by_field_name,be_order_ascending,target,'fiscal_year.id = "' + db_fiscal_years.IdOfCurrent + '"');
end;

procedure TClass_db_emsof_requests.BindOverviewByRegionDictatedAppropriation
  (
  region_dictated_appropriation_id: string;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  BindOverview
    (order_by_field_name,be_order_ascending,target,'region_dictated_appropriation_id = ' + region_dictated_appropriation_id);
end;

procedure TClass_db_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus
  (
  region_dictated_appropriation_id: string;
  status: cardinal;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  BindOverview
    (
    order_by_field_name,
    be_order_ascending,
    target,
    'region_dictated_appropriation_id = ' + region_dictated_appropriation_id,
    'status_code = ' + status.tostring
    );
end;

procedure TClass_db_emsof_requests.BindOverviewByStatus
  (
  status: cardinal;
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object;
  show_all_cycles: boolean = FALSE
  );
var
  and_parm: string;
begin
  if show_all_cycles then begin
    and_parm := EMPTY;
  end else begin
    and_parm := 'fiscal_year.id = "' + db_fiscal_years.IdOfCurrent + '"';
  end;
  BindOverview(order_by_field_name,be_order_ascending,target,'status_code = ' + status.tostring,and_parm);
end;

procedure TClass_db_emsof_requests.BindProofsOfPayment
  (
  request_id: string;
  target: system.object
  );
begin
  self.Open;
  DataGrid(target).datasource := mysqlcommand.Create
    (
    'select id'                                       // column 0
    + ' , DATE_FORMAT(date_of,"%Y-%m-%d") as date_of' // column 1
    + ' , description as method'                      // column 2
    + ' , amount'                                     // column 3
    + ' , note'                                       // column 4
    + ' from emsof_purchase_payment'
    +   ' join payment_proof_method_code_description_map'
    +     ' on (payment_proof_method_code_description_map.code=emsof_purchase_payment.method_code)'
    + ' where master_id = ' + request_id
    + ' order by date_of asc',
    connection
    )
    .ExecuteReader;
  DataGrid(target).DataBind;
  mysqldatareader(DataGrid(target).datasource).Close;
  self.Close;
end;

procedure TClass_db_emsof_requests.BindStateExportBatch
  (
  target: system.object;
  status: cardinal;
  amendment_num_string: string;
  region_code: string
  );
begin
  self.Open;
  DataGrid(target).datasource := mysqlcommand.Create
    (
    'select concat("W",master_id) as w_num'                                                // column 0
    + ' , if(be_reopened_after_going_to_state,"*","") as be_reopened_after_going_to_state' // column 1
    + ' , service.name as service_name'                                                    // column 2
    + ' , if((be_als_amb or be_als_squad or be_air_amb),"ALS",if(be_bls_amb,"BLS",if(be_rescue,"RESCUE","QRS")))'
    +     ' as life_support_level'                                                         // column 3
    + ' , description as equipment_description'                                            // column 4
    + ' , quantity'                                                                        // column 5
    + ' , unit_cost'                                                                       // column 6
    + ' , quantity*unit_cost as total_cost'                                                // column 7
    + ' , emsof_ante'                                                                      // column 8
    + ' , (quantity*unit_cost - emsof_ante) as provider_match'                             // column 9
    + ' , "YES" as recommendation'                                                         // column 10
    + ' from emsof_request_detail'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join service on (service.id=county_dictated_appropriation.service_id)'
    +   ' join eligible_provider_equipment_list'
    +     ' on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
    + ' where emsof_request_master.status_code = ' + status.tostring
    +   ' and quantity > 0'
    +   ' and amendment_num = ' + amendment_num_string
    +   ' and region_code = ' + region_code
    + ' order by service_name',
    connection
    )
    .ExecuteReader;
  DataGrid(target).DataBind;
  self.Close;
end;

function TClass_db_emsof_requests.CountyApprovalTimestampOf(master_id: string): datetime;
begin
  self.Open;
  CountyApprovalTimestampOf := datetime
    (
    mysqlcommand.Create
      ('select county_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
      .ExecuteScalar
    );
  self.Close;
end;

function TClass_db_emsof_requests.CountyCodeOfMasterId(master_id: string): string;
begin
  self.Open;
  CountyCodeOfMasterId := mysqlcommand.Create
    (
    'select county_code'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    + ' where emsof_request_master.id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.CountyDictumIdOf(master_id: string): string;
begin
  self.Open;
  CountyDictumIdOf := mysqlcommand.Create
    (
    'select county_dictated_appropriation_id'
    + ' from emsof_request_master'
    + ' where id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

procedure TClass_db_emsof_requests.DeleteProofOfPayment(id: string);
begin
  self.Open;
  mysqlcommand.Create(db_trail.Saved('delete from emsof_purchase_payment where id = ' + id),connection).ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.Demote
  (
  master_id: string;
  next_status: cardinal
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_master'
      + ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      + ' set emsof_request_master.status_code = ' + next_status.tostring
      + ' where emsof_request_master.id = ' + master_id
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.DetailText(master_id: string): string;
var
  dr: mysqldatareader;
  detail_text: string;
begin
  detail_text := EMPTY;
  self.Open;
  dr := mysqlcommand.Create
    (
    'select priority'
    + ' , description'
    + ' , make_model'
    + ' , place_kept'
    + ' , if(be_refurbished,"REFURB","NEW") as new_or_refurb'
    + ' , quantity'
    + ' , concat("$",format(unit_cost,2)) as formatted_unit_cost'
    + ' , concat("$",format(emsof_ante,2)) as formatted_emsof_ante'
    + ' from emsof_request_detail'
    +   ' join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
    + ' where master_id = ' + master_id
    + ' order by priority',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    detail_text := detail_text
    + 'Priority:          ' + dr['priority'].tostring + NEW_LINE
    + 'Description:       ' + dr['description'].tostring + NEW_LINE
    + 'Make/model:        ' + dr['make_model'].tostring + NEW_LINE
    + 'Place to be kept:  ' + dr['place_kept'].tostring + NEW_LINE
    + 'New/refurb:        ' + dr['new_or_refurb'].tostring + NEW_LINE
    + 'Quantity:          ' + dr['quantity'].tostring + NEW_LINE
    + 'Unit cost:         ' + dr['formatted_unit_cost'].tostring + NEW_LINE
    + 'Max EMSOF amount:  ' + dr['formatted_emsof_ante'].tostring + NEW_LINE
    + NEW_LINE;
  end;
  dr.Close;
  self.Close;
  DetailText := detail_text;
end;

function TClass_db_emsof_requests.DeployCompleted: queue;
var
  id_q: queue;
begin
  id_q := queue.Create;
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved('update emsof_request_master set status_code = 14 where status_code = 13'),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
  DeployCompleted := id_q;
end;

function TClass_db_emsof_requests.EmsofAnteOf(master_id: string): decimal;
begin
  self.Open;
  EmsofAnteOf := decimal
    (
    mysqlcommand.Create
      ('select value from emsof_request_master where id = ' + master_id,connection)
      .ExecuteScalar
    );
  self.Close;
end;

function TClass_db_emsof_requests.EmsofAnteOfItem
  (
  master_id: string;
  priority: string
  )
  : decimal;
begin
  self.Open;
  EmsofAnteOfItem := decimal
    (
    mysqlcommand.Create
      (
      'select emsof_ante'
      + ' from emsof_request_detail'
      + ' where master_id = ' + master_id
      +   ' and priority = ' + priority,
      connection
      )
      .ExecuteScalar
    );
  self.Close;
end;

function TClass_db_emsof_requests.EquipmentCodeOf
  (
  master_id: string;
  priority: string
  )
  : string;
begin
  self.Open;
  EquipmentCodeOf := mysqlcommand.Create
    (
    'select equipment_code'
    + ' from emsof_request_detail'
    + ' where master_id = ' + master_id
    +   ' and priority = ' + priority,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.FailUncompleted: queue;
var
  dr: mysqldatareader;
  id_q: queue;
  transaction: mysqltransaction;
begin
  id_q := queue.Create;
  self.Open;
  transaction := connection.BeginTransaction;
  try
    dr := mysqlcommand.Create('select id from emsof_request_master where status_code < 10',connection,transaction).ExecuteReader;
    while dr.Read do begin
      id_q.Enqueue(dr['id']);
    end;
    dr.Close;
    mysqlcommand.Create
      (
      db_trail.Saved('update emsof_request_master set status_code = 16 where status_code < 10'),
      connection,
      transaction
      )
      .ExecuteNonQuery;
    transaction.Commit;
  except
    transaction.Rollback;
    raise;
  end;
  self.Close;
  FailUncompleted := id_q;
end;

function TClass_db_emsof_requests.FailUnfinalized: queue;
var
  dr: mysqldatareader;
  id_q: queue;
  transaction: mysqltransaction;
begin
  id_q := queue.Create;
  self.Open;
  transaction := connection.BeginTransaction;
  try
    dr := mysqlcommand.Create('select id from emsof_request_master where status_code < 3',connection,transaction).ExecuteReader;
    while dr.Read do begin
      id_q.Enqueue(dr['id']);
    end;
    dr.Close;
    mysqlcommand.Create
      (
      db_trail.Saved('update emsof_request_master set status_code = 16 where status_code < 3'),
      connection,
      transaction
      )
      .ExecuteNonQuery;
    transaction.Commit;
  except
    transaction.Rollback;
    raise;
  end;
  self.Close;
  FailUnfinalized := id_q;
end;

procedure TClass_db_emsof_requests.Finalize(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (db_trail.Saved('update emsof_request_master set status_code = 3 where id = ' + master_id),connection)
    .ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.ForceClosed(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved('update emsof_request_master set be_deadline_exempt = FALSE where id = ' + master_id),connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.ForceOpen(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'START TRANSACTION;'
      + ' update emsof_request_master'
      +   ' set status_code = 2'
      +     ' , be_deadline_exempt = TRUE'
      +     ' , be_reopened_after_going_to_state = TRUE'
      +   ' where id = ' + master_id
      + ';'
      + ' update emsof_request_detail'
      +   ' set status_code = 1'
      +     ' , invoice_designator = ""'
      +     ' , actual_quantity = 0'
      +     ' , actual_subtotal_cost = 0'
      +     ' , actual_emsof_ante = 0'
      +   ' where master_id = ' + master_id
      + ';'
      + ' delete from emsof_purchase_payment where master_id = ' + master_id
      + ';'
      + ' COMMIT'
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := Safe(DataGridItem(e_item).cells[TCCI_FISCAL_YEAR_DESIGNATOR].text,ALPHANUM);
end;

function TClass_db_emsof_requests.HasWishList(master_id: string): boolean;
begin
  self.Open;
  HasWishList := '1' = mysqlcommand.Create
    (
    'select has_wish_list from emsof_request_master where id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.IdOf(e_item: system.object): string;
begin
  IdOf := Safe(DataGridItem(e_item).cells[TCCI_ID].text,NUM);
end;

function TClass_db_emsof_requests.IdOfProofOfPayment(e_item: system.object): string;
begin
  IdOfProofOfPayment := Safe(DataGridItem(e_item).cells[TCCI_PROOF_OF_PAYMENT_ID].text,NUM);
end;

function TClass_db_emsof_requests.LeftoverOrShortageOf(e_item: system.object): decimal;
var
  safe_string: string;
begin
  safe_string := Safe(DataGridItem(e_item).cells[TCCI_LEFTOVER_OR_SHORTAGE].text,REAL_NUM_INCLUDING_NEGATIVE);
  if safe_string = EMPTY then begin
    LeftoverOrShortageOf := 0;
  end else begin
    LeftoverOrShortageOf := decimal.Parse(safe_string);
  end;
end;

procedure TClass_db_emsof_requests.MarkDone
  (
  master_id: string;
  next_status: cardinal;
  user_kind: string
  );
var
  cmdText: string;
begin
  cmdText := 'update emsof_request_master set status_code = ' + next_status.tostring + ' where id = ' + master_id;
  if (user_kind = 'state-staffer') then begin
    cmdText :=
    'START TRANSACTION; '
    + cmdText + ';'
    + ' update emsof_request_detail set status_code = 2 where master_id = ' + master_id + ' and status_code = 1;'
    + ' COMMIT';
  end;
  self.Open;
  mysqlcommand.Create(db_trail.Saved(cmdText),connection).ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.MarkFailed(master_id: string);
begin
  self.Open;
  mysqlcommand.Create(db_trail.Saved('update emsof_request_master set status_code = 16 where id = ' + master_id),connection).ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.MarkSubmittedToState
  (
  region_code: string;
  amendment_num_string: string;
  current_status: cardinal;
  next_status: cardinal
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_master'
      + ' join county_dictated_appropriation'
      +   ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      + ' join region_dictated_appropriation'
      +   ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      + ' join state_dictated_appropriation'
      +   ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' set status_code = ' + next_status.tostring
      + ' where region_code = ' + region_code
      +   ' and amendment_num = ' + amendment_num_string
      +   ' and status_code = ' + current_status.tostring
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.NumRequestsInStateExportBatch
  (
  status: cardinal;
  amendment_num_string: string;
  region_code: string
  )
  : cardinal;
begin
  self.Open;
  NumRequestsInStateExportBatch := mysqlcommand.Create
    (
    'select count(*)'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where status_code = ' + status.tostring
    +   ' and value > 0'
    +   ' and amendment_num = ' + amendment_num_string
    +   ' and region_code = ' + region_code,
    connection
    )
    .ExecuteScalar.GetHashCode;
  self.Close;
end;

function TClass_db_emsof_requests.PropertyNameOfAppropriation: string;
begin
  PropertyNameOfAppropriation := 'appropriation';
end;

function TClass_db_emsof_requests.PropertyNameOfEmsofAnte: string;
begin
  PropertyNameOfEmsofAnte := 'emsof_ante';
end;

function TClass_db_emsof_requests.ReworkDeadline(e_item: system.object): datetime;
begin
  self.Open;
  ReworkDeadline := datetime
    (
    mysqlcommand.Create
      (
      'select service_to_county_submission_deadline'
      + ' from region_dictated_appropriation'
      +   ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.region_dictated_appropriation_id=region_dictated_appropriation.id)'
      +   ' join emsof_request_master on (emsof_request_master.county_dictated_appropriation_id=county_dictated_appropriation.id)'
      + ' where emsof_request_master.id = ' + IdOf(e_item),
      connection
      )
      .ExecuteScalar
    );
  self.Close;
end;

procedure TClass_db_emsof_requests.RollUpActualValue(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_master'
      + ' set actual_value = (select sum(actual_emsof_ante) from emsof_request_detail where master_id = ' + master_id + ')'
      + ' where id = ' + master_id
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.ServiceIdOf(e_item: system.object): string;
begin
  ServiceIdOf := Safe(DataGridItem(e_item).cells[TCCI_SERVICE_ID].text,NUM);
end;

function TClass_db_emsof_requests.ServiceIdOfMasterId(master_id: string): string;
begin
  self.Open;
  ServiceIdOfMasterId := mysqlcommand.Create
    (
    'select service_id'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' where emsof_request_master.id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := Safe(DataGridItem(e_item).cells[TCCI_SERVICE_NAME].text,ORG_NAME);
end;

procedure TClass_db_emsof_requests.SetActuals
  (
  master_id: string;
  priority: string;
  invoice_designator: string;
  quantity: string;
  subtotal_cost: string;
  emsof_ante: decimal;
  item_status_code: cardinal
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_detail'
      + ' set invoice_designator = "' + invoice_designator + '"'
      + ' , actual_quantity = ' + quantity
      + ' , actual_subtotal_cost = ' + subtotal_cost
      + ' , actual_emsof_ante = ' + emsof_ante.tostring
      + ' , status_code = ' + item_status_code.tostring
      + ' where master_id = ' + master_id
      +   ' and priority = ' + priority
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.SetHasWishList
  (
  master_id: string;
  value: boolean
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_master'
      + ' set has_wish_list = ' + value.tostring
      + ' where id = ' + master_id
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

function TClass_db_emsof_requests.SponsorCountyCodeOf(e_item: system.object): string;
begin
  SponsorCountyCodeOf := Safe(DataGridItem(e_item).cells[TCCI_SPONSOR_COUNTY_ID].text,NUM);
end;

function TClass_db_emsof_requests.SponsorCountyNameOf(e_item: system.object): string;
begin
  SponsorCountyNameOf := Safe(DataGridItem(e_item).cells[TCCI_SPONSOR_COUNTY_NAME].text,ALPHA);
end;

function TClass_db_emsof_requests.SponsorRegionNameOf(master_id: string): string;
begin
  self.Open;
  SponsorRegionNameOf := mysqlcommand.Create
    (
    'select name'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join region_code_name_map on (region_code_name_map.code=state_dictated_appropriation.region_code)'
    + ' where emsof_request_master.id = ' + master_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_emsof_requests.StatusCodeOf(e_item: system.object): cardinal;
begin
  StatusCodeOf := convert.ToInt16(Safe(DataGridItem(e_item).cells[TCCI_STATUS_CODE].text,NUM));
end;

function TClass_db_emsof_requests.SumOfActualCostsOfRequestItems(request_id: string): decimal;
var
  sum_of_actual_costs_of_request_items_obj: system.object;
begin
  self.Open;
  sum_of_actual_costs_of_request_items_obj := mysqlcommand.Create
    (
    'select sum(actual_subtotal_cost) from emsof_request_detail where master_id = ' + request_id,
    connection
    )
    .ExecuteScalar;
  self.Close;
  if sum_of_actual_costs_of_request_items_obj <> dbnull.value then begin
    SumOfActualCostsOfRequestItems := decimal(sum_of_actual_costs_of_request_items_obj);
  end else begin
    SumOfActualCostsOfRequestItems := 0;
  end;
end;

function TClass_db_emsof_requests.SumOfActualValues
  (
  user_kind: string;
  user_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
  sum_obj: system.object;
begin
  if user_kind = 'regional_staffer' then begin
    cmdText := 'select sum(actual_value)'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
    + ' where regional_staffer.id = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id;
  end else if user_kind = 'county' then begin
    cmdText := 'select sum(actual_value)'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where county_code = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id;
  end;
  self.Open;
  sum_obj := mysqlcommand.Create(cmdText,connection).ExecuteScalar;
  self.Close;
  if sum_obj <> dbnull.value then begin
    SumOfActualValues := decimal(sum_obj);
  end else begin
    SumOfActualValues := 0;
  end;
end;

function TClass_db_emsof_requests.SumOfProvenPaymentsOfRequest(request_id: string): decimal;
var
  sum_of_proven_payments_of_request_obj: system.object;
begin
  self.Open;
  sum_of_proven_payments_of_request_obj := mysqlcommand.Create
    (
    'select sum(amount) from emsof_purchase_payment where master_id = ' + request_id,
    connection
    )
    .ExecuteScalar;
  self.Close;
  if sum_of_proven_payments_of_request_obj <> dbnull.value then begin
    SumOfProvenPaymentsOfRequest := decimal(sum_of_proven_payments_of_request_obj);
  end else begin
    SumOfProvenPaymentsOfRequest := 0;
  end;
end;

function TClass_db_emsof_requests.SumOfRequestValues
  (
  user_kind: string;
  user_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
  sum_obj: system.object;
begin
  if user_kind = 'regional_staffer' then begin
    cmdText := 'select sum(value)'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
    + ' where regional_staffer.id = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id
    +   ' and ((status_code between 2 and 10) or (status_code = 13))';
  end else if user_kind = 'county' then begin
    cmdText := 'select sum(value)'
    + ' from emsof_request_master'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where county_code = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id
    +   ' and ((status_code between 2 and 10) or (status_code = 13))';
  end;
  self.Open;
  sum_obj := mysqlcommand.Create(cmdText,connection).ExecuteScalar;
  self.Close;
  if sum_obj <> dbnull.value then begin
    SumOfRequestValues := decimal(sum_obj);
  end else begin
    SumOfRequestValues := 0;
  end;
end;

function TClass_db_emsof_requests.SusceptibleTo(milestone: milestone_type): queue;
var
  dr: mysqldatareader;
  id_q: queue;
  status_code: string;
begin
  id_q := queue.Create;
  case milestone of
  COUNTY_DICTATED_APPROPRIATION_DEADLINE_MILESTONE:
    status_code := '3';
  SERVICE_PURCHASE_COMPLETION_DEADLINE_MILESTONE:
    status_code := '9';
  SERVICE_INVOICE_SUBMISSION_DEADLINE_MILESTONE:
    status_code := '9';
  SERVICE_CANCELED_CHECK_SUBMISSION_DEADLINE_MILESTONE:
    status_code := '10';
  end;
  self.Open;
  dr := mysqlcommand.Create('select id from emsof_request_master where status_code < ' + status_code,connection).ExecuteReader;
  while dr.Read do begin
    id_q.Enqueue(dr['id']);
  end;
  self.Close;
  SusceptibleTo := id_q;
end;

function TClass_db_emsof_requests.TallyByStatus(status: cardinal): cardinal;
var
  sql: string;
begin
  sql := 'select count(*) as count'
  + ' from emsof_request_master'
  +   ' join county_dictated_appropriation'
  +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
  +   ' join region_dictated_appropriation'
  +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
  +   ' join state_dictated_appropriation'
  +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
  +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
  + ' where status_code = ' + status.tostring;
  if not (status in [14,15]) then begin
    //
    // Unless tallying DEPLOYED or ARCHIVED statuses, limit tally to requests belonging to the current cycle.
    //
    sql := sql + ' and fiscal_year.id = (select max(id) from fiscal_year)';
  end;
  self.Open;
  TallyByStatus := mysqlcommand.Create(sql,connection).ExecuteScalar.GetHashCode;
  self.Close;
end;

function TClass_db_emsof_requests.TcciOfAppropriation: cardinal;
begin
  TcciOfAppropriation := TCCI_APPROPRIATION;
end;

function TClass_db_emsof_requests.TcciOfId: cardinal;
begin
  TcciOfId := TCCI_ID;
end;

function TClass_db_emsof_requests.TcciOfEmsofAnte: cardinal;
begin
  TcciOfEmsofAnte := TCCI_EMSOF_ANTE;
end;

function TClass_db_emsof_requests.TcciOfFullRequestActuals: cardinal;
begin
  TcciOfFullRequestActuals := TCCI_FULL_REQUEST_ACTUALS;
end;

function TClass_db_emsof_requests.TcciOfFullRequestPriority: cardinal;
begin
  TcciOfFullRequestPriority := TCCI_FULL_REQUEST_PRIORITY;
end;

function TClass_db_emsof_requests.TcciOfPasswordResetEmailAddress: cardinal;
begin
  TcciOfPasswordResetEmailAddress := TCCI_PASSWORD_RESET_EMAIL_ADDRESS;
end;

function TClass_db_emsof_requests.TcciOfServiceName: cardinal;
begin
  TcciOfServiceName := TCCI_SERVICE_NAME;
end;

function TClass_db_emsof_requests.TcciOfLeftoverOrShortage: cardinal;
begin
  TcciOfLeftoverOrShortage := TCCI_LEFTOVER_OR_SHORTAGE;
end;

function TClass_db_emsof_requests.TcciOfSrrReplacementRowIndicator: cardinal;
begin
  TcciOfSrrReplacementRowIndicator := TCCI_SRR_REPLACEMENT_ROW_INDICATOR;
end;

function TClass_db_emsof_requests.TcciOfStatusCode: cardinal;
begin
  TcciOfStatusCode := TCCI_STATUS_CODE;
end;

function TClass_db_emsof_requests.TcciOfStatusDescription: cardinal;
begin
  TcciOfStatusDescription := TCCI_STATUS_DESCRIPTION;
end;

procedure TClass_db_emsof_requests.Unreject(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update emsof_request_master'
      + ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      + ' set emsof_request_master.status_code = 2'
      + ' where emsof_request_master.id = ' + master_id
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

procedure TClass_db_emsof_requests.Withdraw(master_id: string);
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'START TRANSACTION;'
      + 'delete from emsof_request_detail where master_id = ' + master_id
      + ';'
      + 'update emsof_request_master'
      + ' set status_code = 12'
      +   ' , value = 0'
      +   ' , num_items = 0'
      +   ' , shortage = 0'
      +   ' , has_wish_list = FALSE'
      +   ' , actual_value = 0'
      +   ' , be_deadline_exempt = FALSE'
      +   ' , be_reopened_after_going_to_state = FALSE'
      + ' where id = ' + master_id
      + ';'
      + 'COMMIT;'
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

end.
