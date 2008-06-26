unit Class_biz_equipment;

interface

uses
  Class_biz_match_level,
  Class_db_equipment,
  system.collections;

type
  serial_indicator_rec_type = Class_db_equipment.serial_indicator_rec_type;
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
    procedure BindDescriptionsOnlyToListControl(target: system.object);
    procedure BindListControl
      (
      fy_id: string;
      target: system.object
      );
    function SerialIndicatorData
      (
      indicator: string;
      description: string
      )
      : queue;
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

procedure TClass_biz_equipment.BindDescriptionsOnlyToListControl(target: system.object);
begin
  db_equipment.BindDescriptionsOnlyToListControl(target);
end;

procedure TClass_biz_equipment.BindListControl
  (
  fy_id: string;
  target: system.object
  );
begin
  db_equipment.BindListControl(fy_id,target);
end;

function TClass_biz_equipment.SerialIndicatorData
  (
  indicator: string;
  description: string
  )
  : queue;
begin
  SerialIndicatorData := db_equipment.SerialIndicatorData(indicator,description);
end;

end.
