unit Class_biz_regional_staffers;

interface

uses
  Class_db_regional_staffers;

type
  TClass_biz_regional_staffers = class
  private
    db_regional_staffers: TClass_db_regional_staffers;
  public
    constructor Create;
    function RegionCodeOf(id: string): string;
    function RegionNameOf(id: string): string;
  end;

implementation

constructor TClass_biz_regional_staffers.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_regional_staffers := TClass_db_regional_staffers.Create;
end;

function TClass_biz_regional_staffers.RegionCodeOf(id: string): string;
begin
  RegionCodeOf := db_regional_staffers.RegionCodeOf(id);
end;

function TClass_biz_regional_staffers.RegionNameOf(id: string): string;
begin
  RegionNameOf := db_regional_staffers.RegionNameOf(id);
end;

end.
