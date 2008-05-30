unit Class_biz_fiscal_years;

interface

uses
  Class_db_fiscal_years;

type
  TClass_biz_fiscal_years = class
  private
    db_fiscal_years: TClass_db_fiscal_years;
  public
    constructor Create;
    procedure BindListControl(target: system.object);
    function DesignatorOfCurrent: string;
    function IdOfCurrent: string;
    function IdOfDesignator(designator: string): string;
  end;

implementation

constructor TClass_biz_fiscal_years.Create;
begin
  inherited Create;
  db_fiscal_years := TClass_db_fiscal_years.Create;
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

end.
