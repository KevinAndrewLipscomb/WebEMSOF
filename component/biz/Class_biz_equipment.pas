unit Class_biz_equipment;

interface

uses
  Class_biz_match_level,
  Class_db_equipment;

const
  ID = '$Id$';

type
  TClass_biz_equipment = class
  private
    db_equipment: TClass_db_equipment;
  public
    constructor Create;
    function BeMatchExempt
      (
      code: string;
      match_level_enum: Class_biz_match_level.nominal_type
      )
      : boolean;
  end;

implementation

constructor TClass_biz_equipment.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_equipment := TClass_db_equipment.Create;
end;

function TClass_biz_equipment.BeMatchExempt
  (
  code: string;
  match_level_enum: Class_biz_match_level.nominal_type
  )
  : boolean;
var
  allowable_cost: decimal;
begin
  allowable_cost := db_equipment.AllowableCostOf(code);
  case match_level_enum of
  STANDARD:
    BeMatchExempt := (allowable_cost = db_equipment.FundingLevelNonRuralOf(code));
  RURAL:
    BeMatchExempt := (allowable_cost = db_equipment.FundingLevelRuralOf(code));
  DISTRESSED:
    BeMatchExempt :=
      (allowable_cost = db_equipment.FundingLevelNonRuralOf(code))or (allowable_cost = db_equipment.FundingLevelRuralOf(code));
  else
    BeMatchExempt := FALSE;
  end;

end;

end.
