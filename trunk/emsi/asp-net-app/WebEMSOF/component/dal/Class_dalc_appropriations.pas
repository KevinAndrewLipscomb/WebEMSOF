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
    function AppropriationFromNamedParent
      (
      parent_name: string;
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
    function SumOfSelfDictatedAppropriations
      (
      self_kind: string;
      self_id: string;
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

function TClass_dalc_appropriations.AppropriationFromNamedParent
  (
  parent_name: string;
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
      +   ' join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)'
      + ' where service_id = ' + recipient_id
      +   ' and name = "' + parent_name + '"'
      +   ' and fiscal_year_id = ' + fy_id;
  end else if recipient_kind = 'county' then begin
    cmdText := 'select region_dictated_appropriation.amount'
      + ' from region_dictated_appropriation'
      +   ' join state_dictated_appropriation'
      +     ' on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)'
      +   ' join region_code_name_map on (region_code_name_map.code=state_dictated_appropriation.region_code)'
      + ' where county_code = ' + recipient_id
      +   ' and name = "' + parent_name + '"'
      +   ' and fiscal_year_id = ' + fy_id;
  end;
  connection.Open;
  AppropriationFromNamedParent := decimal(borland.data.provider.bdpcommand.Create(cmdText,connection).ExecuteScalar);
  connection.Close;
end;

function TClass_dalc_appropriations.AppropriationFromOnlyParent
  (
  recipient_kind: string;
  recipient_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if recipient_kind = 'regional-staffer' then begin
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

function TClass_dalc_appropriations.SumOfSelfDictatedAppropriations
  (
  self_kind: string;
  self_id: string;
  fy_id: string
  )
  : decimal;
var
  cmdText: string;
begin
  if self_kind = 'regional-staffer' then begin
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
