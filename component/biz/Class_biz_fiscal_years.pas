unit Class_biz_fiscal_years;

interface

uses
  Class_db_fiscal_years;

type
  TClass_biz_fiscal_years = class
  private
    { Private Declarations }
  public
    constructor Create;
    function IdOfCurrent: string;
  end;

implementation

constructor TClass_biz_fiscal_years.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_biz_fiscal_years.IdOfCurrent: string;
begin
  IdOfCurrent := TClass_db_fiscal_years.Create.IdOfCurrent;
end;

end.
