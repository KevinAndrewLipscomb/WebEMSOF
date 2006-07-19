unit Class_db_appropriations;

interface

uses
  borland.data.provider,
  Class_db;

type
  TClass_db_appropriations = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function AppropriationFromSpecificParent
      (
      parent_id: string;
      recipient_kind: string;
      recipient_id: string;
      fy_id: string
      )
      : decimal;
    function AppropriationFromOnlyParent
      (
      recipient_kind: string;
      recipient_id: string;
      fy_id: string
      )
      : decimal;
    function CountyCodeOfCountyDictum(county_dictum_id: string): string;
    function RegionCodeOfCountyDictum(county_dictum_id: string): string;
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
end;

function TClass_db_appropriations.AppropriationFromSpecificParent
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
    cmdText := 'select county_dictated_appropriation.amount'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where service_id = ' + recipient_id
      +   ' and county_code = ' + parent_id
      +   ' and fiscal_year_id = ' + fy_id;
  end else if recipient_kind = 'county' then begin
    cmdText := 'select region_dictated_appropriation.amount'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where county_code = ' + recipient_id
      +   ' and region_code = ' + parent_id
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  AppropriationFromSpecificParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

function TClass_db_appropriations.AppropriationFromOnlyParent
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
    cmdText := 'select state_dictated_appropriation.amount'
      + ' from state_dictated_appropriation'
      +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
      + ' where regional_staffer.id = ' + recipient_id
      +   ' and fiscal_year_id = ' + fy_id;
  end else if recipient_kind = 'county' then begin
    cmdText := 'select region_dictated_appropriation.amount'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where county_code = ' + recipient_id
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  AppropriationFromOnlyParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
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
