unit Class_biz_appropriations;

interface

uses
  Class_biz_fiscal_years,
  Class_biz_user,
  Class_db_appropriations,
  system.web;

const
  ID = '$Id$';

type
  TClass_biz_appropriations = class
  private
    biz_fiscal_years: TClass_biz_fiscal_years;
    biz_user: TClass_biz_user;
    db_appropriations: TClass_db_appropriations;
  public
    constructor Create;
    function BeAnyCurrentToService(service_id: string): boolean;
    function CountyCodeOfCountyDictum(county_dictum_id: string): string;
    function FundingRoundsGenerated
      (
      regional_staffer_id: string;
      amendment_num_string: string = '0'
      )
      : cardinal;
    function MatchFactorOf(county_dictum_id: string): decimal;
    function MatchLevelIdOf(county_dictum_id: string): cardinal;
    function MatchLevelIdOfRegionDictum(region_dictum_id: string): cardinal;
    function NumActiveAmendments(regional_staffer_id: string): cardinal;
    function ParentAppropriationOfEmsofRequest(master_id: string): decimal;
    procedure ReduceBy
      (
      delta: decimal;
      county_dictum_id: string
      );
    function RegionCodeOfCountyDictum(county_dictum_id: string): string;
    procedure SetServiceToCountySubmissionDeadline
      (
      id: string;
      deadline: datetime
      );
    function SumOfAppropriationsFromSpecificParent
      (
      parent_id: string;
      recipient_kind: string = '';
      recipient_id: string = '';
      fy_id: string = ''
      )
      : decimal;
    function SumOfAppropriationsFromOnlyParent
      (
      recipient_kind: string = '';
      recipient_id: string = '';
      fy_id: string = ''
      )
      : decimal;
    function SumOfAppropriationsToServicesInRegion
      (
      region_id: string;
      fy_id: string
      )
      : decimal;
    function SumOfSelfDictatedAppropriations(fy_id: string = ''): decimal;
  end;

implementation

uses
  kix;

constructor TClass_biz_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  biz_fiscal_years := TClass_biz_fiscal_years.Create;
  biz_user := TClass_biz_user.Create;
  db_appropriations := TClass_db_appropriations.Create;
end;

function TClass_biz_appropriations.BeAnyCurrentToService(service_id: string): boolean;
begin
  BeAnyCurrentToService := db_appropriations.BeAnyCurrentToService(service_id);
end;

function TClass_biz_appropriations.CountyCodeOfCountyDictum(county_dictum_id: string): string;
begin
  CountyCodeOfCountyDictum := db_appropriations.CountyCodeOfCountyDictum(county_dictum_id);
end;

function TClass_biz_appropriations.FundingRoundsGenerated
  (
  regional_staffer_id: string;
  amendment_num_string: string = '0'
  )
  : cardinal;
begin
  FundingRoundsGenerated := db_appropriations.FundingRoundsGenerated(regional_staffer_id,amendment_num_string);
end;

function TClass_biz_appropriations.MatchFactorOf(county_dictum_id: string): decimal;
begin
  MatchFactorOf := db_appropriations.MatchFactorOf(county_dictum_id);
end;

function TClass_biz_appropriations.MatchLevelIdOf(county_dictum_id: string): cardinal;
begin
  MatchLevelIdOf := db_appropriations.MatchLevelIdOf(county_dictum_id);
end;

function TClass_biz_appropriations.MatchLevelIdOfRegionDictum(region_dictum_id: string): cardinal;
begin
  MatchLevelIdOfRegionDictum := db_appropriations.MatchLevelIdOfRegionDictum(region_dictum_id);
end;

function TClass_biz_appropriations.NumActiveAmendments(regional_staffer_id: string): cardinal;
begin
  NumActiveAmendments := db_appropriations.NumActiveAmendments(regional_staffer_id);
end;

function TClass_biz_appropriations.ParentAppropriationOfEmsofRequest(master_id: string): decimal;
begin
  ParentAppropriationOfEmsofRequest := db_appropriations.ParentAppropriationOfEmsofRequest(master_id);
end;

procedure TClass_biz_appropriations.ReduceBy
  (
  delta: decimal;
  county_dictum_id: string
  );
begin
  db_appropriations.ReduceBy(delta,county_dictum_id);
end;

function TClass_biz_appropriations.RegionCodeOfCountyDictum(county_dictum_id: string): string;
begin
  RegionCodeOfCountyDictum :=
    db_appropriations.RegionCodeOfCountyDictum(county_dictum_id);
end;

procedure TClass_biz_appropriations.SetServiceToCountySubmissionDeadline
  (
  id: string;
  deadline: datetime
  );
begin
  db_appropriations.SetServiceToCountySubmissionDeadline(id,deadline.tostring('yyyyMMdd') + '235959');
end;

function TClass_biz_appropriations.SumOfAppropriationsFromSpecificParent
  (
  parent_id: string;
  recipient_kind: string = '';
  recipient_id: string = '';
  fy_id: string = ''
  )
  : decimal;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  if recipient_kind = EMPTY then begin
    recipient_kind := biz_user.Kind;
  end;
  if recipient_id = EMPTY then begin
    recipient_id := biz_user.IdNum;
  end;
  if fy_id = EMPTY then begin
    fy_id := biz_fiscal_years.IdOfCurrent;
  end;
  SumOfAppropriationsFromSpecificParent :=
    db_appropriations.SumOfAppropriationsFromSpecificParent(parent_id,recipient_kind,recipient_id,fy_id);
end;

function TClass_biz_appropriations.SumOfAppropriationsFromOnlyParent
  (
  recipient_kind: string = '';
  recipient_id: string = '';
  fy_id: string = ''
  )
  : decimal;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  if recipient_kind = EMPTY then begin
    recipient_kind := biz_user.Kind;
  end;
  if recipient_id = EMPTY then begin
    recipient_id := biz_user.IdNum;
  end;
  if fy_id = EMPTY then begin
    fy_id := biz_fiscal_years.IdOfCurrent;
  end;
  SumOfAppropriationsFromOnlyParent :=
    db_appropriations.SumOfAppropriationsFromOnlyParent(recipient_kind,recipient_id,fy_id);
end;

function TClass_biz_appropriations.SumOfAppropriationsToServicesInRegion
  (
  region_id: string;
  fy_id: string
  )
  : decimal;
begin
  SumOfAppropriationsToServicesInRegion := db_appropriations.SumOfAppropriationsToServicesInRegion(region_id,fy_id);
end;

function TClass_biz_appropriations.SumOfSelfDictatedAppropriations(fy_id: string = ''): decimal;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  if fy_id = EMPTY then begin
    SumOfSelfDictatedAppropriations := db_appropriations.SumOfSelfDictatedAppropriations
      (biz_user.Kind,biz_user.IdNum,biz_fiscal_years.IdOfCurrent);
  end else begin
    SumOfSelfDictatedAppropriations :=
      db_appropriations.SumOfSelfDictatedAppropriations(biz_user.Kind,biz_user.IdNum,fy_id);
  end;
end;

end.
