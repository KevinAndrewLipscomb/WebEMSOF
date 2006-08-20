unit Class_db_appropriations;

interface

uses
  borland.data.provider,
  Class_db,
  Class_biz_fiscal_years,
  Class_biz_regional_staffers;


type
  TClass_db_appropriations = class(TClass_db)
  private
    biz_fiscal_years: TClass_biz_fiscal_years;
    biz_regional_staffers: TClass_biz_regional_staffers;
  public
    constructor Create;
    function CountyCodeOfCountyDictum(county_dictum_id: string): string;
    function FundingRoundsGenerated
      (
      regional_staffer_id: string;
      amendment_num_string: string
      )
      : cardinal;
    procedure IncFundingRoundsGenerated
      (
      regional_staffer_id: string;
      amendment_num_string: string
      );
    function NumActiveAmendments(regional_staffer_id: string): cardinal;
    function ParentAppropriationOfEmsofRequest(master_id: string): decimal;
    function RegionCodeOfCountyDictum(county_dictum_id: string): string;
    function SumOfAppropriationsFromSpecificParent
      (
      parent_id: string;
      recipient_kind: string;
      recipient_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfAppropriationsFromOnlyParent
      (
      recipient_kind: string;
      recipient_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfAppropriationsToServicesInRegion
      (
      region_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfSelfDictatedAppropriations
      (
      self_kind: string;
      self_id: string;
      fy_id: string
      )
      : decimal;
  end;

implementation

constructor TClass_db_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  biz_fiscal_years := TClass_biz_fiscal_years.Create;
  biz_regional_staffers := TClass_biz_regional_staffers.Create;
end;

function TClass_db_appropriations.CountyCodeOfCountyDictum(county_dictum_id: string): string;
begin
  connection.Open;
  CountyCodeOfCountyDictum := borland.data.provider.bdpcommand.Create
    (
    'select county_code'
    + ' from county_dictated_appropriation'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    + ' where county_dictated_appropriation.id = ' + county_dictum_id,
    connection
    )
    .ExecuteScalar.tostring;
  connection.Close;
end;

function TClass_db_appropriations.FundingRoundsGenerated
  (
  regional_staffer_id: string;
  amendment_num_string: string
  )
  : cardinal;
begin
  connection.Open;
  FundingRoundsGenerated := borland.data.provider.bdpcommand.Create
    (
    'select funding_rounds_generated'
    + ' from state_dictated_appropriation'
    + ' where fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent
    +   ' and region_code = ' + biz_regional_staffers.RegionCodeOf(regional_staffer_id)
    +   ' and amendment_num = ' + amendment_num_string,
    connection
    )
    .ExecuteScalar.GetHashCode;
  connection.Close;
end;

procedure TClass_db_appropriations.IncFundingRoundsGenerated
  (
  regional_staffer_id: string;
  amendment_num_string: string
  );
begin
  connection.Open;
  borland.data.provider.bdpcommand.Create
    (
    'update state_dictated_appropriation'
    + ' set funding_rounds_generated = funding_rounds_generated + 1'
    + ' where fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent
    +   ' and region_code = ' + biz_regional_staffers.RegionCodeOf(regional_staffer_id)
    +   ' and amendment_num = ' + amendment_num_string,
    connection
    )
    .ExecuteNonQuery;
  connection.Close;
end;

function TClass_db_appropriations.NumActiveAmendments(regional_staffer_id: string): cardinal;
begin
  connection.Open;
  NumActiveAmendments := -1 + borland.data.provider.bdpcommand.Create
    (
    'select count(id)'
    + ' from state_dictated_appropriation'
    + ' where fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent
    +   ' and region_code = ' + biz_regional_staffers.RegionCodeOf(regional_staffer_id),
    connection
    )
    .ExecuteScalar.GetHashCode;
  connection.Close;
end;

function TClass_db_appropriations.ParentAppropriationOfEmsofRequest(master_id: string): decimal;
begin
  connection.Open;
  ParentAppropriationOfEmsofRequest := decimal
    (
    borland.data.provider.bdpcommand.Create
      (
      'select county_dictated_appropriation.amount'
      + ' from county_dictated_appropriation'
      +   ' join emsof_request_master on (emsof_request_master.county_dictated_appropriation_id=county_dictated_appropriation.id)'
      + ' where emsof_request_master.id = ' + master_id,
      connection
      )
      .ExecuteScalar
    );
  connection.Close;
end;

function TClass_db_appropriations.RegionCodeOfCountyDictum(county_dictum_id: string): string;
begin
  connection.Open;
  RegionCodeOfCountyDictum := borland.data.provider.bdpcommand.Create
    (
    'select region_code'
    + ' from county_dictated_appropriation'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where county_dictated_appropriation.id = ' + county_dictum_id,
    connection
    )
    .ExecuteScalar.tostring;
  connection.Close;
end;

function TClass_db_appropriations.SumOfAppropriationsFromSpecificParent
  (
  parent_id: string;
  recipient_kind: string;
  recipient_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if recipient_kind = 'service' then begin
    cmdText := 'select sum(county_dictated_appropriation.amount)'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where service_id = ' + recipient_id
      +   ' and county_code = ' + parent_id
      +   ' and fiscal_year_id = ' + fy_id;
  end else if recipient_kind = 'county' then begin
    cmdText := 'select sum(region_dictated_appropriation.amount)'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where county_code = ' + recipient_id
      +   ' and region_code = ' + parent_id
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  SumOfAppropriationsFromSpecificParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

function TClass_db_appropriations.SumOfAppropriationsFromOnlyParent
  (
  recipient_kind: string;
  recipient_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if recipient_kind = 'regional_staffer' then begin
    cmdText := 'select sum(state_dictated_appropriation.amount)'
      + ' from state_dictated_appropriation'
      +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
      + ' where regional_staffer.id = ' + recipient_id
      +   ' and fiscal_year_id = ' + fy_id;
  end else if recipient_kind = 'county' then begin
    cmdText := 'select sum(region_dictated_appropriation.amount)'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where county_code = ' + recipient_id
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  SumOfAppropriationsFromOnlyParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

function TClass_db_appropriations.SumOfAppropriationsToServicesInRegion
  (
  region_id: string;
  fy_id: string
  )
  : decimal;
var
  sum_obj: system.object;
begin
  connection.Open;
  sum_obj := borland.data.provider.bdpcommand.Create
    (
    'select sum(county_dictated_appropriation.amount)'
    + ' from county_dictated_appropriation'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where region_code = ' + region_id
    +   ' and fiscal_year_id = ' + fy_id,
    connection
    )
    .ExecuteScalar;
  if sum_obj = dbnull.value then begin
    SumOfAppropriationsToServicesInRegion := 0;
  end else begin
    SumOfAppropriationsToServicesInRegion := decimal(sum_obj);
  end;
  connection.Close;
end;

function TClass_db_appropriations.SumOfSelfDictatedAppropriations
  (
  self_kind: string;
  self_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if self_kind = 'regional_staffer' then begin
    cmdText := 'select sum(region_dictated_appropriation.amount)'
    + ' from region_dictated_appropriation'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
    + ' where regional_staffer.id = ' + self_id
    +   ' and fiscal_year_id = ' + fy_id;
  end else if self_kind = 'county' then begin
    cmdText := 'select sum(county_dictated_appropriation.amount)'
    + ' from county_dictated_appropriation'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where county_code = ' + self_id
    +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  SumOfSelfDictatedAppropriations := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

end.
