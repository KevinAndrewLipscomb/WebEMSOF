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
  end;

implementation

constructor TClass_db_fiscal_years.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_fiscal_years.IdOfCurrent: string;
begin
  connection.Open;
  IdOfCurrent := borland.data.provider.bdpcommand.Create('select max(id) from fiscal_year',connection).ExecuteScalar.tostring;
  connection.Close;
end;

end.
