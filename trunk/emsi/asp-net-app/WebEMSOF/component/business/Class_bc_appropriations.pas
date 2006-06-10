unit Class_bc_appropriations;

interface

uses
  Class_bc_fiscal_years,
  Class_bc_user,
  Class_dalc_appropriations,
  system.web;

const
  ID = '$Id$';

type
  TClass_bc_appropriations = class
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

constructor TClass_bc_appropriations.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_appropriations.AppropriationFromSpecificParent
  (
  parent_id: string;
  recipient_kind: string = '';
  recipient_id: string = '';
  fy_id: string = ''
  )
  : decimal;
var
  bc_user: TClass_bc_user;
begin
  bc_user := TClass_bc_user.Create;
  if recipient_kind = system.string.EMPTY then begin
    recipient_kind := bc_user.Kind;
  end;
  if recipient_id = system.string.EMPTY then begin
    recipient_id := bc_user.IdNum;
  end;
  if fy_id = system.string.EMPTY then begin
    fy_id := TClass_bc_fiscal_years.Create.IdOfCurrent;
  end;
  AppropriationFromSpecificParent :=
    TClass_dalc_appropriations.Create.AppropriationFromSpecificParent(parent_id,recipient_kind,recipient_id,fy_id);
end;

function TClass_bc_appropriations.AppropriationFromOnlyParent
  (
  recipient_kind: string = '';
  recipient_id: string = '';
  fy_id: string = ''
  )
  : decimal;
var
  bc_user: TClass_bc_user;
begin
  bc_user := TClass_bc_user.Create;
  if recipient_kind = system.string.EMPTY then begin
    recipient_kind := bc_user.Kind;
  end;
  if recipient_id = system.string.EMPTY then begin
    recipient_id := bc_user.IdNum;
  end;
  if fy_id = system.string.EMPTY then begin
    fy_id := TClass_bc_fiscal_years.Create.IdOfCurrent;
  end;
  AppropriationFromOnlyParent :=
    TClass_dalc_appropriations.Create.AppropriationFromOnlyParent(recipient_kind,recipient_id,fy_id);
end;

function TClass_bc_appropriations.SumOfSelfDictatedAppropriations(fy_id: string = ''): decimal;
var
  bc_user: TClass_bc_user;
begin
  bc_user := TClass_bc_user.Create;
  if fy_id = system.string.EMPTY then begin
    SumOfSelfDictatedAppropriations := TClass_dalc_appropriations.Create.SumOfSelfDictatedAppropriations
      (bc_user.Kind,bc_user.IdNum,TClass_bc_fiscal_years.Create.IdOfCurrent);
  end else begin
    SumOfSelfDictatedAppropriations :=
      TClass_dalc_appropriations.Create.SumOfSelfDictatedAppropriations(bc_user.Kind,bc_user.IdNum,fy_id);
  end;
end;

end.
