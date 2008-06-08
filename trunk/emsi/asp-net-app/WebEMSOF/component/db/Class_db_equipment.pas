unit Class_db_equipment;

interface

uses
  Class_db;

type
  TClass_db_equipment = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function AllowableCostOf(code: string): decimal;
    procedure BindListControl
      (
      fy_id: string;
      target: system.object
      );
    function FundingLevelNonRuralOf(code: string): decimal;
    function FundingLevelRuralOf(code: string): decimal;
  end;

implementation

uses
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_equipment.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_equipment.AllowableCostOf(code: string): decimal;
var
  allowable_cost_obj: system.object;
begin
  self.Open;
  allowable_cost_obj := mysqlcommand.Create
    (
    'select allowable_cost'
    + ' from eligible_provider_equipment_list'
    + ' where code = ' + code,
    connection
    )
    .ExecuteScalar;
  if allowable_cost_obj <> dbnull.value then begin
    AllowableCostOf := decimal(allowable_cost_obj);
  end else begin
    AllowableCostOf := decimal.MaxValue;
  end;
  self.Close;
end;

procedure TClass_db_equipment.BindListControl
  (
  fy_id: string;
  target: system.object
  );
begin
  self.Open;
  ListControl(target).datasource := mysqlcommand.Create
    (
    'select code,description'
    + ' from eligible_provider_equipment_list'
    + ' where fiscal_year_id = "' + fy_id + '"'
    + ' order by description',
    connection
    )
    .ExecuteReader;
  ListControl(target).datavaluefield := 'code';
  ListControl(target).datatextfield := 'description';
  ListControl(target).DataBind;
  self.Close;
end;

function TClass_db_equipment.FundingLevelNonRuralOf(code: string): decimal;
var
  funding_level_obj: system.object;
begin
  self.Open;
  funding_level_obj := mysqlcommand.Create
    (
    'select funding_level_nonrural'
    + ' from eligible_provider_equipment_list'
    + ' where code = ' + code,
    connection
    )
    .ExecuteScalar;
  if funding_level_obj <> dbnull.value then begin
    FundingLevelNonRuralOf := decimal(funding_level_obj);
  end else begin
    FundingLevelNonRuralOf := decimal.MaxValue - 0.01;
      // Prevents null funding level from equaling null allowable cost, which is tested in TClass_biz_equipment.BeMatchExempt.
  end;
  self.Close;
end;

function TClass_db_equipment.FundingLevelRuralOf(code: string): decimal;
var
  funding_level_obj: system.object;
begin
  self.Open;
  funding_level_obj := mysqlcommand.Create
    (
    'select funding_level_rural'
    + ' from eligible_provider_equipment_list'
    + ' where code = ' + code,
    connection
    )
    .ExecuteScalar;
  if funding_level_obj <> dbnull.value then begin
    FundingLevelRuralOf := decimal(funding_level_obj);
  end else begin
    FundingLevelRuralOf := 0;
  end;
  self.Close;
end;

end.
