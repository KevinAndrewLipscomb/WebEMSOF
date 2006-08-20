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
    function CountyCodeOfCountyDictum(county_dictum_id: string): string;
    function FundingRoundsGenerated
      (
      regional_staffer_id: string;
      amendment_num_string: string = '0'
      )
      : cardinal;
    function NumActiveAmendments(regional_staffer_id: string): cardinal;
    function ParentAppropriationOfEmsofRequest(master_id: string): decimal;
    function RegionCodeOfCountyDictum(county_dictum_id: string): string;
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

constructor TClass_biz_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  biz_fiscal_years := TClass_biz_fiscal_years.Create;
  biz_user := TClass_biz_user.Create;
  db_appropriations := TClass_db_appropriations.Create;
end;

function TClass_biz_appropriations.NumActiveAmendments(regional_staffer_id: string): cardinal;
begin
  NumActiveAmendments := db_appropriations.NumActiveAmendments(regional_staffer_id);
end;

function TClass_biz_appropriations.CountyCodeOfCountyDictum(county_dictum_id: string): string;
begin
  CountyCodeOfCountyDictum :=
    db_appropriations.CountyCodeOfCountyDictum(county_dictum_id);
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

function TClass_biz_appropriations.ParentAppropriationOfEmsofRequest(master_id: string): decimal;
begin
  ParentAppropriationOfEmsofRequest := db_appropriations.ParentAppropriationOfEmsofRequest(master_id);
end;

function TClass_biz_appropriations.RegionCodeOfCountyDictum(county_dictum_id: string): string;
begin
  RegionCodeOfCountyDictum :=
    db_appropriations.RegionCodeOfCountyDictum(county_dictum_id);
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
  if recipient_kind = system.string.EMPTY then begin
    recipient_kind := biz_user.Kind;
  end;
  if recipient_id = system.string.EMPTY then begin
    recipient_id := biz_user.IdNum;
  end;
  if fy_id = system.string.EMPTY then begin
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
  if recipient_kind = system.string.EMPTY then begin
    recipient_kind := biz_user.Kind;
  end;
  if recipient_id = system.string.EMPTY then begin
    recipient_id := biz_user.IdNum;
  end;
  if fy_id = system.string.EMPTY then begin
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
  if fy_id = system.string.EMPTY then begin
    SumOfSelfDictatedAppropriations := db_appropriations.SumOfSelfDictatedAppropriations
      (biz_user.Kind,biz_user.IdNum,biz_fiscal_years.IdOfCurrent);
  end else begin
    SumOfSelfDictatedAppropriations :=
      db_appropriations.SumOfSelfDictatedAppropriations(biz_user.Kind,biz_user.IdNum,fy_id);
  end;
end;

end.
