unit Class_dalc_fiscal_years;

interface

uses
  borland.data.provider,
  Class_dalc_base;

type
  TClass_dalc_fiscal_years = class(TClass_dalc_base)
  private
    { Private Declarations }
  public
    constructor Create;
    function IdOfCurrent: string;
  end;

implementation

constructor TClass_dalc_fiscal_years.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_fiscal_years.IdOfCurrent: string;
begin
  connection.Open;
  IdOfCurrent := borland.data.provider.bdpcommand.Create('select max(id) from fiscal_year',connection).ExecuteScalar.tostring;
  connection.Close;
end;

end.
