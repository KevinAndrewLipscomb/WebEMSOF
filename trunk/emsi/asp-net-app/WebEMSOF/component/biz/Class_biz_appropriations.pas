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
    { Private Declarations }
  public
    constructor Create;
    function AppropriationFromSpecificParent
      (
      parent_id: string;
      recipient_kind: string = '';
      recipient_id: string = '';
      fy_id: string = ''
      )
      : decimal;
    function AppropriationFromOnlyParent
      (
      recipient_kind: string = '';
      recipient_id: string = '';
      fy_id: string = ''
      )
      : decimal;
    function SumOfSelfDictatedAppropriations(fy_id: string = ''): decimal;
  end;

implementation

constructor TClass_biz_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_biz_appropriations.AppropriationFromSpecificParent
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
  AppropriationFromSpecificParent :=
    TClass_db_appropriations.Create.AppropriationFromSpecificParent(parent_id,recipient_kind,recipient_id,fy_id);
end;

function TClass_biz_appropriations.AppropriationFromOnlyParent
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
  AppropriationFromOnlyParent :=
    TClass_db_appropriations.Create.AppropriationFromOnlyParent(recipient_kind,recipient_id,fy_id);
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
