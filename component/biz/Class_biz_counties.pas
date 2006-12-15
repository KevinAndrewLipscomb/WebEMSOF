unit Class_biz_counties;

interface

uses
  Class_db_counties;

type
  TClass_biz_counties = class
  private
    db_counties: TClass_db_counties;
  public
    constructor Create;
    function NameOf(code: string): string;
  end;

implementation

constructor TClass_biz_counties.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_counties := TClass_db_counties.Create;
end;

function TClass_biz_counties.NameOf(code: string): string;
begin
  NameOf := db_counties.NameOf(code);
end;

end.
