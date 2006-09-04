unit Class_db_fiscal_years;

interface

uses
  borland.data.provider,
  Class_db;

type
  TClass_db_fiscal_years = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function IdOfCurrent: string;
    function IdOfDesignator(designator: string): string;
  end;

implementation

constructor TClass_db_fiscal_years.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_fiscal_years.IdOfCurrent: string;
begin
  self.Open;
  IdOfCurrent := borland.data.provider.bdpcommand.Create('select max(id) from fiscal_year',connection).ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_fiscal_years.IdOfDesignator(designator: string): string;
begin
  self.Open;
  IdOfDesignator := borland.data.provider.bdpcommand.Create
    ('select id from fiscal_year where designator = "' + designator + '"',connection).ExecuteScalar.tostring;
  self.Close;
end;

end.
