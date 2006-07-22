unit Class_db_regional_staffers;

interface

uses
  borland.data.provider,
  Class_db;

type
  TClass_db_regional_staffers = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function RegionCodeOf(id: string): string;
  end;

implementation

constructor TClass_db_regional_staffers.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_regional_staffers.RegionCodeOf(id: string): string;
begin
  connection.Open;
  RegionCodeOf := borland.data.provider.BdpCommand.Create
    (
    'SELECT region_code FROM regional_staffer WHERE id = ' + id,
    connection
    )
    .ExecuteScalar.tostring;
  connection.Close;
end;

end.
