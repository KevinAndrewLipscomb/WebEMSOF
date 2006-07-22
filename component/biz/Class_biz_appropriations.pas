unit Class_biz_appropriations;

interface

uses
  system.web;

const
  ID = '$Id$';

type
  TClass_biz_appropriations = class
  private
    { Private Declarations }
  public
    constructor Create;
    function CountyCodeOfCountyDictum(county_dictum_id: string): string;
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

uses
  Class_biz_fiscal_years,
  Class_biz_user,
  Class_db_appropriations;

constructor TClass_biz_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_biz_appropriations.CountyCodeOfCountyDictum(county_dictum_id: string): string;
begin
  CountyCodeOfCountyDictum :=
    TClass_db_appropriations.Create.CountyCodeOfCountyDictum(county_dictum_id);
end;

function TClass_biz_appropriations.ParentAppropriationOfEmsofRequest(master_id: string): decimal;
begin
  ParentAppropriationOfEmsofRequest := TClass_db_appropriations.Create.ParentAppropriationOfEmsofRequest(master_id);
end;

function TClass_biz_appropriations.RegionCodeOfCountyDictum(county_dictum_id: string): string;
begin
  RegionCodeOfCountyDictum :=
    TClass_db_appropriations.Create.RegionCodeOfCountyDictum(county_dictum_id);
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
    fy_id := TClass_biz_fiscal_years.Create.IdOfCurrent;
  end;
  SumOfAppropriationsFromSpecificParent :=
    TClass_db_appropriations.Create.SumOfAppropriationsFromSpecificParent(parent_id,recipient_kind,recipient_id,fy_id);
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
    fy_id := TClass_biz_fiscal_years.Create.IdOfCurrent;
  end;
  SumOfAppropriationsFromOnlyParent :=
    TClass_db_appropriations.Create.SumOfAppropriationsFromOnlyParent(recipient_kind,recipient_id,fy_id);
end;

function TClass_biz_appropriations.SumOfAppropriationsToServicesInRegion
  (
  region_id: string;
  fy_id: string
  )
  : decimal;
begin
  SumOfAppropriationsToServicesInRegion := TClass_db_appropriations.Create.SumOfAppropriationsToServicesInRegion(region_id,fy_id);
end;

function TClass_biz_appropriations.SumOfSelfDictatedAppropriations(fy_id: string = ''): decimal;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  if fy_id = system.string.EMPTY then begin
    SumOfSelfDictatedAppropriations := TClass_db_appropriations.Create.SumOfSelfDictatedAppropriations
      (biz_user.Kind,biz_user.IdNum,TClass_biz_fiscal_years.Create.IdOfCurrent);
  end else begin
    SumOfSelfDictatedAppropriations :=
      TClass_db_appropriations.Create.SumOfSelfDictatedAppropriations(biz_user.Kind,biz_user.IdNum,fy_id);
  end;
end;

end.
