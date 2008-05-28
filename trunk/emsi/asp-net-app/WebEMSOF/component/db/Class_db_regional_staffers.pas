unit Class_db_regional_staffers;

interface

uses
  mysql.data.mysqlclient,
  Class_db;

type
  TClass_db_regional_staffers = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function RegionCodeOf(id: string): string;
    function RegionNameOf(id: string): string;
  end;

implementation

constructor TClass_db_regional_staffers.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_regional_staffers.RegionCodeOf(id: string): string;
begin
  self.Open;
  RegionCodeOf := mysqlcommand.Create
    (
    'SELECT region_code FROM regional_staffer WHERE id = ' + id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_regional_staffers.RegionNameOf(id: string): string;
begin
  self.Open;
  RegionNameOf := mysqlcommand.Create
    (
    'SELECT name'
    + ' FROM regional_staffer join region_code_name_map on (region_code_name_map.code=regional_staffer.region_code)'
    + ' WHERE id = ' + id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

end.
