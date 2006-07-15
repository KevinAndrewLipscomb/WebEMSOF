unit Class_db_emsof_requests;

interface

uses
  ki.common,
  borland.data.provider,
  Class_db,
  System.Web.UI.WebControls;

const
  ID = '$Id$';

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
    function AffiliateNumOf(e_item: system.object): string;
    procedure Approve
      (
      master_id: string;
      next_status: cardinal;
      user_kind: string;
      approval_timestamp_column: approval_timestamp_column_type 
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
      target: system.object
      );
    function CountyApprovalTimestampOf(master_id: string): datetime;
    procedure Demote
      (
      master_id: string;
      next_status: cardinal;
      user_kind: string;
      role: string
      );
    function FyDesignatorOf(e_item: system.object): string;
    function IdOf(e_item: system.object): string;
    procedure MarkDone
      (
      master_id: string;
      next_status: cardinal;
      user_kind: string
      );
    function PropertyNameOfEmsofAnte: string;
    function RegionalExecDirApprovalTimestampOf(master_id: string): datetime;
    function RegionalPlannerApprovalTimestampOf(master_id: string): datetime;
    function ReworkDeadline(e_item: system.object): datetime;
    function ServiceIdOf(e_item: system.object): string;
    function ServiceNameOf(e_item: system.object): string;
    function SponsorCountyCodeOf(e_item: system.object): string;
    function SponsorCountyNameOf(e_item: system.object): string;
    function SponsorRegionNameOf(master_id: string): string;
    function StatusCodeOf(e_item: system.object): cardinal;
    function SumOfRequestValues
      (
      user_kind: string;
      user_id: string;
      fy_id: string
      )
      : decimal;
    function TallyByStatus(status: cardinal): cardinal;
    function TcciOfAppropriation: cardinal;
    function TcciOfId: cardinal;
    function TcciOfEmsofAnte: cardinal;
    function TcciOfPasswordResetEmailAddress: cardinal;
    function TcciOfServiceName: cardinal;
    function TcciOfStatusCode: cardinal;
    function TcciOfStatusDescription: cardinal;
  end;

implementation

const
  TCCI_ID = 0;
  TCCI_SERVICE_ID = 1;
  TCCI_AFFILIATE_NUM = 2;
  TCCI_SERVICE_NAME = 3;
  TCCI_SPONSOR_COUNTY_ID = 4;
  TCCI_SPONSOR_COUNTY_NAME = 5;
  TCCI_FISCAL_YEAR_DESIGNATOR = 6;
  TCCI_EMSOF_ANTE = 7;
  TCCI_APPROPRIATION = 8;
  TCCI_PASSWORD_RESET_EMAIL_ADDRESS = 9;
  TCCI_STATUS_CODE = 10;
  TCCI_STATUS_DESCRIPTION = 11;

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
  if where_parm = system.string.EMPTY then begin
    where_clause := system.string.EMPTY;
  end else begin
    where_clause := 'where ' + where_parm;
    if and_parm <> system.string.EMPTY then begin
      where_clause := where_clause + ' and ' + and_parm;
    end;
  end;
  cmdText := 'select emsof_request_master.id'                                  // column 0
  + ' , service.id as service_id'                                              // column 1
  + ' , service.affiliate_num'                                                 // column 2
  + ' , service.name as service_name'                                          // column 3
  + ' , county_code_name_map.code as county_code'                              // column 4
  + ' , county_code_name_map.name as sponsor_county'                           // column 5
  + ' , fiscal_year.designator as fiscal_year_designator'                      // column 6
  + ' , emsof_request_master.value as emsof_ante'                              // column 7
  + ' , county_dictated_appropriation.amount as appropriation'                 // column 8
  + ' , password_reset_email_address'                                          // column 9
  + ' , status_code'                                                           // column 10
  + ' , request_status_code_description_map.description as status_description' // column 11
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
  +   ' join request_status_code_description_map on (request_status_code_description_map.code=status_code)'
  + where_clause
  + ' order by ' + order_by_field_name;
  if be_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  connection.Open;
  DataGrid(target).datasource := borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteReader;
  DataGrid(target).DataBind;
  connection.Close;
end;

constructor TClass_db_emsof_requests.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
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
  approval_timestamp_column: approval_timestamp_column_type
  );
var
  cmdText: string;
begin
  if approval_timestamp_column <> NONE then begin
    cmdText :=
    'update emsof_request_master'
    + ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' set emsof_request_master.status_code = ' + next_status.tostring
    +   ' , ' + system.object(approval_timestamp_column).tostring + '_approval_timestamp = now()'
    + ' where emsof_request_master.id = ' + master_id;
    if user_kind = 'state-staffer' then begin
      cmdText :=
      'START TRANSACTION; '
      + cmdText + ';'
      + ' update emsof_request_detail set status_code = 2 where master_id = ' + master_id + ' and status_code = 1;'
      + ' COMMIT';
    end;
    connection.Open;
    borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteNonQuery;
    connection.Close;
  end;
end;

procedure TClass_db_emsof_requests.BindDetail
  (
  master_id: string;
  target: system.object
  );
begin
  connection.Open;
  DataGrid(target).datasource := borland.data.provider.bdpcommand.Create
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
  connection.Close;
end;

procedure TClass_db_emsof_requests.BindOverviewAll
  (
  order_by_field_name: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  BindOverview(order_by_field_name,be_order_ascending,target);
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
  target: system.object
  );
begin
  BindOverview(order_by_field_name,be_order_ascending,target,'status_code = ' + status.tostring);
end;

function TClass_db_emsof_requests.CountyApprovalTimestampOf(master_id: string): datetime;
begin
  connection.Open;
  CountyApprovalTimestampOf := datetime
    (
    borland.data.provider.bdpcommand.Create
      ('select county_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
      .ExecuteScalar
    );
  connection.Close;
end;

procedure TClass_db_emsof_requests.Demote
  (
  master_id: string;
  next_status: cardinal;
  user_kind: string;
  role: string
  );
begin
  connection.Open;
  borland.data.provider.bdpcommand.Create
    (
    'update emsof_request_master'
    + ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' set emsof_request_master.status_code = ' + next_status.tostring
    + ' where emsof_request_master.id = ' + master_id,
    connection
    )
    .ExecuteNonQuery;
  connection.Close;
end;

function TClass_db_emsof_requests.FyDesignatorOf(e_item: system.object): string;
begin
  FyDesignatorOf := Safe(DataGridItem(e_item).cells[TCCI_FISCAL_YEAR_DESIGNATOR].text,ALPHANUM);
end;

function TClass_db_emsof_requests.IdOf(e_item: system.object): string;
begin
  IdOf := Safe(DataGridItem(e_item).cells[TCCI_ID].text,NUM);
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
  if user_kind = 'state-staffer' then begin
    cmdText :=
    'START TRANSACTION; '
    + cmdText + ';'
    + ' update emsof_request_detail set status_code = 2 where master_id = ' + master_id + ' and status_code = 1;'
    + ' COMMIT';
  end;
  connection.Open;
  borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteNonQuery;
  connection.Close;
end;

function TClass_db_emsof_requests.PropertyNameOfEmsofAnte: string;
begin
  PropertyNameOfEmsofAnte := 'emsof_ante';
end;

function TClass_db_emsof_requests.RegionalExecDirApprovalTimestampOf(master_id: string): datetime;
begin
  connection.Open;
  RegionalExecDirApprovalTimestampOf := datetime
    (
    borland.data.provider.bdpcommand.Create
      ('select regional_director_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
      .ExecuteScalar
    );
  connection.Close;
end;

function TClass_db_emsof_requests.RegionalPlannerApprovalTimestampOf(master_id: string): datetime;
begin
  connection.Open;
  RegionalPlannerApprovalTimestampOf := datetime
    (
    borland.data.provider.bdpcommand.Create
      ('select regional_planner_approval_timestamp from emsof_request_master where id = ' + master_id,connection)
      .ExecuteScalar
    );
  connection.Close;
end;

function TClass_db_emsof_requests.ReworkDeadline(e_item: system.object): datetime;
begin
  connection.Open;
  ReworkDeadline := datetime
    (
    borland.data.provider.bdpcommand.Create
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
  connection.Close;
end;

function TClass_db_emsof_requests.ServiceIdOf(e_item: system.object): string;
begin
  ServiceIdOf := Safe(DataGridItem(e_item).cells[TCCI_SERVICE_ID].text,NUM);
end;

function TClass_db_emsof_requests.ServiceNameOf(e_item: system.object): string;
begin
  ServiceNameOf := Safe(DataGridItem(e_item).cells[TCCI_SERVICE_NAME].text,ORG_NAME);
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
  connection.Open;
  SponsorRegionNameOf := borland.data.provider.bdpcommand.Create
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
  connection.Close;
end;

function TClass_db_emsof_requests.StatusCodeOf(e_item: system.object): cardinal;
begin
  StatusCodeOf := convert.ToInt16(Safe(DataGridItem(e_item).cells[TCCI_STATUS_CODE].text,NUM));
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
    +   ' and fiscal_year_id = ' + fy_id;
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
    +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  sum_obj := borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar;
  connection.Close;
  if sum_obj <> dbnull.value then begin
    SumOfRequestValues := decimal(sum_obj);
  end else begin
    SumOfRequestValues := 0;
  end;
end;

function TClass_db_emsof_requests.TallyByStatus(status: cardinal): cardinal;
begin
  connection.Open;
  TallyByStatus := borland.data.provider.bdpcommand.Create
      (
      'select count(*) as count'
      + ' from emsof_request_master'
      +   ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)'
      + ' where status_code = ' + status.tostring,
      connection
      )
      .ExecuteScalar.GetHashCode;
  connection.Close;
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

function TClass_db_emsof_requests.TcciOfPasswordResetEmailAddress: cardinal;
begin
  TcciOfPasswordResetEmailAddress := TCCI_PASSWORD_RESET_EMAIL_ADDRESS;
end;

function TClass_db_emsof_requests.TcciOfServiceName: cardinal;
begin
  TcciOfServiceName := TCCI_SERVICE_NAME;
end;

function TClass_db_emsof_requests.TcciOfStatusCode: cardinal;
begin
  TcciOfStatusCode := TCCI_STATUS_CODE;
end;

function TClass_db_emsof_requests.TcciOfStatusDescription: cardinal;
begin
  TcciOfStatusDescription := TCCI_STATUS_DESCRIPTION;
end;

end.
