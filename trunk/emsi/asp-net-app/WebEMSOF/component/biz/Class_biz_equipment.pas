unit Class_biz_equipment;

interface

uses
  Class_biz_match_level,
  Class_db_equipment,
  Class_db_services,
  system.collections;

type
  serial_indicator_rec_type = Class_db_equipment.serial_indicator_rec_type;
  TClass_biz_equipment = class
  private
    db_equipment: TClass_db_equipment;
    db_services: TClass_db_services;
  public
    constructor Create;
    function BeMatchExempt
      (
      code: string;
      match_level_enum: Class_biz_match_level.nominal_type
      )
      : boolean;
    function SpecialRulesViolation
      (
      service_id: string;
      code: string;
      quantity_string: string
      )
      : string;
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

uses
  kix;

constructor TClass_biz_equipment.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_equipment := TClass_db_equipment.Create;
  db_services := TClass_db_services.Create;
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

function TClass_biz_equipment.SpecialRulesViolation
  (
  service_id: string;
  code: string;
  quantity_string: string
  )
  : string;
var
  i: cardinal;
  name: string;
  q: queue;
  special_rules_violation: string;
begin
  //
  special_rules_violation := EMPTY;
  //
  q := db_equipment.SpecialRuleNames(code);
  for i := 1 to q.Count do begin
    name := q.Dequeue.tostring;
    //
    // UpTo1PerVehicle
    //
    if (name = 'UpTo1PerVehicle')
      and (uint32.Parse(quantity_string) > db_services.NumDohLicensedVehiclesOf(service_id))
    then begin
      special_rules_violation := special_rules_violation
      + 'You must limit the quantity of your request to 1 per DOH-licensed vehicle.'
      + SPACE + SPACE;
    //
    // UpTo2PerVehicle
    //
    end else if (name = 'UpTo2PerVehicle')
      and (uint32.Parse(quantity_string) > db_services.NumDohLicensedVehiclesOf(service_id)*2)
    then begin
      special_rules_violation := special_rules_violation
      + 'You must limit the quantity of your request to 2 per DOH licensed vehicle.'
      + SPACE + SPACE;
    //
    // UpTo5
    //
    end else if (name = 'UpTo5')
      and (uint32.Parse(quantity_string) > 5)
    then begin
      special_rules_violation := special_rules_violation
      + 'You must limit the quantity of your request to 5.'
      + SPACE + SPACE;
    //
    // HasMedicalDirector
    //
    end else if (name = 'HasMedicalDirector')
      and (db_services.MdNameOf(service_id) = EMPTY)
    then begin
      special_rules_violation := special_rules_violation
      + 'To request this item, your service''s profile (annual survey) must first specify a Medical Director.'
      + SPACE + SPACE;
    //
    // UpTo1PerAmbulance
    //
    end else if (name = 'UpTo1PerAmbulance')
      and (uint32.Parse(quantity_string) > db_services.NumAmbulancesOf(service_id))
    then begin
      special_rules_violation := special_rules_violation
      + 'You must limit the quantity of your request to 1 per ambulance.'
      + SPACE + SPACE;
    end;
  end;
  //
  SpecialRulesViolation := special_rules_violation;
  //
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
