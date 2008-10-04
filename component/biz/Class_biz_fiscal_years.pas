unit Class_biz_fiscal_years;

interface

uses
  Class_db_fiscal_years;

type
  TClass_biz_fiscal_years = class
  strict private
    db_fiscal_years: TClass_db_fiscal_years;
    new_designator: string;
  public
    constructor Create;
  published
    procedure BindListControl(target: system.object);
    function DesignatorOfCurrent: string;
    function IdOfCurrent: string;
    function IdOfDesignator(designator: string): string;
    function NewDesignator: string;
    procedure StartNew;
  end;

implementation

constructor TClass_biz_fiscal_years.Create;
var
  next_year_string: string;
  this_year_cardinal: cardinal;
  this_year_string: string;
begin
  //
  inherited Create;
  //
  db_fiscal_years := TClass_db_fiscal_years.Create;
  //
  this_year_cardinal := datetime.Now.Year;
  this_year_string := this_year_cardinal.tostring;
  next_year_string := uint32(this_year_cardinal + 1).tostring;
  new_designator := 'FY'
  + this_year_string.Substring(this_year_string.length - 2)
  + next_year_string.Substring(next_year_string.length - 2);
  //
end;

procedure TClass_biz_fiscal_years.BindListControl(target: system.object);
begin
  db_fiscal_years.BindListControl(target);
end;

function TClass_biz_fiscal_years.DesignatorOfCurrent: string;
begin
  DesignatorOfCurrent := db_fiscal_years.DesignatorOfCurrent;
end;

function TClass_biz_fiscal_years.IdOfCurrent: string;
begin
  IdOfCurrent := db_fiscal_years.IdOfCurrent;
end;

function TClass_biz_fiscal_years.IdOfDesignator(designator: string): string;
begin
  IdOfDesignator := db_fiscal_years.IdOfDesignator(designator);
end;

function TClass_biz_fiscal_years.NewDesignator: string;
begin
  NewDesignator := new_designator;
end;

procedure TClass_biz_fiscal_years.StartNew;
begin
  db_fiscal_years.StartNew(new_designator);
end;

end.
