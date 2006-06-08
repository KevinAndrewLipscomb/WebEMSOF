unit Class_dalc_appropriations;

interface

uses
  borland.data.provider,
  Class_dalc_base;

type
  TClass_dalc_appropriations = class(TClass_dalc_base)
  private
    { Private Declarations }
  public
    constructor Create;
    function AppropriationFromOnlyParent
      (
      user_kind: string;
      user_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfSelfDictatedAppropriations
      (
      user_kind: string;
      user_id: string;
      fy_id: string
      )
      : decimal;
  end;

implementation

constructor TClass_dalc_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_appropriations.AppropriationFromOnlyParent
  (
  user_kind: string;
  user_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if user_kind = 'regional-staffer' then begin
    cmdText := 'select amount'
      + ' from state_dictated_appropriation'
      +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
      + ' where regional_staffer.id = ' + user_id
      +   ' and fiscal_year_id = ' + fy_id;
  end else if user_kind = 'county' then begin
    cmdText := 'select amount'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     'on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where county_code = ' + user_id
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  AppropriationFromOnlyParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

function TClass_dalc_appropriations.SumOfSelfDictatedAppropriations
  (
  user_kind: string;
  user_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if user_kind = 'regional-staffer' then begin
    cmdText := 'select sum(region_dictated_appropriation.amount)'
    + ' from region_dictated_appropriation'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    +   ' join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
    + ' where regional_staffer.id = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id;
  end else if user_kind = 'county' then begin
    cmdText := 'select sum(county_dictated_appropriation.amount)'
    + ' from county_dictated_appropriation'
    +   ' join region_dictated_appropriation'
    +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
    +   ' join state_dictated_appropriation'
    +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
    + ' where county_code = ' + user_id
    +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  SumOfSelfDictatedAppropriations := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

end.
